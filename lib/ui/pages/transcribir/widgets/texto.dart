import 'package:flutter/material.dart';

class Texto extends StatelessWidget {
  String _texto;
  Texto(this._texto );

  @override
  Widget build(BuildContext context){
    return Text(
      _texto,
      style: TextStyle(
        color: Colors.white,
        fontSize: 30
      ),  
    );
  }
}