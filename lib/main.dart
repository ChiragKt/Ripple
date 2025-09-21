import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'chat_screen.dart';
import 'services/storage_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive
  await Hive.initFlutter();

  // Initialize StorageService (opens messages box)
  await StorageService.init();

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
