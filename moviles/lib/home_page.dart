import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:moviles/post_detail_page.dart';
import 'package:moviles/domain/entities/post.dart';
import 'package:moviles/homepage_layout.dart'; // Import the HomePage layout
import 'package:moviles/search_page.dart'; // Import the search screen
import 'package:moviles/add_post.dart'; // Import the add post screen
import 'package:moviles/profile_page.dart'; // Import the profile screen
import 'package:moviles/chats_page.dart'; // Import the chats screen

class HomePage extends StatefulWidget {
  final String username;

  const HomePage({Key? key, required this.username}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<DocumentSnapshot> _posts = [];

  @override
  void initState() {
    super.initState();
    // Call the function to fetch posts when the page initializes
    _getPosts();
  }

  Future<void> _getPosts() async {
    // Query the database to fetch all posts
    QuerySnapshot postsSnapshot =
        await FirebaseFirestore.instance.collection('Posts').get();

    setState(() {
      _posts = postsSnapshot.docs;
    });
  }

  @override
  Widget build(BuildContext context) {
    return HomePageLayout(
      pageTitle: 'HOME',
      username: widget.username,
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
            margin: const EdgeInsets.all(8.0), // Add margin around the card
            child: ListTile(
              title: Text(
                newPost.title,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold), // Set the font size to 20 and make it bold
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Author: ${newPost.author}'),
                  Text('Type: ${newPost.type}'),
                  Text('City: ${newPost.city}'),
                  Text('Country: ${newPost.country}'),
                  if (newPost.type == 'Educational') ...[
                    Text('University: ${newPost.university}'),
                    Text('Campus: ${newPost.campus}'),
                  ],
                ],
              ),
              onTap: () {
                // When a post is tapped, navigate to the post detail screen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PostDetailPage(post: newPost, username: widget.username),
                  ),
                );
              },
            ),
          );
        },
      ),
      currentIndex: 0,
      onTabSelected: (index) {
        switch (index) {
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
          case 3:
            Navigator.push(context,
              MaterialPageRoute(
                builder: (context) => ChatsPage (username: widget.username),
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
