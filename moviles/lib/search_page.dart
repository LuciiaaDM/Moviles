import 'package:flutter/material.dart';
import 'package:moviles/add_post.dart';
import 'package:moviles/homepage_layout.dart';
import 'package:moviles/profile_page.dart';
import 'package:moviles/home_page.dart';


class SearchPage extends StatelessWidget {
  final String username;

  const SearchPage({Key? key, required this.username}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HomePageLayout(
      pageTitle: 'Search',
      username: username,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Search by Country',
              ),
            ),
            SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(
                labelText: 'Optional: City or University',
              ),
            ),
            SizedBox(height: 10),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: 'Filter by Post Type',
              ),
              items: ['General', 'Lifestyle', 'Educational'].map((type) {
                return DropdownMenuItem<String>(
                  value: type,
                  child: Text(type),
                );
              }).toList(),
              onChanged: (value) {},
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // Lógica para realizar la búsqueda con los filtros seleccionados
              },
              child: Text('Search'),
            ),
          ],
        ),
      ),
      currentIndex: 1,
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
          case 2:
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddPostPage(username: username),
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
