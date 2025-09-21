import 'package:flutter/material.dart';
import 'dart:math';
import 'package:hive/hive.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late TextEditingController _controller;
  late Box _box;
  final List<Message> _messages = [];
  final String username = generateRandomUsername();

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _box = Hive.box('messages');

    for (var msg in _box.values) {
      _messages.add(Message(sender: msg['sender'], content: msg['content']));
    }
  }

  void _sendMessage(String text) {
    if (text.trim().isEmpty) return;

    final msg = Message(sender: username, content: text);

    setState(() {
      _messages.add(msg);
    });

    _box.add({'sender': msg.sender, 'content': msg.content});

    _controller.clear();
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
              style: TextStyle(
                color: Colors.greenAccent,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true,
              padding: EdgeInsets.all(12),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[_messages.length - 1 - index];
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          message.sender,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[300],
                            fontWeight: FontWeight.bold,
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
                      prefixText: "$username: ",
                      prefixStyle: TextStyle(
                        color: Colors.greenAccent,
                        fontWeight: FontWeight.bold,
                      ),
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

class Message {
  final String sender;
  final String content;
  Message({required this.sender, required this.content});
}

String generateRandomUsername() {
  final random = Random();
  int number = random.nextInt(9000) + 1000;
  return "@rippler$number";
}
