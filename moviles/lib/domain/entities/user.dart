import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String userName;
  final String password;
  final String email;
  final String country;//donde vives
  final String city;//ciudad donde vives
  final String university;
  final String phoneNumber;
  final Timestamp birthday;
  final String cityErasmus;
  final String countryErasmus;
  final String universityErasmus;
  final String campusErasmus;
   
  // Puedes agregar más atributos según sea necesario

  User({
    required this.userName,
    required this.password,
    required this.email,
    required this.country,
    required this.city,
    required this.university,
    required this.phoneNumber,
    required this.birthday,
    this.cityErasmus = '',
    this.countryErasmus = '',
    this.universityErasmus = '',
    this.campusErasmus = ''
    // Puedes agregar más parámetros aquí
  });
}
