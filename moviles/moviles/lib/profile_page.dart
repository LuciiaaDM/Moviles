import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:moviles/home_page.dart';
import 'package:moviles/homepage_layout.dart';
import 'package:moviles/add_post.dart';
import 'package:moviles/search_page.dart';

class ProfilePage extends StatefulWidget {
  final String username;

  const ProfilePage({Key? key, required this.username}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late String _email = '';
  late String _country = '';
  late String _city = '';
  late String _university = '';
  late String _phoneNumber = '';
  late DateTime _birthday = DateTime.now();
  late String _cityErasmus = '';
  late String _countryErasmus = '';
  late String _universityErasmus = '';
  late String _campusErasmus = '';

  @override
  void initState() {
    super.initState();
    // Llama a la función para obtener los datos del usuario al inicializar la página
    _getUserData();
  }

  Future<void> _getUserData() async {
    // Realiza la consulta a la base de datos para obtener los datos del usuario
    DocumentSnapshot userData = await FirebaseFirestore.instance
        .collection('Users')
        .doc(widget.username)
        .get();

    // Asigna los datos obtenidos del usuario a las variables correspondientes
    setState(() {
      _email = userData['email'];
      _country = userData['country'];
      _city = userData['city'];
      _university = userData['university'];
      _phoneNumber = userData['phoneNumber'];
      _birthday = (userData['birthday'] as Timestamp).toDate();
      _cityErasmus = userData['cityErasmus'];
      _countryErasmus = userData['countryErasmus'];
      _universityErasmus = userData['universityErasmus'];
      _campusErasmus = userData['campusErasmus'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return HomePageLayout(
      pageTitle: 'Profile',
      username: widget.username,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Username: ',
              style: TextStyle(fontWeight: FontWeight.bold), // Texto en negrita
            ),
            Text(widget.username),
            SizedBox(height: 10),
            Text(
              'Email: ',
              style: TextStyle(fontWeight: FontWeight.bold), // Texto en negrita
            ),
            Text(_email),
            SizedBox(height: 10),
            Text(
              'Country: ',
              style: TextStyle(fontWeight: FontWeight.bold), // Texto en negrita
            ),
            Text(_country),
            SizedBox(height: 10),
            Text(
              'City: ',
              style: TextStyle(fontWeight: FontWeight.bold), // Texto en negrita
            ),
            Text(_city),
            SizedBox(height: 10),
            Text(
              'University: ',
              style: TextStyle(fontWeight: FontWeight.bold), // Texto en negrita
            ),
            Text(_university),
            SizedBox(height: 10),
            Text(
              'Phone Number: ',
              style: TextStyle(fontWeight: FontWeight.bold), // Texto en negrita
            ),
            Text(_phoneNumber),
            SizedBox(height: 10),
            Text(
              'Birthday: ',
              style: TextStyle(fontWeight: FontWeight.bold), // Texto en negrita
            ),
            Text(_birthday.toString()),
            SizedBox(height: 10),
            Text(
              'Erasmus City: ',
              style: TextStyle(fontWeight: FontWeight.bold), // Texto en negrita
            ),
            Text(_cityErasmus),
            SizedBox(height: 10),
            Text(
              'Erasmus Country: ',
              style: TextStyle(fontWeight: FontWeight.bold), // Texto en negrita
            ),
            Text(_countryErasmus),
            SizedBox(height: 10),
            Text(
              'Erasmus University: ',
              style: TextStyle(fontWeight: FontWeight.bold), // Texto en negrita
            ),
            Text(_universityErasmus),
            SizedBox(height: 10),
            Text(
              'Erasmus Campus: ',
              style: TextStyle(fontWeight: FontWeight.bold), // Texto en negrita
            ),
            Text(_campusErasmus),
          ],
        ),
      ),
      currentIndex: 4,
      onTabSelected: (index) {
        // Manejo de la navegación al cambiar de pestaña en la barra de navegación
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
          case 3:
            Navigator.pushReplacementNamed(context, '/messages');
            break;
          // No hace falta manejar la redirección a la página de perfil aquí,
          // ya que ya estamos en la página de perfil
        }
      },
    );
  }
}
