import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'sign_in.dart'; // Importa la pantalla de inicio de sesión
import 'firebase_options.dart';

void main() async {
  // Inicializa Firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Moviles',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        backgroundColor: Colors.lightBlue[100], // Establece el color de fondo azul claro
        body: SignIn(), // Define la pantalla de inicio de sesión como la pantalla inicial
      ),
    );
  }
}
