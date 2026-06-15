import 'package:flutter/material.dart';

// ─────────────────────────────────────────────
// DATOS DE EJEMPLO (simulan un usuario real)
// ─────────────────────────────────────────────
final Map<String, dynamic> _mockUser = {
  'username': '@techmaster',
  'displayName': 'TechMaster',
  'initials': 'TM',
  'bio': 'Apasionado por el hardware y la tecnología. Armando PCs desde 2018.',
  'joinDate': 'Miembro desde Enero 2023',
  'level': 12,
  'xpCurrent': 6200,
  'xpNext': 10000,
  'bits': 1340,
  'coursesCompleted': 8,
  'studyHours': 47,
};

final List<Map<String, dynamic>> _mockAchievements = [
  {'icon': Icons.construction, 'label': 'Constructor\nNovato'},
  {'icon': Icons.memory, 'label': 'Experto en\nHardware'},
  {'icon': Icons.wifi, 'label': 'Comunidad\nActiva'},
  {'icon': Icons.computer, 'label': 'Maestro PC'},
  {'icon': Icons.terminal, 'label': 'Coder'},
  {'icon': Icons.shield, 'label': 'Seguridad'},
  {'icon': Icons.speed, 'label': 'Veloz'},
  {'icon': Icons.star, 'label': 'Top 100'},
];

final List<Map<String, dynamic>> _mockInventory = [
  {'icon': Icons.calculate, 'label': 'Calculador', 'unlocked': true},
  {'icon': Icons.pin_drop, 'label': 'Pin Año', 'unlocked': true},
  {'icon': Icons.android, 'label': 'MaduAnim', 'unlocked': true},
  {'icon': Icons.bookmark, 'label': 'Bloqueado', 'unlocked': false},
  {'icon': Icons.wifi, 'label': 'NetPro', 'unlocked': false},
  {'icon': Icons.code, 'label': 'Dev', 'unlocked': false},
];

// ─────────────────────────────────────────────
// COLORES DEL TEMA OSCURO
// ─────────────────────────────────────────────
const Color _bgDark = Color(0xFF0A0E1A);
const Color _bgCard = Color(0xFF111827);
const Color _bgCardBorder = Color(0xFF1E2A3A);
const Color _accentBlue = Color(0xFF3B82F6);
const Color _accentGold = Color(0xFFFBBF24);
const Color _textPrimary = Color(0xFFE2E8F0);
const Color _textSecondary = Color(0xFF64748B);
const Color _xpBar = Color(0xFF3B82F6);
const Color _xpBarBg = Color(0xFF1E2A3A);

// ─────────────────────────────────────────────
// PANTALLA PRINCIPAL DE PERFIL SOCIAL
// ─────────────────────────────────────────────
class SocialProfileScreen extends StatelessWidget {
  const SocialProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bgDark,
      // Barra superior con título "Social" y tabs Perfil / Mis Amigos
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Sección: Avatar + Info básica del usuario ──
            _UserHeaderCard(),
            const SizedBox(height: 14),

            // ── Sección: Clasificación / Nivel y XP ──
            _ClassificationCard(),
            const SizedBox(height: 14),

            // ── Sección: Estadísticas (Bits, cursos, horas) ──
            _StatsRow(),
            const SizedBox(height: 14),

            // ── Sección: Logros en cuadrícula ──
            _SectionHeader(title: 'Logros', actionLabel: 'Ver todos'),
            const SizedBox(height: 10),
            _AchievementsGrid(),
            const SizedBox(height: 14),

            // ── Sección: Inventario ──
            _SectionHeader(title: 'Inventario', actionLabel: 'Ver todos'),
            const SizedBox(height: 10),
            _InventoryRow(),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  // AppBar con tabs Perfil / Mis Amigos
  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: _bgDark,
      elevation: 0,
      title: const Text(
        'Social',
        style: TextStyle(
          color: _textPrimary,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.crop_square_rounded, color: _textSecondary),
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(Icons.crop_square_rounded, color: _textSecondary),
          onPressed: () {},
        ),
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(40),
        child: _ProfileTabBar(),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// TAB BAR: Perfil / Mis Amigos
// ─────────────────────────────────────────────
class _ProfileTabBar extends StatefulWidget {
  @override
  State<_ProfileTabBar> createState() => _ProfileTabBarState();
}

class _ProfileTabBarState extends State<_ProfileTabBar> {
  int _selected = 0;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _tab('Perfil', 0),
        _tab('Mis Amigos', 1),
      ],
    );
  }

  Widget _tab(String label, int index) {
    final bool active = _selected == index;
    return GestureDetector(
      onTap: () => setState(() => _selected = index),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: active ? _accentBlue : Colors.transparent,
              width: 2,
            ),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: active ? _accentBlue : _textSecondary,
            fontWeight: active ? FontWeight.bold : FontWeight.normal,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// TARJETA: Avatar + nombre + bio + fecha
// ─────────────────────────────────────────────
class _UserHeaderCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _Card(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Avatar circular con iniciales
          _UserAvatar(
            initials: _mockUser['initials'],
            size: 56,
          ),
          const SizedBox(width: 14),
          // Nombre, username, nivel, bio
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      _mockUser['displayName'],
                      style: const TextStyle(
                        color: _textPrimary,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const Spacer(),
                    // Ícono de editar perfil
                    Icon(Icons.edit_outlined, color: _textSecondary, size: 18),
                  ],
                ),
                Text(
                  _mockUser['username'],
                  style: const TextStyle(color: _textSecondary, fontSize: 13),
                ),
                const SizedBox(height: 6),
                // Chip de nivel
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                  decoration: BoxDecoration(
                    color: _bgCardBorder,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    'Nivel ${_mockUser['level']}',
                    style: const TextStyle(
                      color: _accentBlue,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                // Bio
                Text(
                  _mockUser['bio'],
                  style: const TextStyle(
                    color: _textSecondary,
                    fontSize: 12,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  _mockUser['joinDate'],
                  style: const TextStyle(
                    color: _textSecondary,
                    fontSize: 11,
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

// ─────────────────────────────────────────────
// TARJETA: Clasificación – nivel + barra XP
// ─────────────────────────────────────────────
class _ClassificationCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final int xpCurrent = _mockUser['xpCurrent'];
    final int xpNext = _mockUser['xpNext'];
    final double progress = xpCurrent / xpNext;
    final int xpRemaining = xpNext - xpCurrent;
    final int nextLevel = _mockUser['level'] + 1;

    return _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Título de sección
          const Text(
            'Clasificación',
            style: TextStyle(
              color: _textPrimary,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 12),
          // Fila nivel actual + número
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Nivel actual',
                  style: TextStyle(color: _textSecondary, fontSize: 13)),
              Text(
                'Nivel ${_mockUser['level']}',
                style: const TextStyle(
                  color: _accentBlue,
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          // Fila etiqueta XP + números
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('XP',
                  style: TextStyle(color: _textSecondary, fontSize: 12)),
              Text(
                '${_formatNum(xpCurrent)} / ${_formatNum(xpNext)}',
                style: const TextStyle(
                  color: _accentBlue,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          // Barra de progreso XP
          _XpBar(progress: progress),
          const SizedBox(height: 6),
          Text(
            '${_formatNum(xpRemaining)} XP para el Nivel $nextLevel',
            style: const TextStyle(color: _textSecondary, fontSize: 11),
          ),
        ],
      ),
    );
  }

  String _formatNum(int n) {
    if (n >= 1000) return '${(n / 1000).toStringAsFixed(1)}K';
    return n.toString();
  }
}

// ─────────────────────────────────────────────
// FILA DE ESTADÍSTICAS: Bits – Cursos – Horas
// ─────────────────────────────────────────────
class _StatsRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Tarjeta Bits (más grande, con ícono destacado)
        Expanded(
          flex: 2,
          child: _StatBigCard(
            icon: Icons.toll_rounded,
            label: 'Mis Bits',
            value: '${_mockUser['bits']}',
          ),
        ),
        const SizedBox(width: 10),
        // Columna con dos tarjetas pequeñas
        Expanded(
          flex: 3,
          child: Column(
            children: [
              _StatSmallCard(
                icon: Icons.school_outlined,
                label: 'Cursos',
                value: '${_mockUser['coursesCompleted']}',
                color: _accentBlue,
              ),
              const SizedBox(height: 10),
              _StatSmallCard(
                icon: Icons.timer_outlined,
                label: 'Horas',
                value: '${_mockUser['studyHours']}h',
                color: _accentGold,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────
// CUADRÍCULA DE LOGROS
// ─────────────────────────────────────────────
class _AchievementsGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true, // no hace scroll propio, usa el padre
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 0.85,
      ),
      itemCount: _mockAchievements.length,
      itemBuilder: (context, index) {
        final item = _mockAchievements[index];
        return _AchievementTile(
          icon: item['icon'] as IconData,
          label: item['label'] as String,
        );
      },
    );
  }
}

// ─────────────────────────────────────────────
// FILA DE INVENTARIO
// ─────────────────────────────────────────────
class _InventoryRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: _mockInventory.length,
        separatorBuilder: (_, _) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          final item = _mockInventory[index];
          return _InventoryTile(
            icon: item['icon'] as IconData,
            label: item['label'] as String,
            unlocked: item['unlocked'] as bool,
          );
        },
      ),
    );
  }
}

// ═════════════════════════════════════════════
//  WIDGETS REUTILIZABLES
// ═════════════════════════════════════════════

// ── Contenedor-tarjeta genérico ──
class _Card extends StatelessWidget {
  final Widget child;
  const _Card({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _bgCard,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _bgCardBorder, width: 1),
      ),
      child: child,
    );
  }
}

// ── Avatar circular con iniciales ──
class _UserAvatar extends StatelessWidget {
  final String initials;
  final double size;
  const _UserAvatar({required this.initials, required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: const LinearGradient(
          colors: [Color(0xFF1D4ED8), Color(0xFF3B82F6)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(color: _accentBlue, width: 2),
      ),
      child: Center(
        child: Text(
          initials,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: size * 0.30,
          ),
        ),
      ),
    );
  }
}

// ── Barra de progreso XP ──
class _XpBar extends StatelessWidget {
  final double progress; // 0.0 a 1.0
  const _XpBar({required this.progress});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Stack(
          children: [
            // Fondo de la barra
            Container(
              height: 8,
              width: constraints.maxWidth,
              decoration: BoxDecoration(
                color: _xpBarBg,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            // Relleno de progreso
            Container(
              height: 8,
              width: constraints.maxWidth * progress.clamp(0.0, 1.0),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF1D4ED8), Color(0xFF60A5FA)],
                ),
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ],
        );
      },
    );
  }
}

// ── Encabezado de sección con link "Ver todos" ──
class _SectionHeader extends StatelessWidget {
  final String title;
  final String actionLabel;
  const _SectionHeader({required this.title, required this.actionLabel});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: _textPrimary,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        GestureDetector(
          onTap: () {},
          child: Text(
            actionLabel,
            style: const TextStyle(color: _accentBlue, fontSize: 13),
          ),
        ),
      ],
    );
  }
}

// ── Tarjeta grande de estadística (Bits) ──
class _StatBigCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  const _StatBigCard(
      {required this.icon, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _bgCard,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _bgCardBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Ícono con fondo circular
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: _bgCardBorder,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: _accentBlue, size: 22),
          ),
          const SizedBox(height: 10),
          Text(label,
              style:
                  const TextStyle(color: _textSecondary, fontSize: 12)),
          const SizedBox(height: 2),
          Text(
            value,
            style: const TextStyle(
              color: _textPrimary,
              fontWeight: FontWeight.bold,
              fontSize: 26,
            ),
          ),
        ],
      ),
    );
  }
}

// ── Tarjeta pequeña de estadística ──
class _StatSmallCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;
  const _StatSmallCard(
      {required this.icon,
      required this.label,
      required this.value,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: _bgCard,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _bgCardBorder),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label,
                  style: const TextStyle(
                      color: _textSecondary, fontSize: 11)),
              Text(
                value,
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ── Tile de logro (cuadrícula) ──
class _AchievementTile extends StatelessWidget {
  final IconData icon;
  final String label;
  const _AchievementTile({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _bgCard,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _bgCardBorder),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Ícono con fondo destacado
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: _bgCardBorder,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: _accentBlue, size: 20),
          ),
          const SizedBox(height: 5),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: _textSecondary,
              fontSize: 9,
              height: 1.3,
            ),
          ),
        ],
      ),
    );
  }
}

// ── Tile de inventario (fila horizontal) ──
class _InventoryTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool unlocked;
  const _InventoryTile(
      {required this.icon, required this.label, required this.unlocked});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 72,
      decoration: BoxDecoration(
        color: _bgCard,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          // Los desbloqueados tienen borde azul, los bloqueados gris
          color: unlocked ? _accentBlue.withOpacity(0.4) : _bgCardBorder,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Si está bloqueado, superpone un candado
          Stack(
            alignment: Alignment.center,
            children: [
              Icon(
                icon,
                color: unlocked ? _accentBlue : _textSecondary.withOpacity(0.3),
                size: 28,
              ),
              if (!unlocked)
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Icon(Icons.lock, color: _textSecondary, size: 13),
                ),
            ],
          ),
          const SizedBox(height: 5),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: unlocked ? _textSecondary : _textSecondary.withOpacity(0.4),
              fontSize: 9,
            ),
          ),
        ],
      ),
    );
  }
}