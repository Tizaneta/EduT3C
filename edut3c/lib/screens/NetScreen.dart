import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'StationScreens.dart';
import '../data/NetData.dart';

class NetScreen extends StatefulWidget {
  @override
  State<NetScreen> createState() => _NetScreenState();
}

class _NetScreenState extends State<NetScreen> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/videos/net.mp4')
      ..initialize().then((_) {
        _controller.setLooping(true);
        _controller.setVolume(0);
        _controller.play();
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(title: Text("Redes")),
      body: Stack(
        children: [
          // Fondo: video en loop
          Positioned.fill(
            child: _controller.value.isInitialized
                ? FittedBox(
              fit: BoxFit.cover,
              child: SizedBox(
                width: _controller.value.size.width,
                height: _controller.value.size.height,
                child: VideoPlayer(_controller),
              ),
            )
                : Container(color: Colors.black),
          ),

          // 1 - Fundamentos (arriba centro)
          _buildCircleButton(context, screenWidth * 0.38, screenHeight * 0.04,
              fundamentosRedesLevels, "Fundamentos y Arquitectura de Redes"),

          // 2 - Direccionamiento (derecha)
          _buildCircleButton(context, screenWidth * 0.65, screenHeight * 0.22,
              direccionamientoRedesLevels, "Direccionamiento y Protocolos"),

          // 3 - Infraestructura (derecha abajo)
          _buildCircleButton(context, screenWidth * 0.65, screenHeight * 0.48,
              infraestructuraRedesLevels, "Infraestructura y Hardware"),

          // 4 - Administración (abajo centro)
          _buildCircleButton(context, screenWidth * 0.38, screenHeight * 0.65,
              administracionRedesLevels, "Administración y Monitoreo"),

          // 5 - Seguridad (izquierda abajo)
          _buildCircleButton(context, screenWidth * 0.05, screenHeight * 0.48,
              seguridadRedesLevels, "Seguridad de Redes"),

          // 6 - Redes Avanzadas (izquierda)
          _buildCircleButton(context, screenWidth * 0.05, screenHeight * 0.22,
              redesAvanzadasRedesLevels, "Redes Avanzadas y Servicios"),
        ],
      ),
    );
  }

  Widget _buildCircleButton(
      BuildContext context,
      double left,
      double top,
      Map<int, List<Map<String, dynamic>>> data,
      String title,
      ) {
    return Positioned(
      left: left,
      top: top,
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => StationScreens(
                title: title,
                levels: data.length,
                levelsData: data,
              ),
            ),
          );
        },
        child: Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.transparent,
          ),
        ),
      ),
    );
  }
}
