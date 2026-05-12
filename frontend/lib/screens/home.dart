// ignore_for_file: deprecated_member_use, unnecessary_import
import 'ai.dart';
import 'dart:ui';
import 'safety.dart';
import 'chat.dart';
import 'calender.dart';
import 'elder.dart';
import 'finance.dart';
import 'health.dart';
import 'kids.dart';

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isSidebarOpen = false;

  
  final Color _brandBlue = const Color(0xFF0056D2);
  final Color _actionIconColor = const Color(0xFF0056D2).withOpacity(0.7);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // The outer world background
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
        child: Stack(
          children: [
           
            _buildInnerBackground(),
     
            _buildMainScrollableContent(),

        
            _buildHeader(),
          
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
            // PRIMARY GLOW (purple - stronger, slow drift)
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

            // CENTER LIGHT WASH (makes glass POP)
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

  Widget _buildMainScrollableContent() {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 75),
            _buildGreetingSection(),
            const SizedBox(height: 25),
            _buildFamilyStatusList(),
            const SizedBox(height: 25),
            _buildFamilySuggestion(),
            const SizedBox(height: 25),
            _buildQuickActionsGrid(),
            const SizedBox(height: 15),
            _buildUsraAIBtn(),
            const SizedBox(height: 15),
          ],
        ),
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
        color: Colors.white.withOpacity(0.2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: SafeArea(
        bottom: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // menu
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: IconButton(
                icon: const Icon(Icons.menu_rounded,
                    color: Color.fromARGB(255, 33, 32, 32), size: 28),
                onPressed: () =>
                    setState(() => _isSidebarOpen = true),
              ),
            ),

            // logo + title
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(
                        color: const Color.fromARGB(255, 33, 32, 32).withOpacity(0.1)),
                  ),
                  child: const Icon(Icons.share_outlined,
                      color: Color.fromARGB(255, 33, 32, 32), size: 20),
                ),
                const SizedBox(width: 10),
                const Text(
                  "Usra أسرة",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Color.fromARGB(255, 33, 32, 32),
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),

            // settings
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: IconButton(
                icon: const Icon(Icons.settings_rounded,
                    color: Color.fromARGB(255, 33, 32, 32), size: 26),
                onPressed: () {
               
                },
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
  // --- REUSABLE COMPONENTS (Updated with Hover & Cursors) ---

  Widget _buildGreetingSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("FAMILY STATUS", style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: _brandBlue, letterSpacing: 1.2)),
        const SizedBox(height: 8),
        const Text("Good Morning!", style: TextStyle(fontSize: 26, fontWeight: FontWeight.w800, color: Color(0xFF1A1A1A))),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.6),
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: Colors.white.withOpacity(0.4)),
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.wb_sunny_rounded, size: 16, color: Colors.orangeAccent),
              SizedBox(width: 8),
              Text("Sunny, 33°C in Abu Dhabi", style: TextStyle(fontSize: 12, color: Colors.black87)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildQuickActionsGrid() {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      childAspectRatio: 1.5,
      children: [
        _buildHoverActionCard("Calendar", Icons.calendar_month_rounded),
        _buildHoverActionCard("Grocery", Icons.shopping_basket_rounded),
        _buildHoverActionCard("Memories", Icons.photo_library_rounded),
        _buildHoverActionCard("Care", Icons.health_and_safety_rounded),
      ],
    );
  }

  Widget _buildHoverActionCard(String title, IconData icon) {
    bool isHovered = false;
    return StatefulBuilder(
      builder: (context, setCardState) {
        return MouseRegion(
          cursor: SystemMouseCursors.click,
          onEnter: (_) => setCardState(() => isHovered = true),
          onExit: (_) => setCardState(() => isHovered = false),
          child: AnimatedScale(
            scale: isHovered ? 1.05 : 1.0,
            duration: const Duration(milliseconds: 200),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              decoration: BoxDecoration(
                color: isHovered ? Colors.white : Colors.white.withOpacity(0.6),
                borderRadius: BorderRadius.circular(20),
                boxShadow: isHovered ? [BoxShadow(color: _brandBlue.withOpacity(0.1), blurRadius: 15, offset: const Offset(0, 5))] : [],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(icon, color: isHovered ? _brandBlue : _actionIconColor, size: 26),
                  const SizedBox(height: 6),
                  Text(title, style: TextStyle(fontWeight: isHovered ? FontWeight.w800 : FontWeight.bold, fontSize: 12, color: isHovered ? _brandBlue : Colors.black87)),
                ],
              ),
            ),
          ),
        );
      },
    );
  }


  // --- DATA LISTS ---
  Widget _buildFamilyStatusList() {
    return Column(
      children: [
        _buildMemberCard("Divya", "At Work • Office", Icons.business, "Focused"),
        _buildMemberCard("Yash", "Gym • Active", Icons.directions_run_rounded, "In Workout"),
        _buildMemberCard("Kanish", "School • Classroom", Icons.school, "In School"),
      ],
    );
  }

  Widget _buildMemberCard(String name, String status, IconData icon, String tag) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: Colors.white.withOpacity(0.4), borderRadius: BorderRadius.circular(24), border: Border.all(color: Colors.white.withOpacity(0.2))),
      child: Row(
        children: [
          CircleAvatar(radius: 20, backgroundColor: _brandBlue.withOpacity(0.1), child: Icon(icon, color: _brandBlue, size: 20)),
          const SizedBox(width: 12),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)), Text(status, style: const TextStyle(color: Colors.black54, fontSize: 11)), const SizedBox(height: 6), _buildStatusTag(tag)])),
          MouseRegion(cursor: SystemMouseCursors.click, child: Icon(Icons.more_vert_rounded, color: _brandBlue.withOpacity(0.4), size: 18)),
        ],
      ),
    );
  }

  Widget _buildStatusTag(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(color: Colors.white.withOpacity(0.6), borderRadius: BorderRadius.circular(10)),
      child: Text(label, style: TextStyle(fontSize: 9, fontWeight: FontWeight.w500, color: _brandBlue)),
    );
  }

  Widget _buildFamilySuggestion() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(color: Colors.white.withOpacity(0.4), borderRadius: BorderRadius.circular(25), border: Border.all(color: Colors.white.withOpacity(0.2))),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(25)),
            child: Image.network('https://images.unsplash.com/photo-1513104890138-7c749659a591?auto=format&fit=crop&q=80&w=800', height: 140, width: double.infinity, fit: BoxFit.cover),
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("✨ FAMILY SUGGESTION", style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: _brandBlue)),
                const SizedBox(height: 4),
                const Text("Gourmet Pizza Night", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
                const Text("Everyone is free at 7:00 PM tonight.", style: TextStyle(fontSize: 12, color: Colors.black54)),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(child: MouseRegion(cursor: SystemMouseCursors.click, child: ElevatedButton(onPressed: () {}, style: ElevatedButton.styleFrom(backgroundColor: _brandBlue, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)), elevation: 0), child: const Text("Order Now", style: TextStyle(color: Colors.white, fontSize: 12))))),
                    const SizedBox(width: 8),
                    Expanded(child: MouseRegion(cursor: SystemMouseCursors.click, child: OutlinedButton(onPressed: () {}, style: OutlinedButton.styleFrom(side: const BorderSide(color: Colors.black12), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))), child: const Text("Discuss", style: TextStyle(color: Colors.black87, fontSize: 12))))),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
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

Widget _buildUsraAIBtn() {
  bool isPressed = false;

  return StatefulBuilder(
    builder: (context, setState) {
      return GestureDetector(
        onTapDown: (_) => setState(() => isPressed = true),
        onTapUp: (_) => setState(() => isPressed = false),
        onTapCancel: () => setState(() => isPressed = false),

        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const AiPage(),
            ),
          );
        },

        child: AnimatedScale(
          scale: isPressed ? 0.97 : 1,
          duration: const Duration(milliseconds: 120),

          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            curve: Curves.easeOut,
            margin:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            padding:
                const EdgeInsets.symmetric(vertical: 16, horizontal: 18),

            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(22),

              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF6A5BFF),
                  Color(0xFF4FA8FF),
                ],
              ),

              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF6A5BFF)
                      .withOpacity(isPressed ? 0.18 : 0.35),
                  blurRadius: isPressed ? 10 : 22,
                  offset:
                      Offset(0, isPressed ? 4 : 10),
                ),
              ],
            ),

            child: Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.18),
                        borderRadius:
                            BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.auto_awesome_rounded,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),

                    const SizedBox(width: 12),

                    const Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Usra AI",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                          ),
                        ),

                        Text(
                          "Your smart family assistant",
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                AnimatedRotation(
                  turns: isPressed ? 0.03 : 0,
                  duration:
                      const Duration(milliseconds: 120),
                  child: const Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: Colors.white,
                    size: 16,
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