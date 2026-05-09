// ignore_for_file: deprecated_member_use

import 'dart:ui';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
                          colors: [Color(0xFFD6E4FF), Color(0xFFF0E5FF), Color(0xFFE8F0FF)],
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
                          const SizedBox(height: 40),
                          Center(
                            child: Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.4),
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.white.withOpacity(0.5)),
                              ),
                              child: const Icon(Icons.share_outlined, size: 36, color: Color(0xFF0056D2)),
                            ),
                          ),
                          const SizedBox(height: 15),
                          const Text(
                            "Usra أسرة",
                            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Color(0xFF0056D2)),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            "Empowering families through\nintelligent, connected care solutions.",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.black54, fontSize: 13, height: 1.4),
                          ),
                          const SizedBox(height: 30),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(35),
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                              child: Container(
                                padding: const EdgeInsets.all(25),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(35),
                                  border: Border.all(color: Colors.white.withOpacity(0.3)),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _buildInputLabel("Email Address"),
                                    _buildTextField(hint: "name@family.com", icon: Icons.email_outlined),
                                    const SizedBox(height: 20),
                                    _buildInputLabel("Password"),
                                    _buildTextField(hint: "••••••••", icon: Icons.lock_outline, isPassword: true),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: TextButton(
                                        onPressed: () {},
                                        child: const Text("Forgot password?", style: TextStyle(color: Color(0xFF0056D2), fontWeight: FontWeight.w600, fontSize: 13)),
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    _buildSignInButton(),
                                    const SizedBox(height: 25),
                                    const Row(
                                      children: [
                                        Expanded(child: Divider(color: Colors.black12)),
                                        Padding(
                                          padding: EdgeInsets.symmetric(horizontal: 10),
                                          child: Text("or sign in with biometric", style: TextStyle(color: Colors.black38, fontSize: 12)),
                                        ),
                                        Expanded(child: Divider(color: Colors.black12)),
                                      ],
                                    ),
                                    const SizedBox(height: 20),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        _biometricTile(Icons.fingerprint),
                                        const SizedBox(width: 15),
                                        _biometricTile(Icons.face_retouching_natural),
                                      ],
                                    ),
                                    const SizedBox(height: 25),
                                    const Center(child: Text("New to Usra? Join Family", style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w500, fontSize: 13))),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 40),
                          const Text("Usra أسرة", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF0056D2))),
                          const SizedBox(height: 5),
                          const Text("© 2026 Usra أسرة. All rights reserved.", style: TextStyle(color: Colors.black45, fontSize: 11)),
                          const SizedBox(height: 20),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Privacy", style: TextStyle(decoration: TextDecoration.underline, color: Colors.black54, fontSize: 13)),
                              SizedBox(width: 50),
                              Text("Support", style: TextStyle(decoration: TextDecoration.underline, color: Colors.black54, fontSize: 13)),
                            ],
                          ),
                          const SizedBox(height: 10),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Terms", style: TextStyle(decoration: TextDecoration.underline, color: Colors.black54, fontSize: 13)),
                              SizedBox(width: 50),
                              Text("Modules", style: TextStyle(decoration: TextDecoration.underline, color: Colors.black54, fontSize: 13)),
                            ],
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
    padding: const EdgeInsets.only(left: 4, bottom: 6),
    child: Text(label, style: const TextStyle(color: Colors.black87, fontSize: 13, fontWeight: FontWeight.w500)),
  );

  Widget _buildTextField({required String hint, required IconData icon, bool isPassword = false}) {
    return Container(
      height: 50,
      decoration: BoxDecoration(color: Colors.white.withOpacity(0.5), borderRadius: BorderRadius.circular(20)),
      child: TextField(
        obscureText: isPassword && !_isPasswordVisible,
        style: const TextStyle(fontSize: 14),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(fontSize: 14, color: Colors.black26),
          prefixIcon: Icon(icon, color: Colors.black38, size: 20),
          suffixIcon: isPassword ? IconButton(
            icon: Icon(_isPasswordVisible ? Icons.visibility : Icons.visibility_outlined, color: Colors.black38, size: 20),
            onPressed: () => setState(() => _isPasswordVisible = !_isPasswordVisible),
          ) : null,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 15),
        ),
      ),
    );
  }

  Widget _buildSignInButton() {
    return Container(
      width: double.infinity, height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        gradient: const LinearGradient(colors: [Color(0xFF005DC7), Color(0xFF1E88E5)]),
      ),
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(backgroundColor: Colors.transparent, shadowColor: Colors.transparent, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25))),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Sign In", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(width: 8), Icon(Icons.arrow_forward, color: Colors.white, size: 18),
          ],
        ),
      ),
    );
  }

  Widget _biometricTile(IconData icon) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(color: Colors.white.withOpacity(0.7), borderRadius: BorderRadius.circular(14)),
      child: Icon(icon, color: const Color(0xFF0056D2), size: 28),
    );
  }
}