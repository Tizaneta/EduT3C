import 'package:flutter/material.dart';
import 'HardwareScreen.dart'; // Asegurate que la ruta sea correcta según tu estructura

// ════════════════════════════════════════════════════════════
//  HardwareIntroScreen
//  Pantalla de presentación para el módulo Hardware.
//  Se usa como PRIMER hijo del PageView en home.dart,
//  reemplazando a HardwareScreen en esa posición.
//  HardwareScreen queda como segunda pantalla del PageView.
// ════════════════════════════════════════════════════════════

class HardwareIntroScreen extends StatefulWidget {
  const HardwareIntroScreen({super.key});

  @override
  State<HardwareIntroScreen> createState() => _HardwareIntroScreenState();
}

class _HardwareIntroScreenState extends State<HardwareIntroScreen>
    with SingleTickerProviderStateMixin {

  // ── Controlador para la animación del botón GO ──────────────
  // Cuando lo cambies de nombre, solo tocá la variable [buttonLabel]
  late AnimationController _btnController;
  late Animation<double> _btnScale;

  // ── Nombre del botón central (cambialo cuando quieras) ──────
  static const String buttonLabel = 'GO';

  @override
  void initState() {
    super.initState();

    // Animación de pulsación del botón (scale up → down)
    _btnController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    );
    _btnScale = Tween<double>(begin: 1.0, end: 0.92).animate(
      CurvedAnimation(parent: _btnController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _btnController.dispose();
    super.dispose();
  }

  // ── Manejo del tap en el botón central ─────────────────────
  void _onGoPressed() async {
    // 1. Animación de escala del botón
    await _btnController.forward();
    await _btnController.reverse();

    // ── ESPACIO PARA TU ANIMACIÓN/TRANSICIÓN ─────────────────
    // Acá podés agregar:
    //   - Una animación de partículas (paquete: particles_flutter)
    //   - Un Hero widget sobre la imagen del chip
    //   - Un PageRoute personalizado con transición
    //     Ejemplo:
    //     Navigator.push(context, PageRouteBuilder(
    //       pageBuilder: (_, __, ___) => HardwareScreen(),
    //       transitionsBuilder: (_, anim, __, child) =>
    //         FadeTransition(opacity: anim, child: child),
    //       transitionDuration: Duration(milliseconds: 400),
    //     ));
    // ─────────────────────────────────────────────────────────

    if (!mounted) return;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HardwareMapScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Fondo oscuro igual al diseño
      backgroundColor: const Color(0xFF050A18),

      body: SafeArea(
        child: SingleChildScrollView(
          // El scroll vertical es para pantallas pequeñas.
          // El scroll LATERAL viene del PageView en home.dart — no se toca acá.
          child: Column(
            children: [

              // ── AppBar manual (hamburger + info) ───────────────
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Menú hamburger — conectá tu drawer si lo tenés
                    IconButton(
                      icon: const Icon(Icons.menu, color: Colors.white),
                      onPressed: () {
                        // TODO: abrir Drawer / menú lateral
                      },
                    ),
                    // Botón de info — podés navegar a una pantalla de ayuda
                    IconButton(
                      icon: const Icon(Icons.info_outline, color: Colors.white),
                      onPressed: () {
                        // TODO: navegar a pantalla de información
                      },
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 8),

              // ── Título con efecto neón ──────────────────────────
              // El glow se logra con TextStyle shadows. Si querés más intensidad,
              // podés usar el paquete `neon` de pub.dev o un Stack con BlendMode.
              RichText(
                textAlign: TextAlign.center,
                text: const TextSpan(
                  style: TextStyle(
                    fontSize: 42,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 2,
                  ),
                  children: [
                    // Rayo izquierdo + "HARD" en blanco
                    TextSpan(
                      text: '⚡ HARD',
                      style: TextStyle(
                        color: Colors.white,
                        shadows: [
                          Shadow(color: Colors.white54, blurRadius: 8),
                        ],
                      ),
                    ),
                    // "WARE" en azul neón
                    TextSpan(
                      text: 'WARE',
                      style: TextStyle(
                        color: Color(0xFF3DAAFF),
                        shadows: [
                          Shadow(color: Color(0xFF3DAAFF), blurRadius: 16),
                          Shadow(color: Color(0xFF3DAAFF), blurRadius: 32),
                        ],
                      ),
                    ),
                    // Rayo derecho
                    TextSpan(
                      text: ' ⚡',
                      style: TextStyle(
                        color: Colors.white,
                        shadows: [
                          Shadow(color: Colors.white54, blurRadius: 8),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 12),

              // ── Subtítulo ───────────────────────────────────────
              const Text(
                '¡Aprendamos sobre los\ncomponentes de una\ncomputadora!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 16,
                  height: 1.5,
                ),
              ),

              const SizedBox(height: 40),

              // ── Imagen del chip + botón GO ──────────────────────
              // La imagen es un asset. Necesitás:
              //   1. Agregar la imagen a assets/ (ej: assets/chip.png)
              //   2. Declarar en pubspec.yaml bajo flutter: > assets:
              //      flutter:
              //        assets:
              //          - assets/chip.png
              // Si no la tenés aún, el Stack muestra el botón solo sobre el placeholder.
              SizedBox(
                width: 260,
                height: 260,
                child: Stack(
                  alignment: Alignment.center,
                  children: [

                    // ── Imagen del chip (asset) ─────────────────
                    // Reemplazá 'assets/chip.png' por tu ruta real.
                    // Si el archivo no existe, Flutter tira error en debug;
                    // errorBuilder lo atrapa y muestra un contenedor azul como placeholder.
                    Image.asset(
                      'assets/chip.png',       // ← cambiá este path al tuyo
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        // Placeholder mientras no tengas el asset listo
                        return Container(
                          width: 220,
                          height: 220,
                          decoration: BoxDecoration(
                            color: const Color(0xFF0D1F3C),
                            borderRadius: BorderRadius.circular(24),
                            border: Border.all(
                              color: const Color(0xFF3DAAFF),
                              width: 2,
                            ),
                            boxShadow: const [
                              BoxShadow(
                                color: Color(0x663DAAFF),
                                blurRadius: 24,
                                spreadRadius: 4,
                              ),
                            ],
                          ),
                        );
                      },
                    ),

                    // ── Botón GO (central sobre el chip) ───────
                    // ScaleTransition + GestureDetector para la animación de tap.
                    // Cuando agregues la transición, trabajá desde _onGoPressed().
                    GestureDetector(
                      onTap: _onGoPressed,
                      child: ScaleTransition(
                        scale: _btnScale,
                        child: Container(
                          width: 90,
                          height: 90,
                          decoration: BoxDecoration(
                            color: const Color(0xFF0A1628),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: const Color(0xFF3DAAFF),
                              width: 2,
                            ),
                            boxShadow: const [
                              BoxShadow(
                                color: Color(0x993DAAFF),
                                blurRadius: 20,
                                spreadRadius: 2,
                              ),
                            ],
                          ),
                          alignment: Alignment.center,
                          child: const Text(
                            buttonLabel, // ← cambiá buttonLabel arriba cuando quieras
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1,
                            ),
                          ),
                        ),
                      ),
                    ),

                  ],
                ),
              ),

              const SizedBox(height: 24),

              // ── Flecha + texto "Ingresa al mapeo…" ─────────────
              const Icon(Icons.arrow_forward, color: Color(0xFF3DAAFF), size: 28),
              const SizedBox(height: 8),
              const Text(
                'Ingresa al mapeo interactivo\nde componentes.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white54, fontSize: 14),
              ),

              const SizedBox(height: 32),

              // ── Tarjeta "Dato curioso" ───────────────────────────
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFF0D1B33),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Ícono de lamparita con fondo circular
                      Container(
                        width: 52,
                        height: 52,
                        decoration: BoxDecoration(
                          color: const Color(0xFF0A1628),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: const Color(0xFF3DAAFF),
                            width: 1.5,
                          ),
                        ),
                        child: const Icon(
                          Icons.lightbulb_outline,
                          color: Color(0xFF3DAAFF),
                          size: 26,
                        ),
                      ),
                      const SizedBox(width: 12),
                      // Texto del dato curioso
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Dato curioso',
                              style: TextStyle(
                                color: Color(0xFF3DAAFF),
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'El hardware corresponde a todos los componentes físicos '
                              'que puedes ver y tocar en una computadora.',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 13,
                                height: 1.4,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 32),

            ],
          ),
        ),
      ),
    );
  }
}
