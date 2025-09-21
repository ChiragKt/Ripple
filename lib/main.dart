import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'chat_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('messages');

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
      home: const ChatScreen(),
    );
  }
}
