import 'package:flutter/material.dart';
import 'package:moviles/domain/entities/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
  final TextEditingController birthdayController = TextEditingController(); // Nueva variable de controlador para la fecha de nacimiento
  final TextEditingController cityErasmusController = TextEditingController();
  final TextEditingController countryErasmusController = TextEditingController();
  final TextEditingController universityErasmusController = TextEditingController();
  final TextEditingController campusErasmusController = TextEditingController();

  final Logger logger = Logger();

  SignUp({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up Users'),
      ),
      body: Container(
        color: Colors.lightBlue[100], // Fondo azul claro
        child: Padding(
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
                TextFormField(
                  controller: birthdayController, // Utiliza el controlador de fecha de nacimiento
                  keyboardType: TextInputType.datetime, // Define el tipo de teclado como fecha y hora
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
                ElevatedButton(
                  onPressed: () async {
                    if (passwordController.text == confirmPasswordController.text) {
                      // Parsea la fecha de nacimiento
                      DateTime? birthday = DateTime.tryParse(birthdayController.text);
                      if (birthday != null) {
                        // Convierte la fecha de nacimiento a un Timestamp para almacenarla en Firestore
                        Timestamp birthdayTimestamp = Timestamp.fromDate(birthday);
                        User newUser = User(
                          userName: userNameController.text,
                          password: passwordController.text,
                          email: emailController.text,
                          country: countryController.text,
                          city: cityController.text,
                          university: universityController.text,
                          phoneNumber: phoneNumberController.text,
                          birthday: birthdayTimestamp, // Almacena la fecha como Timestamp en Firestore
                          cityErasmus: cityErasmusController.text,
                          countryErasmus: countryErasmusController.text,
                          universityErasmus: universityErasmusController.text,
                          campusErasmus: campusErasmusController.text,
                        );
                        bool result = await signUp(newUser);
                        if (!result) {
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
                                    Navigator.pop(context); // Regresa a la pantalla de inicio de sesión
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
      CollectionReference usersCollection = FirebaseFirestore.instance.collection('Users');
      QuerySnapshot userExists = await usersCollection.where('username', isEqualTo: user.userName).get();
      if (userExists.docs.isNotEmpty) {
        return false;
      }

      DocumentReference newUserDoc = usersCollection.doc(user.userName);
      
      // Crea las colecciones de mensajes y publicaciones
      //CollectionReference messagesCollection = 
      //newUserDoc.collection('messages');
      //CollectionReference postsCollection = 
      //newUserDoc.collection('posts');
      
      // Agrega documentos a las colecciones si es necesario
      //messagesCollection.add({});
      //postsCollection.add({});

      // Guarda los datos del usuario en Firestore
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
      logger.e('Something is wrong: $error');
      return false;
    }
  }

}
