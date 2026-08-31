import 'dart:async';
import 'package:flutter/material.dart';
import '../widgets/video_block.dart';
import '../widgets/nobackscroll.dart';
import '../services/level_service.dart';
import '../data/session.dart';

class LevelScreen extends StatefulWidget {
  final int backendLevelId;
  final int levelNumber;
  final List<Map<String, dynamic>> contenido;

  // Identificador del componente al que pertenece este nivel (ej: "cpu").
  // Si es null, el nivel se completa igual (se muestra el diálogo de
  // "Nivel completado") pero no se guarda progreso en ningún lado —
  // es el caso de NetScreen/SoftwareScreen, que todavía no usan este sistema.

  const LevelScreen({
    super.key,
    required this.backendLevelId,
    required this.levelNumber,
    required this.contenido,
  });

  @override
  State<LevelScreen> createState() => _LevelScreenState();
}

class _LevelScreenState extends State<LevelScreen> {
  Timer? timer;
  int timeLeft = 7;
  final PageController pageController = PageController();
  bool canScroll = false;
  bool quizAnswered = false;
  int currentPage = 0;

  void startTimer() {
    timer?.cancel();
    timeLeft = 7;
    timer = Timer.periodic(
      const Duration(seconds: 1),
          (timer) {
        setState(() {
          timeLeft--;
          if (timeLeft <= 0) {
            timer.cancel();
            timeLeft = 7;
            canScroll = true;
            quizAnswered = true;
            showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) {
                  return PopScope(
                    canPop: false,
                    child: AlertDialog(
                      backgroundColor: const Color(0xFF0D1B2A),
                      title: const Text("You've run out of time partner!", style: TextStyle(color: Colors.white)),
                      content: Text(
                        "The correct answer was just like ${widget.contenido[currentPage]["correctAnswer"]}",
                        style: const TextStyle(color: Colors.grey),
                      ),
                      actions: [
                        ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.cyan),
                          onPressed: () {
                            Navigator.pop(context);
                            if (currentPage == widget.contenido.length - 1) {
                              finishLevel();
                            }
                          },
                          label: const Text("Holy shii", style: TextStyle(color: Colors.black)),
                        )
                      ],
                    ),
                  );
                }
            );
          }
        });
      },
    );
  }

  Future<void> finishLevel() async {
    final result = await LevelService.completeLevel(
    levelId: widget.backendLevelId,
  );
    if (!mounted) return;
    print(result);
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return PopScope(
          canPop: false,
          child: AlertDialog(
            backgroundColor: const Color(0xFF0D1B2A),
            title: const Text("¡Nivel completado!", style: TextStyle(color: Colors.cyan, fontWeight: FontWeight.bold)),
            content: Text("Ganaste ${result["xp_gained"]} XP\n Ganaste ${result["bits_gained"]} Bits", 
            style: TextStyle(color: Colors.white)),
            actions: [
              ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.cyan),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Volver", style: TextStyle(color: Colors.black))
              )
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Hacemos el AppBar transparente para que no corte el fondo tecnológico
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
            "Nivel ${widget.levelNumber}",
            style: const TextStyle(color: Colors.cyan, fontWeight: FontWeight.bold, letterSpacing: 1.5)
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.cyan),
      ),
      body: PageView.builder(
        onPageChanged: (index) {
          pageController.jumpToPage(index);
          setState(() {
            currentPage = index;
            canScroll = false;
            quizAnswered = false;
            final newType = widget.contenido[index]["type"];

            if (newType == "quiz") {
              startTimer();
            } else {
              timer?.cancel();
            }
          });
        },
        controller: pageController,
        physics: canScroll
            ? const NoBackScrollPhysics()
            : const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemCount: widget.contenido.length,
        itemBuilder: (context, index) {
          if (widget.contenido[index]["type"] == "video") {
            return VideoBlock(
              assetPath: widget.contenido[index]["path"],
              onVideoFinished: () {
                setState(() {
                  canScroll = true;
                });
              },
            );
          } else {
            // Lista de letras para las opciones (A, B, C, D...)
            List<String> letters = ["A", "B", "C", "D", "E"];

            return Stack(
              children: [
                // 1. FONDO TECNOLÓGICO USANDO TU IMAGEN
                Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/imagenes/FondoHard.jpg'), // Asegúrate de que esta ruta coincida en tu pubspec.yaml
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                // Capa oscura sutil encima del fondo para mejorar contraste de textos
                Container(color: Colors.black.withOpacity(0.3)),

                // 2. CONTENIDO DE LA PREGUNTA
                SafeArea(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Timer circular futurista
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              SizedBox(
                                width: 70,
                                height: 70,
                                child: CircularProgressIndicator(
                                  value: timeLeft / 7,
                                  strokeWidth: 6,
                                  backgroundColor: Colors.white10,
                                  color: timeLeft <= 3 ? Colors.redAccent : Colors.cyan,
                                ),
                              ),
                              Text(
                                "$timeLeft",
                                style: TextStyle(
                                    fontSize: 26,
                                    fontWeight: FontWeight.bold,
                                    color: timeLeft <= 3 ? Colors.redAccent : Colors.white
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 40),

                          // Tarjeta contenedora de la pregunta
                          Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(color: Colors.cyan.withOpacity(0.3), width: 1.5),
                            ),
                            child: Text(
                              widget.contenido[index]["question"],
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          const SizedBox(height: 40),

                          // 3. OPCIONES ESTILO BOTÓN TECNOLÓGICO (A, B, C, D)
                          ...widget.contenido[index]["options"].asMap().entries.map((entry) {
                            int optIndex = entry.key;
                            String option = entry.value;
                            String letter = optIndex < letters.length ? letters[optIndex] : "?";

                            return Padding(
                              padding: const EdgeInsets.only(bottom: 16.0),
                              child: InkWell(
                                onTap: quizAnswered
                                    ? null
                                    : () {
                                  setState(() {
                                    quizAnswered = true;
                                    timer?.cancel();
                                    timeLeft = 7;
                                    canScroll = true;
                                  });
                                  final correctAnswer = widget.contenido[index]["correctAnswer"];

                                  _showResultDialog(option == correctAnswer, correctAnswer);
                                },
                                child: Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                                  decoration: BoxDecoration(
                                    // Fondo oscuro semitransparente como la imagen B/C/D
                                    color: const Color(0xFF09101A).withOpacity(0.85),
                                    borderRadius: BorderRadius.circular(12),
                                    // Borde con brillo neón azul/cyan
                                    border: Border.all(
                                        color: Colors.cyan.withOpacity(0.6),
                                        width: 2
                                    ),
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
                                      // Indicador de la Letra (A, B, C...) simulando el recuadro interno
                                      Container(
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          color: Colors.cyan.withOpacity(0.1),
                                          borderRadius: BorderRadius.circular(6),
                                          border: Border.all(color: Colors.cyan.withOpacity(0.4)),
                                        ),
                                        constraints: const BoxConstraints(minWidth: 35, minHeight: 35),
                                        alignment: Alignment.center,
                                        child: Text(
                                          letter,
                                          style: const TextStyle(
                                              color: Colors.cyan,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 16),
                                      // Texto de la opción
                                      Expanded(
                                        child: Text(
                                          option,
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }

  // Refactorizado para limpiar código del builder principal
  void _showResultDialog(bool isCorrect, String correctAnswer) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return PopScope(
          canPop: false,
          child: AlertDialog(
            backgroundColor: const Color(0xFF0D1B2A),
            title: Text(
                isCorrect ? "¡Correcto!" : "¡Incorrecto!",
                style: TextStyle(color: isCorrect ? Colors.greenAccent : Colors.redAccent, fontWeight: FontWeight.bold)
            ),
            content: Text(
              isCorrect ? "¡Lo has hecho genial!" : "¡Estuviste bastante cerca, hay que seguir practicando!",
              style: const TextStyle(color: Colors.white),
            ),
            actions: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: isCorrect ? Colors.greenAccent : Colors.redAccent),
                onPressed: () {
                  quizAnswered = true;
                  Navigator.pop(context);
                  if (currentPage == widget.contenido.length - 1) {
                    finishLevel();
                  }
                },
                child: Text(isCorrect ? "Aceptar" : "Aceptar", style: const TextStyle(color: Colors.black)),
              )
            ],
          ),
        );
      },
    );
  }
}