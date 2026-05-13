// ignore_for_file: unused_element_parameter, unused_field, deprecated_member_use
import 'ai.dart';
import 'dart:ui';
import 'home.dart';
import 'chat.dart';
import 'calender.dart';
import 'elder.dart';
import 'finance.dart';
import 'health.dart';
import 'kids.dart';
import 'login.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Safety extends StatefulWidget {
  const Safety({super.key});

  @override
  State<Safety> createState() => _SafetyState();
}

class _SafetyState extends State<Safety> {
  bool _isSidebarOpen = false;
  // ignore: prefer_final_fields
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

            _buildSafetyContent(),

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
bool _sosHover = false;
bool _plusHover = false;
bool _sosActive = false;

  Widget _buildSafetyContent() {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.only(
          top: 60,
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
                                    blurRadius: 45,
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

            _buildGlassCard(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "FAMILY LIVE LOCATION",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      color: Colors.black54,
                    ),
                  ),

                  const SizedBox(height: 12),

                  ClipRRect(
                    borderRadius: BorderRadius.circular(18),
                    child: SizedBox(
                      height: 200,
                      child: _buildFakeMap(),
                    ),
                  ),

                  const SizedBox(height: 10),

                  const Text(
                    "Live tracking of all family members in real time",
                    style: TextStyle(fontSize: 12, color: Colors.black54),
                  ),
                ],
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
                          'https://res.cloudinary.com/dw4mv7p40/image/upload/v1778619985/masdar-city-istock2_qhubsm.jpg',
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
                          "Current Location: Masdar City",
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
                      "Blood: O+\nAllergy:Penicillin",
                      Icons.medical_services_outlined,
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: _buildSmallCard(
                      "USRA SHIELD",
                      "All members secured. \nNo alerts.",
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
                    "James Howard",
                    "Spouse • Emergency Admin",
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            _buildGlassCard(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "IMPORTANT UAE SAFETY NUMBERS",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      color: Colors.black54,
                    ),
                  ),
                  const SizedBox(height: 12),

                  _buildInfoRow("Police", "999"),
                  _buildInfoRow("Ambulance", "998"),
                  _buildInfoRow("Fire Dept", "997"),
                  _buildInfoRow("Coast Guard", "996"),
                  _buildInfoRow("Electricity Emergency", "991"),
                  _buildInfoRow("Water Emergency", "922"),
                ],
              ),
            ),

            const SizedBox(height: 20),

            _buildGlassCard(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "SAFETY RESOURCES (UAE)",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      color: Colors.black54,
                    ),
                  ),
                  const SizedBox(height: 12),

                  _buildLinkRow("UAE Police Portal", "https://www.adpolice.gov.ae"),
                  _buildLinkRow("Dubai Police", "https://www.dubaipolice.gov.ae"),
                  _buildLinkRow("MOI UAE", "https://www.moi.gov.ae"),
                  _buildLinkRow("NCEMA Safety", "https://www.ncema.gov.ae"),
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }

Widget _buildFakeMap() {
  return ClipRRect(
    borderRadius: BorderRadius.circular(18),
    child: SizedBox(
      height: 200,
      width: double.infinity,
      child: Stack(
        children: [
          // MAP IMAGE
          Image.network(
            'https://res.cloudinary.com/dw4mv7p40/image/upload/v1778619939/6b802523-cc8f-4c9c-b79d-5df28a9078ef_qm26mx.jpg',
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),

          // DARK OVERLAY
          Container(color: Colors.black.withOpacity(0.2)),

          // YOU
          const Positioned(
            left: 140,
            top: 80,
            child: _LiveUserMarker(label: "You", color: Colors.blue),
          ),

          // DAD
          const Positioned(
            right: 40,
            top: 40,
            child: _LiveUserMarker(label: "Dad", color: Colors.orange),
          ),

          // MOM
          const Positioned(
            left: 40,
            bottom: 40,
            child: _LiveUserMarker(label: "Mom", color: Colors.pink),
          ),
        ],
      ),
    ),
  );
}

Widget _buildInfoRow(String title, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 6),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
            )),
        Text(value,
            style: const TextStyle(
              fontSize: 13,
              color: Colors.blue,
              fontWeight: FontWeight.bold,
            )),
      ],
    ),
  );
}
Future<void> _openUrl(String url) async {
  final uri = Uri.parse(url);

  if (!await launchUrl(
    uri,
    webOnlyWindowName: '_blank',
  )) {
    throw "Could not open $url";
  }
}

Widget _buildLinkRow(String title, String url) {
  return InkWell(
    onTap: () => _openUrl(url),
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          const Icon(Icons.link, size: 16, color: Colors.blue),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Colors.blue,
              ),
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
    padding: const EdgeInsets.all(14),
    child: SizedBox(
      height: 95,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            icon,
            color: Colors.brown[300],
            size: 26,
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 11,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ],
      ),
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
          },
        ),
      ),
    ],
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

      _sidebarTileV2(Icons.verified_user_rounded, "Safety", true, const Safety()),
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






class _LiveUserMarker extends StatelessWidget {
  final String label;
  final Color color;

  const _LiveUserMarker({
    super.key,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 14,
          height: 14,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 2),
          ),
        ),
        const SizedBox(height: 4),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.6),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 10,
            ),
          ),
        ),
      ],
    );
  }
}