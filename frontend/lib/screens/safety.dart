// ignore_for_file: deprecated_member_use
import 'ai.dart';
import 'dart:ui';
import 'package:flutter/material.dart';

class Safety extends StatefulWidget {
  const Safety({super.key});

  @override
  State<Safety> createState() => _SafetyState();
}

class _SafetyState extends State<Safety> {
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
            _buildSafetyContent(),

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

  Widget _buildInnerBackground() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        color: Color(0xFFF8FAFF),
        gradient: RadialGradient(
          center: Alignment(-0.8, -0.6),
          radius: 1.2,
          colors: [
            Color(0xFFE8F0FF),
            Color(0xFFFDFBFF),
            Color(0xFFF3E8FF),
          ],
        ),
      ),
    );
  }

bool _sosHover = false;
bool _plusHover = false;
bool _sosActive = false;

  Widget _buildSafetyContent() {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.only(
          top: 90,
          bottom: 120,
        ),
        child: Column(
          children: [
            // SOS CARD
            MouseRegion(
              cursor: SystemMouseCursors.click,
              onEnter: (_) => setState(() => _sosHover = true),
              onExit: (_) => setState(() => _sosHover = false),
              child: GestureDetector(
                onTap: () {
                  setState(() => _sosActive = true);

                  Future.delayed(const Duration(seconds: 2), () {
                    if (mounted) {
                      setState(() => _sosActive = false);
                    }
                  });
                },
                child: _buildGlassCard(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: const Color(0xFFD32F2F),
                          boxShadow: _sosActive
                              ? [
                                  BoxShadow(
                                    color: Colors.red.withOpacity(0.6),
                                    blurRadius: 25,
                                    spreadRadius: 8,
                                  ),
                                  BoxShadow(
                                    color: Colors.red.withOpacity(0.25),
                                    blurRadius: 50,
                                    spreadRadius: 18,
                                  ),
                                ]
                              : [
                                  const BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 10,
                                  )
                                ],
                        ),
                        child: AnimatedScale(
                          duration: const Duration(milliseconds: 200),
                          scale: _sosActive ? 1.1 : 1.0,
                          child: const Icon(
                            Icons.warning_amber_rounded,
                            color: Colors.white,
                            size: 45,
                          ),
                        ),
                      ),

                      const SizedBox(height: 15),

                      const Text(
                        "SOS",
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w900,
                          color: Color(0xFFD32F2F),
                        ),
                      ),

                      const Text(
                        "Hold for 3 seconds to alert all family members and local services.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // SAFE ZONE CARD
            _buildGlassCard(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: EdgeInsets.zero,
              child: Column(
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(24),
                        ),
                        child: Image.network(
                          'https://images.unsplash.com/photo-1449824913935-59a10b8d2000?auto=format&fit=crop&w=800&q=80',
                          height: 160,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const Icon(
                        Icons.radar,
                        color: Color(0xFFE1BEE7),
                        size: 120,
                      ),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Safe Zone",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Current Location: Downtown Hub",
                          style: TextStyle(color: Colors.black54),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // SMALL CARDS
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Expanded(
                    child: _buildSmallCard(
                      "HEALTH PASS",
                      "Blood: O+\nAllergy:\nPenicillin",
                      Icons.medical_services_outlined,
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: _buildSmallCard(
                      "USRA SHIELD",
                      "All members secured.",
                      Icons.shield_outlined,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // CONTACTS CARD
            _buildGlassCard(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "EMERGENCY CONTACTS",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          color: Colors.black54,
                        ),
                      ),

                      // + BUTTON
                      MouseRegion(
                        cursor: SystemMouseCursors.click,
                        onEnter: (_) => setState(() => _plusHover = true),
                        onExit: (_) => setState(() => _plusHover = false),
                        child: AnimatedScale(
                          duration: const Duration(milliseconds: 150),
                          scale: _plusHover ? 1.2 : 1.0,
                          child: Icon(
                            Icons.add_circle,
                            color: _plusHover
                                ? Colors.blueAccent
                                : const Color(0xFF1E88E5),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  _buildContactRow(
                    "Dr. Sarah Chen",
                    "Primary Physician",
                  ),
                  const Divider(),
                  _buildContactRow(
                    "James Usra",
                    "Spouse • Emergency Admin",
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGlassCard({
    required Widget child,
    EdgeInsets? padding,
    EdgeInsets? margin,
  }) {
    return Container(
      margin: margin,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 10,
            sigmaY: 10,
          ),
          child: Container(
            padding: padding ?? const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.5),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: Colors.white.withOpacity(0.3),
              ),
            ),
            child: child,
          ),
        ),
      ),
    );
  }

  Widget _buildSmallCard(
    String title,
    String subtitle,
    IconData icon,
  ) {
    return _buildGlassCard(
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: Colors.brown[300],
            size: 28,
          ),
          const SizedBox(height: 10),
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: const TextStyle(
              fontSize: 11,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactRow(
    String name,
    String desc,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 20,
            backgroundColor: Colors.teal,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  desc,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.call_outlined,
              color: Colors.blue,
            ),
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: Icon(
                  Icons.menu_rounded,
                  color: _brandBlue,
                  size: 28,
                ),
                onPressed: () {
                  setState(() {
                    _isSidebarOpen = true;
                  });
                },
              ),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: _brandBlue.withOpacity(0.1),
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
          BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 20)
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
              _buildPremiumNavItem(Icons.auto_awesome_rounded, "AI Assistant",
                  _currentIndex == 1, 1),
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
              setState(() => _currentIndex = index);

              if (index == 1) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const AiPage()),
                );
              }
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
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
                      fontWeight: isActive ? FontWeight.w900 : FontWeight.bold,
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

  // --- REUSABLE SIDEBAR ---
  Widget _buildAestheticSidebar() {
    return Container(
      width: 290,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.94),
        borderRadius: const BorderRadius.only(
            topRight: Radius.circular(30), bottomRight: Radius.circular(30)),
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
            topRight: Radius.circular(30), bottomRight: Radius.circular(30)),
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
      padding: const EdgeInsets.fromLTRB(24, 65, 24, 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 56,
            width: 56,
            decoration: BoxDecoration(
              gradient:
                  LinearGradient(colors: [_brandBlue, const Color(0xFF5A8DFF)]),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(Icons.blur_on_rounded,
                color: Colors.white, size: 36),
          ),
          const SizedBox(height: 20),
          const Text("USRA",
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 2.8,
                  color: Color(0xFF1A1A1A))),
        ],
      ),
    );
  }

  Widget _buildSidebarList() {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      children: [
        _sidebarTile(Icons.auto_awesome_rounded, "AI Assistant", false),
        _sidebarTile(Icons.verified_user_rounded, "Safety", true),
        _sidebarTile(Icons.forum_rounded, "Family Chat", false),
        _sidebarTile(Icons.calendar_month_rounded, "Calendar", false),
        _sidebarTile(Icons.paid_rounded, "Finance", false),
        _sidebarTile(Icons.child_care_rounded, "Kids & Education", false),
        _sidebarTile(Icons.elderly_rounded, "Elder Care Hub", false),
        _sidebarTile(Icons.health_and_safety_rounded, "Health Hub", false),
        _sidebarTile(Icons.spa_rounded, "Wellbeing", false),
      ],
    );
  }

//USB
  Widget _sidebarTile(IconData icon, String title, bool isSelected) {
    bool isHovered = false;
    return StatefulBuilder(builder: (context, setTileState) {
      return MouseRegion(
          cursor: SystemMouseCursors.click,
          onEnter: (_) => setTileState(() => isHovered = true),
          onExit: (_) => setTileState(() => isHovered = false),
          child: GestureDetector(
            onTap: () {
              if (title == "AI Assistant") {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const AiPage()),
                );
              }
              if (title == "Safety") {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const Safety()),
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
                leading: Icon(icon,
                    color:
                        isHovered || isSelected ? _brandBlue : Colors.black54,
                    size: 22),
                title: Text(title,
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: isHovered || isSelected
                            ? FontWeight.w800
                            : FontWeight.w600,
                        color: isHovered || isSelected
                            ? _brandBlue
                            : Colors.black87)),
              ),
            ),
          ));
    });
  }

  Widget _buildSignOutButton() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 40),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: InkWell(
          onTap: () => setState(() => _isSidebarOpen = false),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 16),
            decoration: BoxDecoration(
                color: Colors.black, borderRadius: BorderRadius.circular(18)),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.logout_rounded, color: Colors.white, size: 18),
                SizedBox(width: 12),
                Text("Sign Out",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                        fontSize: 15)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
