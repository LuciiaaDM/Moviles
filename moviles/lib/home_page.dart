import 'package:flutter/material.dart';
import 'package:moviles/add_post.dart';
import 'package:moviles/homepage_layout.dart';
import 'package:moviles/profile_page.dart';
import 'package:moviles/search_page.dart';


class HomePage extends StatelessWidget {
  final String username;

  const HomePage({Key? key, required this.username}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HomePageLayout(
      pageTitle: 'Home',
      username: username,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Aquí puedes mostrar información de los posts
          Container(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Información de los Posts',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 5, // Número de posts a mostrar
              itemBuilder: (context, index) {
                // Aquí debes cargar la información real de los posts desde la base de datos
                // Por ahora, se muestra información de ejemplo
                return ListTile(
                  title: Text('Título del Post $index'),
                  subtitle: Text('Contenido del Post $index'),
                );
              },
            ),
          ),
        ],
      ),
      currentIndex: 0,
      onTabSelected: (index) {
        switch (index) {
          case 1:
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SearchPage(username: username),
              ),
            );
            break;
          case 2:
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddPostPage(username: username),
              ),
            );
            break;
          case 3:
            Navigator.pushReplacementNamed(context, '/messages');
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
