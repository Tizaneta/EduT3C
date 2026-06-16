import 'package:flutter/material.dart';
// TODO: importá LoginScreen cuando implementes el cierre de sesión
// import 'LoginScreen.dart';

// ─────────────────────────────────────────────
//  SettingsScreen
//  Pantalla de ajustes accesible deslizando el
//  PageView de Home hasta esta posición.
//  Secciones: Cuenta · Notificaciones · 
//             Privacidad · Suscripción · Información
// ─────────────────────────────────────────────

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {

  // ── Estados de los toggles de Notificaciones ─
  // Cada bool controla un Switch de la sección.
  // Para persistirlos entre sesiones necesitarías
  // SharedPreferences (ver TODO en cada uno).
  bool _notifDiarios   = true;
  bool _notifDesafios  = true;
  bool _notifAmistades = true;
  bool _notifLogros    = true;

  // ── Estados de los toggles de Privacidad ─────
  bool _perfilPublico      = true;
  bool _mostrarNivel       = true;
  bool _mostrarInventario  = true;
  bool _bloquearSolicitudes = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF050D1A),
      body: Stack(
        children: [

          // ── Fondo degradado radial ────────────
          Container(
            decoration: const BoxDecoration(
              gradient: RadialGradient(
                center: Alignment(0, -0.4),
                radius: 1.1,
                colors: [Color(0xFF0A1628), Color(0xFF020810)],
              ),
            ),
          ),

          // ── Trazas de circuito decorativas ───
          Positioned.fill(
            child: CustomPaint(painter: _CircuitPainter()),
          ),

          // ── Contenido scrolleable ─────────────
          SafeArea(
            child: Column(
              children: [

                // ── AppBar personalizado ─────────
                _buildAppBar(),

                // ── Lista de secciones ───────────
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    children: [

                      _buildCuentaSection(),
                      const SizedBox(height: 16),

                      _buildNotificacionesSection(),
                      const SizedBox(height: 16),

                      _buildPrivacidadSection(),
                      const SizedBox(height: 16),

                      _buildSuscripcionSection(),
                      const SizedBox(height: 16),

                      _buildInformacionSection(),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ── AppBar con botón volver ───────────────────
  Widget _buildAppBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      child: Row(
        children: [
          // Botón volver: regresa a la pantalla anterior
          // En un PageView esto no navega hacia atrás sino
          // que el usuario desliza. Si quisieras que sí
          // navegue, usá Navigator.pop(context) acá.
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.chevron_left,
                color: Colors.white70, size: 28),
          ),
          const Expanded(
            child: Text(
              'Ajustes',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          // Espacio para equilibrar el Row visualmente
          const SizedBox(width: 48),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────────
  //  SECCIÓN: CUENTA
  // ─────────────────────────────────────────────
  Widget _buildCuentaSection() {
    return _SectionCard(
      title: 'Cuenta',
      icon: Icons.person_outline,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          // ── Avatar del usuario ────────────────
          Stack(
            children: [
              // Foto de perfil circular
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: const LinearGradient(
                    colors: [Color(0xFF2979FF), Color(0xFF00B0FF)],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF2979FF).withOpacity(0.4),
                      blurRadius: 12,
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(2.5),
                  child: Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFF0A1628),
                    ),
                    child: const Icon(Icons.smart_toy_outlined,
                        color: Color(0xFF4FC3F7), size: 40),
                  ),
                ),
              ),
              // Botón de editar foto (lápiz)
              Positioned(
                bottom: 0,
                right: 0,
                child: GestureDetector(
                  onTap: () {
                    // TODO: abrir selector de imagen
                    // Usá image_picker:
                    //   final picker = ImagePicker();
                    //   final img = await picker.pickImage(source: ImageSource.gallery);
                    // Luego subí la imagen a Firebase Storage
                    // y actualizá la URL en el perfil del usuario.
                  },
                  child: Container(
                    width: 26,
                    height: 26,
                    decoration: BoxDecoration(
                      color: const Color(0xFF2979FF),
                      shape: BoxShape.circle,
                      border: Border.all(
                          color: const Color(0xFF050D1A), width: 2),
                    ),
                    child: const Icon(Icons.edit,
                        color: Colors.white, size: 13),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(width: 16),

          // ── Opciones de cuenta ────────────────
          Expanded(
            child: Column(
              children: [
                _SettingsButton(
                  icon: Icons.person_outline,
                  title: 'Editar perfil',
                  subtitle: 'Cambia tu nombre y foto',
                  onTap: () {
                    // TODO: navegar a EditProfileScreen
                    // Creá una pantalla con campos para
                    // nombre, bio y foto, y guardá los
                    // cambios en tu base de datos.
                    // Navigator.push(context,
                    //   MaterialPageRoute(builder: (_) => EditProfileScreen()));
                  },
                ),
                _buildDivider(),
                _SettingsButton(
                  icon: Icons.mail_outline,
                  title: 'Correo electrónico',
                  subtitle: 'ejemplo@correo.com',
                  onTap: () {
                    // TODO: navegar a ChangeEmailScreen
                    // Pedí la nueva dirección, verificala
                    // con un correo de confirmación y
                    // actualizá en Firebase Auth / tu API.
                  },
                ),
                _buildDivider(),
                _SettingsButton(
                  icon: Icons.lock_outline,
                  title: 'Cambiar contraseña',
                  subtitle: 'Actualiza tu contraseña',
                  onTap: () {
                    // TODO: navegar a ChangePasswordScreen
                    // Pedí contraseña actual + nueva + confirmación.
                    // En Firebase: user.updatePassword(newPassword)
                    // o enviá un correo de reset con
                    // FirebaseAuth.instance.sendPasswordResetEmail(email: email)
                  },
                ),
                _buildDivider(),
                _SettingsButton(
                  icon: Icons.logout,
                  title: 'Cerrar sesión',
                  subtitle: 'Salir de tu cuenta actual',
                  iconColor: Colors.redAccent,
                  onTap: () {
                    // Cerramos sesión y volvemos al login.
                    // pushReplacement elimina el historial de
                    // navegación para que no pueda volver atrás.
                    //
                    // TODO: agregar también el cierre de sesión
                    // en Firebase: FirebaseAuth.instance.signOut()
                    // o borrar el token de tu API.
                    //
                    // Navigator.pushReplacement(context,
                    //   MaterialPageRoute(builder: (_) => LoginScreen()));
                    _showSnack('Sesión cerrada');
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────────
  //  SECCIÓN: NOTIFICACIONES
  // ─────────────────────────────────────────────
  Widget _buildNotificacionesSection() {
    return _SectionCard(
      title: 'Notificaciones',
      icon: Icons.notifications_outlined,
      child: Column(
        children: [
          // ── Toggle: Recordatorios diarios ─────
          _ToggleRow(
            icon: Icons.calendar_today_outlined,
            title: 'Recordatorios diarios',
            subtitle: 'Recibe recordatorios para estudiar',
            value: _notifDiarios,
            onChanged: (v) {
              setState(() => _notifDiarios = v);
              // TODO: guardar preferencia con SharedPreferences:
              //   final prefs = await SharedPreferences.getInstance();
              //   prefs.setBool('notif_diarios', v);
              // Y configurar/cancelar la notificación local con
              // el paquete flutter_local_notifications.
            },
          ),
          _buildDivider(),
          _ToggleRow(
            icon: Icons.flag_outlined,
            title: 'Nuevos desafíos',
            subtitle: 'Avisos sobre nuevos desafíos disponibles',
            value: _notifDesafios,
            onChanged: (v) => setState(() => _notifDesafios = v),
            // TODO: mismo patrón que Recordatorios diarios
          ),
          _buildDivider(),
          _ToggleRow(
            icon: Icons.people_outline,
            title: 'Solicitudes de amistad',
            subtitle: 'Notificaciones de nuevas solicitudes',
            value: _notifAmistades,
            onChanged: (v) => setState(() => _notifAmistades = v),
            // TODO: escuchar cambios en tu colección de solicitudes
            // en Firestore y disparar una notificación push con FCM.
          ),
          _buildDivider(),
          _ToggleRow(
            icon: Icons.emoji_events_outlined,
            title: 'Logros desbloqueados',
            subtitle: 'Avísame cuando obtenga nuevos logros',
            value: _notifLogros,
            onChanged: (v) => setState(() => _notifLogros = v),
          ),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────────
  //  SECCIÓN: PRIVACIDAD
  // ─────────────────────────────────────────────
  Widget _buildPrivacidadSection() {
    return _SectionCard(
      title: 'Privacidad',
      icon: Icons.shield_outlined,
      child: Column(
        children: [
          _ToggleRow(
            icon: Icons.person_outline,
            title: 'Perfil público',
            subtitle: 'Otros usuarios podrán ver tu perfil',
            value: _perfilPublico,
            onChanged: (v) {
              setState(() => _perfilPublico = v);
              // TODO: actualizar campo "isPublic" del usuario
              // en Firestore / tu base de datos.
            },
          ),
          _buildDivider(),
          _ToggleRow(
            icon: Icons.bar_chart_outlined,
            title: 'Mostrar mi nivel',
            subtitle: 'Permitir que otros vean tu nivel',
            value: _mostrarNivel,
            onChanged: (v) => setState(() => _mostrarNivel = v),
          ),
          _buildDivider(),
          _ToggleRow(
            icon: Icons.inventory_2_outlined,
            title: 'Mostrar inventario',
            subtitle: 'Permitir que otros vean tu inventario',
            value: _mostrarInventario,
            onChanged: (v) => setState(() => _mostrarInventario = v),
          ),
          _buildDivider(),
          _ToggleRow(
            icon: Icons.person_off_outlined,
            title: 'Bloquear solicitudes de amistad',
            subtitle: 'No recibir solicitudes de personas desconocidas',
            value: _bloquearSolicitudes,
            onChanged: (v) => setState(() => _bloquearSolicitudes = v),
          ),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────────
  //  SECCIÓN: SUSCRIPCIÓN
  //  Solo un botón, sin detalles de beneficios.
  // ─────────────────────────────────────────────
  Widget _buildSuscripcionSection() {
    return _SectionCard(
      title: 'Suscripción',
      icon: Icons.star_outline,
      child: SizedBox(
        width: double.infinity,
        height: 50,
        child: ElevatedButton(
          onPressed: () {
            // TODO: integrar sistema de pagos.
            // Opciones recomendadas para Flutter:
            //   - in_app_purchase (paquete oficial de Flutter)
            //     Maneja compras en Google Play y App Store.
            //   - revenue_cat (RevenueCat)
            //     Simplifica la gestión de suscripciones
            //     en ambas plataformas con una sola API.
            // Pasos básicos:
            //   1. Configurar productos en Google Play Console / App Store Connect
            //   2. Inicializar el paquete con tu API key
            //   3. Mostrar los productos disponibles
            //   4. Ejecutar la compra y validar el recibo
          },
          style: ElevatedButton.styleFrom(
            // Degradado dorado para destacar la suscripción
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: EdgeInsets.zero,
          ),
          child: Ink(
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF1565C0), Color(0xFF2979FF)],
              ),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF2979FF).withOpacity(0.4),
                  blurRadius: 12,
                ),
              ],
            ),
            child: const Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.star, color: Colors.amber, size: 20),
                  SizedBox(width: 10),
                  Text(
                    'Suscribirse',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ─────────────────────────────────────────────
  //  SECCIÓN: INFORMACIÓN
  // ─────────────────────────────────────────────
  Widget _buildInformacionSection() {
    return _SectionCard(
      title: 'Información',
      icon: Icons.info_outline,
      child: Column(
        children: [
          // Versión de la app (dato estático por ahora)
          _SettingsButton(
            icon: Icons.apps_outlined,
            title: 'Versión de la aplicación',
            subtitle: '1.0.0',
            showArrow: false,
            onTap: () {},
            // No hace nada, solo muestra la versión.
            // Para obtener la versión dinámicamente usá
            // el paquete package_info_plus:
            //   final info = await PackageInfo.fromPlatform();
            //   info.version → '1.0.0'
          ),
          _buildDivider(),
          _SettingsButton(
            icon: Icons.description_outlined,
            title: 'Términos y condiciones',
            onTap: () {
              // TODO: abrir URL con url_launcher:
              //   launchUrl(Uri.parse('https://tusitio.com/terminos'));
              // O navegar a una pantalla WebView interna.
            },
          ),
          _buildDivider(),
          _SettingsButton(
            icon: Icons.privacy_tip_outlined,
            title: 'Política de privacidad',
            onTap: () {
              // TODO: mismo que Términos y condiciones
              // pero con la URL de tu política de privacidad.
            },
          ),
          _buildDivider(),
          _SettingsButton(
            icon: Icons.mail_outline,
            title: 'Contactar soporte',
            subtitle: '¿Necesitas ayuda? Escríbenos',
            onTap: () {
              // TODO: abrir cliente de correo con url_launcher:
              //   launchUrl(Uri.parse('mailto:soporte@tusitio.com'));
              // O abrir un chat de soporte (Intercom, Zendesk, etc.)
            },
          ),
        ],
      ),
    );
  }

  // ── Línea divisora entre items ────────────────
  Widget _buildDivider() {
    return const Divider(
      color: Colors.white10,
      height: 1,
      thickness: 1,
    );
  }

  void _showSnack(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: const Color(0xFF1A3A6C),
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  _SectionCard
//  Contenedor reutilizable para cada sección.
//  Muestra un título con ícono y el contenido
//  dentro de un fondo oscuro con bordes.
// ─────────────────────────────────────────────
class _SectionCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Widget child;

  const _SectionCard({
    required this.title,
    required this.icon,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF0D1F38).withOpacity(0.9),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          // ── Encabezado de la sección ──────────
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 10),
            child: Row(
              children: [
                Icon(icon, color: const Color(0xFF4FC3F7), size: 22),
                const SizedBox(width: 10),
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          const Divider(color: Colors.white12, height: 1),

          // ── Contenido de la sección ───────────
          Padding(
            padding: const EdgeInsets.all(14),
            child: child,
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  _SettingsButton
//  Fila táctil con ícono, título, subtítulo
//  opcional y flecha a la derecha.
// ─────────────────────────────────────────────
class _SettingsButton extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final VoidCallback onTap;
  final Color iconColor;
  final bool showArrow;

  const _SettingsButton({
    required this.icon,
    required this.title,
    required this.onTap,
    this.subtitle,
    this.iconColor = const Color(0xFF4FC3F7),
    this.showArrow = true,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            Icon(icon, color: iconColor, size: 22),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  if (subtitle != null) ...[
                    const SizedBox(height: 2),
                    Text(
                      subtitle!,
                      style: const TextStyle(
                        color: Colors.white38,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            if (showArrow)
              const Icon(Icons.chevron_right,
                  color: Colors.white38, size: 20),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  _ToggleRow
//  Fila con ícono, texto y Switch a la derecha.
// ─────────────────────────────────────────────
class _ToggleRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  const _ToggleRow({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF4FC3F7), size: 22),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: Colors.white38,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          // Switch con color activo azul
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: const Color(0xFF2979FF),
            activeTrackColor: const Color(0xFF2979FF).withOpacity(0.3),
            inactiveThumbColor: Colors.white38,
            inactiveTrackColor: Colors.white12,
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  _CircuitPainter
//  Fondo de trazas PCB consistente con el
//  resto de las pantallas de la app.
// ─────────────────────────────────────────────
class _CircuitPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final linePaint = Paint()
      ..color = const Color(0xFF1A3A5C).withOpacity(0.3)
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    final lines = [
      [0.0,  0.05, 0.15, 0.05],
      [0.15, 0.05, 0.15, 0.18],
      [0.85, 0.02, 1.0,  0.02],
      [0.85, 0.02, 0.85, 0.15],
      [0.0,  0.75, 0.1,  0.75],
      [0.1,  0.75, 0.1,  0.88],
      [0.88, 0.82, 1.0,  0.82],
      [0.88, 0.82, 0.88, 0.95],
    ];

    for (final l in lines) {
      canvas.drawLine(
        Offset(l[0] * size.width, l[1] * size.height),
        Offset(l[2] * size.width, l[3] * size.height),
        linePaint,
      );
    }

    final dotPaint = Paint()
      ..color = const Color(0xFF2979FF).withOpacity(0.5)
      ..style = PaintingStyle.fill;

    final dots = [
      [0.15, 0.05], [0.15, 0.18],
      [0.85, 0.02], [0.85, 0.15],
      [0.1,  0.75], [0.1,  0.88],
      [0.88, 0.82], [0.88, 0.95],
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
