import 'package:flutter/material.dart';

void main() {
  runApp(const Ripple());
}

class Ripple extends StatelessWidget {
  const Ripple({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text("Ripple"),
          titleTextStyle: TextStyle(color: Colors.green),
        ),
        body: Center(child: Column(children: [
                
              ],
            )),
      ),
    );
  }
}
