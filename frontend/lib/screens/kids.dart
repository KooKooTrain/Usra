// ignore_for_file: prefer_final_fields, deprecated_member_use

import 'dart:ui';
import 'package:flutter/material.dart';
import 'ai.dart';
import 'safety.dart';
import 'chat.dart';
import 'calender.dart';
import 'elder.dart';
import 'login.dart';
import 'finance.dart';
import 'health.dart';
import 'home.dart';

class Kids extends StatefulWidget {
  const Kids({super.key});

  @override
  State<Kids> createState() => _KidsState();
}

class _KidsState extends State<Kids> {
  bool _isSidebarOpen = false;
  int _currentIndex = 0;

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

  // ─── GLASS HELPER ───────────────────────────────────────────────────────────

Widget _bar(double value, String label) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        width: 18,
        height: value * 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          gradient: const LinearGradient(
            colors: [Color(0xFF2D62ED), Color(0xFF9061F9)],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),
        ),
      ),
      const SizedBox(height: 6),
      Text(label, style: const TextStyle(fontSize: 10)),
    ],
  );
}

  Widget glass({
    required Widget child,
    double radius = 24,
    double opacity = 0.18,
    EdgeInsets padding = const EdgeInsets.all(0),
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Container(
          padding: padding,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(opacity),
            borderRadius: BorderRadius.circular(radius),
            border: Border.all(
              color: Colors.white.withOpacity(0.25),
              width: 1,
            ),
          ),
          child: child,
        ),
      ),
    );
  }

  // ─── PHONE FRAME ────────────────────────────────────────────────────────────

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

            _buildPageContent(),

            _buildHeader(),

            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: _buildBottomNav(),
            ),

            // SIDEBAR OVERLAY
            if (_isSidebarOpen)
              GestureDetector(
                onTap: () => setState(() => _isSidebarOpen = false),
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

  // ─── BACKGROUND ─────────────────────────────────────────────────────────────

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

  Widget _glowBlob(Color color, {double size = 300, double opacity = 0.5}) {
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

  // ─── HEADER ─────────────────────────────────────────────────────────────────

  Widget _buildHeader() {
    return Stack(
      children: [
        Positioned(
          top: 12,
          left: 10,
          child: IconButton(
            icon: const Icon(Icons.menu_rounded, color: Colors.black, size: 28),
            onPressed: () => setState(() => _isSidebarOpen = true),
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


  Widget _buildPageContent() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 70),
          const Text(
            "FAMILY MODULE",
            style: TextStyle(
              color: Colors.blueAccent,
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Text(
            "Divya's Learning\nJourney",
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 10),
          _buildGemBadge(),
          const SizedBox(height: 25),
          _buildHomeworkAICard(),
          const SizedBox(height: 25),
          _buildScreenTimeCard(),
          const SizedBox(height: 25),
          _buildAcademicGrowthCard(),
          const SizedBox(height: 25),
          _buildUniRecommendations(),
          const SizedBox(height: 25),
          const Text(
            "Recent Milestones",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 15),
          _buildMilestoneItem(
            "Physics Test",
            "A+ Score Achieved!",
            Icons.camera_enhance,
            Colors.black,
          ),
          const SizedBox(height: 7),
          _buildMilestoneItem(
            "Reading Streak",
            "7 Days Consistent",
            Icons.menu_book,
            Colors.brown,
          ),
          const SizedBox(height: 120),
        ],
      ),
    );
  }

  // ─── CARDS ──────────────────────────────────────────────────────────────────

  Widget _buildGemBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.stars, color: Colors.amber, size: 18),
          SizedBox(width: 5),
          Text("1,240 Gems",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildHomeworkAICard() {
    return _GlassContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _badge("LIVE ASSISTANCE"),
              const Icon(Icons.share_outlined, size: 18, color: Colors.grey),
            ],
          ),
          const SizedBox(height: 10),
          const Text("Homework AI",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          const Text(
            "Divya is currently working on \"The Solar System\" essay...",
            style: TextStyle(color: Colors.black54, fontSize: 13),
          ),
          const SizedBox(height: 15),
          _buildAIChatBubble(),
          const SizedBox(height: 15),
          _gradientButton("Join Discussion"),
        ],
      ),
    );
  }

  Widget _buildScreenTimeCard() {
    return _GlassContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("SCREEN TIME",
                  style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Colors.black54)),
              Icon(Icons.access_time, size: 16, color: Colors.black54),
            ],
          ),
          const SizedBox(height: 15),
          _timeBar("Educational Apps", "2h 15m / 3h", 0.7, Colors.blue),
          const SizedBox(height: 12),
          _timeBar("Entertainment", "55m / 1h", 0.9, Colors.red),
          const SizedBox(height: 15),
          _statusBox(Icons.block, "CURR. ACTIVE\nApps lock in 15 mins"),
        ],
      ),
    );
  }

  Widget _buildAcademicGrowthCard() {
    return _GlassContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Academic\nGrowth",
                  style:
                      TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              DropdownButton<String>(
                value: 'This Week',
                items: const [
                  DropdownMenuItem(
                      value: 'This Week',
                      child: Text('This Week',
                          style: TextStyle(fontSize: 12)))
                ],
                onChanged: (_) {},
                underline: const SizedBox(),
              ),
            ],
          ),
          const SizedBox(height: 40),
          SizedBox(
            height: 120,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _bar(0.4, "Mon"),
                _bar(0.7, "Tue"),
                _bar(0.5, "Wed"),
                _bar(0.9, "Thu"),
                _bar(0.6, "Fri"),
                _bar(0.8, "Sat"),
                _bar(0.3, "Sun"),
              ],
            ),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildUniRecommendations() {
    return _GlassContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("UNIVERSITY RECOMMENDATIONS",
              style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54)),
          const SizedBox(height: 12),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                "https://res.cloudinary.com/dw4mv7p40/image/upload/v1778624444/_ADU_Ranking_web-0-690-0-0_bbjpm3.webp",
                width: 40,
                height: 40,
                fit: BoxFit.cover,
              ),
            ),
            title: const Text("Abu Dhabi University",
                style:
                    TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
            subtitle: const Text("Top choice for Computer Science",
                style: TextStyle(fontSize: 12)),
            trailing:
                const Icon(Icons.arrow_forward_ios, size: 14),
          ),
        ],
      ),
    );
  }

  // ─── HELPERS ────────────────────────────────────────────────────────────────

  Widget _timeBar(
      String label, String time, double progress, Color color) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label,
                style: const TextStyle(
                    fontSize: 11, fontWeight: FontWeight.w600)),
            Text(time,
                style: const TextStyle(
                    fontSize: 11, color: Colors.blueAccent)),
          ],
        ),
        const SizedBox(height: 5),
        LinearProgressIndicator(
            value: progress,
            color: color,
            backgroundColor: Colors.grey[200],
            minHeight: 6),
      ],
    );
  }

  Widget _buildAIChatBubble() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          color: const Color(0xFFE8F1FF),
          borderRadius: BorderRadius.circular(15)),
      child: const Text(
        "\"That's a great start, Divya! Did you know Saturn's rings are mostly made of ice and rock?\"",
        style: TextStyle(
            fontSize: 12,
            color: Color(0xFF1A46BB),
            fontStyle: FontStyle.italic),
      ),
    );
  }

Widget _buildMilestoneItem(
    String title, String sub, IconData icon, Color color) {
  return _GlassContainer(
    child: Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.8),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: Colors.white, size: 20),
        ),
        const SizedBox(width: 15),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style: const TextStyle(fontWeight: FontWeight.bold)),
            Text(sub,
                style: const TextStyle(
                    color: Colors.blueAccent, fontSize: 11)),
          ],
        )
      ],
    ),
  );
}

  Widget _gradientButton(String text) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: const LinearGradient(
            colors: [Color(0xFF2D62ED), Color(0xFF9061F9)]),
      ),
      child: Center(
          child: Text(text,
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold))),
    );
  }

  Widget _badge(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
          color: Colors.blue[50], borderRadius: BorderRadius.circular(8)),
      child: Text(text,
          style: const TextStyle(
              color: Colors.blueAccent,
              fontSize: 9,
              fontWeight: FontWeight.bold)),
    );
  }

  Widget _statusBox(IconData icon, String text) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          color: Colors.grey[100], borderRadius: BorderRadius.circular(15)),
      child: Row(
        children: [
          Icon(icon, size: 18, color: Colors.grey),
          const SizedBox(width: 10),
          Text(text,
              style:
                  const TextStyle(fontSize: 10, color: Colors.black54)),
        ],
      ),
    );
  }

  // ─── BOTTOM NAV ─────────────────────────────────────────────────────────────

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
                _buildPremiumNavItem(Icons.home_filled, "Home",
                    _currentIndex == 0, 0),
                _buildPremiumNavItem(Icons.auto_awesome_rounded,
                    "AI Assistant", _currentIndex == 1, 1),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPremiumNavItem(
      IconData icon, String label, bool isActive, int index) {
    bool isHovered = false;

    return StatefulBuilder(
      builder: (context, setNavState) {
        return MouseRegion(
          cursor: SystemMouseCursors.click,
          onEnter: (_) => setNavState(() => isHovered = true),
          onExit: (_) => setNavState(() => isHovered = false),
          child: GestureDetector(
            onTap: () {
              if (index == 0) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const HomePage()),
                );
              } else if (index == 1) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const AiPage()),
                );
              }
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              padding:
                  const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
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

  // ─── SIDEBAR ────────────────────────────────────────────────────────────────

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
                      color: Color.fromARGB(255, 12, 12, 12),
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
      _sidebarTileV2(Icons.forum_rounded, "Family Chat", false, const Chat()),


      _sidebarTileV2(Icons.health_and_safety_rounded, "Health Hub", false, const Health()),
      _sidebarTileV2(Icons.paid_rounded, "Finance", false, const Finance()),
      _sidebarTileV2(Icons.child_care_rounded, "Kids", true, const Kids()),
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
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 40),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 12, 12, 12),
          borderRadius: BorderRadius.circular(18),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.logout_rounded, color: Colors.white, size: 18),
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

// ─── SHARED WIDGET ──────────────────────────────────────────────────────────

class _GlassContainer extends StatelessWidget {
  final Widget child;
  const _GlassContainer({required this.child});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(25),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.15),
            borderRadius: BorderRadius.circular(25),
            border: Border.all(
              color: Colors.white.withOpacity(0.25),
              width: 1,
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}