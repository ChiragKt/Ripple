import 'package:flutter/material.dart';
import 'dart:math';
import 'models/message.dart';
import 'services/storage_service.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late TextEditingController _controller;
  final List<Message> _messages = [];
  String username = generateRandomUsername();

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _messages.addAll(StorageService.getMessages());
  }

  void _sendMessage(String text) async {
    if (text.trim().isEmpty) return;

    final msg = Message(sender: username, content: text);
    setState(() {
      _messages.add(msg);
    });

    _controller.clear();
    await StorageService.addMessage(msg);
  }

  List<Message> get chatPoolMessages {
    return _messages.where((msg) => msg.receiver == null).toList();
  }

  void _regenerateUsername() {
    setState(() {
      username = generateRandomUsername();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Row(
          children: [
            Text(
              "Ripple",
              style: TextStyle(
                color: Color(0xFF00FF55),
                fontWeight: FontWeight.w900,
                fontSize: 36,
              ),
            ),
            SizedBox(width: 12),
            Text(
              username,
              style: TextStyle(color: Colors.greenAccent, fontSize: 18),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.warning, color: Colors.red),
            onPressed: _regenerateUsername,
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true,
              padding: EdgeInsets.all(12),
              itemCount: chatPoolMessages.length,
              itemBuilder: (context, index) {
                final message =
                    chatPoolMessages[chatPoolMessages.length - 1 - index];
                final isMe = message.sender == username;

                return Align(
                  alignment:
                      isMe ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 4),
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 14),
                    decoration: BoxDecoration(
                      color: isMe ? Colors.greenAccent : Colors.grey[850],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment:
                          isMe
                              ? CrossAxisAlignment.end
                              : CrossAxisAlignment.start,
                      children: [
                        if (!isMe)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 4.0),
                            child: Text(
                              message.sender,
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        Text(
                          message.content,
                          style: TextStyle(
                            color: isMe ? Colors.black : Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: "Type a message...",
                      hintStyle: TextStyle(color: Colors.grey),
                      filled: true,
                      fillColor: Colors.grey[900],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 16),
                    ),
                    onSubmitted: _sendMessage,
                  ),
                ),
                SizedBox(width: 8),
                IconButton(
                  icon: Icon(Icons.send, color: Colors.greenAccent),
                  onPressed: () => _sendMessage(_controller.text),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

String generateRandomUsername() {
  final random = Random();
  int number = random.nextInt(9000) + 1000;
  return "@ripple$number";
}
