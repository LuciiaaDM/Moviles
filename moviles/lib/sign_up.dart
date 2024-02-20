import 'package:flutter/material.dart';
import 'package:moviles/domain/entities/user.dart'; // Import the User class
import 'package:cloud_firestore/cloud_firestore.dart'; // Import the Cloud Firestore library
import 'package:logger/logger.dart'; // Import the Logger library

class SignUp extends StatelessWidget {
  // Text editing controllers for various input fields
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController universityController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController birthdayController = TextEditingController(); // New controller variable for birthday
  final TextEditingController cityErasmusController = TextEditingController();
  final TextEditingController countryErasmusController = TextEditingController();
  final TextEditingController universityErasmusController = TextEditingController();
  final TextEditingController campusErasmusController = TextEditingController();

  final Logger logger = Logger(); // Logger instance for logging messages

  SignUp({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SIGN UP USERS'),
      ),
      body: Container(
        color: Colors.lightBlue[100], // Light blue background color
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Input fields for user registration
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
                TextFormField(
                  controller: confirmPasswordController,
                  obscureText: true,
                  decoration: const InputDecoration(labelText: 'Confirm Password'),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(labelText: 'Email'),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: countryController,
                  decoration: const InputDecoration(labelText: 'Country'),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: cityController,
                  decoration: const InputDecoration(labelText: 'City'),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: universityController,
                  decoration: const InputDecoration(labelText: 'University'),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: phoneNumberController,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(labelText: 'Telephone Number'),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: birthdayController, // Use the birthday controller
                  keyboardType: TextInputType.datetime, // Set the keyboard type as date and time
                  decoration: const InputDecoration(labelText: 'Birthday (YYYY-MM-DD)'),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: cityErasmusController,
                  decoration: const InputDecoration(labelText: 'Erasmus City (Optional)'),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: countryErasmusController,
                  decoration: const InputDecoration(labelText: 'Erasmus Country (Optional)'),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: universityErasmusController,
                  decoration: const InputDecoration(labelText: 'Erasmus University (Optional)'),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: campusErasmusController,
                  decoration: const InputDecoration(labelText: 'Erasmus Campus (Optional)'),
                ),
                const SizedBox(height: 10),
                // Button to sign up a new user
                ElevatedButton(
                  onPressed: () async {
                    // Check if passwords match
                    if (passwordController.text == confirmPasswordController.text) {
                      // Parse the birthday
                      DateTime? birthday = DateTime.tryParse(birthdayController.text);
                      if (birthday != null) {
                        // Convert the birthday to a Timestamp to store it in Firestore
                        Timestamp birthdayTimestamp = Timestamp.fromDate(birthday);
                        User newUser = User(
                          userName: userNameController.text,
                          password: passwordController.text,
                          email: emailController.text,
                          country: countryController.text,
                          city: cityController.text,
                          university: universityController.text,
                          phoneNumber: phoneNumberController.text,
                          birthday: birthdayTimestamp, // Store the birthday as a Timestamp in Firestore
                          cityErasmus: cityErasmusController.text,
                          countryErasmus: countryErasmusController.text,
                          universityErasmus: universityErasmusController.text,
                          campusErasmus: campusErasmusController.text,
                        );
                        bool result = await signUp(newUser);
                        if (!result) {
                          // Show error dialog if username already exists
                          if (!context.mounted) return;
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('Error'),
                              content: const Text('The username already exists.'),
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
                          logger.e('The username already exists.');
                        } else {
                          if (!context.mounted) return;
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('Success'),
                              content: const Text('The user was registered successfully.'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    Navigator.pop(context); // Return to the login screen
                                  },
                                  child: const Text('OK'),
                                ),
                              ],
                            ),
                          );
                        }
                      } else {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('Error'),
                            content: const Text('Invalid date format for birthday.'),
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
                        logger.e('Invalid date format for birthday.');
                      }
                    } else {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Error'),
                          content: const Text('The passwords doesn\'t match.'),
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
                      logger.e('The passwords doesn\'t match.');
                    }
                  },
                  child: const Text('Sign up'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> signUp(User user) async {
    try {
      // Get the reference to the 'Users' collection in Firestore
      CollectionReference usersCollection = FirebaseFirestore.instance.collection('Users');
      // Check if the user already exists
      QuerySnapshot userExists = await usersCollection.where('username', isEqualTo: user.userName).get();
      if (userExists.docs.isNotEmpty) {
        return false;
      }

      DocumentReference newUserDoc = usersCollection.doc(user.userName);
      
      // Create message and post collections if necessary
      // CollectionReference messagesCollection = 
      // newUserDoc.collection('messages');
      // CollectionReference postsCollection = 
      // newUserDoc.collection('posts');
      
      // Add documents to collections if necessary
      // messagesCollection.add({});
      // postsCollection.add({});

      // Save user data to Firestore
      await newUserDoc.set({
        'username': user.userName,
        'password': user.password,
        'email': user.email,
        'country': user.country,
        'city': user.city,
        'university': user.university,
        'phoneNumber': user.phoneNumber,
        'birthday': user.birthday,
        'cityErasmus': user.cityErasmus,
        'countryErasmus': user.countryErasmus,
        'universityErasmus': user.universityErasmus,
        'campusErasmus': user.campusErasmus,
      });

      return true;
    } catch (error) {
      // Log any errors that occur during the sign-up process
      logger.e('Something is wrong: $error');
      return false;
    }
  }

}
