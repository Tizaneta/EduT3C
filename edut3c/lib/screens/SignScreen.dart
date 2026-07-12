import 'dart:io';
import 'package:edut3c/models/user.dart';
import 'package:flutter/material.dart';
import 'package:edut3c/screens/Loginscreen.dart';
import '../services/api_service.dart';
// ─────────────────────────────────────────────
//  RegisterScreen
//  Pantalla de registro de nuevo usuario.
//  Diseño: dark tech con fondo de circuito,
//  campos con ícono lateral y botón principal
//  azul brillante. Sin integración Microsoft.
// ─────────────────────────────────────────────

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  // ── Controladores de texto ───────────────────
  // Cada campo tiene su propio controller para
  // poder leer el valor que escribió el usuario.
  final _emailController    = TextEditingController();
  final _nameController     = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController  = TextEditingController();

  // ── Estado de visibilidad de contraseñas ────
  // true = texto oculto (••••), false = visible
  bool _hidePassword = true;
  bool _hideConfirm  = true;

  @override
  void dispose() {
    // Liberar los controladores cuando la pantalla se destruye
    _emailController.dispose();
    _nameController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  // ── Lógica de registro ───────────────────────
  // Por ahora solo imprime los datos; reemplazá
  // este método con tu lógica de autenticación real.
  void _handleRegister() async {
    final email    = _emailController.text.trim();
    final username     = _nameController.text.trim();
    final password = _passwordController.text;
    final confirm  = _confirmController.text;

    // Validación básica
    if (email.isEmpty || username.isEmpty || password.isEmpty) {
      _showSnack('Por favor completá todos los campos.');
      return;
    }
    if (password != confirm) {
      _showSnack('Las contraseñas no coinciden.');
      return;
    }
    if (password.length < 8) {
      _showSnack('La contraseña debe tener al menos 8 caracteres.');
      return;
    }

    // ── MODO MOCK: bypass temporal sin backend ──────────
    // Ver ApiService.mockMode para desactivarlo.
    if (ApiService.mockMode) {
      _showSnack('Registro simulado (modo mock activo).');
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const LoginScreen(),
        ),
      );
      return;
    }

    try {
      debugPrint("1");
      final result =
      await ApiService.register(
        username,
        email,
        password,
      );
      debugPrint("2");
      if (!mounted) return;
      debugPrint("3: pasó el mounted");
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const LoginScreen(),
        ),
      );
      debugPrint("Ya pasó el navigator.");
      debugPrint(result.toString());
    } catch (e, stackTrace) {
      if (!mounted) return;
      debugPrint("ERROR $e");
      debugPrint(stackTrace.toString());
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

      // ── Stack para superponer el fondo decorativo ─
      body: Stack(
        children: [

          // ── Fondo con degradado radial ───────────
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

          // ── Patrón de circuito al fondo ──────────
          Positioned.fill(
            child: CustomPaint(painter: _CircuitPainter()),
          ),

          // ── Contenido scrolleable ────────────────
          // SingleChildScrollView evita overflow cuando
          // el teclado sube y ocupa espacio en pantalla.
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [

                  // ── Botón volver ─────────────────
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 12, bottom: 2),
                      child: _BackButton(), // TODO este boton de volver es re trol
                    ),
                  ),

                  // ── Avatar del mascot ─────────────
                  // Círculo con borde azul brillante
                  _buildAvatar(),

                  const SizedBox(height: 20),

                  // ── Títulos ───────────────────────
                  const Text(
                    'Crear cuenta',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.3,
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Únete y comienza tu aprendizaje',
                    style: TextStyle(
                      color: Colors.white54,
                      fontSize: 15,
                    ),
                  ),

                  const SizedBox(height: 28),

                  // ── Tarjeta del formulario ────────
                  // Contenedor con bordes redondeados
                  // y fondo semi-transparente oscuro.
                  _buildFormCard(),

                  const SizedBox(height: 28),

                  // ── Pie de pantalla ───────────────
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

  // ── Avatar circular con borde brillante ──────
  Widget _buildAvatar() {
    return Container(
      width: 130,
      height: 130,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        // Borde azul brillante con gradiente
        gradient: const LinearGradient(
          colors: [Color(0xFF2979FF), Color(0xFF00B0FF)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF2979FF).withOpacity(0.5),
            blurRadius: 20,
            spreadRadius: 2,
          ),
        ],
      ),
      // Relleno interior con fondo oscuro para el ícono
      child: Padding(
        padding: const EdgeInsets.all(3),
        child: Container(
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            // Fondo del círculo interno: gradiente oscuro nocturno
            gradient: LinearGradient(
              colors: [Color(0xFF0A1F3D), Color(0xFF051020)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: const Icon(
            Icons.smart_toy_outlined, // Robot de aprendizaje TODO lo vamos a cambiar por el logo
            color: Color(0xFF4FC3F7),
            size: 64,
          ),
        ),
      ),
    );
  }

  // ── Tarjeta del formulario ────────────────────
  Widget _buildFormCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF0D1F38).withOpacity(0.9),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white12),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF2979FF).withOpacity(0.08),
            blurRadius: 24,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          // ── Campo: Correo electrónico ─────────
          _buildLabel('Correo electrónico'),
          _buildField(
            controller: _emailController,
            hint: 'ejemplo@correo.com',
            icon: Icons.mail_outline,
            keyboardType: TextInputType.emailAddress,
          ),
          _buildHelper('Usaremos este correo para mantener tu cuenta segura.'),

          const SizedBox(height: 16),

          // ── Campo: Nombre completo ────────────
          _buildLabel('Nombre completo'),
          _buildField(
            controller: _nameController,
            hint: 'Tu nombre completo',
            icon: Icons.person_outline,
          ),
          _buildHelper('Este nombre será visible para otros usuarios.'),

          const SizedBox(height: 16),

          // ── Campo: Contraseña ─────────────────
          _buildLabel('Contraseña'),
          _buildField(
            controller: _passwordController,
            hint: 'Crea una contraseña segura',
            icon: Icons.lock_outline,
            obscure: _hidePassword,
            // Botón de ojo para mostrar/ocultar
            suffix: _eyeButton(
              visible: !_hidePassword,
              onTap: () => setState(() => _hidePassword = !_hidePassword),
            ),
          ),
          _buildHelper('Mínimo 8 caracteres con letras, números y símbolos.'),

          const SizedBox(height: 16),

          // ── Campo: Confirmar contraseña ───────
          _buildLabel('Confirmar contraseña'),
          _buildField(
            controller: _confirmController,
            hint: 'Repite tu contraseña',
            icon: Icons.lock_outline,
            obscure: _hideConfirm,
            suffix: _eyeButton(
              visible: !_hideConfirm,
              onTap: () => setState(() => _hideConfirm = !_hideConfirm),
            ),
          ),
          _buildHelper('Asegúrate de que ambas contraseñas coincidan.'),

          const SizedBox(height: 24),

          // ── Botón principal "Crear cuenta" ────
          SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton(
              onPressed: _handleRegister,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2979FF),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                elevation: 8,
                shadowColor: const Color(0xFF2979FF).withOpacity(0.5),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Crear cuenta',
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

          // ── Divisor "o regístrate con" ─────────
          Row(
            children: [
              Expanded(child: Divider(color: Colors.white24)),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Text(
                  'o regístrate con',
                  style: TextStyle(color: Colors.white38, fontSize: 13),
                ),
              ),
              Expanded(child: Divider(color: Colors.white24)),
            ],
          ),

          const SizedBox(height: 16),

          // ── Botón Google ──────────────────────
          SizedBox(
            width: double.infinity,
            height: 48,
            child: OutlinedButton.icon(
              onPressed: () {
                // TODO: implementar Google Sign-In
              },
              icon: const Icon(Icons.g_mobiledata,
                  color: Color(0xFF4FC3F7), size: 26),
              label: const Text(
                'Google',
                style: TextStyle(color: Colors.white70, fontSize: 15),
              ),
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Colors.white24),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── Label azul de cada campo ──────────────────
  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        text,
        style: const TextStyle(
          color: Color(0xFF4FC3F7),
          fontSize: 13,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  // ── Texto de ayuda gris bajo cada campo ───────
  Widget _buildHelper(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: Text(
        text,
        style: const TextStyle(color: Colors.white38, fontSize: 11.5),
      ),
    );
  }

  // ── Campo de texto con ícono lateral ──────────
  // Acepta parámetros opcionales para contraseña
  // (obscure) y el botón de ojo (suffix).
  Widget _buildField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    bool obscure = false,
    Widget? suffix,
  }) {
    return Row(
      children: [

        // ── Ícono cuadrado con borde ──────────
        Container(
          width: 44,
          height: 50,
          decoration: BoxDecoration(
            color: const Color(0xFF0A1628),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: const Color(0xFF2979FF).withOpacity(0.4)),
          ),
          child: Icon(icon, color: const Color(0xFF4FC3F7), size: 22),
        ),

        const SizedBox(width: 10),

        // ── Campo de texto expandido ──────────
        Expanded(
          child: TextField(
            controller: controller,
            obscureText: obscure,
            keyboardType: keyboardType,
            style: const TextStyle(color: Colors.white, fontSize: 15),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: const TextStyle(color: Colors.white30, fontSize: 14),
              filled: true,
              fillColor: const Color(0xFF0A1628),
              suffixIcon: suffix,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide:
                BorderSide(color: Colors.white12),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide:
                const BorderSide(color: Color(0xFF2979FF), width: 1.5),
              ),
              contentPadding:
              const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
            ),
          ),
        ),
      ],
    );
  }

  // ── Botón de ojo para contraseñas ─────────────
  Widget _eyeButton({required bool visible, required VoidCallback onTap}) {
    return IconButton(
      onPressed: onTap,
      icon: Icon(
        visible ? Icons.visibility : Icons.visibility_off_outlined,
        color: Colors.white38,
        size: 20,
      ),
    );
  }

  // ── Pie: link a iniciar sesión + seguridad ─────
  Widget _buildFooter() {
    return Column(
      children: [
        // Link "¿Ya tenés cuenta?"
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              '¿Ya tienes una cuenta? ',
              style: TextStyle(color: Colors.white54, fontSize: 14),
            ),
            GestureDetector(
              onTap: () {
                // TODO: navegar a LoginScreen
                Navigator.push(context,
                  MaterialPageRoute(builder: (context)  => LoginScreen()
                  ),
                );
              },
              child: const Text(
                'Iniciar sesión',
                style: TextStyle(
                  color: Color(0xFF4FC3F7),
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 16),

        // Badge de seguridad inferior
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.shield_outlined, color: Colors.white30, size: 16),
            SizedBox(width: 6),
            Text(
              'Tu información está segura con nosotros',
              style: TextStyle(color: Colors.white30, fontSize: 12),
            ),
          ],
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────
//  _BackButton
//  Botón de volver con borde redondeado,
//  igual al de la imagen de referencia.
// ─────────────────────────────────────────────
class _BackButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: Container(
        width: 42,
        height: 42,
        decoration: BoxDecoration(
          color: const Color(0xFF0D1F38),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.white12),
        ),
        child: const Icon(Icons.chevron_left, color: Colors.white70, size: 26),
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  _CircuitPainter
//  Mismo fondo de trazas de PCB que en
//  SoftwareScreen para mantener coherencia visual.
// ─────────────────────────────────────────────
class _CircuitPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final linePaint = Paint()
      ..color = const Color(0xFF1A3A5C).withOpacity(0.3)
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    // Trazas de circuito en los bordes (esquinas)
    final lines = [
      [0.0, 0.15, 0.2, 0.15],
      [0.2, 0.15, 0.2, 0.3],
      [0.8, 0.05, 1.0, 0.05],
      [0.8, 0.05, 0.8, 0.2],
      [0.0, 0.6, 0.12, 0.6],
      [0.12, 0.6, 0.12, 0.75],
      [0.88, 0.7, 1.0, 0.7],
      [0.88, 0.7, 0.88, 0.9],
      [0.05, 0.9, 0.25, 0.9],
      [0.75, 0.95, 1.0, 0.95],
    ];

    for (final l in lines) {
      canvas.drawLine(
        Offset(l[0] * size.width, l[1] * size.height),
        Offset(l[2] * size.width, l[3] * size.height),
        linePaint,
      );
    }

    // Nodos (puntos de soldadura)
    final dotPaint = Paint()
      ..color = const Color(0xFF2979FF).withOpacity(0.5)
      ..style = PaintingStyle.fill;

    final dots = [
      [0.2, 0.15], [0.2, 0.3], [0.8, 0.05],
      [0.8, 0.2],  [0.12, 0.6],[0.12, 0.75],
      [0.88, 0.7], [0.88, 0.9],
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