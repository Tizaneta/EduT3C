import 'package:flutter/material.dart';
import 'LevelScreen.dart';
import '../models/level_local.dart';

class StationScreens extends StatelessWidget {
  final Map<int, LocalLevel> levelsData;
  final String title;
  final int levels;

  const StationScreens({
    super.key,
    required this.levelsData,
    required this.title,
    required this.levels,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,

      appBar: AppBar(
        title: Text(
          title,
          style: const TextStyle(
            color: Colors.cyan,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.cyan,
        ),
      ),

      body: Stack(
        children: [

          // Fondo
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  'assets/imagenes/FondoHard.jpg',
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Oscurecimiento
          Container(
            color: Colors.black.withOpacity(0.4),
          ),

          SafeArea(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 15,
              ),
              itemCount: levels,
              itemBuilder: (context, index) {

                final currentLevel = index + 1;

                final level = levelsData[currentLevel];

                if (level == null) {
                  return const SizedBox.shrink();
                }

                return Padding(
                  padding: const EdgeInsets.only(
                    bottom: 20,
                  ),

                  child: ElevatedButton(
                    onPressed: () async {

                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LevelScreen(
                            backendLevelId: level.backendId,
                            levelNumber: currentLevel,
                            contenido: level.contenido,
                          ),
                        ),
                      );
                    },

                    child: Container(
                      width: double.infinity,

                      padding: const EdgeInsets.symmetric(
                        vertical: 18,
                        horizontal: 16,
                      ),

                      decoration: BoxDecoration(
                        color: const Color(0xFF09101A)
                            .withOpacity(0.85),

                        borderRadius:
                            BorderRadius.circular(12),

                        border: Border.all(
                          color: Colors.cyan.withOpacity(0.6),
                          width: 2,
                        ),

                        boxShadow: [
                          BoxShadow(
                            color: Colors.cyan.withOpacity(0.15),
                            blurRadius: 8,
                            spreadRadius: 1,
                          ),
                        ],
                      ),

                      child: Row(
                        children: [

                          Container(
                            padding:
                                const EdgeInsets.all(8),

                            decoration: BoxDecoration(
                              color: Colors.cyan
                                  .withOpacity(0.1),

                              borderRadius:
                                  BorderRadius.circular(6),

                              border: Border.all(
                                color: Colors.cyan
                                    .withOpacity(0.4),
                              ),
                            ),

                            constraints:
                                const BoxConstraints(
                              minWidth: 40,
                              minHeight: 40,
                            ),

                            alignment: Alignment.center,

                            child: Text(
                              "$currentLevel",

                              style: const TextStyle(
                                color: Colors.cyan,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ),

                          const SizedBox(width: 20),

                          Expanded(
                            child: Text(
                              "Nivel $currentLevel",

                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.8,
                              ),
                            ),
                          ),

                          Icon(
                            Icons.arrow_forward_ios,
                            size: 16,
                            color: Colors.cyan.withOpacity(0.7),
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