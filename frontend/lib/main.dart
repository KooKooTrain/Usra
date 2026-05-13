// ignore_for_file: deprecated_member_use

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/material.dart';
import 'screens/login.dart';
import 'screens/signup.dart';
import 'screens/home.dart';

void main() async {
  await dotenv.load(fileName: ".env");
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
      home: const SignupPage(),
      routes: {
        '/login': (context) => const LoginPage(),
        '/signup': (context) => const SignupPage(),
        '/home': (context) => const HomePage(),
      },
    );
  }
}
