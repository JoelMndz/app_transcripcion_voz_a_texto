import 'package:flutter/material.dart';
import 'package:transcripcion_texto/ui/pages/transcribir/transcribir.dart';

Map<String, WidgetBuilder> getRoutes(BuildContext context){
  return <String, WidgetBuilder>{
    '/': (context) => const TranscribirPage(),
  };
}