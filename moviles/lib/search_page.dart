import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:moviles/add_post.dart';
import 'package:moviles/homepage_layout.dart';
import 'package:moviles/profile_page.dart';
import 'package:moviles/home_page.dart';
import 'package:moviles/chats_page.dart';
import 'package:moviles/post_detail_page.dart';
import 'package:moviles/domain/entities/post.dart';

class SearchPage extends StatefulWidget {
  final String username;

  const SearchPage({Key? key, required this.username}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late String country = '';
  late String city = '';
  late String filterType = 'General';

  void searchPosts() {
    // Query the posts collection with the specified filters
    // You can adjust this query according to your Firestore structure
    Query postsQuery = FirebaseFirestore.instance.collection('Posts');

    // Apply filter by country if it's not empty
    if (country.isNotEmpty) {
      postsQuery = postsQuery.where('country', isEqualTo: country);
    }

    // Apply filter by city field if it's not empty
    if (city.isNotEmpty) {
      postsQuery = postsQuery.where('city', isEqualTo: city);
    }

    // Apply filter by post type
    if (filterType != 'General') {
      postsQuery = postsQuery.where('type', isEqualTo: filterType);
    }

    // Execute the query and navigate to a new page to display the search results
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SearchResultPage(postsQuery: postsQuery, username: widget.username),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return HomePageLayout(
      pageTitle: 'SEARCH',
      username: widget.username,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              onChanged: (value) => country = value,
              decoration: const InputDecoration(
                labelText: 'Search by Country',
              ),
            ),
            const SizedBox(height: 20), // Increase the space between the fields
            TextField(
              onChanged: (value) => city = value,
              decoration: const InputDecoration(
                labelText: 'City',
              ),
            ),
            const SizedBox(height: 20), // Increase the space between the fields
            DropdownButtonFormField<String>(
              value: filterType,
              decoration: const InputDecoration(
                labelText: 'Filter by Post Type',
              ),
              items: ['General', 'Lifestyle', 'Educational'].map((type) {
                return DropdownMenuItem<String>(
                  value: type,
                  child: Text(type),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  filterType = value!;
                });
              },
            ),
            const SizedBox(height: 20), // Increase the space between the fields
            ElevatedButton(
              onPressed: searchPosts,
              child: const Text('Search'),
            ),
          ],
        ),
      ),
      currentIndex: 1,
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
          case 2:
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddPostPage(username: widget.username),
              ),
            );
            break;
          case 3:
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChatsPage(username: widget.username),
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

class SearchResultPage extends StatelessWidget {
  final Query postsQuery;
  final String username;

  const SearchResultPage({Key? key, required this.postsQuery, required this.username}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Results'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: postsQuery.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          List<QueryDocumentSnapshot> posts = snapshot.data!.docs;
          if (posts.isEmpty) {
            return const Center(child: Text('No posts found'));
          }
          return ListView.builder(
            itemCount: posts.length,
            itemBuilder: (context, index) {
              var post = posts[index];
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
              // Customize how each post is displayed
              return ListTile(
                title: Text(
                  post['author'],
                  style: TextStyle(fontSize: 20), // Tamaño de fuente aumentado a 20
                ),
                subtitle: Text(
                  post['title'],
                  style: TextStyle(fontSize: 20), // Tamaño de fuente aumentado a 20
                ),
                onTap: () {
                  // Navigate to the post detail page when tapped
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PostDetailPage(post: newPost, username: username),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
