import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:moviles/post_detail_page.dart';
import 'package:moviles/domain/entities/post.dart';

class ViewMyPostsPage extends StatefulWidget {
  final String username;

  const ViewMyPostsPage({Key? key, required this.username}) : super(key: key);

  @override
  _ViewMyPostsPageState createState() => _ViewMyPostsPageState();
}

class _ViewMyPostsPageState extends State<ViewMyPostsPage> {
  late List<DocumentSnapshot> _posts = [];

  @override
  void initState() {
    super.initState();
    _getPosts();
  }

  Future<void> _getPosts() async {
    QuerySnapshot postsSnapshot = await FirebaseFirestore.instance
        .collection('Posts')
        .where('author', isEqualTo: widget.username)
        .get();

    setState(() {
      _posts = postsSnapshot.docs;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue[100], // Fondo de la barra superior azul
        title: const Text(
          'MY POSTS', // Título en mayúsculas
          style: TextStyle(
            fontWeight: FontWeight.bold, // Negrita
            fontSize: 28, // Tamaño de fuente más grande
          ),
        ),
        centerTitle: true, // Centrar el título
      ),
      body: ListView.builder(
        itemCount: _posts.length,
        itemBuilder: (context, index) {
          var post = _posts[index];
          var newPost = Post(
            author: post['author'],
            title: post['title'],
            type: post['type'],
            country: post['country'],
            city: post['city'],
            university: post['university'] ?? '',
            campus: post['campus'] ?? '',
            text: post['text'],
          );

          return Card(
            margin: const EdgeInsets.all(8), // Add margin for spacing between cards
            child: ListTile(
              title: Text(
                newPost.title,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold), // Set the font size to 20 and make it bold (adjust as needed)
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Type: ${newPost.type}'), // Display post type
                  Text('City: ${newPost.city}'), // Display post city
                  Text('Country: ${newPost.country}'), // Display post country
                  if (newPost.type == 'Educational') ...[
                    Text('University: ${newPost.university}'), // Display post university if type is Educational
                    Text('Campus: ${newPost.campus}'), // Display post campus if type is Educational
                  ],
                ],
              ),
              onTap: () {
                // When a post is tapped, navigate to the post detail screen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PostDetailPage(post: newPost, username: widget.username), // Pass post data and username to the post detail page
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
