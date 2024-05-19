import 'package:flutter/material.dart';
import 'views/Module_1/info_screen.dart';
import './splashScreen.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'glucosync',
      initialRoute: '/info', // Ruta inicial
      routes: {
        '/info': (context) => SplashScreen(), // Ruta para la pantalla de información
      },
    );
  }
}
//SplashScreen
//InfoScreen