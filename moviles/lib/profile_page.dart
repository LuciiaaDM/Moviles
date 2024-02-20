import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:moviles/home_page.dart';
import 'package:moviles/homepage_layout.dart';
import 'package:moviles/add_post.dart';
import 'package:moviles/my_posts.dart';
import 'package:moviles/search_page.dart';
import 'package:moviles/chats_page.dart';

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

  bool _isEditing = false; // Variable para indicar si estamos en modo de edición

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

  Future<void> _setNewUserData() async {
    // Actualiza los datos del usuario en la base de datos
    await FirebaseFirestore.instance.collection('Users').doc(widget.username).update({
      'email': _email,
      'country': _country,
      'city': _city,
      'university': _university,
      'phoneNumber': _phoneNumber,
      'cityErasmus': _cityErasmus,
      'countryErasmus': _countryErasmus,
      'universityErasmus': _universityErasmus,
      'campusErasmus': _campusErasmus,
    });
  }


  @override
  Widget build(BuildContext context) {
    return HomePageLayout(
      pageTitle: 'PROFILE',
      username: widget.username,
      body: Container(
        color: Colors.white, // Light blue background color
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _isEditing ? _buildEditableField('Email', _email, (value) => _email = value) : _buildStaticField('Email', _email),
              _isEditing ? _buildEditableField('Country', _country, (value) => _country = value) : _buildStaticField('Country', _country),
              _isEditing ? _buildEditableField('City', _city, (value) => _city = value) : _buildStaticField('City', _city),
              _isEditing ? _buildEditableField('University', _university, (value) => _university = value) : _buildStaticField('University', _university),
              _isEditing ? _buildEditableField('Phone Number', _phoneNumber, (value) => _phoneNumber = value) : _buildStaticField('Phone Number', _phoneNumber),
              _isEditing ? _buildEditableField('Erasmus City', _cityErasmus, (value) => _cityErasmus = value) : _buildStaticField('Erasmus City', _cityErasmus),
              _isEditing ? _buildEditableField('Erasmus Country', _countryErasmus, (value) => _countryErasmus = value) : _buildStaticField('Erasmus Country', _countryErasmus),
              _isEditing ? _buildEditableField('Erasmus University', _universityErasmus, (value) => _universityErasmus = value) : _buildStaticField('Erasmus University', _universityErasmus),
              _isEditing ? _buildEditableField('Erasmus Campus', _campusErasmus, (value) => _campusErasmus = value) : _buildStaticField('Erasmus Campus', _campusErasmus),
              const SizedBox(height: 20), // Espacio adicional
              if (!_isEditing)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _isEditing = true;
                        });
                      },
                      child: const Text('Edit Profile'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // Lógica para ver los posts del usuario
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ViewMyPostsPage(username: widget.username),
                          ),
                        );
                      },
                      child: const Text('View Posts'),
                    ),
                  ],
                ),
              if (_isEditing)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // Lógica para guardar los cambios
                        _setNewUserData();
                        setState(() {
                          _getUserData();
                          _isEditing = false;
                        });
                      },
                      child: const Text('Save Changes'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // Lógica para descartar los cambios
                        // Revertir los cambios
                        _getUserData();
                        setState(() {
                          _isEditing = false;                        
                        });
                      },
                      child: const Text('Discard Changes'),
                    ),
                  ],
                ),
            ],
          ),
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
            Navigator.push(context,
              MaterialPageRoute(
                builder: (context) => ChatsPage (username: widget.username),
              ),
            );
            break;
        }
      },
    );
  }

  Widget _buildStaticField(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$label:',
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        Text(value, style: const TextStyle(fontSize: 16)),
        const SizedBox(height: 10),
      ],
    );
  }

  Widget _buildEditableField(String label, String value, Function(String) onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$label:',
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        TextFormField(
          initialValue: value,
          onChanged: onChanged,
          style: const TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 10),
      ],
    );
  }

}
