import 'package:flutter/material.dart';
import 'signIn.dart'; // Importa la pantalla de inicio de sesión

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Moviles',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SignIn(), // Define la pantalla de inicio de sesión como la pantalla inicial
    );
  }
}
