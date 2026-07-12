import 'dart:io';
import 'package:flutter/material.dart';
import 'SignScreen.dart';
import '../services/api_service.dart';
import 'home.dart';
import '../models/user.dart';
// TODO: importá Home cuando tengas la autenticación lista
// import 'home.dart';

// ─────────────────────────────────────────────
//  LoginScreen
//  Primera pantalla que ve el usuario al abrir
//  la app. Permite ingresar con correo, nombre
//  de usuario y contraseña, o ir a registrarse.
//
//  Flujo:
//    App inicia → LoginScreen
//      → login exitoso   → Home (pushReplacement)
//      → "Crear cuenta"  → RegisterScreen (push)
// ─────────────────────────────────────────────

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController    = TextEditingController();
  final _passwordController = TextEditingController();
  bool _hidePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    final email    = _emailController.text.trim();
    final password = _passwordController.text;
    if (
    email.isEmpty ||
        password.isEmpty
    ) {
      _showSnack('Por favor completá todos los campos.');
      return;
    }

    // ── MODO MOCK: bypass temporal sin backend ──────────
    // Ver ApiService.mockMode para desactivarlo.
    if (ApiService.mockMode) {
      final mockUser = User(
        id: 1,
        username: 'DevUser',
        email: email,
        xp: 250,
        level: 1,
        bits: 500,
      );
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => Home(user: mockUser),
        ),
      );
      return;
    }

    try {
      final result =
      await ApiService.login(
        email,
        password,
      );
      final user = User.fromJson(
        result["user"],
      );
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => Home(user: user,),
        ),
      );
      debugPrint(result.toString());
    } catch (e) {
      if (!mounted) return;
      if (e is SocketException) {
        _showSnack('No se pudo conectar al servidor. Verificá tu conexión y que el backend esté activo.');
      } else {
        _showSnack(e.toString());
      }
    }
  }

  void _showSnack(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: const Color(0xFF1A3A6C),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF050D1A),

      // ── Stack: fondo + contenido superpuesto ─
      body: Stack(
        children: [

          // ── Degradado radial oscuro de fondo ──
          Container(
            decoration: const BoxDecoration(
              gradient: RadialGradient(
                center: Alignment(0, -0.4),
                radius: 1.1,
                colors: [
                  Color(0xFF0A1628),
                  Color(0xFF020810),
                ],
              ),
            ),
          ),

          // ── Trazas de circuito decorativas ───
          // Mismo CustomPainter que en RegisterScreen
          // para mantener coherencia visual.
          Positioned.fill(
            child: CustomPaint(painter: _CircuitPainter()),
          ),

          // ── Contenido principal scrolleable ──
          // SingleChildScrollView evita overflow
          // cuando el teclado sube en pantalla.
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [

                  const SizedBox(height: 32),

                  // ── Avatar del mascot ──────────
                  _buildAvatar(),

                  const SizedBox(height: 24),

                  // ── Título y subtítulo ─────────
                  const Text(
                    'Bienvenido de nuevo',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.3,
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Inicia sesión para continuar aprendiendo',
                    style: TextStyle(color: Colors.white54, fontSize: 14),
                  ),

                  const SizedBox(height: 32),

                  // ── Tarjeta del formulario ─────
                  _buildFormCard(),

                  const SizedBox(height: 28),

                  // ── Pie de pantalla ────────────
                  _buildFooter(),

                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── Avatar circular con borde azul brillante ─
  // Mismo estilo que RegisterScreen para coherencia
  Widget _buildAvatar() {
    return Container(
      width: 130,
      height: 130,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: const LinearGradient(
          colors: [Color(0xFF2979FF), Color(0xFF00B0FF)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF2979FF).withValues(),
            blurRadius: 20,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(3),
        child: Container(
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [Color(0xFF0A1F3D), Color(0xFF051020)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: const Icon(
            Icons.smart_toy_outlined,
            color: Color(0xFF4FC3F7),
            size: 64,
          ),
        ),
      ),
    );
  }

  // ── Tarjeta blanca con los campos del login ───
  Widget _buildFormCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF0D1F38).withValues(),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white12),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF2979FF).withValues(),
            blurRadius: 24,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          // ── Encabezado de la tarjeta ──────────
          Row(
            children: const [
              Icon(Icons.person_outline,
                  color: Color(0xFF4FC3F7), size: 28),
              SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Iniciar sesión',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  // Línea azul decorativa bajo el título
                  SizedBox(height: 3),
                  SizedBox(
                    width: 80,
                    child: Divider(
                      color: Color(0xFF2979FF),
                      thickness: 2,
                      height: 2,
                    ),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 24),

          // ── Campo: Correo electrónico ─────────
          _buildField(
            controller: _emailController,
            label: 'Correo electrónico',
            hint: 'ejemplo@correo.com',
            icon: Icons.mail_outline,
            keyboardType: TextInputType.emailAddress,
          ),

          const SizedBox(height: 16),

          // ── Campo: Contraseña ─────────────────
          _buildField(
            controller: _passwordController,
            label: 'Contraseña',
            hint: 'Ingresa tu contraseña',
            icon: Icons.lock_outline,
            obscure: _hidePassword,
            suffix: IconButton(
              onPressed: () =>
                  setState(() => _hidePassword = !_hidePassword),
              icon: Icon(
                _hidePassword
                    ? Icons.visibility_off_outlined
                    : Icons.visibility,
                color: Colors.white38,
                size: 20,
              ),
            ),
          ),

          // ── Link "¿Olvidaste tu contraseña?" ──
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.only(top: 8),
              child: GestureDetector(
                onTap: () {
                  // TODO: implementar recuperación de contraseña
                },
                child: const Text(
                  '¿Olvidaste tu contraseña?',
                  style: TextStyle(
                    color: Color(0xFF4FC3F7),
                    fontSize: 13,
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(height: 24),

          // ── Botón principal "Iniciar sesión" ──
          SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton(
              onPressed: _handleLogin,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2979FF),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                elevation: 8,
                shadowColor: const Color(0xFF2979FF).withValues(alpha: 0.5),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Iniciar sesión',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.4,
                    ),
                  ),
                  SizedBox(width: 10),
                  Icon(Icons.arrow_forward, size: 20),
                ],
              ),
            ),
          ),

          const SizedBox(height: 20),

          // ── Separador "¿No tienes una cuenta?" ─
          const Center(
            child: Text(
              '¿No tienes una cuenta?',
              style: TextStyle(color: Colors.white38, fontSize: 13),
            ),
          ),

          const SizedBox(height: 12),

          // ── Botón secundario "Crear cuenta" ───
          // Borde azul, fondo transparente.
          // Navega a RegisterScreen con push (no
          // pushReplacement) para que el usuario
          // pueda volver al login con el botón atrás.
          SizedBox(
            width: double.infinity,
            height: 50,
            child: OutlinedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const RegisterScreen(),
                  ),
                );
              },
              icon: const Icon(
                Icons.person_add_outlined,
                color: Color(0xFF4FC3F7),
                size: 22,
              ),
              label: const Text(
                'Crear cuenta',
                style: TextStyle(
                  color: Color(0xFF4FC3F7),
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              style: OutlinedButton.styleFrom(
                side: const BorderSide(
                  color: Color(0xFF2979FF),
                  width: 1.5,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── Campo de texto reutilizable ───────────────
  // Tiene el label azul arriba, el ícono a la
  // izquierda y opcionalmente un widget suffix
  // (como el botón de ojo en la contraseña).
  Widget _buildField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    bool obscure = false,
    Widget? suffix,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF0A1628),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white12),
      ),
      child: Row(
        children: [

          // ── Ícono lateral con separador ───────
          Container(
            width: 48,
            height: 68,
            decoration: BoxDecoration(
              border: Border(
                right: BorderSide(
                  color: const Color(0xFF2979FF).withValues(),
                ),
              ),
            ),
            child: Icon(icon, color: const Color(0xFF4FC3F7), size: 22),
          ),

          // ── Campo de texto con label flotante ─
          Expanded(
            child: TextField(
              controller: controller,
              obscureText: obscure,
              keyboardType: keyboardType,
              style: const TextStyle(color: Colors.white, fontSize: 15),
              decoration: InputDecoration(
                // Label pequeño azul arriba del hint
                labelText: label,
                labelStyle: const TextStyle(
                  color: Color(0xFF4FC3F7),
                  fontSize: 12,
                ),
                hintText: hint,
                hintStyle:
                const TextStyle(color: Colors.white30, fontSize: 14),
                suffixIcon: suffix,
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 10,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── Pie de pantalla ───────────────────────────
  Widget _buildFooter() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Icon(Icons.shield_outlined, color: Colors.white30, size: 16),
        SizedBox(width: 6),
        Text(
          'Tu información está segura con nosotros',
          style: TextStyle(color: Colors.white30, fontSize: 12),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────
//  _CircuitPainter
//  Mismo fondo de trazas PCB que en Register
//  y SoftwareScreen. Dibuja líneas y nodos
//  decorativos en las esquinas de la pantalla.
// ─────────────────────────────────────────────
class _CircuitPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final linePaint = Paint()
      ..color = const Color(0xFF1A3A5C).withValues()
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    // Trazas en las cuatro esquinas
    final lines = [
      [0.0,  0.05, 0.15, 0.05],
      [0.15, 0.05, 0.15, 0.18],
      [0.0,  0.12, 0.08, 0.12],
      [0.85, 0.02, 1.0,  0.02],
      [0.85, 0.02, 0.85, 0.15],
      [0.92, 0.08, 1.0,  0.08],
      [0.0,  0.75, 0.1,  0.75],
      [0.1,  0.75, 0.1,  0.88],
      [0.0,  0.92, 0.18, 0.92],
      [0.82, 0.85, 1.0,  0.85],
      [0.82, 0.85, 0.82, 0.97],
      [0.9,  0.97, 1.0,  0.97],
    ];

    for (final l in lines) {
      canvas.drawLine(
        Offset(l[0] * size.width, l[1] * size.height),
        Offset(l[2] * size.width, l[3] * size.height),
        linePaint,
      );
    }

    // Nodos (puntos donde se cruzan las trazas)
    final dotPaint = Paint()
      ..color = const Color(0xFF2979FF).withValues()
      ..style = PaintingStyle.fill;

    final dots = [
      [0.15, 0.05], [0.15, 0.18], [0.85, 0.02],
      [0.85, 0.15], [0.1,  0.75], [0.1,  0.88],
      [0.82, 0.85], [0.82, 0.97],
    ];

    for (final d in dots) {
      canvas.drawCircle(
        Offset(d[0] * size.width, d[1] * size.height),
        3,
        dotPaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}