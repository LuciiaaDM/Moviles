import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/logger.dart';
import 'signUp.dart'; // Importa la pantalla de registro
import 'homePage.dart'; // Importa la pantalla homePage

class SignIn extends StatelessWidget {
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final Logger logger = Logger();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign In'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: userNameController,
              decoration: const InputDecoration(labelText: 'Username'),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Password'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () async {
                if (userNameController.text.isNotEmpty &&
                    passwordController.text.isNotEmpty) {
                  bool isAuthenticated = await authenticateUser(
                      userNameController.text, passwordController.text, context);
                  if (isAuthenticated) {
                    if(!context.mounted) return;
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage(username: userNameController.text)),
                    );
                  } else {
                    if(!context.mounted) return;
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Error'),
                        content: const Text('Invalid username or password.'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('OK'),
                          ),
                        ],
                      ),
                    );
                    logger.e('Invalid username or password');
                  }
                } else {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Error'),
                      content: const Text('Please fill in all fields.'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('OK'),
                        ),
                      ],
                    ),
                  );
                  logger.w('Please fill in all fields.');
                }
              },
              child: const Text('Sign In'),
            ),
            const SizedBox(height: 10),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignUp()),
                );
              },
              child: const Text("Don't have an account? Sign Up here"),
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> authenticateUser(
      String username, String password, BuildContext context) async {
    try {
      CollectionReference usersCollection =
          FirebaseFirestore.instance.collection('Users');

      QuerySnapshot querySnapshot = await usersCollection
          .where('username', isEqualTo: username)
          .where('password', isEqualTo: password)
          .get();

      return querySnapshot.docs.isNotEmpty;
    } catch (error) {
      logger.e('Error authenticating user: $error');
      return false;
    }
  }
}
