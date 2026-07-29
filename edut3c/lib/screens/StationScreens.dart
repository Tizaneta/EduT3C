import 'package:flutter/material.dart';
import 'LevelScreen.dart';
import '../services/progress_service.dart';
import '../models/level_local.dart';
import '../models/level.dart';

class StationScreens extends StatefulWidget {
  final Map<int, LocalLevel> levelsData;
  final String title;
  final int levels;
  // Identificador del componente (ej: "cpu", "gpu", "storage" — las mismas
  // keys que en data/HardwareData.dart). Si es null, esta pantalla se
  // comporta exactamente como antes: todos los niveles quedan siempre
  // desbloqueados. Esto es así para no romper NetScreen ni SoftwareScreen,
  // que reutilizan esta misma pantalla sin sistema de bloqueo (todavía).
  final String? componentKey;

  const StationScreens({
    super.key,
    required this.levelsData,
    required this.title,
    required this.levels,
    this.componentKey,
  });

  @override
  State<StationScreens> createState() => _StationScreensState();
}

class _StationScreensState extends State<StationScreens> {
  int _maxCompletedLevel = 0;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadProgress();
  }

  Future<void> _loadProgress() async {
    if (widget.componentKey == null) {
      // Sin componentKey no hay sistema de bloqueo: todo desbloqueado,
      // igual que el comportamiento original de esta pantalla.
      if (!mounted) return;
      setState(() => _loading = false);
      return;
    }
    final max =
    await ProgressService.getMaxCompletedLevel(widget.componentKey!);
    if (!mounted) return;
    setState(() {
      _maxCompletedLevel = max;
      _loading = false;
    });
  }

  bool _isLocked(int level) {
    if (widget.componentKey == null) return false;
    return level > _maxCompletedLevel + 1;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 1. Extendemos el cuerpo detrás del AppBar para que el fondo ocupe el 100% de la pantalla
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          widget.title,
          style: const TextStyle(
            color: Colors.cyan,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
          ),
        ),
        backgroundColor: Colors.transparent, // Barra transparente
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.cyan), // Flecha de retorno cyber
      ),
      body: Stack(
        children: [
          // 2. FONDO TECNOLÓGICO (Misma imagen de la pantalla de niveles)
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/imagenes/FondoHard.jpg'), // Asegúrate de tener la ruta correcta en tu pubspec.yaml
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Capa de oscurecimiento para garantizar la lectura correcta de los textos
          Container(color: Colors.black.withOpacity(0.4)),

          // 3. LISTA DE NIVELES FUTURISTAS
          SafeArea(
            child: _loading
                ? const Center(
              child: CircularProgressIndicator(color: Colors.cyan),
            )
                : ListView.builder(
              padding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              itemCount: widget.levels,
              itemBuilder: (context, index) {
                // El index arranca en 0, los niveles en tu base de datos en 1
                final currentLevel = index + 1;
                final locked = _isLocked(currentLevel);

                return Padding(
                  padding: const EdgeInsets.only(bottom: 20), // Separación entre niveles
                  child: ElevatedButton(
                    onPressed: locked
                        ? () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Completá el nivel anterior para desbloquear este.',
                          ),
                        ),
                      );
                    }
                        : () async {
                      final level = widget.levelsData[currentLevel]!;
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LevelScreen(
                            backendLevelId: level.backendId,
                            levelNumber: currentLevel,
                            contenido: level.contenido,
                            componentKey: widget.componentKey,
                          ),
                        ),
                      );
                      // Al volver del nivel, recargamos el progreso
                      // por si se acaba de desbloquear el siguiente.
                      await _loadProgress();
                    },

                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
                      decoration: BoxDecoration(
                        // Fondo oscuro semitransparente (más apagado si está bloqueado)
                        color: locked
                            ? const Color(0xFF09101A).withOpacity(0.5)
                            : const Color(0xFF09101A).withOpacity(0.85),
                        borderRadius: BorderRadius.circular(12),
                        // Borde de neón cyan brillante (gris si está bloqueado)
                        border: Border.all(
                          color: locked
                              ? Colors.white24
                              : Colors.cyan.withOpacity(0.6),
                          width: 2,
                        ),
                        // Sombra para el efecto de resplandor neón (sin sombra si está bloqueado)
                        boxShadow: locked
                            ? []
                            : [
                          BoxShadow(
                            color: Colors.cyan.withOpacity(0.15),
                            blurRadius: 8,
                            spreadRadius: 1,
                          )
                        ],
                      ),
                      child: Row(
                        children: [
                          // Indicador numérico de nivel estilizado como casilla interna
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: locked
                                  ? Colors.white10
                                  : Colors.cyan.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(
                                color: locked
                                    ? Colors.white24
                                    : Colors.cyan.withOpacity(0.4),
                              ),
                            ),
                            constraints: const BoxConstraints(minWidth: 40, minHeight: 40),
                            alignment: Alignment.center,
                            child: locked
                                ? const Icon(
                              Icons.lock_outline,
                              color: Colors.white38,
                              size: 20,
                            )
                                : Text(
                              "$currentLevel",
                              style: const TextStyle(
                                color: Colors.cyan,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ),
                          const SizedBox(width: 20),

                          // Texto descriptivo del botón
                          Expanded(
                            child: Text(
                              "Nivel $currentLevel",
                              style: TextStyle(
                                color: locked ? Colors.white38 : Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.8,
                              ),
                            ),
                          ),

                          // Icono decorativo (candado si está bloqueado, flecha si no)
                          Icon(
                            locked ? Icons.lock_outline : Icons.arrow_forward_ios,
                            size: locked ? 18 : 16,
                            color: locked
                                ? Colors.white24
                                : Colors.cyan.withOpacity(0.7),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}