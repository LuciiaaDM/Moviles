import 'package:flutter/material.dart';
import 'package:moviles/domain/entities/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class HomePage extends StatelessWidget {
  final String username;

  const HomePage({required this.username});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: FirebaseFirestore.instance.collection('Users').doc(username).get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(); // Muestra un indicador de carga mientras se obtienen los datos del usuario.
        }
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}'); // Muestra un mensaje de error si ocurre un error al obtener los datos del usuario.
        }
        if (!snapshot.hasData || !snapshot.data!.exists) {
          return Text('User not found'); // Muestra un mensaje si no se encuentra el usuario en Firestore.
        }

        // Recupera los datos del usuario desde el documento obtenido.
        Map<String, dynamic> userData = snapshot.data!.data() as Map<String, dynamic>;
        // Utiliza los datos del usuario para construir la interfaz de usuario de la página de inicio.
        return Scaffold(
          appBar: AppBar(
            title: Text('Welcome, ${userData['username']}!'),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Username: ${userData['username']}'),
                Text('Email: ${userData['email']}'),
                // Agrega más campos según sea necesario
              ],
            ),
          ),
        );
      },
    );
  }
}
