// ignore_for_file: prefer_final_fields, deprecated_member_use

import 'dart:ui';
import 'package:flutter/material.dart';
import 'ai.dart';
import 'safety.dart';
import 'login.dart';
import 'chat.dart';
import 'calender.dart';
import 'elder.dart';
import 'home.dart';
import 'health.dart';
import 'kids.dart';

class Finance extends StatefulWidget {
  const Finance({super.key});

  @override
  State<Finance> createState() => _FinanceState();
}

class _FinanceState extends State<Finance> {
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
            _buildFinanceContent(),

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

  Widget _buildFinanceContent() {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.only(
          top: 70,
          bottom: 120,
          left: 20,
          right: 20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildBalanceCard(),
            const SizedBox(height: 25),

            _buildGoalTracker(),
            const SizedBox(height: 25),

            _buildAIAdvisor(),
            const SizedBox(height: 25),

            const Text(
              "Kids Allowance",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),

            _buildKidRow(
              "Divya",
              "85.50 AED",
              "Level 12 • Budget Maven",
              0.7,
              Colors.blue,
            ),
            _buildKidRow(
              "Yash",
              "42.50 AED",
              "Level 8 • Savvy Saver",
              0.4,
              Colors.blueAccent,
            ),

            const SizedBox(height: 25),

            _buildRecentTransactions(),
          ],
        ),
      ),
    );
  }

  // --- UI Sections ---

  Widget _buildBalanceCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFFE8F1FF).withOpacity(0.85),
        borderRadius: BorderRadius.circular(25),
        border: Border.all(
          color: Colors.white.withOpacity(0.3),
        ),
      ),
      child: Column(
        children: [
          const Text("SHARED BUDGET BALANCE", style: TextStyle(color: Colors.grey, fontSize: 12, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          const Text("\$4,280.00", style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: Color(0xFF1A46BB))),
          const Text("▲ +12.4% from last month", style: TextStyle(color: Colors.green, fontSize: 13)),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(child: _buildActionBtn(Icons.add, "Add Funds", isPrimary: false)),
              const SizedBox(width: 15),
              Expanded(child: _buildActionBtn(Icons.article, "View Report", isPrimary: true)),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildGoalTracker() {
    return Column(
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Goal Tracker", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Text("See All", style: TextStyle(color: Colors.blueAccent)),
          ],
        ),
        const SizedBox(height: 15),
        _buildGoalItem("Summer Vacation", "\$3,200 / \$4,000", 0.75, Icons.beach_access),
        const SizedBox(height: 12),
        _buildGoalItem("EV Fund", "\$20,000 / \$50,000", 0.40, Icons.directions_car),
      ],
    );
  }

  Widget _buildAIAdvisor() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFE8F1FF).withOpacity(0.55),
        borderRadius: BorderRadius.circular(25),
        border: Border.all(
          color: Colors.white.withOpacity(0.3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.auto_awesome, color: Color(0xFF2D62ED), size: 18),
              SizedBox(width: 8),
              Text("AI ADVISOR", style: TextStyle(color: Color(0xFF2D62ED), fontWeight: FontWeight.bold, fontSize: 12)),
            ],
          ),
          const SizedBox(height: 10),
          const Text("Optimization Found", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 8),
          const Text(
            "Buying your grocery from 'Noon Minutes' could save the family \$45/month based on Maya's recent spending patterns.",
            style: TextStyle(color: Colors.black54, fontSize: 13),
          ),
          const SizedBox(height: 15),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.blueAccent,
                elevation: 0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text("Apply Optimization"),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildRecentTransactions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Recent Transactions", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 15),
        _buildTransactionItem("Whole Foods Market", "-\$142.10", "Family Groceries • 2 hours ago", Icons.shopping_cart, Colors.purple[100]!),
        _buildTransactionItem("Tesla Supercharger", "-\$18.50", "Shared EV • Today, 10:15 AM", Icons.electric_bolt, Colors.blue[100]!),
      ],
    );
  }

  // --- Helper Widgets ---

Widget _buildActionBtn(
  IconData icon,
  String label, {
  required bool isPrimary,
}) {
  return GestureDetector(
    onTap: () {
      if (label == "View Report") {
        _showFinanceReportPopup();
      }
    },
    child: Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: isPrimary
            ? const Color(0xFF1A46BB)
            : const Color(0xFFF0F4FF),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 18,
            color: isPrimary ? Colors.white : Colors.blueAccent,
          ),
          const SizedBox(width: 8),
          Text(
            label,
            style: TextStyle(
              color: isPrimary ? Colors.white : Colors.blueAccent,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    ),
  );
}
void _showFinanceReportPopup() {
  showDialog(
    context: context,
    barrierColor: Colors.black.withOpacity(0.4),
    builder: (context) {
      return Center(
        child: Material(
          color: Colors.transparent,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(25),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
              child: Container(
                width: 305,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.25),
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.3),
                  ),
                ),
                child: Stack(
                  children: [
                    // CLOSE BUTTON
                    Positioned(
                      right: 0,
                      top: 0,
                      child: GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.55),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.close,
                            size: 18,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),

                    const Padding(
                      padding: EdgeInsets.only(top: 30),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Financial Report",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 15),

                          Text("💰 Total Spend: \$1,240"),
                          SizedBox(height: 6),
                          Text("📈 Savings: \$320"),
                          SizedBox(height: 6),
                          Text("🛒 Top Category: Groceries"),
                          SizedBox(height: 6),
                          Text("📊 Monthly Trend: +12.4%"),
                          SizedBox(height: 15),

                          Text(
                            "AI Insight: You can save 12% by reducing dining expenses.",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.black54,
                            ),
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

  Widget _buildGoalItem(String title, String amount, double progress, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: Row(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              CircularProgressIndicator(value: progress, backgroundColor: Colors.grey[200], strokeWidth: 5),
              Text("${(progress * 100).toInt()}%", style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
              Text(amount, style: const TextStyle(color: Colors.grey, fontSize: 12)),
              Icon(icon, size: 14, color: Colors.grey),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildKidRow(String name, String balance, String sub, double progress, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: Colors.white.withOpacity(0.7), borderRadius: BorderRadius.circular(20)),
      child: Row(
        children: [
          const CircleAvatar(radius: 25, backgroundColor: Colors.grey),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
                    Text(balance, style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF1A46BB))),
                  ],
                ),
                Text(sub, style: const TextStyle(fontSize: 10, color: Colors.grey)),
                const SizedBox(height: 5),
                LinearProgressIndicator(value: progress, color: color, backgroundColor: Colors.grey[200]),
              ],
            ),
          ),
          const Icon(Icons.send, color: Colors.blueAccent, size: 18),
        ],
      ),
    );
  }

  Widget _buildTransactionItem(String title, String price, String sub, IconData icon, Color bg) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: const Color(0xFFE8F1FF).withOpacity(0.85),
        borderRadius: BorderRadius.circular(25),
        border: Border.all(
          color: Colors.white.withOpacity(0.3),
        ),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        leading: CircleAvatar(backgroundColor: bg, child: Icon(icon, color: Colors.white)),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
        subtitle: Text(sub, style: const TextStyle(fontSize: 11)),
        trailing: Text(price, style: const TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold)),
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
      _sidebarTileV2(Icons.forum_rounded, "Family Chat", false, const Chat()),


      _sidebarTileV2(Icons.health_and_safety_rounded, "Health Hub", false, const Health()),
      _sidebarTileV2(Icons.paid_rounded, "Finance", true, const Finance()),
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