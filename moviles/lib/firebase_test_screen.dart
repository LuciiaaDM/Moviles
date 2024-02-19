import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseTestScreen extends StatelessWidget {
  const FirebaseTestScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Firestore Collection List'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Función para obtener y mostrar la lista de colecciones
            agregarDocumento();
          },
          child: const Text('List Firestore Collections'),
        ),
      ),
    );
  }

  void agregarDocumento() {
    FirebaseFirestore.instance.collection('uuuu').add({
      'campo1': 'valor1',
      'campo2': 'valor2',
      // Puedes agregar más campos aquí
    }).then((value) {
      print('Documento agregado con ID: ${value.id}');
    }).catchError((error) {
      print('Error al agregar el documento: $error');
    });
  }
  
}
