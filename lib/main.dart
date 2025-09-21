import 'package:flutter/material.dart';
import 'chat_screen.dart';

void main() {
  runApp(const Ripple());
}

class Ripple extends StatelessWidget {
  const Ripple({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.black,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
      ),
      home: ChatScreen(),
    );
  }
}
