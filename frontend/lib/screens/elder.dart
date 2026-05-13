// ignore_for_file: prefer_final_fields, deprecated_member_use

import 'dart:ui';
import 'package:flutter/material.dart';
import 'ai.dart';
import 'safety.dart';
import 'chat.dart';
import 'calender.dart';
import 'home.dart';
import 'login.dart';
import 'finance.dart';
import 'health.dart';
import 'kids.dart';
class Elder extends StatefulWidget {
  const Elder({super.key});

  @override
  State<Elder> createState() => _ElderState();
}

class _ElderState extends State<Elder> {
  bool _isSidebarOpen = false;
  int _currentIndex = 2;
  final ScrollController _flowController = ScrollController();

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

  // ─── PAGE CONTENT ───────────────────────────────────────────────────────────

  Widget _buildPageContent() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          const SizedBox(height: 70),

          // 1. Memory Anchor Section
          _buildMemoryAnchor(),
          const SizedBox(height: 25),

          // 2. Activity Monitor (ESP32 Integration UI)
          _buildActivityMonitor(),
          const SizedBox(height: 25),

          // 3. Medicine Reminder (Med Compliance)
          _buildMedCompliance(),
          const SizedBox(height: 25),

          // 4. Story Vault Memory
          _buildStoryVault(),
          const SizedBox(height: 25),

          // 5. Daily Flow (Timeline)
          _buildDailyFlow(),

          const SizedBox(height: 120),
        ],
      ),
    );
  }

  // ─── UI MODULES ─────────────────────────────────────────────────────────────

  Widget _buildMemoryAnchor() {
    return _GlassContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "MEMORY ANCHOR",
            style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
                letterSpacing: 1.2),
          ),
          const SizedBox(height: 15),
          const Row(
            children: [
              CircleAvatar(
                  radius: 25,
                  backgroundImage:
                      NetworkImage('https://res.cloudinary.com/dw4mv7p40/image/upload/v1778439356/sample.jpg')),
              SizedBox(width: 15),
              Text(
                "Elder Care Hub,\nHi Evelyn!",
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1A46BB),
                    height: 1.1),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.5),
                borderRadius: BorderRadius.circular(15)),
            child: const Text(
              "Today is Wednesday, May 13th. The sun is shining in the conservatory. Your grandson Liam is coming for tea at 4:00 PM.",
              style: TextStyle(fontSize: 13, color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActivityMonitor() {
    return _GlassContainer(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Row(children: [
                Icon(Icons.monitor_heart,
                    size: 18, color: Color(0xFF1A46BB)),
                SizedBox(width: 8),
                Text("Activity Monitor",
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ]),
              _statusBadge("ESP32: CONNECTED"),
            ],
          ),
          const SizedBox(height: 20),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: 1.5,
            children: [
              _gridItem(Icons.chair, "Living Room", "Motion 2m\nago", true),
              _gridItem(Icons.bed, "Bedroom", "Quiet", false),
              _gridItem(Icons.kitchen, "Kitchen", "Active", true),
              _gridItem(Icons.thermostat, "Temp", "72°F", false),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMedCompliance() {
    return _GlassContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(children: [
            Icon(Icons.medical_services, size: 18, color: Colors.redAccent),
            SizedBox(width: 8),
            Text("Med Compliance",
                style: TextStyle(fontWeight: FontWeight.bold)),
          ]),
          const SizedBox(height: 15),
          _medItem("Morning Vit.", "Taken at 8:15 AM", true),
          const SizedBox(height: 10),
          _medItem("Blood Pressure", "Due at 12:00 PM", false),
        ],
      ),
    );
  }

  Widget _buildStoryVault() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient:
            LinearGradient(colors: [Colors.blue[50]!, Colors.blue[100]!]),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("The Story Vault",
              style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1A46BB))),
          const SizedBox(height: 10),
          const Text(
              "Search through shared memories, recorded tales, and family history.",
              style: TextStyle(color: Colors.black54, fontSize: 13)),
          const SizedBox(height: 20),
          _searchBar(),
        ],
      ),
    );
  }


Widget _buildDailyFlow() {
  return _GlassContainer(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(
          children: [
            Icon(Icons.access_time, size: 18, color: Colors.orange),
            SizedBox(width: 8),
            Text(
              "Daily Flow",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(height: 20),

        Scrollbar(
          controller: _flowController,
          thumbVisibility: true,
          thickness: 4,
          radius: const Radius.circular(10),
          child: SingleChildScrollView(
            controller: _flowController,
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _flowCard("09:00 AM", "Morning Walk", "in the garden", Colors.blue),
                const SizedBox(width: 15),
                _flowCard("11:30 AM", "Puzzles", "Living room", Colors.orange),
                const SizedBox(width: 15),
                _flowCard("02:00 PM", "Tea Time", "Balcony", Colors.green),
                const SizedBox(width: 15),
                _flowCard("06:00 PM", "Evening News", "TV Room", Colors.purple),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

  // ─── SUB-WIDGETS ────────────────────────────────────────────────────────────

  Widget _medItem(String title, String sub, bool taken) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.6),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.white)),
      child: Row(
        children: [
          Icon(
              taken
                  ? Icons.check_circle
                  : Icons.radio_button_unchecked,
              color: taken ? Colors.blueAccent : Colors.grey),
          const SizedBox(width: 12),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(title,
                style: const TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 14)),
            Text(sub,
                style:
                    const TextStyle(fontSize: 11, color: Colors.grey)),
          ]),
        ],
      ),
    );
  }

  Widget _gridItem(
      IconData icon, String room, String status, bool isActive) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.5),
          borderRadius: BorderRadius.circular(15)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: const Color(0xFF1A46BB), size: 20),
          const SizedBox(height: 4),
          Text(room,
              style: const TextStyle(fontSize: 10, color: Colors.grey)),
          Text(status,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: isActive
                      ? const Color(0xFF1A46BB)
                      : Colors.black87)),
        ],
      ),
    );
  }

  Widget _flowCard(
      String time, String activity, String loc, Color color) {
    return Container(
      padding: const EdgeInsets.all(15),
      width: 160,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border(left: BorderSide(color: color, width: 4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(time,
              style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.bold,
                  fontSize: 12)),
          const SizedBox(height: 5),
          Text(activity,
              style: const TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 14)),
          Text(loc,
              style:
                  const TextStyle(color: Colors.grey, fontSize: 10)),
        ],
      ),
    );
  }

  Widget _statusBadge(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
          color: const Color(0xFFDFFFE8),
          borderRadius: BorderRadius.circular(8)),
      child: Text(text,
          style: const TextStyle(
              color: Color(0xFF1DB954),
              fontSize: 9,
              fontWeight: FontWeight.bold)),
    );
  }

  Widget _searchBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(15)),
      child: Row(
        children: [
          const Icon(Icons.search, color: Colors.grey, size: 20),
          const SizedBox(width: 10),
          const Expanded(
              child: Text("Search Memories",
                  style: TextStyle(color: Colors.grey, fontSize: 13))),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF345DA7),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10))),
            child: const Text("Search",
                style: TextStyle(color: Colors.white)),
          )
        ],
      ),
    );
  }

  // ─── BOTTOM NAV ─────────────────────────────────────────────────────────────

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
                  Icons.home_filled, "Home", _currentIndex == 0, 0),
              _buildPremiumNavItem(Icons.auto_awesome_rounded,
                  "AI Assistant", _currentIndex == 1, 1),
            ],
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
      _sidebarTileV2(Icons.forum_rounded, "Family Chat", false, const Chat()),


      _sidebarTileV2(Icons.health_and_safety_rounded, "Health Hub", false, const Health()),
      _sidebarTileV2(Icons.paid_rounded, "Finance", false, const Finance()),
      _sidebarTileV2(Icons.child_care_rounded, "Kids", false, const Kids()),
      _sidebarTileV2(Icons.elderly_rounded, "Elder Care", true, const Elder()),

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