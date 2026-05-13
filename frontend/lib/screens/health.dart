// ignore_for_file: unused_import, prefer_final_fields, deprecated_member_use

import 'dart:ui';
import 'package:flutter/material.dart';
import 'ai.dart';
import 'safety.dart';
import 'chat.dart';
import 'login.dart';
import 'calender.dart';
import 'elder.dart';
import 'finance.dart';
import 'home.dart';
import 'kids.dart';

class Health extends StatefulWidget {
  const Health({super.key});

  @override
  State<Health> createState() => _HealthState();
}

class _HealthState extends State<Health> {
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
                  alignment: Alignment(-0.8 + value * 1.6, -0.6 + value * 0.8),
                  child: _glowBlob(const Color(0xFF7C6CFF), size: 320, opacity: 0.55),
                ),
              ),
              Positioned.fill(
                child: Align(
                  alignment: Alignment(0.8 - value * 1.6, 0.6 - value * 0.8),
                  child: _glowBlob(const Color(0xFF4FA8FF), size: 340, opacity: 0.5),
                ),
              ),
              Positioned.fill(
                child: Align(
                  alignment: Alignment(-0.2 + value * 0.6, 0.2 - value * 0.4),
                  child: _glowBlob(const Color(0xFF7FE7FF), size: 280, opacity: 0.35),
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
            onPressed: () {},
          ),
        ),
      ],
    );
  }

  // ─── PAGE CONTENT ───────────────────────────────────────────────────────────

  Widget _buildPageContent() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 60),
          const Text(
            "Family Health Hub",
            style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1A46BB)),
          ),
          const Text(
            "Real-time wellness tracking for the whole household.",
            style: TextStyle(fontSize: 12, color: Colors.black54),
          ),
          const SizedBox(height: 25),

          _buildVitalsCard("Divya", "Family Admin", "64 bpm", "8,432", true),
          const SizedBox(height: 20),

          _buildMemberAlertCard("Yash", "BP High", Colors.redAccent),
          const SizedBox(height: 20),

          _buildFoodScannerCard(),
          const SizedBox(height: 20),

          Row(
            children: [
              Expanded(
                  child: _buildSmallMemberCard("Asher", "Sleeping", Icons.nights_stay)),
              const SizedBox(width: 15),
              Expanded(
                  child: _buildSmallMemberCard("Hrishi", "Active", Icons.directions_run)),
            ],
          ),
          const SizedBox(height: 25),

          _buildMedReminders(),
          const SizedBox(height: 25),

          const Text("Quick Symptom Logger",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 15),
          _buildSymptomGrid(),
          const SizedBox(height: 25),

          _buildAIInsightCard(),
          const SizedBox(height: 125),
        ],
      ),
    );
  }

  // ─── GLASS CARD ─────────────────────────────────────────────────────────────

  Widget _buildGlassCard({required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.52),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.white.withOpacity(0.5)),
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

  // ─── CARD WIDGETS ────────────────────────────────────────────────────────────

  Widget _buildVitalsCard(
      String name, String role, String bpm, String steps, bool optimal) {
    return _buildGlassCard(
      child: Column(
        children: [
          Row(
            children: [
              const CircleAvatar(
                radius: 20,
                backgroundColor: Colors.transparent,
                backgroundImage: NetworkImage(
                  "https://res.cloudinary.com/dw4mv7p40/image/upload/v1778439357/samples/animals/cat.jpg",
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16)),
                  Text(role,
                      style: const TextStyle(fontSize: 10, color: Colors.grey)),
                ],
              ),
              const Spacer(),
              if (optimal)
                _statusBadge("Optimal Status", const Color(0xFFE8F1FF), Colors.blueAccent),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(child: _vitalStat("Resting Heart Rate", bpm, "bpm")),
              const VerticalDivider(),
              Expanded(child: _vitalStat("Daily Steps", steps, "")),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMemberAlertCard(String name, String alert, Color alertColor) {
    return _buildGlassCard(
      child: Row(
        children: [
              const CircleAvatar(
                radius: 20,
                backgroundColor: Colors.transparent,
                backgroundImage: NetworkImage(
                  "https://res.cloudinary.com/dw4mv7p40/image/upload/v1778439377/main-sample.png", 
                ),
              ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16)),
              Text("Alert",
                  style: TextStyle(fontSize: 10, color: alertColor)),
            ],
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: alertColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                Icon(Icons.warning_amber_rounded, color: alertColor, size: 14),
                const SizedBox(width: 5),
                Text(alert,
                    style: TextStyle(
                        color: alertColor,
                        fontSize: 12,
                        fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFoodScannerCard() {
    return _buildGlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("AI Food Scanner",
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: Color(0xFF1A46BB))),
          const Text("Scan your meal for instant nutritional insights.",
              style: TextStyle(fontSize: 11, color: Colors.black54)),
          const SizedBox(height: 15),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              gradient: const LinearGradient(
                  colors: [Color(0xFF2D62ED), Color(0xFF9061F9)]),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.camera_alt_outlined, color: Colors.white, size: 18),
                SizedBox(width: 8),
                Text("Scan Now",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSmallMemberCard(String name, String status, IconData icon) {
    return _buildGlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const CircleAvatar(
                radius: 20,
                backgroundColor: Colors.transparent,
                backgroundImage: NetworkImage(
                  "https://res.cloudinary.com/dw4mv7p40/image/upload/v1778439371/samples/man-portrait.jpg", 
                ),
              ),
              const SizedBox(width: 8),
              Text(name,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 14)),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Icon(icon, size: 16, color: _brandBlue),
              const SizedBox(width: 6),
              Text(status,
                  style: TextStyle(
                      fontSize: 12,
                      color: _brandBlue,
                      fontWeight: FontWeight.w600)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMedReminders() {
    return _buildGlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.medication_rounded, size: 18, color: Colors.redAccent),
              SizedBox(width: 8),
              Text("Med Reminders",
                  style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            ],
          ),
          const SizedBox(height: 15),
          _medReminderItem("Divya - Vitamin D", "8:00 AM", true),
          const SizedBox(height: 10),
          _medReminderItem("Yash - Blood Pressure", "12:00 PM", false),
          const SizedBox(height: 10),
          _medReminderItem("Kanish - Aspirin", "6:00 PM", false),
        ],
      ),
    );
  }

  Widget _medReminderItem(String label, String time, bool taken) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: taken
            ? Colors.blue.withOpacity(0.06)
            : Colors.white.withOpacity(0.4),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Icon(
              taken
                  ? Icons.check_circle_rounded
                  : Icons.radio_button_unchecked,
              color: taken ? Colors.blueAccent : Colors.grey,
              size: 18),
          const SizedBox(width: 10),
          Expanded(
            child: Text(label,
                style: const TextStyle(
                    fontSize: 13, fontWeight: FontWeight.w600)),
          ),
          Text(time,
              style: const TextStyle(fontSize: 11, color: Colors.grey)),
        ],
      ),
    );
  }

  Widget _buildSymptomGrid() {
    final symptoms = [
      {'icon': Icons.wb_sunny_outlined, 'label': 'Fever'},
      {'icon': Icons.sentiment_dissatisfied, 'label': 'Headache'},
      {'icon': Icons.waves, 'label': 'Nausea'},
      {'icon': Icons.air_outlined, 'label': 'Cough'},
      {'icon': Icons.bedtime_outlined, 'label': 'Fatigue'},
      {'icon': Icons.link, 'label': 'Joint Pain'},
      {'icon': Icons.remove_red_eye_outlined, 'label': 'Eye Strain'},
      {'icon': Icons.add, 'label': 'Other'},
    ];

    return _buildGlassCard(
      child: Wrap(
        spacing: 15,
        runSpacing: 15,
        alignment: WrapAlignment.spaceBetween,
        children: symptoms
            .map((s) => Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.6),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(s['icon'] as IconData,
                          size: 20, color: Colors.black54),
                    ),
                    const SizedBox(height: 5),
                    Text(s['label'] as String,
                        style: const TextStyle(
                            fontSize: 10, color: Colors.black54)),
                  ],
                ))
            .toList(),
      ),
    );
  }

  Widget _buildAIInsightCard() {
    return _buildGlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("AI Health Insight",
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1A46BB))),
          const SizedBox(height: 10),
          const Text(
            "Based on family data from the last 7 days, your collective activity is up 12%. Yash's blood pressure trend is stabilizing.",
            style: TextStyle(fontSize: 12, color: Colors.black54, height: 1.4),
          ),
          const SizedBox(height: 20),
          _insightMiniRow("ACTIVE MINUTES", "1,240", "total", Colors.blue),
          const SizedBox(height: 15),
          _insightMiniRow("SLEEP QUALITY", "84", "avg score", Colors.purple),
        ],
      ),
    );
  }

  // ─── SHARED UI HELPERS ───────────────────────────────────────────────────────

  Widget _statusBadge(String text, Color bg, Color fg) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration:
          BoxDecoration(color: bg, borderRadius: BorderRadius.circular(8)),
      child: Text(text,
          style: TextStyle(
              color: fg, fontSize: 9, fontWeight: FontWeight.bold)),
    );
  }

  Widget _vitalStat(String label, String value, String unit) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(fontSize: 10, color: Colors.grey)),
        Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Text(value,
                style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1A46BB))),
            const SizedBox(width: 4),
            Text(unit,
                style: const TextStyle(
                    fontSize: 12, color: Color(0xFF1A46BB))),
          ],
        ),
      ],
    );
  }

  Widget _insightMiniRow(
      String label, String val, String sub, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(
                fontSize: 9,
                fontWeight: FontWeight.bold,
                color: Colors.grey)),
        Row(
          children: [
            Text(val,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: color)),
            const SizedBox(width: 5),
            Text(sub,
                style: const TextStyle(fontSize: 11, color: Colors.grey)),
          ],
        ),
        LinearProgressIndicator(
            value: 0.7,
            color: color,
            backgroundColor: Colors.grey[100],
            minHeight: 4),
      ],
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
              border:
                  Border.all(color: Colors.white.withOpacity(0.25), width: 1),
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
                    Icons.home_filled, "Home", _currentIndex == 0, 0),
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
                  Icon(icon,
                      color: isActive
                          ? _brandBlue
                          : isHovered
                              ? _brandBlue.withOpacity(0.8)
                              : Colors.black26,
                      size: 24),
                  Text(label,
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight:
                            isActive ? FontWeight.w900 : FontWeight.bold,
                        color: isActive
                            ? _brandBlue
                            : isHovered
                                ? _brandBlue.withOpacity(0.8)
                                : Colors.black26,
                      )),
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
                child: const Icon(Icons.blur_on_rounded,
                    color: Colors.white, size: 30),
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


      _sidebarTileV2(Icons.health_and_safety_rounded, "Health Hub", true, const Health()),
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