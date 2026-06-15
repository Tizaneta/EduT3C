import 'package:flutter/material.dart';
import 'StationScreens.dart';

// ─────────────────────────────────────────────
//  SoftwareScreen
//  Pantalla de selección de temas para la
//  sección de Software. El diseño imita capas
//  3D apiladas con efecto glassmorphism sobre
//  un fondo oscuro tipo "circuito".
// ─────────────────────────────────────────────

class SoftwareScreenPP extends StatelessWidget {

  // ── Datos de cada tema ──────────────────────
  // Cada mapa contiene:
  //   label   → nombre del tema que se muestra en la tarjeta
  //   icon    → ícono representativo del tema
  //   color   → color de acento de esa capa
  //   levels  → cantidad de niveles que tiene el tema
  //   levelsData → datos reales para LevelScreen (vacío aquí como placeholder)
  final List<Map<String, dynamic>> topics = const [
    {
      'label': 'Sistema operativo',
      'icon': Icons.terminal,
      'color': Color(0xFF4FC3F7), // azul claro
      'levels': 5,
    },
    {
      'label': 'Base de datos',
      'icon': Icons.storage,
      'color': Color(0xFF4DB6AC), // verde azulado
      'levels': 5,
    },
    {
      'label': 'Aplicaciones',
      'icon': Icons.window,
      'color': Color(0xFF9575CD), // violeta
      'levels': 5,
    },
    {
      'label': 'Programación',
      'icon': Icons.code,
      'color': Color(0xFF4FC3F7), // azul claro
      'levels': 5,
    },
    {
      'label': 'Programación avanzada',
      'icon': Icons.data_object,
      'color': Color(0xFF78909C), // gris azulado (bloqueado visualmente)
      'levels': 5,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ── Fondo ───────────────────────────────
      // Stack permite superponer el degradado de fondo
      // con el contenido scrolleable encima.
      backgroundColor: const Color(0xFF050D1A),
      body: Stack(
        children: [

          // ── Fondo degradado oscuro ───────────
          Container(
            decoration: const BoxDecoration(
              gradient: RadialGradient(
                center: Alignment(0, -0.3),
                radius: 1.2,
                colors: [
                  Color(0xFF0A1628), // centro levemente más claro
                  Color(0xFF020810), // bordes muy oscuros
                ],
              ),
            ),
          ),

          // ── Patrón de "circuito" decorativo ─
          // CustomPaint dibuja líneas y puntos
          // que simulan trazas de PCB al fondo.
          Positioned.fill(
            child: CustomPaint(
              painter: _CircuitPainter(),
            ),
          ),

          // ── Contenido principal ──────────────
          SafeArea(
            child: Column(
              children: [

                // ── AppBar personalizado ─────────
                _buildAppBar(context),

                // ── Hint superior ───────────────
                _buildHint(),

                // ── Lista de tarjetas de temas ──
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 8,
                    ),
                    itemCount: topics.length,
                    itemBuilder: (context, index) {
                      return _TopicCard(
                        number: index + 1,
                        label: topics[index]['label'] as String,
                        icon: topics[index]['icon'] as IconData,
                        accentColor: topics[index]['color'] as Color,
                        levels: topics[index]['levels'] as int,
                        // El último tema aparece bloqueado (sin datos)
                        isLocked: index == topics.length - 1,
                      );
                    },
                  ),
                ),

                // ── Banner "Consejo" inferior ───
                _buildTipBanner(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ── AppBar personalizado ─────────────────────
  Widget _buildAppBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          // Botón de menú (hamburguesa)
          IconButton(
            icon: const Icon(Icons.menu, color: Colors.white70),
            onPressed: () {},
          ),

          // Título centrado
          const Expanded(
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
          ),

          // Botón de info
          IconButton(
            icon: const Icon(Icons.info_outline, color: Colors.white70),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  // ── Hint superior con ícono de mano ──────────
  Widget _buildHint() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
      child: Row(
        children: const [
          Icon(Icons.touch_app_outlined, color: Colors.white54, size: 20),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              'Toca cada tema para ver información detallada',
              style: TextStyle(color: Colors.white54, fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }

  // ── Banner inferior de consejo ───────────────
  Widget _buildTipBanner(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: const Color(0xFF0D1F38),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white12),
      ),
      child: Row(
        children: [
          // Ícono de bombilla
          const Icon(Icons.lightbulb_outline,
              color: Color(0xFF4FC3F7), size: 32),
          const SizedBox(width: 12),

          // Texto del consejo
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
                  'Toca cada número para aprender\nsobre su función y características.',
                  style: TextStyle(color: Colors.white70, fontSize: 12),
                ),
              ],
            ),
          ),

          // Flecha
          const Icon(Icons.chevron_right,
              color: Color(0xFF4FC3F7), size: 24),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  _TopicCard
//  Tarjeta individual con efecto de capa 3D y
//  borde brillante del color de acento.
// ─────────────────────────────────────────────
class _TopicCard extends StatelessWidget {
  final int number;
  final String label;
  final IconData icon;
  final Color accentColor;
  final int levels;
  final bool isLocked;

  const _TopicCard({
    required this.number,
    required this.label,
    required this.icon,
    required this.accentColor,
    required this.levels,
    this.isLocked = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLocked
          ? null // Sin acción si está bloqueado
          : () {
              // Navega a StationScreens pasando datos del tema
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => StationScreens(
                    title: label,
                    levels: levels,
                    // levelsData vacío: reemplazá con los datos reales
                    levelsData: {
                      for (int i = 1; i <= levels; i++) i: []
                    },
                  ),
                ),
              );
            },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 14),

        // ── Efecto de perspectiva con Transform ─
        // Transform.scale da la sensación de que
        // las tarjetas inferiores son más pequeñas
        // (efecto de profundidad sutil).
        child: Transform(
          alignment: Alignment.center,
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.001) // perspectiva leve
            ..rotateX(-0.04),       // inclinación mínima hacia el usuario
          child: _buildCardBody(),
        ),
      ),
    );
  }

  Widget _buildCardBody() {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        // Degradado glassmorphism con el color del tema
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            accentColor.withOpacity(isLocked ? 0.05 : 0.15),
            accentColor.withOpacity(isLocked ? 0.02 : 0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          // Borde brillante del color del tema
          color: accentColor.withOpacity(isLocked ? 0.2 : 0.5),
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: accentColor.withOpacity(isLocked ? 0.0 : 0.2),
            blurRadius: 12,
            spreadRadius: -2,
          ),
        ],
      ),
      child: Row(
        children: [

          // ── Badge con número ─────────────────
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isLocked ? Colors.white12 : accentColor,
              ),
              child: Center(
                child: Text(
                  '$number',
                  style: TextStyle(
                    color: isLocked ? Colors.white38 : Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(width: 14),

          // ── Nombre del tema ──────────────────
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                color: isLocked ? Colors.white38 : Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.3,
              ),
            ),
          ),

          // ── Ícono del tema ───────────────────
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Icon(
              isLocked ? Icons.lock_outline : icon,
              color: accentColor.withOpacity(isLocked ? 0.3 : 0.9),
              size: 30,
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  _CircuitPainter
//  CustomPainter que dibuja un patrón de trazas
//  de circuito impreso al fondo de la pantalla.
// ─────────────────────────────────────────────
class _CircuitPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF1A3A5C).withOpacity(0.35)
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    // Trazas horizontales y verticales que simulan un PCB
    final lines = [
      // [x1, y1, x2, y2] como fracciones del tamaño total
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

    // Puntos de soldadura (nodos del circuito)
    final dotPaint = Paint()
      ..color = const Color(0xFF4FC3F7).withOpacity(0.4)
      ..style = PaintingStyle.fill;

    final dots = [
      [0.3, 0.2], [0.3, 0.5], [0.7, 0.1], [0.7, 0.35],
      [0.4, 0.8], [0.6, 0.65], [0.15, 0.5], [0.15, 0.7],
    ];

    for (final d in dots) {
      canvas.drawCircle(
        Offset(d[0] * size.width, d[1] * size.height),
        3,
        dotPaint,
      );
    }
  }

  // Solo repinta si el widget cambia (acá nunca cambia)
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
