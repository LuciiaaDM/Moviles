import 'package:flutter/material.dart';
import 'package:moviles/domain/entities/post.dart'; 
import 'package:moviles/message_page.dart'; 

class PostDetailPage extends StatelessWidget {
  final Post post;
  final String username;

  const PostDetailPage({
    Key? key,
    required this.post,
    required this.username,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue[100], // Fondo de la barra superior azul
        title: const Text(
          'POST DETAIL', // Título en mayúsculas
          style: TextStyle(
            fontWeight: FontWeight.bold, // Negrita
            fontSize: 28, // Tamaño de fuente más grande
          ),
        ),
        centerTitle: true, // Centrar el título
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              post.title,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              'Author: ${post.author}',
              style: const TextStyle(fontSize: 18), // Aumentar el tamaño de fuente
            ),
            Text(
              'Type: ${post.type}',
              style: const TextStyle(fontSize: 18), // Aumentar el tamaño de fuente
            ),
            Text(
              'Country: ${post.country}',
              style: const TextStyle(fontSize: 18), // Aumentar el tamaño de fuente
            ),
            Text(
              'City: ${post.city}',
              style: const TextStyle(fontSize: 18), // Aumentar el tamaño de fuente
            ),
            if (post.type == 'Educational')
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'University: ${post.university}',
                    style: const TextStyle(fontSize: 18), // Aumentar el tamaño de fuente
                  ),
                  Text(
                    'Campus: ${post.campus}',
                    style: const TextStyle(fontSize: 18), // Aumentar el tamaño de fuente
                  ),
                ],
              ),
            Text(
              'Text: ${post.text}',
              style: const TextStyle(fontSize: 18), // Aumentar el tamaño de fuente
            ),
            const SizedBox(height: 20),
            if (post.author != username)
              ElevatedButton(
                onPressed: () {
                  /*FirebaseFirestore.instance
                    .collection('Users')
                    .doc(username)
                    .collection('messages')
                    .doc(post.author)
                    .collection('conversation')
                    .add({
                      'sender': username,
                      'content': "Hi, I'm $username",
                      'timestamp': Timestamp.now(),
                    });
                  FirebaseFirestore.instance
                    .collection('Users')
                    .doc(post.author)
                    .collection('messages')
                    .doc(username)
                    .collection('conversation')
                    .add({
                      'sender': username,
                      'content': "Hi, I'm $username",
                      'timestamp': Timestamp.now(),
                    }); */
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MessagePage(
                        currentUsername: username,
                        otherUsername: post.author,// Mensaje inicial al contactar al usuario
                      ),
                    ),
                  );
                },
                child: const Text('Contact User'),
              ),
          ],
        ),
      ),
    );
  }
}
