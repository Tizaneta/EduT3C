import 'package:flutter/material.dart';
import 'LevelScreen.dart';

class StationScreens extends StatefulWidget {
  final Map<int, List<Map<String, dynamic>>> levelsData;
  final String title;
  final int levels;
  final int componentNumber;
  final String description;
  final String imagePath;

  const StationScreens({
    super.key,
    required this.levelsData,
    required this.title,
    required this.levels,
    this.componentNumber = 1,
    this.description = '',
    this.imagePath = '',
  });

  @override
  State<StationScreens> createState() => _StationScreensState();
}

class _StationScreensState extends State<StationScreens> {
  int? _selectedLevel;

  void _goToLevel(int levelNumber) {
    final data = widget.levelsData[levelNumber];
    if (data == null) return;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LevelScreen(
          levelNumber: levelNumber,
          contenido: data,
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
          children: [
            // ── Contenido scrolleable ──────────────────────────────────────
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Botón volver
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(Icons.arrow_back_ios_new,
                          color: Colors.white70, size: 20),
                    ),
                    const SizedBox(height: 16),

                    // ── Número + Título ───────────────────────────────────
                    Row(
                      children: [
                        Container(
                          width: 36,
                          height: 36,
                          decoration: const BoxDecoration(
                            color: Color(0xFF4F7FFF),
                            shape: BoxShape.circle,
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            '${widget.componentNumber}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            widget.title,
                            style: const TextStyle(
                              color: Color(0xFF4F7FFF),
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // ── Imagen del componente ─────────────────────────────
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Container(
                        width: double.infinity,
                        height: 200,
                        color: const Color(0xFF131929),
                        child: widget.imagePath.isNotEmpty
                            ? Image.asset(
                          widget.imagePath,
                          fit: BoxFit.contain,
                          errorBuilder: (_, __, ___) =>
                              _PlaceholderIcon(title: widget.title),
                        )
                            : _PlaceholderIcon(title: widget.title),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // ── Descripción ───────────────────────────────────────
                    if (widget.description.isNotEmpty) ...[
                      Text(
                        widget.description,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                          height: 1.6,
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],

                    // ── Lista de niveles ──────────────────────────────────
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFF131929),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                            color: Colors.white.withOpacity(0.07)),
                      ),
                      child: Column(
                        children: List.generate(widget.levels, (index) {
                          final lvl = index + 1;
                          final isLast = lvl == widget.levels;
                          return Column(
                            children: [
                              InkWell(
                                onTap: () =>
                                    setState(() => _selectedLevel = lvl),
                                borderRadius: BorderRadius.circular(16),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 14),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          'Nivel $lvl',
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: 22,
                                        height: 22,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: _selectedLevel == lvl
                                                ? const Color(0xFF4F7FFF)
                                                : Colors.white38,
                                            width: 2,
                                          ),
                                        ),
                                        child: _selectedLevel == lvl
                                            ? Center(
                                          child: Container(
                                            width: 10,
                                            height: 10,
                                            decoration: const BoxDecoration(
                                              color: Color(0xFF4F7FFF),
                                              shape: BoxShape.circle,
                                            ),
                                          ),
                                        )
                                            : null,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              if (!isLast)
                                Divider(
                                  height: 1,
                                  color: Colors.white.withOpacity(0.07),
                                  indent: 16,
                                  endIndent: 16,
                                ),
                            ],
                          );
                        }),
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),

            // ── Botón fijo abajo ───────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
              child: SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4F7FFF),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    elevation: 0,
                  ),
                  onPressed: _selectedLevel != null
                      ? () => _goToLevel(_selectedLevel!)
                      : null,
                  child: Text(
                    _selectedLevel != null
                        ? 'Ir al Nivel $_selectedLevel'
                        : 'Seleccioná un nivel',
                    style: const TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Ícono placeholder si no hay imagen ───────────────────────────────────────

class _PlaceholderIcon extends StatelessWidget {
  final String title;
  const _PlaceholderIcon({required this.title});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.developer_board,
              color: Color(0xFF4F7FFF), size: 64),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(color: Colors.white38, fontSize: 13),
          ),
        ],
      ),
    );
  }
}