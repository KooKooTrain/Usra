// ignore_for_file: deprecated_member_use, unnecessary_import

import 'dart:ui';
import '../secrets.dart';
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
        color: Color(0xFFF8FAFF),
        gradient: RadialGradient(
          center: Alignment(0.8, -0.5),
          radius: 1.5,
          colors: [
            Color(0xFFF3E8FF),
            Color(0xFFFDFBFF),
            Color(0xFFE8F0FF)
          ],
        ),
      ),
    );
  }

  Widget _buildChatInterface() {
    return SafeArea(
      child: Column(
        children: [
          const SizedBox(height: 80),

          Container(
            height: 190,
            width: 190,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: ClipOval(
              child: Image.network(
                "https://res.cloudinary.com/dw4mv7p40/image/upload/fl_animated/blob_final_vsfnto.gif", //https://res.cloudinary.com/dw4mv7p40/image/upload/v1778572104/blob_final_vsfnto.gif
                fit: BoxFit.cover,
              ),
            ),
          ),

          const SizedBox(height: 20),

          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final msg = _messages[index];

                return _buildChatBubble(
                  msg['content']!,
                  msg['role'] == 'ai',
                );
              },
            ),
          ),

          if (_isTyping)
            Padding(
              padding: const EdgeInsets.only(
                left: 20,
                bottom: 10,
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Usra AI is typing...",
                  style: TextStyle(
                    color: Colors.black45,
                    fontSize: 12,
                  ),
                ),
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
          color: Colors.white.withOpacity(0.9),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 10,
        ),
        child: SafeArea(
          bottom: false,
          child: Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
            children: [
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: IconButton(
                  icon: Icon(
                    Icons.menu_rounded,
                    color: _brandBlue,
                    size: 28,
                  ),
                  onPressed: () =>
                      setState(() => _isSidebarOpen = true),
                ),
              ),

              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color:
                            _brandBlue.withOpacity(0.1),
                      ),
                    ),
                    child: Icon(
                      Icons.share_outlined,
                      color: _brandBlue,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    "Usra أسرة",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: _brandBlue,
                    ),
                  ),
                ],
              ),

              const SizedBox(width: 48),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBottomNav() {
    return Container(
      height: 75,
      margin: const EdgeInsets.only(left: 20, right: 20, bottom: 25),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.85),
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 20,
          )
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
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
      width: 290,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.94),
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
          child: Column(
            children: [
              _buildSidebarHeader(),
              Expanded(child: _buildSidebarList()),
              _buildSignOutButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSidebarHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(
        24,
        65,
        24,
        30,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 56,
            width: 56,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  _brandBlue,
                  const Color(0xFF5A8DFF)
                ],
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(
              Icons.blur_on_rounded,
              color: Colors.white,
              size: 36,
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            "USRA",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w900,
              letterSpacing: 2.8,
              color: Color(0xFF1A1A1A),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSidebarList() {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      children: [
        _sidebarTile(
          Icons.auto_awesome_rounded,
          "AI Assistant",
          true,
        ),
        _sidebarTile(
          Icons.verified_user_rounded,
          "Safety",
          false,
        ),
        _sidebarTile(
          Icons.forum_rounded,
          "Family Chat",
          false,
        ),
        _sidebarTile(
          Icons.calendar_month_rounded,
          "Calendar",
          false,
        ),
        _sidebarTile(
          Icons.paid_rounded,
          "Finance",
          false,
        ),
        _sidebarTile(
          Icons.child_care_rounded,
          "Kids & Education",
          false,
        ),
        _sidebarTile(
          Icons.elderly_rounded,
          "Elder Care Hub",
          false,
        ),
        _sidebarTile(
          Icons.health_and_safety_rounded,
          "Health Hub",
          false,
        ),
        _sidebarTile(
          Icons.spa_rounded,
          "Wellbeing",
          false,
        ),
      ],
    );
  }

  Widget _sidebarTile(
    IconData icon,
    String title,
    bool isSelected,
  ) {
    bool isHovered = false;

    return StatefulBuilder(
      builder: (context, setTileState) {
        return MouseRegion(
          cursor: SystemMouseCursors.click,
          onEnter: (_) =>
              setTileState(() => isHovered = true),
          onExit: (_) =>
              setTileState(() => isHovered = false),
          child: GestureDetector(
            onTap: () {
              if (title == "Home") {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const HomePage(),
                  ),
                );
              }
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              margin: const EdgeInsets.only(bottom: 6),
              decoration: BoxDecoration(
                color: isHovered
                    ? Colors.white
                    : (isSelected
                        ? _brandBlue.withOpacity(0.06)
                        : Colors.transparent),
                borderRadius: BorderRadius.circular(14),
              ),
              child: ListTile(
                dense: true,
                leading: Icon(
                  icon,
                  color: isHovered || isSelected
                      ? _brandBlue
                      : Colors.black54,
                  size: 22,
                ),
                title: Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: isHovered || isSelected
                        ? FontWeight.w800
                        : FontWeight.w600,
                    color: isHovered || isSelected
                        ? _brandBlue
                        : Colors.black87,
                  ),
                ),
              ),
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
          color: Colors.black,
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