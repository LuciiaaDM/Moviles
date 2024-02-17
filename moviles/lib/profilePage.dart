import 'package:flutter/material.dart';
import 'package:moviles/domain/entities/user.dart';

class ProfilePage extends StatefulWidget {
  final User currentUser;

  ProfilePage({required this.currentUser});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late TextEditingController _userNameController;
  late TextEditingController _emailController;
  late TextEditingController _countryController;
  late TextEditingController _cityController;
  late TextEditingController _universityController;
  late TextEditingController _phoneNumberController;
  late TextEditingController _birthdayController;
  late TextEditingController _cityErasmusController;
  late TextEditingController _countryErasmusController;
  late TextEditingController _universityErasmusController;
  late TextEditingController _campusErasmusController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _userNameController = TextEditingController(text: widget.currentUser.userName);
    _emailController = TextEditingController(text: widget.currentUser.email);
    _countryController = TextEditingController(text: widget.currentUser.country);
    _cityController = TextEditingController(text: widget.currentUser.city);
    _universityController = TextEditingController(text: widget.currentUser.university);
    _phoneNumberController = TextEditingController(text: widget.currentUser.phoneNumber);
    _birthdayController = TextEditingController(text: widget.currentUser.birthday.toString());
    _cityErasmusController = TextEditingController(text: widget.currentUser.cityErasmus);
    _countryErasmusController = TextEditingController(text: widget.currentUser.countryErasmus);
    _universityErasmusController = TextEditingController(text: widget.currentUser.universityErasmus);
    _campusErasmusController = TextEditingController(text: widget.currentUser.campusErasmus);
    _passwordController = TextEditingController(text: widget.currentUser.password);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _userNameController,
                decoration: InputDecoration(labelText: 'Username'),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(labelText: 'Password'),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _countryController,
                decoration: InputDecoration(labelText: 'Country'),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _cityController,
                decoration: InputDecoration(labelText: 'City'),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _universityController,
                decoration: InputDecoration(labelText: 'University'),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _phoneNumberController,
                decoration: InputDecoration(labelText: 'Phone Number'),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _birthdayController,
                decoration: InputDecoration(labelText: 'Birthday'),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _cityErasmusController,
                decoration: InputDecoration(labelText: 'City (Erasmus)'),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _countryErasmusController,
                decoration: InputDecoration(labelText: 'Country (Erasmus)'),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _universityErasmusController,
                decoration: InputDecoration(labelText: 'University (Erasmus)'),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _campusErasmusController,
                decoration: InputDecoration(labelText: 'Campus (Erasmus)'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  User updatedUser = User(
                    userName: _userNameController.text,
                    email: _emailController.text,
                    password: _passwordController.text, // Actualiza la contraseña
                    country: _countryController.text,
                    city: _cityController.text,
                    university: _universityController.text,
                    phoneNumber: _phoneNumberController.text,
                    birthday: DateTime.parse(_birthdayController.text),
                    cityErasmus: _cityErasmusController.text,
                    countryErasmus: _countryErasmusController.text,
                    universityErasmus: _universityErasmusController.text,
                    campusErasmus: _campusErasmusController.text,
                  );
                  print('Updated User: $updatedUser');
                },
                child: Text('Save Changes'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
