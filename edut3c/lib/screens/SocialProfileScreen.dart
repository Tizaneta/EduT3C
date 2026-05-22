import 'package:flutter/material.dart';
import 'home.dart';


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Social Profile',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF0D0F14),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF4A90E2),
          surface: Color(0xFF161B24),
        ),
      ),
      home: const SocialProfileScreen(),
    );
  }
}

class SocialProfileScreen extends StatelessWidget {
  const SocialProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0F14),
      body: SafeArea(
        child: Column(
          children: [
            // ── Top App Bar ──────────────────────────────────────────────
            _TopBar(),

            // ── Tab Bar ──────────────────────────────────────────────────
            _TabBar(),

            // ── Scrollable body ──────────────────────────────────────────
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    _ProfileCard(),
                    const SizedBox(height: 24),
                    _StatsRow(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

      // ── Bottom Navigation Bar ────────────────────────────────────────
      bottomNavigationBar: _BottomNavBar(),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// TOP BAR
// ─────────────────────────────────────────────────────────────────────────────
class _TopBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          const Text(
            'Social',
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.3,
            ),
          ),
          const Spacer(),
          // Message icon
          _IconBtn(icon: Icons.chat_bubble_outline_rounded),
          const SizedBox(width: 8),
          // Add person icon
          _IconBtn(icon: Icons.person_add_outlined),
        ],
      ),
    );
  }
}

class _IconBtn extends StatelessWidget {
  final IconData icon;
  const _IconBtn({required this.icon});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: 38,
        height: 38,
        decoration: BoxDecoration(
          color: const Color(0xFF1C2230),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: Colors.white70, size: 20),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// TAB BAR
// ─────────────────────────────────────────────────────────────────────────────
class _TabBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          _Tab(label: 'Perfil', isSelected: true),
          const SizedBox(width: 24),
          _Tab(label: 'Mis Amigos', isSelected: false),
        ],
      ),
    );
  }
}

class _Tab extends StatelessWidget {
  final String label;
  final bool isSelected;
  const _Tab({required this.label, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    const blue = Color(0xFF4A90E2);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Text(
            label,
            style: TextStyle(
              color: isSelected ? blue : Colors.white38,
              fontSize: 15,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
            ),
          ),
        ),
        Container(
          height: 2.5,
          width: label.length * 8.5,
          decoration: BoxDecoration(
            color: isSelected ? blue : Colors.transparent,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// PROFILE CARD
// ─────────────────────────────────────────────────────────────────────────────
class _ProfileCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF161B24),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Avatar + name row
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Avatar with blue ring
              Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: const Color(0xFF4A90E2), width: 2.5),
                ),
                child: ClipOval(
                  child: Container(
                    color: const Color(0xFF1C2230),
                    child: const Icon(
                      Icons.computer,
                      color: Color(0xFF4A90E2),
                      size: 36,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 14),

              // Name + handle + level
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'TechMaster',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 2),
                    const Text(
                      '@techmaster',
                      style: TextStyle(color: Colors.white38, fontSize: 13),
                    ),
                    const SizedBox(height: 8),
                    // Level badge
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xFF4A90E2)),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Icon(Icons.shield_outlined,
                              color: Color(0xFF4A90E2), size: 13),
                          SizedBox(width: 4),
                          Text(
                            'Nivel 12',
                            style: TextStyle(
                              color: Color(0xFF4A90E2),
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Edit icon
              const Icon(Icons.edit_outlined, color: Colors.white38, size: 20),
            ],
          ),

          const SizedBox(height: 12),

          // Bio
          const Text(
            'Apasionado por el hardware y la tecnología. Armando PCs desde 2018.',
            style: TextStyle(
              color: Colors.white60,
              fontSize: 13,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// STATS ROW (Publicaciones / Seguidores / Siguiendo)
// ─────────────────────────────────────────────────────────────────────────────
class _StatsRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: const Color(0xFF161B24),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          _StatItem(value: '128', label: 'Publicaciones'),
          _StatDivider(),
          _StatItem(value: '347', label: 'Seguidores'),
          _StatDivider(),
          _StatItem(value: '196', label: 'Siguiendo'),
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String value;
  final String label;
  const _StatItem({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Text(
            "anal sex",
            style: const TextStyle(
              color: Color(0xFF4A90E2),
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(color: Colors.white38, fontSize: 12),
          ),
        ],
      ),
    );
  }
}

class _StatDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(width: 1, height: 36, color: const Color(0xFF2A3040));
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// BOTTOM NAVIGATION BAR
// ─────────────────────────────────────────────────────────────────────────────
class _BottomNavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFF161B24),
        border: Border(top: BorderSide(color: Color(0xFF2A3040), width: 0.5)),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _NavItem(icon: Icons.map_outlined, label: 'Mapa', isActive: false),
              _NavItem(
                  icon: Icons.people_outline,
                  label: 'Social',
                  isActive: true),
              _NavItem(
                  icon: Icons.explore_outlined,
                  label: 'Explorar',
                  isActive: false),
              _NavItemBadge(
                  icon: Icons.notifications_outlined,
                  label: 'Notificaciones',
                  badge: 3),
              _NavItem(
                  icon: Icons.settings_outlined,
                  label: 'Ajustes',
                  isActive: false),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  const _NavItem(
      {required this.icon, required this.label, required this.isActive});

  @override
  Widget build(BuildContext context) {
    const blue = Color(0xFF4A90E2);
    final color = isActive ? blue : Colors.white38;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: color, size: 24),
        const SizedBox(height: 3),
        Text(label,
            style: TextStyle(
                color: color, fontSize: 10, fontWeight: FontWeight.w500)),
      ],
    );
  }
}

class _NavItemBadge extends StatelessWidget {
  final IconData icon;
  final String label;
  final int badge;
  const _NavItemBadge(
      {required this.icon, required this.label, required this.badge});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            Icon(icon, color: Colors.white38, size: 24),
            Positioned(
              right: -6,
              top: -4,
              child: Container(
                padding: const EdgeInsets.all(3),
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 226, 74, 74),
                  shape: BoxShape.circle,
                ),
                child: Text(
                  '$badge',
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 9,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 3),
        Text(label,
            style: const TextStyle(color: Color.fromARGB(96, 231, 225, 225), fontSize: 10)),
      ],
    );
  }
}
