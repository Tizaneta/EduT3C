import 'package:edut3c/screens/HardwareScreen.dart';
import 'package:flutter/material.dart';

// ─── Data ────────────────────────────────────────────────────────────────────

const List<Map<String, dynamic>> _components = [
  {'id': 1, 'label': 'Fuente de Alimentación', 'route': 'psu'},
  {'id': 2, 'label': 'Disco Duro / SSD',        'route': 'storage'},
  {'id': 3, 'label': 'Memoria RAM',              'route': 'ram'},
  {'id': 4, 'label': 'Tarjeta de Red / Wi-Fi',  'route': 'network'},
  {'id': 5, 'label': 'Microprocesador (CPU)',    'route': 'cpu'},
  {'id': 6, 'label': 'Módulo RAM',               'route': 'ram_module'},
  {'id': 7, 'label': 'Cooler / Ventilador CPU',  'route': 'cooler'},
  {'id': 8, 'label': 'Tarjeta Gráfica (GPU)',    'route': 'gpu'},
  {'id': 9, 'label': 'Almacenamiento M.2',       'route': 'm2'},
];

// Positions as fractions of the image size (left%, top%)
// Adjust these to match your actual image asset coordinates.
const List<Map<String, double>> _positions = [
  {'l': 0.76, 't': 0.30}, // 1 – PSU
  {'l': 0.68, 't': 0.52}, // 2 – HDD/SSD
  {'l': 0.44, 't': 0.50}, // 3 – RAM stick
  {'l': 0.10, 't': 0.48}, // 4 – Network card
  {'l': 0.46, 't': 0.30}, // 5 – CPU
  {'l': 0.08, 't': 0.30}, // 6 – RAM module
  {'l': 0.14, 't': 0.40}, // 7 – Cooler
  {'l': 0.30, 't': 0.60}, // 8 – GPU
  {'l': 0.56, 't': 0.46}, // 9 – M.2
];

// ─── Screen ──────────────────────────────────────────────────────────────────

class HardwareMapScreen extends StatelessWidget {
  const HardwareMapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D1117),
      appBar: _buildAppBar(context),
      body: Column(
        children: [
          _HintBanner(),
          Expanded(child: _MapArea()),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFF0D1117),
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.menu, color: Colors.white),
        onPressed: () {},
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
        IconButton(
          icon: const Icon(Icons.info_outline, color: Colors.white),
          onPressed: () {},
        ),
      ],
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

class _MapArea extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final w = constraints.maxWidth;
        final h = constraints.maxHeight;

        return Stack(
          children: [
            // ── Background image ──────────────────────────────────────────
            Positioned.fill(
              child: Image.asset(
                'assets/images/components_map.png', // <-- put your image here
                fit: BoxFit.contain,
                alignment: Alignment.center,
                // If you don't have the asset yet, use a placeholder:
                errorBuilder: (_, __, ___) => _PlaceholderMap(),
              ),
            ),

            // ── Numbered hotspots ────────────────────────────────────────
            for (int i = 0; i < _components.length; i++)
              _buildHotspot(context, i, w, h),
          ],
        );
      },
    );
  }

  Widget _buildHotspot(
      BuildContext context, int index, double w, double h) {
    final pos  = _positions[index];
    final comp = _components[index];
    const double dot = 28;

    return Positioned(
      left: w * pos['l']! - dot / 2,
      top:  h * pos['t']! - dot / 2,
      child: GestureDetector(
        onTap: () => _showComponentSheet(context, comp),
        child: _NumberBadge(number: comp['id'] as int),
      ),
    );
  }

  void _showComponentSheet(
      BuildContext context, Map<String, dynamic> comp) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF161B22),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => _ComponentSheet(component: comp),
    );
  }
}

// ─── Number badge ─────────────────────────────────────────────────────────────

class _NumberBadge extends StatelessWidget {
  final int number;
  const _NumberBadge({required this.number});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 28,
      height: 28,
      decoration: BoxDecoration(
        color: const Color(0xFF1A6CF6),
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF1A6CF6).withOpacity(0.6),
            blurRadius: 8,
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
    );
  }
}

// ─── Bottom sheet ─────────────────────────────────────────────────────────────

class _ComponentSheet extends StatelessWidget {
  final Map<String, dynamic> component;
  const _ComponentSheet({required this.component});

  @override
  Widget build(BuildContext context) {
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
                  color: const Color(0xFF1A6CF6).withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10),
                ),
                alignment: Alignment.center,
                child: Text(
                  '${component['id']}',
                  style: const TextStyle(
                    color: Color(0xFF1A6CF6),
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Text(
                  component['label'] as String,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 17,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1A6CF6),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                Navigator.push(context,
                MaterialPageRoute(builder: (context) => HardwareScreen()));
                // Navigator.push(context, MaterialPageRoute(...));
              },
              child: const Text(
                'Ver lecciones',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
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
              'Agrega la imagen del mapa\nen assets/images/components_map.png',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white38, fontSize: 13),
            ),
          ],
        ),
      ),
    );
  }
}
