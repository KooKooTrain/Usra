// ignore_for_file: deprecated_member_use

import 'dart:ui';
import 'package:flutter/material.dart';
import 'home.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFFD6E4FF), Color(0xFFF0E5FF), Color(0xFFE8F0FF)],
          ),
        ),
        child: Center(
          child: Container(
            width: 360,
            height: 740,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(40),
              border: Border.all(color: const Color(0xFF2C2C2C), width: 8),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 30,
                  spreadRadius: 5,
                )
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(32),
              child: Scaffold(
                backgroundColor: Colors.transparent,
                body: Stack(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color(0xFFD6E4FF),
                            Color(0xFFF0E5FF),
                            Color(0xFFE8F0FF)
                          ],
                        ),
                      ),
                    ),
                    SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: Column(
                        children: [
                          const SizedBox(height: 12),
                          Center(
                            child: Container(
                              width: 60,
                              height: 5,
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          const SizedBox(height: 30),

                          // Logo and Title matching Login Page
                          Center(
                            child: Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.4),
                                shape: BoxShape.circle,
                                border: Border.all(
                                    color: Colors.white.withOpacity(0.5)),
                              ),
                              child: const Icon(Icons.share_outlined,
                                  size: 28, color: Color(0xFF0056D2)),
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            "Usra أسرة",
                            style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF0056D2)),
                          ),
                          const SizedBox(height: 20),

                          ClipRRect(
                            borderRadius: BorderRadius.circular(35),
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                              child: Container(
                                padding: const EdgeInsets.all(22),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(35),
                                  border: Border.all(
                                      color: Colors.white.withOpacity(0.3)),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _buildInputLabel("Full Name"),
                                    _buildTextField(
                                        hint: "Divya Bhosale",
                                        icon: Icons.person_outline),
                                    const SizedBox(height: 15),
                                    Row(
                                      children: [
                                        Expanded(
                                          flex: 2,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              _buildInputLabel("DOB"),
                                              _buildTextField(
                                                  hint: "DD/MM/YY",
                                                  icon: Icons
                                                      .calendar_today_outlined),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(width: 15),
                                        Expanded(
                                          flex: 3,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              _buildInputLabel("Partner Name"),
                                              _buildTextField(
                                                  hint: "Optional",
                                                  icon: Icons.favorite_outline),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 15),
                                    _buildInputLabel("Email Address"),
                                    _buildTextField(
                                        hint: "name@mail.com",
                                        icon: Icons.email_outlined),
                                    const SizedBox(height: 20),
                                    const Text("Family Composition",
                                        style: TextStyle(
                                            color: Color(0xFF0056D2),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14)),
                                    const SizedBox(height: 12),
                                    _buildCounterRow("How many Elders?",
                                        Icons.elderly_outlined),
                                    const SizedBox(height: 10),
                                    _buildCounterRow("How many Children?",
                                        Icons.child_care_outlined),
                                    const SizedBox(height: 20),
                                    _buildInputLabel("Password"),
                                    _buildTextField(
                                        hint: "••••••••",
                                        icon: Icons.lock_outline,
                                        isPassword: true),
                                    const SizedBox(height: 25),
                                    _buildSignUpButton(),
                                    const SizedBox(height: 15),
                                    Center(
                                      child: MouseRegion(
                                        cursor: SystemMouseCursors.click,
                                        child: GestureDetector(
                                          onTap: () => Navigator.pushNamed(
                                              context, '/login'),
                                          child: RichText(
                                            text: const TextSpan(
                                              text: "Already have an account? ",
                                              style: TextStyle(
                                                color: Colors.black54,
                                                fontSize: 12,
                                              ),
                                              children: [
                                                TextSpan(
                                                  text: "Sign In",
                                                  style: TextStyle(
                                                    color: Color(0xFF0056D2),
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 30),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInputLabel(String label) => Padding(
        padding: const EdgeInsets.only(left: 4, bottom: 4),
        child: Text(label,
            style: const TextStyle(
                color: Colors.black87,
                fontSize: 12,
                fontWeight: FontWeight.w600)),
      );

  Widget _buildTextField(
      {required String hint, required IconData icon, bool isPassword = false}) {
    return Container(
      height: 42,
      decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.5),
          borderRadius: BorderRadius.circular(18)),
      child: TextField(
        obscureText: isPassword && !_isPasswordVisible,
        style: const TextStyle(fontSize: 13),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(fontSize: 12, color: Colors.black26),
          prefixIcon: Icon(icon, color: Colors.black38, size: 16),
          suffixIcon: isPassword
              ? IconButton(
                  icon: Icon(
                      _isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_outlined,
                      color: Colors.black38,
                      size: 16),
                  onPressed: () =>
                      setState(() => _isPasswordVisible = !_isPasswordVisible),
                )
              : null,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 10),
        ),
      ),
    );
  }

  Widget _buildCounterRow(String label, IconData icon) {
    return Row(
      children: [
        Icon(icon, size: 18, color: Colors.black38),
        const SizedBox(width: 8),
        Expanded(
            child: Text(label,
                style: const TextStyle(fontSize: 12, color: Colors.black87))),
        Container(
          width: 60,
          height: 32,
          decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.4),
              borderRadius: BorderRadius.circular(10)),
          child: const TextField(
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12),
            decoration:
                InputDecoration(hintText: "0", border: InputBorder.none),
          ),
        ),
      ],
    );
  }

  Widget _buildSignUpButton() {
    return Container(
      width: double.infinity,
      height: 48,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: const LinearGradient(
            colors: [Color(0xFF005DC7), Color(0xFF1E88E5)]),
      ),
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const HomePage()),
          );
        },
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24))),
        child: const Text("Create Account",
            style: TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.bold)),
      ),
    );
  }
}
