import 'package:flutter/material.dart';
import '../models/user.dart';

// ─────────────────────────────────────────────
// COLORES DEL TEMA OSCURO
// Mismos valores que en SocialProfileScreen.dart. Se duplican acá porque
// son constantes privadas de ese archivo (Dart no las expone fuera de él).
// Si en algún momento se arma un archivo de tema compartido para el
// perfil social, esto se puede unificar ahí.
// ─────────────────────────────────────────────
const Color _bgDark = Color(0xFF0A0E1A);
const Color _bgCard = Color(0xFF111827);
const Color _bgCardBorder = Color(0xFF1E2A3A);
const Color _accentGold = Color(0xFFFBBF24);
const Color _textPrimary = Color(0xFFE2E8F0);
const Color _textSecondary = Color(0xFF64748B);

// ─────────────────────────────────────────────
// PANTALLA DE LOGROS
// Vacía a propósito: todavía no hay logros definidos. Cuando los tengas,
// esta pantalla es el lugar para armar la grilla real (se puede seguir
// el mismo patrón que _AchievementsGrid en SocialProfileScreen.dart).
// ─────────────────────────────────────────────
class AchievementsScreen extends StatelessWidget {
  final User? user;
  const AchievementsScreen({super.key, this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bgDark,
      appBar: AppBar(
        backgroundColor: _bgDark,
        elevation: 0,
        iconTheme: const IconThemeData(color: _textPrimary),
        title: const Text(
          'Logros',
          style: TextStyle(
            color: _textPrimary,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      body: const _EmptyAchievements(),
    );
  }
}

// ── Estado vacío ──
class _EmptyAchievements extends StatelessWidget {
  const _EmptyAchievements();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 88,
              height: 88,
              decoration: BoxDecoration(
                color: _bgCard,
                shape: BoxShape.circle,
                border: Border.all(color: _bgCardBorder, width: 1.5),
              ),
              alignment: Alignment.center,
              child: const Icon(
                Icons.emoji_events_outlined,
                color: _accentGold,
                size: 40,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Todavía no hay logros',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: _textPrimary,
                fontWeight: FontWeight.bold,
                fontSize: 17,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Los logros van a aparecer acá a medida\nque los vayamos agregando.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: _textSecondary,
                fontSize: 13,
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
