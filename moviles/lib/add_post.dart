import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:moviles/chats_page.dart';
import 'package:moviles/homepage_layout.dart';
import 'package:moviles/profile_page.dart';
import 'package:moviles/home_page.dart';
import 'package:moviles/search_page.dart';
import 'package:logger/logger.dart';

class AddPostPage extends StatelessWidget {
  final String username;
  final Logger logger = Logger();

  AddPostPage({Key? key, required this.username}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String title = '';
    String type = 'General';
    String erasmusCountry = '';
    String erasmusCity = '';
    String erasmusUniversity = '';
    String campus = '';
    String text = '';

    return HomePageLayout(
      pageTitle: 'New Post',
      username: username,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              decoration: const InputDecoration(labelText: 'Title'),
              onChanged: (value) {
                title = value;
              },
            ),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(labelText: 'Type'),
              value: type,
              items: ['General', 'Educational', 'Lifestyle'].map((type) {
                return DropdownMenuItem<String>(
                  value: type,
                  child: Text(type),
                );
              }).toList(),
              onChanged: (value) {
                type = value ?? '';
              },
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Erasmus Country'),
              onChanged: (value) {
                erasmusCountry = value;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Erasmus City'),
              onChanged: (value) {
                erasmusCity = value;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Erasmus University'),
              onChanged: (value) {
                erasmusUniversity = value;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Campus'),
              onChanged: (value) {
                campus = value;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Text'),
              maxLines: null,
              onChanged: (value) {
                text = value;
              },
            ),
            ElevatedButton(
              onPressed: () {
                // Lógica para enviar el post
                _publish(
                  context,
                  username,
                  title,
                  type,
                  erasmusCountry,
                  erasmusCity,
                  erasmusUniversity,
                  campus,
                  text,
                );
              },
              child: const Text('Post'),
            ),
          ],
        ),
      ),
      currentIndex: 2,
      onTabSelected: (index) {
        // Manejar el cambio de pestaña
        switch (index) {
          case 0:
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HomePage(username: username),
              ),
            );
            break;
          case 1:
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SearchPage(username: username),
              ),
            );
            break;
          case 3:
            Navigator.push(context,
              MaterialPageRoute(
                builder: (context) => ChatsPage (username: username),
              ),
            );
            break;
          case 4:
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProfilePage(username: username),
              ),
            );
            break;
        }
      },
    );
  }

  void _publish(
    BuildContext context,
    String username,
    String title,
    String type,
    String erasmusCountry,
    String erasmusCity,
    String erasmusUniversity,
    String campus,
    String text,
  ) async {

    try {
      // Crear un nuevo documento en la colección "Posts" con un ID único
      final newPostRef = FirebaseFirestore.instance.collection('Posts').doc();

      // Establecer los valores del post en el documento
      await newPostRef.set({
        'author': username,
        'title': title,
        'type': type,
        'country': erasmusCountry,
        'city': erasmusCity,
        'university': erasmusUniversity,
        'campus': campus,
        'text': text,
      });
      
      if(!context.mounted) return;

      // Mostrar un mensaje de éxito
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Post published correctly')),
      );
      Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HomePage(username: username),
              ),
      );

      // Limpiar los campos después de enviar el post
      // Puedes añadir esta lógica según tus necesidades
    } catch (error) {
      // Manejar cualquier error que ocurra al enviar el post
      logger.e('Error at publishing the post: $error');
      // Mostrar un mensaje de error si es necesario
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error')),
      );
    }
  }

}
