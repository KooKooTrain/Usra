// ignore_for_file: unnecessary_const, unnecessary_to_list_in_spreads, unused_field, prefer_const_constructors, prefer_final_fields, file_names, deprecated_member_use, unnecessary_import

import 'dart:ui';
import '../secret.dart';
import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'home.dart';

class AiPage extends StatefulWidget {
  const AiPage({super.key});

  @override
  State<AiPage> createState() => _AiPageState();
}

class _AiPageState extends State<AiPage> {
  bool _isSidebarOpen = false;
  int _currentIndex = 1;

  final Color _brandBlue = const Color(0xFF0056D2);
  final Color _actionIconColor =
      const Color(0xFF0056D2).withOpacity(0.7);

  final TextEditingController _controller = TextEditingController();

  late final GenerativeModel _model;
  late final ChatSession _chat;

  bool _isTyping = false;

  final List<Map<String, String>> _messages = [
    {
      "role": "ai",
      "content": "Hello! I'm Usra AI. How can I help your family today?"
    }
  ];

  @override
  void initState() {
    super.initState();

    _model = GenerativeModel(
      model: 'gemini-3.1-flash-lite',
      apiKey: api,
    );

    _chat = _model.startChat();
  }

  Future<void> _sendMessage() async {
    final text = _controller.text.trim();

    if (text.isEmpty) return;

    setState(() {
      _messages.add({
        "role": "user",
        "content": text,
      });

      _isTyping = true;
    });

    _controller.clear();

    try {
      final response = await _chat.sendMessage(
        Content.text(text),
      );

      final reply = response.text;

      setState(() {
      _messages.add({
        "role": "ai",
        "content": reply ?? "Empty response from AI",
      });
      });
    } catch (e) {
      setState(() {
        _messages.add({
          "role": "ai",
          "content": "ERROR: $e",
        });
      });
    }

    setState(() {
      _isTyping = false;
    });
  }

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
            colors: [
              Color(0xFFD6E4FF),
              Color(0xFFF0E5FF),
              Color(0xFFE8F0FF)
            ],
          ),
        ),
        child: Center(
          child: _buildPhoneFrame(),
        ),
      ),
    );
  }

  Widget _buildPhoneFrame() {
    return Container(
      width: 360,
      height: 740,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(40),
        border: Border.all(
          color: const Color(0xFF2C2C2C),
          width: 8,
        ),
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
        child: Stack(
          children: [
            _buildInnerPageBackground(),
            _buildChatInterface(),
            _buildHeader(),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: _buildBottomNav(),
            ),

            if (_isSidebarOpen)
              GestureDetector(
                onTap: () => setState(() => _isSidebarOpen = false),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  color: Colors.black.withOpacity(0.4),
                ),
              ),

            AnimatedPositioned(
              duration: const Duration(milliseconds: 500),
              curve: Curves.fastLinearToSlowEaseIn,
              left: _isSidebarOpen ? 0 : -300,
              top: 0,
              bottom: 0,
              child: _buildAestheticSidebar(),
            ),
          ],
        ),
      ),
    );
  }

Widget _buildInnerPageBackground() {
  return Container(
    width: double.infinity,
    height: double.infinity,
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color(0xFFD6E4FF),
          Color(0xFFF0E5FF),
          Color(0xFFE8F0FF),
        ],
      ),
    ),
    child: Stack(
      children: [
        Positioned(
          top: -80,
          right: -60,
          child: _blurCircle(const Color(0xFF6EA8FF).withOpacity(0.25)),
        ),
        Positioned(
          bottom: -100,
          left: -80,
          child: _blurCircle(const Color(0xFFFFC6FF).withOpacity(0.25)),
        ),
        Positioned(
          top: 200,
          left: 120,
          child: _blurCircle(const Color(0xFFB6E0FF).withOpacity(0.18)),
        ),
      ],
    ),
  );
}
Widget _blurCircle(Color color) {
  return Container(
    width: 180,
    height: 180,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: color,
      boxShadow: [
        BoxShadow(
          color: color,
          blurRadius: 80,
          spreadRadius: 20,
        ),
      ],
    ),
  );
}
Widget _buildChatInterface() {
  return SafeArea(
    child: Column(
      children: [
        const SizedBox(height: 80),

        Expanded(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            children: [
              Container(
                height: 190,
                width: 190,
                decoration: const BoxDecoration(shape: BoxShape.circle),
                child: ClipOval(
                  child: Image.network(
                    "https://res.cloudinary.com/dw4mv7p40/image/upload/v1778604549/finallllllll_ywnih3.gif",
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              ..._messages.map((msg) {
                return _buildChatBubble(
                  msg['content']!,
                  msg['role'] == 'ai',
                );
              }).toList(),

              if (_isTyping)
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Text(
                      "Usra AI is typing...",
                      style: TextStyle(
                        color: Colors.black45,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),

              const SizedBox(height: 120),
            ],
          ),
        ),

        _buildTextInputField(),

        const SizedBox(height: 110),
      ],
    ),
  );
}

  Widget _buildChatBubble(String text, bool isAi) {
    return Align(
      alignment:
          isAi ? Alignment.centerLeft : Alignment.centerRight,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        constraints: const BoxConstraints(maxWidth: 240),
        decoration: BoxDecoration(
          color: isAi ? Colors.white : _brandBlue,
          borderRadius: BorderRadius.circular(20).copyWith(
            bottomLeft: isAi
                ? const Radius.circular(0)
                : const Radius.circular(20),
            bottomRight: isAi
                ? const Radius.circular(20)
                : const Radius.circular(0),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
            )
          ],
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isAi ? Colors.black87 : Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _buildTextInputField() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.white),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
          )
        ],
      ),
      child: Row(
        children: [
          const SizedBox(width: 12),

          Expanded(
            child: TextField(
              controller: _controller,
              decoration: const InputDecoration(
                hintText: "Ask Usra anything...",
                hintStyle: TextStyle(
                  fontSize: 14,
                  color: Colors.black26,
                ),
                border: InputBorder.none,
              ),
            ),
          ),

          TweenAnimationBuilder<double>(
            tween: Tween(begin: 0.95, end: 1.05),
            duration: const Duration(milliseconds: 1200),
            curve: Curves.easeInOut,
            builder: (context, scale, child) {
              return Transform.scale(
                scale: scale,
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: _sendMessage,
                    child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [
                          _brandBlue,
                          const Color(0xFF6EA8FF),
                        ],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: _brandBlue.withOpacity(0.45),
                          blurRadius: 20,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.arrow_upward_rounded,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
              ));
            },
            onEnd: () {
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

Widget _buildHeader() {
  return Positioned(
    top: 0,
    left: 0,
    right: 0,
    child: Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 12,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: SafeArea(
        bottom: false,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: IconButton(
                  icon: Icon(Icons.menu_rounded, color: _brandBlue, size: 28),
                  onPressed: () => setState(() => _isSidebarOpen = true),
                ),
              ),
            ),

            ShaderMask(
              shaderCallback: (bounds) => LinearGradient(
                colors: [
                  _brandBlue,
                  const Color(0xFF6EA8FF),
                ],
              ).createShader(bounds),
              child: const Text(
                "USRA AI",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 3,
                  fontFamily: "Tenor Sans",
                ),
              ),
            ),

            Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                icon: Icon(Icons.settings,
                    color: _brandBlue, size: 26),
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget _buildBottomNav() {
  return Padding(
    padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18), 
        child: Container(
          height: 75,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.45), 
            borderRadius: BorderRadius.circular(30),
            border: Border.all(
              color: Colors.white.withOpacity(0.25), 
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 25,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildPremiumNavItem(
                Icons.home_filled,
                "Home",
                _currentIndex == 0,
                0,
              ),
              _buildPremiumNavItem(
                Icons.auto_awesome_rounded,
                "AI Assistant",
                _currentIndex == 1,
                1,
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

  Widget _buildPremiumNavItem(
    IconData icon,
    String label,
    bool isActive,
    int index,
  ) {
    bool isHovered = false;

    return StatefulBuilder(
      builder: (context, setNavState) {
        return MouseRegion(
          cursor: SystemMouseCursors.click,
          onEnter: (_) =>
              setNavState(() => isHovered = true),
          onExit: (_) =>
              setNavState(() => isHovered = false),
          child: GestureDetector(
            onTap: () {
              if (index == 0) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const HomePage(),
                  ),
                );
              } else if (index == 1) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const AiPage(),
                  ),
                );
              }
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 10,
              ),
              decoration: BoxDecoration(
                color: isActive
                    ? _brandBlue.withOpacity(0.18)
                    : isHovered
                        ? _brandBlue.withOpacity(0.08)
                        : Colors.transparent,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    icon,
                    color: isActive
                        ? _brandBlue
                        : isHovered
                            ? _brandBlue.withOpacity(0.8)
                            : Colors.black26,
                    size: 24,
                  ),
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: isActive
                          ? FontWeight.w900
                          : FontWeight.bold,
                      color: isActive
                          ? _brandBlue
                          : isHovered
                              ? _brandBlue.withOpacity(0.8)
                              : Colors.black26,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

Widget _buildAestheticSidebar() {
  return Container(
    width: 300,
    decoration: BoxDecoration(
      color: Colors.white.withOpacity(0.92),
      borderRadius: const BorderRadius.only(
        topRight: Radius.circular(32),
        bottomRight: Radius.circular(32),
      ),
    ),
    child: Column(
      children: [
        _buildSidebarHeaderV2(),
        Expanded(child: _buildSidebarListV2()),
        _buildSignOutButton(),
      ],
    ),
  );
}

Widget _buildSidebarHeaderV2() {
  return Container(
    padding: const EdgeInsets.fromLTRB(22, 55, 22, 30),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              height: 52,
              width: 52,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 12, 12, 12),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Icon(
                Icons.blur_on_rounded,
                color: Colors.white,
                size: 30,
              ),
            ),
            const SizedBox(width: 12),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "USRA",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.2,
                    color: const Color.fromARGB(255, 12, 12, 12),
                  ),
                ),
                Text(
                  "عُسرة",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ],
        ),

        const SizedBox(height: 18),

        Text(
          "Family OS Dashboard",
          style: TextStyle(
            fontSize: 13,
            color: Colors.black54,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    ),
  );
}
Widget _buildSidebarListV2() {
  return Column(
    children: [
      _sidebarTileV2(Icons.auto_awesome_rounded, "AI Assistant", false),
      _sidebarTileV2(Icons.calendar_month_rounded, "Calendar", true),
      _sidebarTileV2(Icons.forum_rounded, "Family Chat", false),


      _sidebarTileV2(Icons.health_and_safety_rounded, "Health Hub", false),
      _sidebarTileV2(Icons.paid_rounded, "Finance", false),
      _sidebarTileV2(Icons.child_care_rounded, "Kids", false),
      _sidebarTileV2(Icons.elderly_rounded, "Elder Care", false),

      const SizedBox(height: 10),
      Divider(color: Colors.black12),

      _sidebarTileV2(Icons.verified_user_rounded, "Safety", false),
    ],
  );
}
Widget _sidebarTileV2(
  IconData icon,
  String title,
  bool isSelected,
) {
  bool isHovered = false;

  return StatefulBuilder(
    builder: (context, setState) {
      return MouseRegion(
        onEnter: (_) => setState(() => isHovered = true),
        onExit: (_) => setState(() => isHovered = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          margin: const EdgeInsets.symmetric(vertical: 4),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          decoration: BoxDecoration(
            color: isSelected
                ? Colors.black.withOpacity(0.06)
                : isHovered
                    ? Colors.black.withOpacity(0.04)
                    : Colors.transparent,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Row(
            children: [
              Icon(
                icon,
                size: 20,
                color: isSelected
                    ? Colors.black
                    : Colors.black54,
              ),
              const SizedBox(width: 12),
              Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: isSelected
                      ? FontWeight.w800
                      : FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}


  Widget _buildSignOutButton() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        20,
        10,
        20,
        40,
      ),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(
          vertical: 16,
        ),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 12, 12, 12),
          borderRadius: BorderRadius.circular(18),
        ),
        child: const Row(
          mainAxisAlignment:
              MainAxisAlignment.center,
          children: [
            Icon(
              Icons.logout_rounded,
              color: Colors.white,
              size: 18,
            ),
            SizedBox(width: 12),
            Text(
              "Sign Out",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w800,
                fontSize: 15,
              ),
            ),
          ],
        ),
      ),
    );
  }
}