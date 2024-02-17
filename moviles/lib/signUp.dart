import 'package:flutter/material.dart';
import 'package:moviles/domain/entities/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; //Import the Cloud Firestore package
import 'package:logger/logger.dart';

class SignUp extends StatelessWidget {
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController universityController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController birthdayController = TextEditingController();
  final TextEditingController cityErasmusController = TextEditingController();
  final TextEditingController countryErasmusController = TextEditingController();
  final TextEditingController universityErasmusController = TextEditingController();
  final TextEditingController campusErasmusController = TextEditingController();

final Logger logger = Logger();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up Users'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
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
              ElevatedButton(
                onPressed: () async{
                  if (passwordController.text == confirmPasswordController.text) {
                    User newUser = User(
                      userName: userNameController.text,
                      password: passwordController.text,
                      email: emailController.text,
                      country: countryController.text,
                      city: cityController.text,
                      university: universityController.text,
                      phoneNumber: phoneNumberController.text,
                      birthday: DateTime.parse(birthdayController.text),
                      cityErasmus: cityErasmusController.text,
                      countryErasmus: countryErasmusController.text,
                      universityErasmus: universityErasmusController.text,
                      campusErasmus: campusErasmusController.text,
                    );
                    // Function sign up
                    bool result = await signUp(newUser);
                    if(!result){
                      if(!context.mounted) return;
                      // Mostrar un mensaje de error si el usuario ya existe
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
                    }
                    else{
                      if(!context.mounted) return;
                      // Mostrar un mensaje de éxito si el usuario se registró correctamente
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Success'),
                          content: const Text('The user was registered successfully.'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                                Navigator.pop(context); //Regresa a la pantalla de registro
                                Navigator.pop(context); //Regresa a la pantalla de inicio de sesión
                              },
                              child: const Text('OK'),
                            ),
                          ],
                        ),
                      );
                    }

                  } else {
                    // Mostrar un mensaje de error si las contraseñas no coinciden
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Error'),
                        content: const Text('The passwords doesnt match.'),
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
                    logger.e('The passwords doesnt match.');
                  }
                },
                child: const Text('Sign up'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> signUp(User user) async {
    try {
      // Obtain the collection reference Users
      CollectionReference usersCollection = FirebaseFirestore.instance.collection('Users');
      
      //Check if the username already exists
      QuerySnapshot userExists = await usersCollection.where('username', isEqualTo: user.userName).get();

      if (userExists.docs.isNotEmpty) {
        
        return false;
      }


      // Creates a new document for the user with a uniq ID
      DocumentReference newUserDoc = usersCollection.doc(user.userName); // Generates a new ID for the user

      // Creates the new colections for posts and for messages
      newUserDoc.collection('messages');
      newUserDoc.collection('posts');

      // Add all the filds of the user to the document
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
        'campusErasmus': user.campusErasmus
        // Agrega más campos según sea necesario
      });

      // Registro de usuario completado
      return true;
    } catch (error) {
      // Manejar errores
      logger.e('Something is wrong: $error');
      return false;
    }
  }
}
