import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:transcripcion_texto/ui/pages/transcribir/widgets/circulo.dart';
import 'package:transcripcion_texto/ui/pages/transcribir/widgets/texto.dart';

class TranscribirPage extends StatefulWidget {
  const TranscribirPage({ Key? key }) : super(key: key);

  @override
  _TranscribirState createState() => _TranscribirState();
}

class _TranscribirState extends State<TranscribirPage> {
  late stt.SpeechToText _speech;
  List<String> _transcripciones = [];
  String _textoActual = 'Te escucho...';

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
    _empezarAEscuchar();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(33, 33, 33, 0),
      body: ListView(
        padding: EdgeInsets.only(top: 50, bottom: 10, left: 10, right: 10),
        children: [Circulo(),..._listarTranscripciones()],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => setState(() {
          _textoActual = '';
          _transcripciones.clear();
        }),
        child: Icon(Icons.delete_outline),
        backgroundColor: Color.fromRGBO(138, 180, 248, 1),
      ),
    );
  }

  _listarTranscripciones(){
    List<Widget> lista = [];//_transcripciones.map((e) => Texto(e)).toList();
    lista.add(Texto(_textoActual));
    return lista; 
  }

  void _empezarAEscuchar() async{
    await Permission.microphone.request();
    bool disponible = await _speech.initialize( 
      onStatus: (status){
        if(status == 'notListening'){
          setState(() {
            // if(_textoActual != ''){
            //   _transcripciones.add(_textoActual);
            //   _textoActual = '';
            // }
            _empezarAEscuchar();
          });
        }else if(status == 'done'){
        }
      }, 
      onError: (error)=>print('Error: $error') );
    if ( disponible ) {
      _speech.listen( 
        onResult: (result){
          setState(() {
            _textoActual = result.recognizedWords;
          });
        },
        // listenFor: Duration(seconds: 15)
      );
    }
    else {
      print("The user has denied the use of speech recognition.");
    }
  }

  @override
  void dispose() {
    _speech.stop();
    super.dispose();
  }
}