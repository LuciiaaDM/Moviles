import 'package:flutter/foundation.dart';

class Message {
  final String id; // Identificador único del mensaje
  final String senderId; // ID del remitente del mensaje
  final String recipientId; // ID del destinatario del mensaje
  final String content; // Contenido del mensaje
  final DateTime timestamp; // Fecha y hora del mensaje

  Message({
    required this.id,
    required this.senderId,
    required this.recipientId,
    required this.content,
    required this.timestamp,
  });

  // Método factory para crear un objeto Message a partir de un mapa (usado para convertir datos de Firebase, por ejemplo)
  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      id: map['id'],
      senderId: map['senderId'],
      recipientId: map['recipientId'],
      content: map['content'],
      timestamp: DateTime.fromMillisecondsSinceEpoch(map['timestamp']),
    );
  }

  // Método para convertir un objeto Message a un mapa (usado para guardar datos en Firebase, por ejemplo)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'senderId': senderId,
      'recipientId': recipientId,
      'content': content,
      'timestamp': timestamp.millisecondsSinceEpoch,
    };
  }
}
