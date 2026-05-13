// ignore_for_file: dead_code, prefer_final_fields, deprecated_member_use

import 'dart:ui';
import 'package:flutter/material.dart';
import 'ai.dart';
import 'safety.dart';
import 'home.dart';
import 'login.dart';
import 'calender.dart';
import 'elder.dart';
import 'finance.dart';
import 'health.dart';
import 'kids.dart';

class Chat extends StatefulWidget {
  const Chat({super.key});

  @override
  State<Chat> createState() => _ChatPageState();
}

class _ChatPageState extends State<Chat> {
  bool _isSidebarOpen = false;
  int _currentIndex = 2;

  final Color _brandBlue = const Color(0xFF0056D2);

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
              Color(0xFFE8F0FF),
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
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(32),
        child: Stack(
          children: [
            _buildInnerBackground(),

            // YOUR PAGE CONTENT HERE
            _buildChatContent(),

            // HEADER
            _buildHeader(),

            // BOTTOM NAV
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: _buildBottomNav(),
            ),

            // SIDEBAR OVERLAY
            if (_isSidebarOpen)
              GestureDetector(
                onTap: () =>
                    setState(() => _isSidebarOpen = false),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  color: Colors.black.withOpacity(0.4),
                ),
              ),

            // SIDEBAR
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

Widget _buildInnerBackground() {
  return TweenAnimationBuilder<double>(
    tween: Tween(begin: 0, end: 1),
    duration: const Duration(seconds: 12),
    curve: Curves.linear,
    builder: (context, value, child) {
      return Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFEAF2FF),
              Color(0xFFF2ECFF),
              Color(0xFFE6F7FF),
            ],
          ),
        ),
        child: Stack(
          children: [
           
            Positioned.fill(
              child: Align(
                alignment: Alignment(
                  -0.8 + value * 1.6,
                  -0.6 + value * 0.8,
                ),
                child: _glowBlob(
                  const Color(0xFF7C6CFF),
                  size: 320,
                  opacity: 0.55,
                ),
              ),
            ),

      
            Positioned.fill(
              child: Align(
                alignment: Alignment(
                  0.8 - value * 1.6,
                  0.6 - value * 0.8,
                ),
                child: _glowBlob(
                  const Color(0xFF4FA8FF),
                  size: 340,
                  opacity: 0.5,
                ),
              ),
            ),

        
            Positioned.fill(
              child: Align(
                alignment: Alignment(
                  -0.2 + value * 0.6,
                  0.2 - value * 0.4,
                ),
                child: _glowBlob(
                  const Color(0xFF7FE7FF),
                  size: 280,
                  opacity: 0.35,
                ),
              ),
            ),

           
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    center: Alignment.center,
                    radius: 1.4,
                    colors: [
                      Colors.white.withOpacity(0.45),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 290,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.white.withOpacity(0.75),
                      Colors.white.withOpacity(0.2),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}

Widget _glowBlob(Color color, {
  double size = 300,
  double opacity = 0.5,
}) {
  return Container(
    width: size,
    height: size,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      gradient: RadialGradient(
        colors: [
          color.withOpacity(opacity),
          color.withOpacity(opacity * 0.4),
          Colors.transparent,
        ],
      ),
      boxShadow: [
        BoxShadow(
          color: color.withOpacity(opacity),
          blurRadius: 140,
          spreadRadius: 80,
        ),
      ],
    ),
  );
}


Widget _buildChatContent() {
  return SafeArea(
    child: ListView(
      padding: const EdgeInsets.only(
        top: 60,
        left: 20,
        right: 20,
        bottom: 110,
      ),
      children: [
        const Text(
          "Family Chat",
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w900,
          ),
        ),

        const SizedBox(height: 8),

        const Text(
          "Stay connected with your family.",
          style: TextStyle(
            fontSize: 14,
            color: Colors.black54,
          ),
        ),

        const SizedBox(height: 24),

        _buildChatTile(
          "Mom",
          "Did everyone eat lunch?",
          "2m ago",
          true,
        ),

        _buildChatTile(
          "Dad",
          "I'll be home by 7.",
          "12m ago",
          false,
        ),

        _buildChatTile(
          "Aisha",
          "Can someone pick me up?",
          "25m ago",
          true,
        ),

        _buildChatTile(
          "Family Group",
          "Movie night today 🍿",
          "1h ago",
          false,
        ),

        _buildChatTile(
          "Grandma",
          "Good morning dear ❤️",
          "3h ago",
          false,
        ),

        _buildChatTile(
          "Omar",
          "Sent the notes.",
          "5h ago",
          false,
        ),
      ],
    ),
  );
}



Widget _buildChatTile(
  String name,
  String message,
  String time,
  bool unread,
) {
  return StatefulBuilder(
    builder: (context, setHover) {
      bool hovered = false;

      return MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => setHover(() => hovered = true),
        onExit: (_) => setHover(() => hovered = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          transform: Matrix4.translationValues(
            0,
            hovered ? -3 : 0,
            0,
          ),
          margin: const EdgeInsets.only(bottom: 16),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(28),
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 16,
                sigmaY: 16,
              ),
              child: Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.38),
                  borderRadius: BorderRadius.circular(28),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.32),
                    width: 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(
                        hovered ? 0.08 : 0.04,
                      ),
                      blurRadius: hovered ? 28 : 16,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      width: 58,
                      height: 58,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            _brandBlue.withOpacity(0.9),
                            const Color(0xFF7C6CFF),
                          ],
                        ),
                        borderRadius:
                            BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color:
                                _brandBlue.withOpacity(0.3),
                            blurRadius: 18,
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          name[0],
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w800,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(width: 16),

                    Expanded(
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  name,
                                  style:
                                      const TextStyle(
                                    fontWeight:
                                        FontWeight.w800,
                                    fontSize: 16,
                                  ),
                                ),
                              ),

                              Text(
                                time,
                                style:
                                    const TextStyle(
                                  color:
                                      Colors.black45,
                                  fontSize: 11,
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 6),

                          Text(
                            message,
                            style: const TextStyle(
                              color: Colors.black54,
                              fontSize: 13,
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(width: 10),

                    if (unread)
                      Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              _brandBlue,
                              const Color(0xFF7C6CFF),
                            ],
                          ),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color:
                                  _brandBlue.withOpacity(
                                0.45,
                              ),
                              blurRadius: 12,
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    },
  );
}


Widget _buildHeader() {
  return Stack(
    children: [
      Positioned(
        top: 12,
        left: 10,
        child: IconButton(
          icon: const Icon(Icons.menu_rounded,
              color: Colors.black, size: 28),
          onPressed: () =>
              setState(() => _isSidebarOpen = true),
        ),
      ),

      Positioned(
        top: 12,
        right: 10,
        child: IconButton(
          icon: const Icon(Icons.settings,
              color: Color.fromARGB(255, 20, 20, 20), size: 26),
          onPressed: () {
            // open settings later
          },
        ),
      ),
    ],
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
                    color:  Color.fromARGB(255, 12, 12, 12),
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

        const Text(
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
      _sidebarTileV2(Icons.auto_awesome_rounded, "AI Assistant", false, const AiPage()),
      _sidebarTileV2(Icons.calendar_month_rounded, "Calendar", false, const Calender()),
      _sidebarTileV2(Icons.forum_rounded, "Family Chat", true, const Chat()),


      _sidebarTileV2(Icons.health_and_safety_rounded, "Health Hub", false, const Health()),
      _sidebarTileV2(Icons.paid_rounded, "Finance", false, const Finance()),
      _sidebarTileV2(Icons.child_care_rounded, "Kids", false, const Kids()),
      _sidebarTileV2(Icons.elderly_rounded, "Elder Care", false, const Elder()),

      const SizedBox(height: 10),
      const Divider(color: Colors.black12),

      _sidebarTileV2(Icons.verified_user_rounded, "Safety", false, const Safety()),
    ],
  );
}
Widget _sidebarTileV2(
  IconData icon,
  String title,
  bool isSelected,
  Widget? page,
) {
  bool isHovered = false;

  return StatefulBuilder(
    builder: (context, setState) {
      return MouseRegion(
        onEnter: (_) => setState(() => isHovered = true),
        onExit: (_) => setState(() => isHovered = false),
        child: GestureDetector(
          onTap: () {
            if (page != null) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => page),
              );
            }
          },
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
                Icon(icon,
                    size: 20,
                    color: isSelected ? Colors.black : Colors.black54),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight:
                        isSelected ? FontWeight.w800 : FontWeight.w500,
                    color: Colors.black87,
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