import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  final List<String> users; // Lista de usuarios con los que el usuario ha tenido interacciones de chat

  const ChatPage({super.key, required this.users});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat'),
      ),
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];
          return ListTile(
            title: Text(user),
            onTap: () {
              // Aquí puedes navegar a la pantalla de chat con el usuario seleccionado
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatScreen(user: user),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class ChatScreen extends StatelessWidget {
  final String user; // Usuario con el que se abrirá la conversación de chat

  const ChatScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat with $user'),
      ),
      body: Center(
        child: Text('Chat with $user'), // Puedes personalizar esta pantalla para mostrar mensajes de chat
      ),
    );
  }
}
