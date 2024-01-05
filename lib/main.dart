import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transcripcion_texto/di/injeccionDependencias.dart';
import 'package:transcripcion_texto/ui/routes/routes.dart';

void main() {
  inicialzarInjeccionDependencias();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: getProviders(),
      builder: (context, child) {
        return MaterialApp(
          title: 'Transcripcion Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
            useMaterial3: true,
          ),
          debugShowCheckedModeBanner: false,
          routes: getRoutes(context),
          initialRoute: '/',
        );
      }
    );
  }
}
