import 'package:flutter/material.dart';
import 'StationScreens.dart';
import '../models/level_local.dart';
import '../data/SoftwareData.dart';

class SoftwareScreen extends StatelessWidget {
  const SoftwareScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF050D1A),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: RadialGradient(
                center: Alignment(0, -0.3),
                radius: 1.2,
                colors: [
                  Color(0xFF0A1628),
                  Color(0xFF020810),
                ],
              ),
            ),
          ),

          Positioned.fill(
            child: CustomPaint(
              painter: _CircuitPainter(),
            ),
          ),

          SafeArea(
            child: Column(
              children: [
                _buildAppBar(),
                _buildHint(),

                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 8,
                    ),
                    children: [
                      _TopicCard(
                        number: 1,
                        label: 'Sistema operativo',
                        icon: Icons.terminal,
                        accentColor: const Color(0xFF4FC3F7),
                        data: fundamentosLevels,
                      ),

                      _TopicCard(
                        number: 2,
                        label: 'Base de datos',
                        icon: Icons.storage,
                        accentColor: const Color(0xFF4DB6AC),
                        data: direccionamientoLevels,
                      ),

                      _TopicCard(
                        number: 3,
                        label: 'Aplicaciones',
                        icon: Icons.window,
                        accentColor: const Color(0xFF9575CD),
                        data: infraestructuraLevels,
                      ),

                      _TopicCard(
                        number: 4,
                        label: 'Programación',
                        icon: Icons.code,
                        accentColor: const Color(0xFF4FC3F7),
                        data: administracionLevels,
                      ),

                      _TopicCard(
                        number: 5,
                        label: 'Programación avanzada',
                        icon: Icons.data_object,
                        accentColor: const Color(0xFF78909C),
                        data: seguridadLevels,
                        isLocked: true,
                      ),
                    ],
                  ),
                ),

                _buildTipBanner(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppBar() {
    return const Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 12,
      ),
      child: Text(
        'Software',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  Widget _buildHint() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 4,
      ),
      child: Row(
        children: const [
          Icon(
            Icons.touch_app_outlined,
            color: Colors.white54,
            size: 20,
          ),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              'Toca cada tema para ver información detallada',
              style: TextStyle(
                color: Colors.white54,
                fontSize: 13,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTipBanner() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 14,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFF0D1F38),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.white12,
        ),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.lightbulb_outline,
            color: Color(0xFF4FC3F7),
            size: 32,
          ),
          const SizedBox(width: 12),

          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Consejo',
                  style: TextStyle(
                    color: Color(0xFF4FC3F7),
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  'Toca cada número para aprender\n'
                  'sobre su función y características.',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TopicCard extends StatelessWidget {
  final int number;
  final String label;
  final IconData icon;
  final Color accentColor;

  // ESTE es el punto importante:
  // cada tarjeta recibe directamente sus niveles.
  final Map<int, LocalLevel> data;

  final bool isLocked;

  const _TopicCard({
    required this.number,
    required this.label,
    required this.icon,
    required this.accentColor,
    required this.data,
    this.isLocked = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLocked
          ? null
          : () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => StationScreens(
                    title: label,

                    // Cantidad de niveles
                    levels: data.length,

                    // Datos completos de los niveles
                    levelsData: data,
                  ),
                ),
              );
            },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 14),
        child: Transform(
          alignment: Alignment.center,
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.001)
            ..rotateX(-0.04),
          child: _buildCardBody(),
        ),
      ),
    );
  }

  Widget _buildCardBody() {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            accentColor.withOpacity(
              isLocked ? 0.05 : 0.15,
            ),
            accentColor.withOpacity(
              isLocked ? 0.02 : 0.05,
            ),
          ],
        ),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: accentColor.withOpacity(
            isLocked ? 0.2 : 0.5,
          ),
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: accentColor.withOpacity(
              isLocked ? 0.0 : 0.2,
            ),
            blurRadius: 12,
            spreadRadius: -2,
          ),
        ],
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isLocked
                    ? Colors.white12
                    : accentColor,
              ),
              child: Center(
                child: Text(
                  '$number',
                  style: TextStyle(
                    color: isLocked
                        ? Colors.white38
                        : Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(width: 14),

          Expanded(
            child: Text(
              label,
              style: TextStyle(
                color: isLocked
                    ? Colors.white38
                    : Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.3,
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Icon(
              isLocked
                  ? Icons.lock_outline
                  : icon,
              color: accentColor.withOpacity(
                isLocked ? 0.3 : 0.9,
              ),
              size: 30,
            ),
          ),
        ],
      ),
    );
  }
}

class _CircuitPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF1A3A5C).withOpacity(0.35)
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    final lines = [
      [0.0, 0.2, 0.3, 0.2],
      [0.3, 0.2, 0.3, 0.5],
      [0.7, 0.1, 1.0, 0.1],
      [0.7, 0.1, 0.7, 0.35],
      [0.1, 0.8, 0.4, 0.8],
      [0.4, 0.8, 0.4, 1.0],
      [0.6, 0.65, 1.0, 0.65],
      [0.6, 0.65, 0.6, 0.9],
      [0.0, 0.5, 0.15, 0.5],
      [0.15, 0.5, 0.15, 0.7],
      [0.85, 0.4, 1.0, 0.4],
    ];

    for (final l in lines) {
      canvas.drawLine(
        Offset(l[0] * size.width, l[1] * size.height),
        Offset(l[2] * size.width, l[3] * size.height),
        paint,
      );
    }

    final dotPaint = Paint()
      ..color = const Color(0xFF4FC3F7).withOpacity(0.4)
      ..style = PaintingStyle.fill;

    final dots = [
      [0.3, 0.2],
      [0.3, 0.5],
      [0.7, 0.1],
      [0.7, 0.35],
      [0.4, 0.8],
      [0.6, 0.65],
      [0.15, 0.5],
      [0.15, 0.7],
    ];

    for (final d in dots) {
      canvas.drawCircle(
        Offset(
          d[0] * size.width,
          d[1] * size.height,
        ),
        3,
        dotPaint,
      );
    }
  }

  @override
  bool shouldRepaint(
    covariant CustomPainter oldDelegate,
  ) {
    return false;
  }
}