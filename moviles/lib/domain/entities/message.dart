import 'package:cloud_firestore/cloud_firestore.dart';

// Message model
class Message {
  final String sender; // Sender of the message
  final String content; // Content of the message
  final DateTime timestamp; // Timestamp of when the message was sent

  // Constructor
  Message({
    required this.sender,
    required this.content,
    required this.timestamp,
  });

  // Factory method to create a Message object from a map (used for converting Firebase data)
  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      sender: map['sender'], // Extract sender from the map
      content: map['content'], // Extract content from the map
      timestamp: (map['timestamp'] as Timestamp).toDate(), // Convert timestamp from Firestore Timestamp to DateTime
    );
  }
}
