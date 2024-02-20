import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:moviles/domain/entities/message.dart';

class MessagePage extends StatefulWidget {
  final String currentUsername;
  final String otherUsername;

  const MessagePage({
    Key? key,
    required this.currentUsername,
    required this.otherUsername,
  }) : super(key: key);

  @override
  _MessagePageState createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  late TextEditingController _messageController;
  late List<Message> _messages;

  @override
  void initState() {
    super.initState();
    _messageController = TextEditingController();
    _messages = [];
    _getConversationMessages();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat with ${widget.otherUsername}'),
        backgroundColor: Colors.lightBlue[100], // Establecer el fondo azul en la barra superior
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              reverse: true,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return Align(
                  alignment: message.sender == widget.currentUsername
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: message.sender == widget.currentUsername
                          ? Colors.blue[200]
                          : Colors.grey[300],
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Text(
                      message.content,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: const InputDecoration(labelText: 'Enter your message...'),
                  ),
                ),
                IconButton(
                  onPressed: _sendMessage,
                  icon: const Icon(Icons.send),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _getConversationMessages() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('Users')
          .doc(widget.currentUsername)
          .collection('messages')
          .doc(widget.otherUsername)
          .collection('conversation')
          .orderBy('timestamp', descending: true)
          .get();

      setState(() {
        _messages = querySnapshot.docs.map((doc) => Message.fromMap(doc.data() as Map<String, dynamic>)).toList();
      });
    } catch (error) {
      print('Error fetching conversation messages: $error');
    }
  }

  void _sendMessage() {
    String messageContent = _messageController.text.trim();
    if (messageContent.isNotEmpty) {
      // Añadir el mensaje a la colección del remitente
      FirebaseFirestore.instance
          .collection('Users')
          .doc(widget.currentUsername)
          .collection('messages')
          .doc(widget.otherUsername)
          .collection('conversation')
          .add({
        'sender': widget.currentUsername,
        'content': messageContent,
        'timestamp': Timestamp.now(),
      });

      // Añadir el mensaje a la colección del destinatario
      FirebaseFirestore.instance
          .collection('Users')
          .doc(widget.otherUsername)
          .collection('messages')
          .doc(widget.currentUsername)
          .collection('conversation')
          .add({
        'sender': widget.currentUsername,
        'content': messageContent,
        'timestamp': Timestamp.now(),
      });

      // Limpiar el campo de texto después de enviar el mensaje
      _messageController.clear();

      // Actualizar los mensajes mostrados
      _getConversationMessages();
    }
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }
}
