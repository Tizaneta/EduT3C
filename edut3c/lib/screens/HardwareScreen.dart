import 'package:flutter/material.dart';
import 'StationScreens.dart';
import '../data/HardwareData.dart';
import '../services/progress_service.dart';

// ─── Posiciones de los hotspots ────────────────────────────────────────────
// Lista (no mapa) porque un mismo componente puede tener más de un punto
// en la imagen (ej: si algún día separás visualmente dos tornillos del
// mismo gabinete). `route` tiene que coincidir con una key de
// hardwareComponents en data/HardwareData.dart. l y t son fracciones
// (0.0 a 1.0) del tamaño de la IMAGEN real, no del contenedor.
//
// EDITÁ VOS ESTOS VALORES mirando tu imagen real
// (assets/imagenes/components_map.jpeg).
class HotspotPosition {
  final String route;
  final double l;
  final double t;
  const HotspotPosition(this.route, this.l, this.t);
}

const List<HotspotPosition> _hotspots = [
  HotspotPosition('cpu', 0.38, 0.30),
  HotspotPosition('gpu', 0.20, 0.65),
  HotspotPosition('ssd', 0.68, 0.52),
  HotspotPosition('hdd', 0.42, 0.62),
  HotspotPosition('motherboard', 0.35, 0.43),
  HotspotPosition('psu', 0.68, 0.52),
  HotspotPosition('ram', 0.23, 0.56),
  HotspotPosition('cooler', 0.20, 0.40),
  HotspotPosition('m2', 0.65, 0.60),

];

// ─── Screen ──────────────────────────────────────────────────────────────────

class HardwareMapScreen extends StatefulWidget {
  const HardwareMapScreen({super.key});

  @override
  State<HardwareMapScreen> createState() => _HardwareMapScreenState();
}

class _HardwareMapScreenState extends State<HardwareMapScreen> {
  // route -> si el componente está desbloqueado
  Map<String, bool> _unlocked = {};
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadUnlocked();
  }

  // Un componente está desbloqueado si es el primero de la lista
  // (según el orden de hardwareComponents), o si el componente
  // anterior ya está 100% completo.
  Future<void> _loadUnlocked() async {
    final routes = hardwareComponents.keys.toList();
    final Map<String, bool> unlocked = {};
    bool previousCompleted = true;

    for (final route in routes) {
      unlocked[route] = previousCompleted;
      final total = hardwareComponents[route]!.length;
      previousCompleted =
      await ProgressService.isComponentCompleted(route, total);
    }

    if (!mounted) return;
    setState(() {
      _unlocked = unlocked;
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D1117),
      appBar: _buildAppBar(context),
      body: Column(
        children: [
          _HintBanner(),
          Expanded(
            child: _loading
                ? const Center(
              child: CircularProgressIndicator(color: Color(0xFF1A6CF6)),
            )
                : _MapArea(
              unlocked: _unlocked,
              onReturn: _loadUnlocked,
            ),
          ),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFF0D1117),
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.white),
        // Vuelve a la pantalla anterior en el stack (HardwareIntroScreen).
        onPressed: () => Navigator.pop(context),
      ),
      title: const Text(
        'Mapa de componentes',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
          fontSize: 18,
        ),
      ),
      centerTitle: true,
      actions: [
        // ── Botón de DEBUG (solo para testear el desbloqueo) ──
        // Sacalo cuando termines de probar: es lo único que agregué
        // que no estaba pedido explícitamente para producción.
        IconButton(
          icon: const Icon(Icons.bug_report_outlined, color: Colors.white54),
          tooltip: 'Debug: progreso',
          onPressed: () => _showDebugSheet(context),
        ),
      ],
    );
  }

  void _showDebugSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF161B22),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => _DebugProgressSheet(
        onChanged: _loadUnlocked,
      ),
    );
  }
}

// ─── Debug: completar / resetear progreso por componente ──────────────────────
// Pantalla de testing. Usa únicamente los métodos reales que ya existen
// en ProgressService (completeLevel, resetComponent) — no inventa nada
// nuevo del backend ni de persistencia.
class _DebugProgressSheet extends StatefulWidget {
  final Future<void> Function() onChanged;
  const _DebugProgressSheet({required this.onChanged});

  @override
  State<_DebugProgressSheet> createState() => _DebugProgressSheetState();
}

class _DebugProgressSheetState extends State<_DebugProgressSheet> {
  bool _working = false;

  Future<void> _completeComponent(String route) async {
    setState(() => _working = true);
    final total = hardwareComponents[route]!.length;
    // Marca todos los niveles del componente como completados,
    // uno por uno, con el mismo método que usa el flujo real.
    for (int level = 1; level <= total; level++) {
      await ProgressService.completeLevel(route, level);
    }
    await widget.onChanged();
    if (mounted) setState(() => _working = false);
  }

  Future<void> _resetComponent(String route) async {
    setState(() => _working = true);
    await ProgressService.resetComponent(route);
    await widget.onChanged();
    if (mounted) setState(() => _working = false);
  }

  Future<void> _resetAll() async {
    setState(() => _working = true);
    for (final route in hardwareComponents.keys) {
      await ProgressService.resetComponent(route);
    }
    await widget.onChanged();
    if (mounted) setState(() => _working = false);
  }

  @override
  Widget build(BuildContext context) {
    final routes = hardwareComponents.keys.toList();
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.white24,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Debug: progreso de componentes',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'Solo para testing. No usar en producción.',
            style: TextStyle(color: Colors.white54, fontSize: 12),
          ),
          const SizedBox(height: 16),
          if (_working)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: LinearProgressIndicator(color: Color(0xFF1A6CF6)),
            ),
          for (final route in routes)
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      hardwareComponentNames[route] ?? route,
                      style: const TextStyle(color: Colors.white70, fontSize: 14),
                    ),
                  ),
                  TextButton(
                    onPressed: _working ? null : () => _completeComponent(route),
                    child: const Text('Desbloquear todo'),
                  ),
                  TextButton(
                    onPressed: _working ? null : () => _resetComponent(route),
                    child: const Text('Reiniciar'),
                  ),
                ],
              ),
            ),
          const SizedBox(height: 8),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: _working ? null : _resetAll,
              child: const Text('Reiniciar todo el progreso'),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Hint banner ─────────────────────────────────────────────────────────────

class _HintBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: const Color(0xFF0D1117),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: const [
          Icon(Icons.touch_app_outlined, color: Colors.white54, size: 18),
          SizedBox(width: 8),
          Text(
            'Toca un componente para ver más información',
            style: TextStyle(color: Colors.white54, fontSize: 13),
          ),
        ],
      ),
    );
  }
}

// ─── Interactive map ──────────────────────────────────────────────────────────
//
// _MapArea resuelve el tamaño REAL (en píxeles) de la imagen de fondo y
// calcula el rectángulo exacto donde BoxFit.contain la termina dibujando
// dentro del contenedor disponible. Los hotspots se ubican relativos a
// ESE rectángulo (no al contenedor completo), así quedan siempre
// centrados sobre el número correspondiente sin importar el tamaño de
// pantalla ni la proporción de la imagen.

class _MapArea extends StatefulWidget {
  final Map<String, bool> unlocked;
  final Future<void> Function() onReturn;

  const _MapArea({
    required this.unlocked,
    required this.onReturn,
  });

  @override
  State<_MapArea> createState() => _MapAreaState();
}

class _MapAreaState extends State<_MapArea> {
  static const String _assetPath = 'assets/imagenes/components_map.jpeg';

  Size? _imageSize;
  bool _imageError = false;
  ImageStream? _imageStream;
  late final ImageStreamListener _imageListener;

  @override
  void initState() {
    super.initState();
    _imageListener =
        ImageStreamListener(_onImageLoaded, onError: _onImageError);
    _resolveImageSize();
  }

  void _resolveImageSize() {
    final stream =
    const AssetImage(_assetPath).resolve(const ImageConfiguration());
    _imageStream = stream;
    stream.addListener(_imageListener);
  }

  void _onImageLoaded(ImageInfo info, bool _) {
    if (!mounted) return;
    setState(() {
      _imageSize = Size(
        info.image.width.toDouble(),
        info.image.height.toDouble(),
      );
    });
  }

  void _onImageError(Object error, StackTrace? stackTrace) {
    if (!mounted) return;
    setState(() => _imageError = true);
  }

  @override
  void dispose() {
    _imageStream?.removeListener(_imageListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final containerW = constraints.maxWidth;
        final containerH = constraints.maxHeight;

        // Sin asset todavía (o falló la carga): mostramos el placeholder,
        // sin hotspots — no tiene sentido posicionarlos sobre una imagen
        // que no existe.
        if (_imageError) {
          return _PlaceholderMap();
        }

        // Resolviendo el tamaño real de la imagen todavía.
        if (_imageSize == null) {
          return const Center(
            child: CircularProgressIndicator(color: Color(0xFF1A6CF6)),
          );
        }

        // Rectángulo real donde se dibuja la imagen con BoxFit.contain.
        final imageAspect = _imageSize!.width / _imageSize!.height;
        final containerAspect = containerW / containerH;

        double renderW, renderH, offsetX, offsetY;
        if (containerAspect > imageAspect) {
          // El contenedor es más "ancho" que la imagen -> franjas a los costados.
          renderH = containerH;
          renderW = renderH * imageAspect;
          offsetX = (containerW - renderW) / 2;
          offsetY = 0;
        } else {
          // El contenedor es más "alto" que la imagen -> franjas arriba/abajo.
          renderW = containerW;
          renderH = renderW / imageAspect;
          offsetX = 0;
          offsetY = (containerH - renderH) / 2;
        }

        return Stack(
          children: [
            // ── Background image ──────────────────────────────────────────
            Positioned.fill(
              child: Image.asset(
                _assetPath,
                fit: BoxFit.contain,
                alignment: Alignment.center,
                errorBuilder: (_, __, ___) => _PlaceholderMap(),
              ),
            ),

            // ── Hotspots (uno por cada entrada en _hotspots) ────────────────
            for (final hotspot in _hotspots)
              _buildHotspot(context, hotspot, renderW, renderH, offsetX, offsetY),
          ],
        );
      },
    );
  }

  Widget _buildHotspot(
      BuildContext context,
      HotspotPosition hotspot,
      double renderW,
      double renderH,
      double offsetX,
      double offsetY,
      ) {
    final route = hotspot.route;
    final name = hardwareComponentNames[route] ?? route;
    final isUnlocked = widget.unlocked[route] ?? false;
    const double ringSize = 36;

    final left = offsetX + renderW * hotspot.l - ringSize / 2;
    final top = offsetY + renderH * hotspot.t - ringSize / 2;

    return Positioned(
      left: left,
      top: top,
      child: GestureDetector(
        // Siempre se puede previsualizar (bloqueado o no); lo que cambia
        // es si desde la ficha se puede entrar a los niveles.
        onTap: () => _showComponentSheet(context, route, name, isUnlocked),
        child: _HotspotMarker(unlocked: isUnlocked, size: ringSize),
      ),
    );
  }

  void _showComponentSheet(
      BuildContext context,
      String route,
      String name,
      bool isUnlocked,
      ) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF161B22),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => _ComponentSheet(
        route: route,
        name: name,
        isUnlocked: isUnlocked,
        onReturn: widget.onReturn,
      ),
    );
  }
}

// ─── Hotspot marker ─────────────────────────────────────────────────────────
// El número ya está dibujado en la imagen — esto NO dibuja otro número
// encima. Desbloqueado: aro sutil que brilla alrededor del número.
// Bloqueado: oscurece el número y muestra un candado (la imagen sola no
// puede indicar este estado).

class _HotspotMarker extends StatelessWidget {
  final bool unlocked;
  final double size;
  const _HotspotMarker({required this.unlocked, this.size = 36});

  @override
  Widget build(BuildContext context) {
    const accent = Color(0xFF1A6CF6);

    if (unlocked) {
      return Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: accent.withOpacity(0.85), width: 2),
          boxShadow: [
            BoxShadow(
              color: accent.withOpacity(0.55),
              blurRadius: 10,
              spreadRadius: 1,
            ),
          ],
        ),
      );
    }

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.black.withOpacity(0.55),
        border: Border.all(color: Colors.white24, width: 1),
      ),
      alignment: Alignment.center,
      child: const Icon(Icons.lock_outline, color: Colors.white54, size: 14),
    );
  }
}

// ─── Bottom sheet ─────────────────────────────────────────────────────────────
//
// Sirve como PREVIEW del componente. Siempre muestra nombre y cantidad
// de niveles, esté o no desbloqueado. Si está bloqueado, el botón queda
// deshabilitado visualmente y, si lo tocás, te avisa qué falta — pero
// nunca navega a StationScreens.

class _ComponentSheet extends StatelessWidget {
  final String route;
  final String name;
  final bool isUnlocked;
  final Future<void> Function() onReturn;

  const _ComponentSheet({
    required this.route,
    required this.name,
    required this.isUnlocked,
    required this.onReturn,
  });

  @override
  Widget build(BuildContext context) {
    final levelsData = hardwareComponents[route];
    final totalLevels = levelsData?.length ?? 0;
    const accent = Color(0xFF1A6CF6);

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // drag handle
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.white24,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: (isUnlocked ? accent : Colors.white24).withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10),
                ),
                alignment: Alignment.center,
                child: Icon(
                  isUnlocked ? Icons.memory : Icons.lock_outline,
                  color: isUnlocked ? accent : Colors.white38,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: TextStyle(
                        color: isUnlocked ? Colors.white : Colors.white70,
                        fontWeight: FontWeight.w600,
                        fontSize: 17,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      isUnlocked ? '$totalLevels niveles' : 'Bloqueado',
                      style: TextStyle(
                        color: isUnlocked ? Colors.white54 : Colors.orangeAccent,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: isUnlocked ? accent : Colors.white12,
                foregroundColor: isUnlocked ? Colors.white : Colors.white38,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: isUnlocked ? null : 0,
              ),
              onPressed: () async {
                if (!isUnlocked) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Completá el componente anterior para desbloquear este.',
                      ),
                    ),
                  );
                  return;
                }
                if (levelsData == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('No existe data para $route')),
                  );
                  return;
                }
                final navigator = Navigator.of(context);
                navigator.pop(); // cierra el bottom sheet
                await navigator.push(
                  MaterialPageRoute(
                    builder: (_) => StationScreens(
                      title: name,
                      levelsData: levelsData,
                      levels: levelsData.length,
                      componentKey: route,
                    ),
                  ),
                );
                await onReturn();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (!isUnlocked) ...[
                    const Icon(Icons.lock_outline, size: 18),
                    const SizedBox(width: 8),
                  ],
                  Text(
                    isUnlocked ? 'Ver lecciones' : 'Bloqueado',
                    style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Placeholder (shown if image asset is missing) ────────────────────────────

class _PlaceholderMap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF0D1117),
      child: const Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.developer_board, color: Colors.white24, size: 64),
            SizedBox(height: 12),
            Text(
              'Agrega la imagen del mapa\nen assets/imagenes/components_map.jpeg',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white38, fontSize: 13),
            ),
          ],
        ),
      ),
    );
  }
}