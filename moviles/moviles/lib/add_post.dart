import 'package:flutter/material.dart';
import 'package:moviles/homepage_layout.dart';
import 'package:moviles/profile_page.dart';
import 'package:moviles/home_page.dart';
import 'package:moviles/search_page.dart';

class AddPostPage extends StatelessWidget {
  final String username;

  const AddPostPage({Key? key, required this.username}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            ),
            const SizedBox(height: 10),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(labelText: 'Type'),
              items: ['General', 'Educational', 'Lifestyle'].map((type) {
                return DropdownMenuItem<String>(
                  value: type,
                  child: Text(type),
                );
              }).toList(),
              onChanged: (value) {},
            ),
            const SizedBox(height: 10),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Country'),
              initialValue: 'Erasmus Country', // Valor autorelleno
            ),
            const SizedBox(height: 10),
            TextFormField(
              decoration: const InputDecoration(labelText: 'City'),
              initialValue: 'Erasmus City', // Valor autorelleno
            ),
            const SizedBox(height: 10),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Text'),
              maxLines: null,
            ),
            const SizedBox(height: 10),
            TextFormField(
              decoration: const InputDecoration(labelText: 'University'),
              initialValue: 'Erasmus University', // Valor autorelleno
            ),
            const SizedBox(height: 10),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Campus'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // Lógica para enviar el post
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
            // Navegar a la página de mensajes
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
}
