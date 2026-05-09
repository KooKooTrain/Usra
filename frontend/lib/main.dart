import 'package:flutter/material.dart';
import 'screens/login.dart';

void main() {
  runApp(const Usra());
}

class Usra extends StatelessWidget {
  const Usra({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Usra App',
      theme: ThemeData(
        fontFamily: 'SF Pro Display', 
        primarySwatch: Colors.blue,
      ),
      home: const LoginPage(),
    );
  }
}