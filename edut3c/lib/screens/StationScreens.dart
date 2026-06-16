import 'package:flutter/material.dart';
import 'LevelScreen.dart';

class StationScreens extends StatelessWidget {
  final Map<int, List<Map<String, dynamic>>> levelsData;
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
      // 1. Extendemos el cuerpo detrás del AppBar para que el fondo ocupe el 100% de la pantalla
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
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              itemCount: levels,
              itemBuilder: (context, index) {
                // El index arranca en 0, los niveles en tu base de datos en 1
                final currentLevel = index + 1; 

                return Padding(
                  padding: const EdgeInsets.only(bottom: 20), // Separación entre niveles
                  child: ElevatedButton(
                    // Mantenemos intacto el comportamiento original de navegación
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LevelScreen(
                            levelNumber: currentLevel,
                            contenido: levelsData[currentLevel]!,
                          ),
                        ),
                      );
                    },
                    
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
                      decoration: BoxDecoration(
                        // Fondo oscuro semitransparente
                        color: const Color(0xFF09101A).withOpacity(0.85),
                        borderRadius: BorderRadius.circular(12),
                        // Borde de neón cyan brillante
                        border: Border.all(
                          color: Colors.cyan.withOpacity(0.6),
                          width: 2,
                        ),
                        // Sombra para el efecto de resplandor neón
                        boxShadow: [
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
                              color: Colors.cyan.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(color: Colors.cyan.withOpacity(0.4)),
                            ),
                            constraints: const BoxConstraints(minWidth: 40, minHeight: 40),
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
                          
                          // Texto descriptivo del botón
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

                          // Icono decorativo de flecha tecnológica hacia adelante
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