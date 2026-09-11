import 'NetScreen.dart';
import 'SoftwareScreen.dart';
import 'package:flutter/material.dart';
import 'SocialProfileScreen.dart';
import 'HardwareIntroScreen.dart';
import 'SettingsScreen.dart';
import '../models/user.dart';

class Home extends StatefulWidget {
  final User user;

  const Home({
    super.key,
    required this.user,
  });

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final PageController _controller = PageController();

  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF050B18),

      appBar: currentPage == 3
          ? null
          : _HomeAppBar(
              user: widget.user,
            ),

      body: PageView(
        controller: _controller,

        onPageChanged: (index) {
          setState(() {
            currentPage = index;
          });
        },

        children: [
          HardwareIntroScreen(),
          SoftwareScreen(),
          NetScreen(),
          SocialProfileScreen(
            user: widget.user,
          ),
          SettingsScreen(),
        ],
      ),
    );
  }
}

class _HomeAppBar extends StatelessWidget
    implements PreferredSizeWidget {

  final User user;

  const _HomeAppBar({
    required this.user,
  });

  @override
  Size get preferredSize => const Size.fromHeight(78);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF050B18),
            Color(0xFF071A30),
            Color(0xFF06111F),
          ],
        ),
        border: const Border(
          bottom: BorderSide(
            color: Color(0xFF087EA4),
            width: 1,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF00BFFF).withValues(alpha: 0.18),
            blurRadius: 12,
            offset: const Offset(0, 3),
          ),
        ],
      ),

      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 10,
          ),

          child: Row(
            children: [


              const SizedBox(width: 4),

              // ─────────────────────
              // AVATAR
              // ─────────────────────

              Container(
                width: 42,
                height: 42,

                decoration: BoxDecoration(
                  shape: BoxShape.circle,

                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFF087EA4),
                      Color(0xFF00C7E8),
                    ],
                  ),

                  border: Border.all(
                    color: const Color(0xFF00C7E8),
                    width: 2,
                  ),

                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF00C7E8)
                          .withValues(alpha: 0.35),
                      blurRadius: 8,
                    ),
                  ],
                ),

                child: Center(
                  child: Text(
                    user.username.isNotEmpty
                        ? user.username[0].toUpperCase()
                        : '?',

                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),

              const SizedBox(width: 10),

              // ─────────────────────
              // NOMBRE + NIVEL
              // ─────────────────────

              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    Text(
                      user.username,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,

                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 2),

                    Text(
                      'NIVEL ${user.level}',
                      style: const TextStyle(
                        color: Color(0xFF00C7E8),
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ],
                ),
              ),

              // ─────────────────────
              // XP
              // ─────────────────────

              _ResourceDisplay(
                icon: const Icon(Icons.bolt_rounded,
                color: Color(0xFF00C7E8),
                ),
                value: '${user.xp}',
                label: 'XP',
              ),

              const SizedBox(width: 10),

              // ─────────────────────
              // BITS
              // ─────────────────────

              _ResourceDisplay(
                icon: Image.asset(
                  'assets/images/bits.png',
                  width: 40,
                  height: 40,
                  ),
                value: '${user.bits}',
                label: 'BITS',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ResourceDisplay extends StatelessWidget {
  final Widget icon;
  final String value;
  final String label;

  const _ResourceDisplay({
    required this.icon,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 5,
      ),

      decoration: BoxDecoration(
        color: const Color(0xFF0B1C2E),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: const Color(0xFF16445C),
        ),
      ),

      child: Row(
        children: [
          SizedBox(
            width: 20,
            height: 20,
            child: icon,
          ),

          const SizedBox(width: 4),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),

              Text(
                label,
                style: const TextStyle(
                  color: Color(0xFF5C7185),
                  fontSize: 8,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}