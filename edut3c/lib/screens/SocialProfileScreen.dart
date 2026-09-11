import 'package:edut3c/models/user.dart';
import 'package:flutter/material.dart';
import 'Loginscreen.dart';
import 'SignScreen.dart';
import 'AchievementsScreen.dart';
import '../services/api_service.dart';
import '../models/user.dart';
import '../data/achievement_repository.dart';
import '../models/achievement.dart';
// ─────────────────────────────────────────────
// DATOS DE EJEMPLO (simulan un usuario real)
// ─────────────────────────────────────────────

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
class SocialProfileScreen extends StatefulWidget {
  final User user;
  const SocialProfileScreen({super.key, required this.user});

  @override
  State<SocialProfileScreen> createState() => _SocialProfileScreenState();
}

class _SocialProfileScreenState extends State<SocialProfileScreen> {
  int _selected = 0;
  final AchievementRepository _achievementRepository = const AchievementRepository();

  @override
  Widget build(BuildContext context) {
    final achievements = _achievementRepository.getAchievements();
    final inventory = _achievementRepository.getInventory();

    return Scaffold(
      backgroundColor: _bgDark,
      // Barra superior con título "Social" y tabs Perfil / Mis Amigos
      appBar: _buildAppBar(),
      // Según el tab seleccionado mostramos el perfil o el estado
      // vacío de "Mis Amigos" (funcionalidad a implementar a futuro).
      body: _selected == 0
          ? _buildProfileBody(
              achievements: achievements,
              inventory: inventory,
            )
          : const _FriendsEmptyState(),
    );
  }

  Widget _buildProfileBody({
    required List<AchievementItem> achievements,
    required List<InventoryItem> inventory,
  }) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Sección: Avatar + Info básica del usuario ──
          _UserHeaderCard(user: widget.user),
          const SizedBox(height: 14),

          // ── Sección: Clasificación / Nivel y XP ──
          _ClassificationCard(user: widget.user),
          const SizedBox(height: 14),

          // ── Sección: Estadísticas (Bits, cursos, horas) ──
          _StatsRow(user: widget.user),
          const SizedBox(height: 14),

          _XpBar(progress: 30),
          const SizedBox(height:  14),

          // ── Sección: Logros en cuadrícula ──
          _SectionHeader(
            title: 'Logros',
            actionLabel: 'Ver todos',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => AchievementsScreen(user: widget.user),
                ),
              );
            },
          ),
          const SizedBox(height: 10),
          _AchievementsGrid(achievements: achievements),
          const SizedBox(height: 14),

          // ── Sección: Inventario ──
          _SectionHeader(title: 'Inventario', actionLabel: 'Ver todos'),
          const SizedBox(height: 10),
          _InventoryRow(inventory: inventory),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  // AppBar con tabs Perfil / Mis Amigos (sin botones sueltos sin función)
  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: _bgDark,
      elevation: 0,
      title: const Text(
        "Tu perfil",
        style: TextStyle(
          color: _textPrimary,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(40),
        child: _ProfileTabBar(
        selected: _selected,
        onChanged: (index) {
        setState(() {
        _selected = index;
      });
  },
),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// TAB BAR: Perfil / Mis Amigos
// ─────────────────────────────────────────────
class _ProfileTabBar extends StatelessWidget {
  final int selected;
  final ValueChanged<int> onChanged;
  const _ProfileTabBar({
  required this.selected,
  required this.onChanged,
  });


  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _tab("Perfil", 0),
        _tab("Mis Amigos", 1),
      ],
    );
  }

  Widget _tab(String label, int index) {
    final bool active = selected == index;
    return GestureDetector(
      onTap: () => onChanged(index),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
            color: active ? _textPrimary : _textSecondary,
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
  final User user;
  const _UserHeaderCard({
    required this.user,
  });
  @override
  Widget build(BuildContext context) {
    return _Card(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Avatar circular con iniciales
          _UserAvatar(
            initials: user.username,
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
                      user.username,
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
                  user.email,
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
                    'Nivel ${user.level}',
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
                  'XP acumulado: ${user.xp}',
                  style: const TextStyle(
                    color: _textSecondary,
                    fontSize: 12,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Bits: ${user.bits}',
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
  final User user;
  const _ClassificationCard({
    required this.user,
  });
  @override
  Widget build(BuildContext context) {
    final int xpCurrent = user.xp;
    //final int xpNext = user.xpNext;
    //final double progress = xpCurrent / xpNext;
    //final int xpRemaining = xpNext - xpCurrent;
    final int nextLevel = user.level + 1;

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
                'Nivel ${user.level}',
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
                '$xpCurrent XP',
                style: const TextStyle(
                  color: _accentBlue,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          //_XpBar(progress: progress),
          const SizedBox(height: 6),
          Text(
            '${user.level * 100 - xpCurrent} XP para el Nivel $nextLevel',
            style: const TextStyle(color: _textSecondary, fontSize: 11),
          ),
        ],
      ),
    );
  }

}

// ─────────────────────────────────────────────
// FILA DE ESTADÍSTICAS: Bits – Cursos – Horas
// ─────────────────────────────────────────────
class _StatsRow extends StatelessWidget {
  final User user;
  const _StatsRow({
    required this.user,
  });
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: _StatBigCard(
        icon: Icons.toll_rounded,
        label: 'Mis Bits',
        value: '${user.bits}',
      ),
    );
  }
}

// ─────────────────────────────────────────────
// CUADRÍCULA DE LOGROS
// ─────────────────────────────────────────────
class _AchievementsGrid extends StatelessWidget {
  final List<AchievementItem> achievements;

  const _AchievementsGrid({required this.achievements});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 0.85,
      ),
      itemCount: achievements.length,
      itemBuilder: (context, index) {
        final item = achievements[index];
        return _AchievementTile(
          icon: item.icon,
          label: item.label,
        );
      },
    );
  }
}

// ─────────────────────────────────────────────
// FILA DE INVENTARIO
// ─────────────────────────────────────────────
class _InventoryRow extends StatelessWidget {
  final List<InventoryItem> inventory;

  const _InventoryRow({required this.inventory});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: inventory.length,
        separatorBuilder: (_, _) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          final item = inventory[index];
          return _InventoryTile(
            icon: item.icon,
            label: item.label,
            unlocked: item.unlocked,
          );
        },
      ),
    );
  }
}

// ─────────────────────────────────────────────
// ESTADO VACÍO: MIS AMIGOS
// (la lista real de amigos es una implementación
// a futuro; por ahora solo mostramos este aviso)
// ─────────────────────────────────────────────
class _FriendsEmptyState extends StatelessWidget {
  const _FriendsEmptyState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.people_outline, color: _textSecondary, size: 56),
            const SizedBox(height: 16),
            const Text(
              'Aún no tienes amigos',
              style: TextStyle(
                color: _textPrimary,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Muy pronto vas a poder agregar amigos y ver su progreso acá.',
              textAlign: TextAlign.center,
              style: TextStyle(color: _textSecondary, fontSize: 13, height: 1.4),
            ),
          ],
        ),
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
  final VoidCallback? onTap;
  const _SectionHeader({
    required this.title,
    required this.actionLabel,
    this.onTap,
  });

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
          onTap: onTap ?? () {},
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
    return Center(
      child: Text(
        label,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: _textSecondary,
          fontSize: 9,
          height: 1.3,
        ),
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
    return SizedBox(
      width: 72,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: unlocked ? _textSecondary : _textSecondary.withValues(alpha: 0.4),
              fontSize: 9,
            ),
          ),
        ),
      ),
    );
  }
}