import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String userName; // User's username
  final String password; // User's password
  final String email; // User's email address
  final String country; // User's country of residence
  final String city; // User's city of residence
  final String university; // User's university
  final String phoneNumber; // User's phone number
  final Timestamp birthday; // User's birthday
  final String cityErasmus; // City of Erasmus experience (if applicable)
  final String countryErasmus; // Country of Erasmus experience (if applicable)
  final String universityErasmus; // University of Erasmus experience (if applicable)
  final String campusErasmus; // Campus of Erasmus experience (if applicable)
   
  // Additional attributes can be added as needed

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
    // Additional parameters can be added here
  });
}
