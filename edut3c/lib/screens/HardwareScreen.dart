import 'package:flutter/material.dart';
import 'StationScreens.dart';
import '../data/HardwareData.dart';

// ─── Datos de componentes ─────────────────────────────────────────────────────

class _ComponentData {
  final int id;
  final String title;
  final String description;
  final String imagePath;
  final int levels;
  final Map<int, List<Map<String, dynamic>>> levelsData;
  final double l; // fracción horizontal sobre la imagen
  final double t; // fracción vertical sobre la imagen

  const _ComponentData({
    required this.id,
    required this.title,
    required this.description,
    required this.imagePath,
    required this.levels,
    required this.levelsData,
    required this.l,
    required this.t,
  });
}

final List<_ComponentData> _components = [
  _ComponentData(
    id: 1, title: 'Fuente de Alimentación (PSU)',
    description: 'Suministra energía eléctrica a todos los componentes del sistema. Convierte la corriente alterna (AC) en corriente continua (DC).',
    imagePath: 'assets/images/psu.png',
    levels: 3, levelsData: const {},
    l: 0.90, t: 0.50,
  ),
  _ComponentData(
    id: 2, title: 'Disco Duro (HDD)',
    description: 'Almacena permanentemente el sistema operativo, programas y archivos usando platos magnéticos giratorios.',
    imagePath: 'assets/images/hdd.png',
    levels: 3, levelsData: ssdhddLevels,
    l: 0.72, t: 0.72,
  ),
  _ComponentData(
    id: 3, title: 'SSD 2.5"',
    description: 'Disco de estado sólido SATA. Sin partes móviles, más rápido y silencioso que el HDD tradicional.',
    imagePath: 'assets/images/ssd.png',
    levels: 3, levelsData: ssdhddLevels,
    l: 0.44, t: 0.58,
  ),
  _ComponentData(
    id: 4, title: 'Microprocesador (CPU)',
    description: 'El cerebro del sistema. Ejecuta instrucciones y coordina el funcionamiento de todos los componentes.',
    imagePath: 'assets/images/cpu.png',
    levels: 7, levelsData: cpuLevels,
    l: 0.20, t: 0.62,
  ),
  _ComponentData(
    id: 5, title: 'Placa Base (Motherboard)',
    description: 'Circuito principal que conecta e interconecta todos los componentes: CPU, RAM, GPU, almacenamiento y más.',
    imagePath: 'assets/images/motherboard.png',
    levels: 3, levelsData: const {},
    l: 0.47, t: 0.36,
  ),
  _ComponentData(
    id: 6, title: 'Memoria RAM',
    description: 'Almacena temporalmente los datos de los programas en ejecución. Más RAM permite correr más aplicaciones a la vez.',
    imagePath: 'assets/images/ram.png',
    levels: 3, levelsData: const {},
    l: 0.10, t: 0.40,
  ),
  _ComponentData(
    id: 7, title: 'Cooler CPU',
    description: 'Sistema de refrigeración del procesador. Disipa el calor generado durante la operación para evitar daños.',
    imagePath: 'assets/images/cooler.png',
    levels: 3, levelsData: const {},
    l: 0.05, t: 0.50,
  ),
  _ComponentData(
    id: 8, title: 'Tarjeta Gráfica (GPU)',
    description: 'Procesa y renderiza imágenes, videos y gráficos 3D. Esencial para gaming, diseño e inteligencia artificial.',
    imagePath: 'assets/images/gpu.png',
    levels: 5, levelsData: gpuLevels,
    l: 0.42, t: 0.78,
  ),
  _ComponentData(
    id: 9, title: 'Almacenamiento M.2 NVMe',
    description: 'SSD en formato M.2 que se conecta directamente a la placa base vía PCIe. Velocidades varias veces superiores al SATA.',
    imagePath: 'assets/images/m2.png',
    levels: 3, levelsData: const {},
    l: 0.50, t: 0.53,
  ),
];

// ─── Pantalla principal ───────────────────────────────────────────────────────

class HardwareScreen extends StatelessWidget {
  const HardwareScreen({super.key});

  void _openComponent(BuildContext context, _ComponentData comp) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => StationScreens(
          title: comp.title,
          levels: comp.levels,
          levelsData: comp.levelsData,
          componentNumber: comp.id,
          description: comp.description,
          imagePath: comp.imagePath,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0E1A),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Header ─────────────────────────────────────────────────────
            const Padding(
              padding: EdgeInsets.fromLTRB(20, 16, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Hardware',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          letterSpacing: -0.5)),
                  SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(Icons.touch_app_outlined,
                          color: Colors.white38, size: 15),
                      SizedBox(width: 6),
                      Text('Tocá un componente para aprender',
                          style:
                          TextStyle(color: Colors.white38, fontSize: 13)),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            // ── Mapa interactivo ───────────────────────────────────────────
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      final w = constraints.maxWidth;
                      final h = constraints.maxHeight;
                      return Stack(
                        children: [
                          // Imagen de fondo
                          Positioned.fill(
                            child: Image.asset(
                              'assets/images/hardwaremap.png',
                              fit: BoxFit.contain,
                              alignment: Alignment.center,
                              errorBuilder: (_, __, ___) =>
                              const _PlaceholderMap(),
                            ),
                          ),
                          // Overlay oscuro sutil para que los badges resalten
                          Positioned.fill(
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Colors.black.withOpacity(0.15),
                                    Colors.black.withOpacity(0.05),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          // Badges numerados
                          for (final comp in _components)
                            Positioned(
                              left: w * comp.l - 15,
                              top: h * comp.t - 15,
                              child: _Badge(
                                number: comp.id,
                                onTap: () => _openComponent(context, comp),
                              ),
                            ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

// ─── Badge numerado ───────────────────────────────────────────────────────────

class _Badge extends StatelessWidget {
  final int number;
  final VoidCallback onTap;
  const _Badge({required this.number, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: const Color(0xFF1A6CF6),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF1A6CF6).withOpacity(0.7),
              blurRadius: 10,
              spreadRadius: 1,
            ),
          ],
        ),
        alignment: Alignment.center,
        child: Text(
          '$number',
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 13,
          ),
        ),
      ),
    );
  }
}

// ─── Placeholder si no hay imagen ─────────────────────────────────────────────

class _PlaceholderMap extends StatelessWidget {
  const _PlaceholderMap();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF0D1B2A),
      child: const Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.developer_board, color: Color(0xFF4F7FFF), size: 64),
            SizedBox(height: 12),
            Text(
              'Agregá la imagen en\nassets/images/Hardwaremap.png',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white38, fontSize: 13),
            ),
          ],
        ),
      ),
    );
  }
}