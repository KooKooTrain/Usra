// ignore_for_file: unnecessary_const, prefer_const_literals_to_create_immutables, prefer_const_constructors, dead_code, prefer_final_fields, deprecated_member_use

import 'dart:ui';
import 'package:flutter/material.dart';
import 'ai.dart';
import 'safety.dart';
import 'chat.dart';
import 'home.dart';
import 'elder.dart';
import 'login.dart';
import 'finance.dart';
import 'health.dart';
import 'kids.dart';

class Calender extends StatefulWidget {
  const Calender({super.key});

  @override
  State<Calender> createState() => _CalenderState();
}

class _CalenderState extends State<Calender> {
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

Widget _buildPageContent() {
  return SafeArea(
    child: Padding(
      padding: const EdgeInsets.only(
        left: 20,
        right: 20,
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 55),
            const Text(
              "Family Calendar",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w900,
              ),
            ),

            const SizedBox(height: 8),

            const Text(
              "Plan smarter. Live better together.",
              style: TextStyle(
                fontSize: 14,
                color: Colors.black54,
              ),
            ),

            const SizedBox(height: 15),

            SizedBox(
              height: 58,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _buildQuickAction(
                    Icons.add_rounded,
                    "Add Event",
                  ),
                  _buildQuickAction(
                    Icons.groups_rounded,
                    "Family Meet",
                  ),
                ],
              ),
            ),

            const SizedBox(height: 5),

            // CALENDAR
            StatefulBuilder(
              builder: (context, setHover) {
                bool hovered = false;

                return MouseRegion(
                  cursor: SystemMouseCursors.click,
                  onEnter: (_) => setHover(() => hovered = true),
                  onExit: (_) => setHover(() => hovered = false),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    transform: Matrix4.translationValues(
                      0,
                      hovered ? -4 : 0,
                      0,
                    ),
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.white.withOpacity(0.72),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.5),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(
                            hovered ? 0.08 : 0.04,
                          ),
                          blurRadius: hovered ? 28 : 16,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                          children: [
                            const Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "July 2026",
                                  style: TextStyle(
                                    fontSize: 21,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                                SizedBox(height: 2),
                                Text(
                                  "18 events this month",
                                  style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),

                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: _brandBlue.withOpacity(0.1),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.calendar_month_rounded,
                                color: _brandBlue,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 18),

                        Row(
                          mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                          children: const [
                            Text("M"),
                            Text("T"),
                            Text("W"),
                            Text("T"),
                            Text("F"),
                            Text("S"),
                            Text("S"),
                          ],
                        ),

                        const SizedBox(height: 14),

                        Wrap(
                          spacing: 10,
                          runSpacing: 10,
                          children: List.generate(31, (index) {
                            bool selected = index + 1 == 13;

                            return StatefulBuilder(
                              builder: (context, setDayHover) {
                                bool dayHover = false;

                                return MouseRegion(
                                  onEnter: (_) =>
                                      setDayHover(() => dayHover = true),
                                  onExit: (_) =>
                                      setDayHover(() => dayHover = false),
                                  child: AnimatedContainer(
                                    duration:
                                        const Duration(milliseconds: 180),
                                    width: 34,
                                    height: 34,
                                    transform:
                                        Matrix4.translationValues(
                                      0,
                                      dayHover ? -2 : 0,
                                      0,
                                    ),
                                    decoration: BoxDecoration(
                                      color: selected
                                          ? _brandBlue
                                          : dayHover
                                              ? _brandBlue
                                                  .withOpacity(0.08)
                                              : Colors.white,
                                      borderRadius:
                                          BorderRadius.circular(12),
                                      boxShadow: [
                                        if (selected)
                                          BoxShadow(
                                            color: _brandBlue
                                                .withOpacity(0.35),
                                            blurRadius: 14,
                                          ),
                                      ],
                                    ),
                                    child: Center(
                                      child: Text(
                                        "${index + 1}",
                                        style: TextStyle(
                                          color: selected
                                              ? Colors.white
                                              : Colors.black87,
                                          fontWeight:
                                              FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          }),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),

            const SizedBox(height: 22),

            _buildGlassCard(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Today's Schedule",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      Icon(
                        Icons.schedule_rounded,
                        color: _brandBlue,
                      ),
                    ],
                  ),

                  const SizedBox(height: 18),

                  _buildScheduleTile(
                    "8:00 AM",
                    "School Drop-Off",
                    Icons.directions_car_rounded,
                    const Color(0xFF6C63FF),
                  ),

                  _buildScheduleTile(
                    "4:00 PM",
                    "Football Practice",
                    Icons.sports_soccer_rounded,
                    const Color(0xFF00B894),
                  ),

                  _buildScheduleTile(
                    "7:30 PM",
                    "Family Dinner",
                    Icons.restaurant_rounded,
                    Colors.orange,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 22),

            // AI CARD
            Container(
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.black,
                    const Color(0xFF161A2D),
                  ],
                ),
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    blurRadius: 24,
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.08),
                      borderRadius:
                          BorderRadius.circular(20),
                    ),
                    child: const Icon(
                      Icons.auto_awesome_rounded,
                      color: Colors.white,
                    ),
                  ),

                  const SizedBox(width: 16),

                  const Expanded(
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        Text(
                          "USRA AI Insight",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w800,
                            fontSize: 18,
                          ),
                        ),

                        SizedBox(height: 8),

                        Text(
                          "Your family has a free evening today. Perfect time for a family walk or game night.",
                          style: TextStyle(
                            color: Colors.white70,
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 22),

            // BIRTHDAY CARD
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: StatefulBuilder(
                builder: (context, setHover) {
                  bool hovered = false;

                  return MouseRegion(
                    onEnter: (_) => setHover(() => hovered = true),
                    onExit: (_) => setHover(() => hovered = false),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      transform: Matrix4.translationValues(
                        0,
                        hovered ? -4 : 0,
                        0,
                      ),
                      padding: const EdgeInsets.all(22),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            const Color(0xFFFFD6E7),
                            const Color(0xFFFFF0C9),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.pink.withOpacity(
                              hovered ? 0.22 : 0.12,
                            ),
                            blurRadius: hovered ? 30 : 18,
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 250),
                            width: hovered ? 70 : 62,
                            height: hovered ? 70 : 62,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.7),
                              borderRadius: BorderRadius.circular(22),
                            ),
                            child: const Icon(
                              Icons.cake_rounded,
                              color: Colors.pink,
                              size: 34,
                            ),
                          ),

                          const SizedBox(width: 18),

                          const Expanded(
                            child: Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Birthday Reminder 🎉",
                                  style: TextStyle(
                                    fontSize: 19,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),

                                SizedBox(height: 8),

                                Text(
                                  "Aisha's birthday is tomorrow. USRA recommends planning a family dinner and preparing a surprise gift.",
                                  style: TextStyle(
                                    color: Colors.black87,
                                    height: 1.5,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

          const SizedBox(height: 22),
            // PRODUCTIVITY CARD
            _buildGlassCard(
              child: Row(
                children: [
                  Expanded(
                    child: _buildMiniStat(
                      "Events",
                      "18",
                      Icons.event_rounded,
                    ),
                  ),

                  const SizedBox(width: 14),

                  Expanded(
                    child: _buildMiniStat(
                      "Tasks",
                      "9",
                      Icons.task_alt_rounded,
                    ),
                  ),

                  const SizedBox(width: 14),

                  Expanded(
                    child: _buildMiniStat(
                      "Free Time",
                      "3h",
                      Icons.free_breakfast_rounded,
                    ),
                  ),

                ],
                
              ),
              
            ),
            const SizedBox(height: 120)
          ],
        ),
      ),
    ),
  );
}

Widget _buildQuickAction(
  IconData icon,
  String text,
) {
  bool isHovered = false;

  return StatefulBuilder(
    builder: (context, setHover) {
      return MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => setHover(() => isHovered = true),
        onExit: (_) => setHover(() => isHovered = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          margin: const EdgeInsets.only(right: 12, top: 4, bottom: 4),
          padding: const EdgeInsets.symmetric(
            horizontal: 18,
            vertical: 12,
          ),
          transform: Matrix4.translationValues(
            0,
            isHovered ? -3 : 0,
            0,
          ),
          decoration: BoxDecoration(
            color: isHovered
                ? _brandBlue
                : Colors.white.withOpacity(0.72),
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 12,
              ),
            ],
          ),
          child: Row(
            children: [
              Icon(
                icon,
                size: 18,
                color: isHovered
                    ? Colors.white
                    : _brandBlue,
              ),

              const SizedBox(width: 8),

              Text(
                text,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: isHovered
                      ? Colors.white
                      : Colors.black87,
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

Widget _buildGlassCard({
  required Widget child,
}) {
  return Container(
    padding: const EdgeInsets.all(22),
    decoration: BoxDecoration(
      color: Colors.white.withOpacity(0.52),
      borderRadius: BorderRadius.circular(30),
      border: Border.all(
        color: Colors.white.withOpacity(0.5),
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.06),
          blurRadius: 16,
        ),
      ],
    ),
    child: child,
  );
}

Widget _buildScheduleTile(
  String time,
  String title,
  IconData icon,
  Color color,
) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 16),
    child: Row(
      children: [
        Container(
          width: 52,
          height: 52,
          decoration: BoxDecoration(
            color: color.withOpacity(0.12),
            borderRadius: BorderRadius.circular(18),
          ),
          child: Icon(
            icon,
            color: color,
          ),
        ),

        const SizedBox(width: 16),

        Expanded(
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 15,
                ),
              ),

              const SizedBox(height: 4),

              Text(
                time,
                style: const TextStyle(
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildMiniStat(
  String title,
  String value,
  IconData icon,
) {
  return Container(
    padding: const EdgeInsets.symmetric(
      vertical: 18,
    ),
    decoration: BoxDecoration(
      color: Colors.white.withOpacity(0.8),
      borderRadius: BorderRadius.circular(22),
    ),
    child: Column(
      children: [
        Icon(
          icon,
          color: _brandBlue,
        ),

        const SizedBox(height: 10),

        Text(
          value,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w900,
            color: _brandBlue,
          ),
        ),

        const SizedBox(height: 4),

        Text(
          title,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.black54,
          ),
        ),
      ],
    ),
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
      _sidebarTileV2(Icons.auto_awesome_rounded, "AI Assistant", false, const AiPage()),
      _sidebarTileV2(Icons.calendar_month_rounded, "Calendar", true, const Calender()),
      _sidebarTileV2(Icons.forum_rounded, "Family Chat", false, const Chat()),


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