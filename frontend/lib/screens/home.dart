// ignore_for_file: deprecated_member_use, unnecessary_import
import 'ai.dart';
import 'dart:ui';
import 'safety.dart';
import 'chat.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isSidebarOpen = false;
  int _currentIndex = 0; // 0 for Home, 1 for AI
  
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
            // --- THE INNER PAGE BACKGROUND (SUBTLE GRADIENT) ---
            _buildInnerPageBackground(),
            
            // --- SCROLLABLE CONTENT ---
            _buildMainScrollableContent(),

            // --- PERSISTENT UI OVERLAYS ---
            _buildHeader(),
            Positioned(bottom: 0, left: 0, right: 0, child: _buildBottomNav()),
            
            // SIDEBAR SYSTEM
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
        color: Color(0xFFF8FAFF), // Base soft white
        gradient: RadialGradient(
          center: Alignment(-0.8, -0.6),
          radius: 1.2,
          colors: [
            Color(0xFFE8F0FF), // Soft blue glow top left
            Color(0xFFFDFBFF), // Transition
            Color(0xFFF3E8FF), // Soft purple glow bottom right
          ],
          stops: [0.0, 0.5, 1.0],
        ),
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
            const SizedBox(height: 70), // Space for fixed header
            _buildGreetingSection(),
            const SizedBox(height: 20),
            _buildFamilyStatusList(),
            const SizedBox(height: 25),
            _buildFamilySuggestion(),
            const SizedBox(height: 25),
            _buildQuickActionsGrid(),
            const SizedBox(height: 120), // Space for bottom nav
          ],
        ),
      ),
    );
  }

  // --- HEADER (PERSISTENT) ---
Widget _buildHeader() {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Container(
        // Solid white backdrop with a hint of transparency for a modern look
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
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: SafeArea(
          bottom: false,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // 1. Menu Button
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: IconButton(
                  icon: Icon(Icons.menu_rounded, color: _brandBlue, size: 28),
                  onPressed: () => setState(() => _isSidebarOpen = true),
                ),
              ),

              // 2. Logo & App Name (Matching your uploaded branding)
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(color: _brandBlue.withOpacity(0.1)),
                    ),
                    child: Icon(Icons.share_outlined, color: _brandBlue, size: 20),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    "Usra أسرة",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: _brandBlue,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),

              // 3. Balancing Spacer
              const SizedBox(width: 48),
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

  Widget _buildBottomNav() {
    return Container(
      height: 75,
      margin: const EdgeInsets.only(left: 20, right: 20, bottom: 25),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.85),
        borderRadius: BorderRadius.circular(30),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 20)],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildPremiumNavItem(Icons.home_filled, "Home", _currentIndex == 0, 0),
              _buildPremiumNavItem(Icons.auto_awesome_rounded, "AI Assistant", _currentIndex == 1, 1),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPremiumNavItem(IconData icon, String label, bool isActive, int index) {
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
        borderRadius: const BorderRadius.only(topRight: Radius.circular(30), bottomRight: Radius.circular(30)),
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(topRight: Radius.circular(30), bottomRight: Radius.circular(30)),
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
            height: 56, width: 56,
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [_brandBlue, const Color(0xFF5A8DFF)]),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(Icons.blur_on_rounded, color: Colors.white, size: 36),
          ),
          const SizedBox(height: 20),
          const Text("USRA", style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900, letterSpacing: 2.8, color: Color(0xFF1A1A1A))),
        ],
      ),
    );
  }

  Widget _buildSidebarList() {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      children: [
        _sidebarTile(Icons.auto_awesome_rounded, "AI Assistant", false),
        _sidebarTile(Icons.verified_user_rounded, "Safety", false),
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
            if (title == "Family Chat") {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const Chat()),
              );
            }
          },
          child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: const EdgeInsets.only(bottom: 6),
          decoration: BoxDecoration(
            color: isHovered ? Colors.white : (isSelected ? _brandBlue.withOpacity(0.06) : Colors.transparent),
            borderRadius: BorderRadius.circular(14),
          ),
          child: ListTile(
            dense: true,
            leading: Icon(icon, color: isHovered || isSelected ? _brandBlue : Colors.black54, size: 22),
            title: Text(title, style: TextStyle(fontSize: 14, fontWeight: isHovered || isSelected ? FontWeight.w800 : FontWeight.w600, color: isHovered || isSelected ? _brandBlue : Colors.black87)),
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
            decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(18)),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.logout_rounded, color: Colors.white, size: 18),
                SizedBox(width: 12),
                Text("Sign Out", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 15)),
              ],
            ),
          ),
        ),
      ),
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