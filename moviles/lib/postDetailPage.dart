import 'package:flutter/material.dart';
import 'package:moviles/domain/entities/post.dart'; // Asegúrate de importar la clase Post desde el archivo correcto

class PostDetailPage extends StatelessWidget {
  final Post post; // El post seleccionado que se mostrará en detalle

  PostDetailPage({required this.post});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Post Detail'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              post.title,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text('Type: ${post.type}'),
            Text('Country: ${post.country}'),
            Text('City: ${post.city}'),
            Text('Text: ${post.text}'),
            if (post.images.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10),
                  Text('Images:'),
                  SizedBox(height: 5),
                  Column(
                    children: post.images.map((image) {
                      return Image.network(image); // Muestra las imágenes utilizando la URL
                    }).toList(),
                  ),
                ],
              ),
            if (post.type == 'Educational')
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10),
                  Text('University: ${post.university}'),
                  Text('Campus: ${post.campus}'),
                ],
              ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Aquí puedes implementar la lógica para contactar al usuario que publicó el post
                // Puedes abrir un formulario de contacto o iniciar una conversación de chat con el usuario.
              },
              child: Text('Contact User'),
            ),
          ],
        ),
      ),
    );
  }
}
