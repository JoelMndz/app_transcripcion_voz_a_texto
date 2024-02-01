
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class TranscripcionProvider with ChangeNotifier{
  final stt.SpeechToText _speech = stt.SpeechToText();
  String? _textoActual;
  String? get textoActual => _textoActual;
  set textoActual(String? texto){
    _textoActual = texto;
    notifyListeners();
  }
  bool _escuchando = false;
  bool get escuchando => _escuchando;
  set escuchando(bool estado){
    _escuchando = estado;
    notifyListeners();
  } 

  void empezarAEscuchar() async{
    await Permission.microphone.request();
    bool disponible = await _speech.initialize( 
      onStatus: (status){
        print(status);
        if(status == 'done'){
          escuchando = false;
        }
      }, 
      onError: (error)=>print('Error: $error') );
    if ( disponible ) {
      escuchando = true;
      _speech.listen( 
        onResult: (result){
          textoActual = result.recognizedWords;
          print(result.recognizedWords);
        },
      );
    }
    else {
      print("The user has denied the use of speech recognition.");
    }
  }

  detener(){
    textoActual = null;
    _speech.stop();
  }
}