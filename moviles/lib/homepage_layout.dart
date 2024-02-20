import 'package:flutter/material.dart';
import 'package:moviles/sign_in.dart';

class HomePageLayout extends StatelessWidget {
  final String pageTitle;
  final String username;
  final Widget body;
  final int currentIndex;
  final Function(int) onTabSelected;

  const HomePageLayout({
    Key? key,
    required this.pageTitle,
    required this.username,
    required this.body,
    required this.currentIndex,
    required this.onTabSelected,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue[100], // Fondo azul claro
        automaticallyImplyLeading: false,        
        title: Center(
          child: Text(
            pageTitle.toUpperCase(), // Convertir a mayúsculas
            style: const TextStyle(
              fontSize: 28.0,
              fontWeight: FontWeight.bold, // Texto en negrita
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Text(
              username,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          IconButton( // Botón de LogOut
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SignIn(),
                ),
              );
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: body,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.grey[300], // Fondo gris
        selectedItemColor: Colors.grey, // Íconos seleccionados en gris
        unselectedItemColor: Colors.grey, // Íconos no seleccionados en gris
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, size: 40.0), // Icono más grande
            label: 'Home',
            // Tamaño del texto aumentado
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search, size: 40.0), // Icono más grande
            label: 'Find',
            // Tamaño del texto aumentado
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add, size: 40.0), // Icono más grande
            label: 'New Post',
            // Tamaño del texto aumentado
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message, size: 40.0), // Icono más grande
            label: 'Chats',
            // Tamaño del texto aumentado
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, size: 40.0), // Icono más grande
            label: 'Profile',
            // Tamaño del texto aumentado
          ),
        ],
        onTap: (index) => onTabSelected(index),
      ),
    );
  }
}
