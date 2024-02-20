import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:moviles/message_page.dart';
import 'package:moviles/homepage_layout.dart';
import 'package:moviles/search_page.dart';
import 'package:moviles/add_post.dart';
import 'package:moviles/profile_page.dart';
import 'package:moviles/home_page.dart';

class ChatsPage extends StatefulWidget {
  final String username;

  const ChatsPage({Key? key, required this.username}) : super(key: key);

  @override
  _ChatsPageState createState() => _ChatsPageState();
}

class _ChatsPageState extends State<ChatsPage> {
  late List<DocumentSnapshot> _usersWithMessages = [];


  @override
  void initState() {
    super.initState();
    _getUsersWithMessages();
  }

  Future<void> _getUsersWithMessages() async {
    try {
      QuerySnapshot messagesSnapshot = await FirebaseFirestore.instance
          .collection('Users')
          .doc(widget.username)
          .collection('messages')
          .get();
      
      setState(() {
        _usersWithMessages = messagesSnapshot.docs; // Asignar directamente los documentos
      });
    } catch (error) {
      print('Error fetching users with messages: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return HomePageLayout(
      pageTitle: 'Chats',
      username: widget.username,
      body: _usersWithMessages == null
          ? const Center(child: CircularProgressIndicator()) // Muestra un indicador de carga mientras se cargan los datos
          : _usersWithMessages!.isEmpty
              ? const Center(child: Text('No chats available')) // Mostrar mensaje si no hay chats
              : ListView.builder(
                  itemCount: _usersWithMessages!.length,
                  itemBuilder: (context, index) {
                    var otherUsername = _usersWithMessages![index].id;
                    return Card(
                      margin: const EdgeInsets.all(8.0),
                      child: ListTile(
                        title: Text(
                          otherUsername,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MessagePage(
                                currentUsername: widget.username,
                                otherUsername: otherUsername,
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
      currentIndex: 3,
      onTabSelected: (index) {
        switch (index) {
          case 0:
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HomePage(username: widget.username),
              ),
            );
            break;
          case 1:
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SearchPage(username: widget.username),
              ),
            );
            break;
          case 2:
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddPostPage(username: widget.username),
              ),
            );
            break;
          case 4:
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProfilePage(username: widget.username),
              ),
            );
            break;
        }
      },
    );
  }
}
