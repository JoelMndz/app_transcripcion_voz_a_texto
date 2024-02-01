import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:transcripcion_texto/ui/pages/transcribir/widgets/circulo.dart';
import 'package:transcripcion_texto/ui/pages/transcribir/widgets/texto.dart';
import 'package:transcripcion_texto/ui/providers/transcripcion.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TranscribirPage extends StatefulWidget {
  const TranscribirPage({ Key? key }) : super(key: key);

  @override
  _TranscribirState createState() => _TranscribirState();
}

class _TranscribirState extends State<TranscribirPage> {

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<TranscripcionProvider>();

    return Scaffold(
      backgroundColor: Color.fromRGBO(35, 32, 31, 1),
      body: Column(
        children: [
          Flexible(
            flex: 7,
            child: Scrollbar(
              child: ListView(
                padding: EdgeInsets.only(top: 50, bottom: 10, left: 10, right: 10),
                children: [
                  Texto(provider.textoActual ?? ''),
                  if(!provider.escuchando) ...mostrarEnLenguaSignos(provider.textoActual),

                ],
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: Circulo(
              animar: provider.escuchando,
              onTap: ()=> provider.empezarAEscuchar(),
            ),
          )
        ],
      ),
    );
  }

  List<Widget> mostrarEnLenguaSignos(String? texto){
    final palabras = texto?.split(' ') ?? [];
    List<Row> filas = [];
    for (var palabra in palabras) {
      final caracteres = palabra.split('');
      List<Widget> imagenes = [];
      for (var caracter in caracteres) {
        if(esDelAbecedario(caracter)){
          if(esVocal(caracter)){
            caracter = quitarTilde(caracter);
          }
          imagenes.add(Expanded(child: Image.asset('assets/abecedario/${caracter.toLowerCase()}.png')));  
        }
      }
      filas.add(Row(children: imagenes,));
    } 
    return filas.length != 0 ? [Divider(),...filas] : filas;
  }

  bool esDelAbecedario(String input) {
    RegExp regExp = RegExp(r'^[a-zA-ZáéíóúüñÁÉÍÓÚÜÑ]+$');
    return regExp.hasMatch(input);
  }
  
  bool esVocal(String vocal){
    RegExp regExp = RegExp(r'^[aeiouáéíóúüAEIOUÁÉÍÓÚÜ]+$');
    return regExp.hasMatch(vocal);
  }

  String quitarTilde(String vocal){
    if(vocal.toLowerCase() == 'á') return "a";
    if(vocal.toLowerCase() == 'é') return "e";
    if(vocal.toLowerCase() == 'í') return "i";
    if(vocal.toLowerCase() == 'ó') return "o";
    if(vocal.toLowerCase() == 'ú') return "u";
    return vocal;
  }

  @override
  void dispose() {
    Provider.of<TranscripcionProvider>(context, listen: false).detener();
    super.dispose();
  }
}