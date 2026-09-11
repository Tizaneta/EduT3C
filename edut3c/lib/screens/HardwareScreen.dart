import 'package:flutter/material.dart';
import 'StationScreens.dart';
import '../data/HardwareData.dart';
import '../data/session.dart';
import '../models/level_local.dart';
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
  @override
  void initState() {
    super.initState();
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
      child: _MapArea(),
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
  const _MapArea();

  @override
  State<_MapArea> createState() => _MapAreaState();
}

class _MapAreaState extends State<_MapArea> {
  static const String _assetPath =
      'assets/imagenes/components_map.jpeg';

  Size? _imageSize;
  bool _imageError = false;
  ImageStream? _imageStream;
  late final ImageStreamListener _imageListener;

  @override
  void initState() {
    super.initState();

    _imageListener = ImageStreamListener(
      _onImageLoaded,
      onError: _onImageError,
    );

    _resolveImageSize();
  }

  void _resolveImageSize() {
    final stream = const AssetImage(_assetPath)
        .resolve(const ImageConfiguration());

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

    setState(() {
      _imageError = true;
    });
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

        if (_imageError) {
          return _PlaceholderMap();
        }

        if (_imageSize == null) {
          return const Center(
            child: CircularProgressIndicator(
              color: Color(0xFF1A6CF6),
            ),
          );
        }

        final imageAspect =
            _imageSize!.width / _imageSize!.height;

        final containerAspect =
            containerW / containerH;

        double renderW;
        double renderH;
        double offsetX;
        double offsetY;

        if (containerAspect > imageAspect) {
          renderH = containerH;
          renderW = renderH * imageAspect;
          offsetX = (containerW - renderW) / 2;
          offsetY = 0;
        } else {
          renderW = containerW;
          renderH = renderW / imageAspect;
          offsetX = 0;
          offsetY = (containerH - renderH) / 2;
        }

        return Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                _assetPath,
                fit: BoxFit.contain,
                alignment: Alignment.center,
                errorBuilder: (_, __, ___) =>
                    _PlaceholderMap(),
              ),
            ),

            for (final hotspot in _hotspots)
              _buildHotspot(
                context,
                hotspot,
                renderW,
                renderH,
                offsetX,
                offsetY,
              ),
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

    const double ringSize = 36;

    final left =
        offsetX + renderW * hotspot.l - ringSize / 2;

    final top =
        offsetY + renderH * hotspot.t - ringSize / 2;

    return Positioned(
      left: left,
      top: top,
      child: GestureDetector(
        onTap: () => _showComponentSheet(
          context,
          route,
          name,
        ),
        child: const _HotspotMarker(),
      ),
    );
  }

  void _showComponentSheet(
    BuildContext context,
    String route,
    String name,
  ) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF161B22),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      builder: (_) => _ComponentSheet(
        route: route,
        name: name,
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
  final double size;

  const _HotspotMarker({
    this.size = 36,
  });

  @override
  Widget build(BuildContext context) {
    const accent = Color(0xFF1A6CF6);

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: accent.withOpacity(0.85),
          width: 2,
        ),
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

  const _ComponentSheet({
    required this.route,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    final levelsData = hardwareComponents[route];
    final totalLevels = levelsData?.length ?? 0;

    const accent = Color(0xFF1A6CF6);

    return Padding(
      padding: const EdgeInsets.fromLTRB(
        20,
        16,
        20,
        32,
      ),
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

          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: accent.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10),
                ),
                alignment: Alignment.center,
                child: const Icon(
                  Icons.memory,
                  color: accent,
                ),
              ),

              const SizedBox(width: 14),

              Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 17,
                      ),
                    ),

                    const SizedBox(height: 2),

                    Text(
                      '$totalLevels niveles',
                      style: const TextStyle(
                        color: Colors.white54,
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
                backgroundColor: accent,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  vertical: 14,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                if (levelsData == null) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(
                    SnackBar(
                      content: Text(
                        'No existe data para $route',
                      ),
                    ),
                  );
                  return;
                }

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => StationScreens(
                      title: name,
                      levelsData: levelsData,
                      levels: levelsData.length,
                    ),
                  ),
                );
              },
              child: const Text(
                'Ver lecciones',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
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