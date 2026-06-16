import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'StationScreens.dart';
import '../data/SoftwareData.dart';

class SoftwareScreen extends StatefulWidget {
  @override
  State<SoftwareScreen> createState() => _SoftwareScreenState();
}

class _SoftwareScreenState extends State<SoftwareScreen> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/videos/sofware.mp4')
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
      appBar: AppBar(title: Text("Software")),
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

          // 1 - S.O
          _buildLayerButton(context,
              left: screenWidth * 0.05,
              top: screenHeight * 0.10,
              width: screenWidth * 0.90,
              height: screenHeight * 0.12,
              data: fundamentosLevels,
              title: "S.O"),

          // 2 - Capas
          _buildLayerButton(context,
              left: screenWidth * 0.05,
              top: screenHeight * 0.24,
              width: screenWidth * 0.90,
              height: screenHeight * 0.12,
              data: direccionamientoLevels,
              title: "Capas"),

          // 3 - Aplicaciones
          _buildLayerButton(context,
              left: screenWidth * 0.05,
              top: screenHeight * 0.38,
              width: screenWidth * 0.90,
              height: screenHeight * 0.12,
              data: infraestructuraLevels,
              title: "Aplicaciones"),

          // 4 - Programación
          _buildLayerButton(context,
              left: screenWidth * 0.05,
              top: screenHeight * 0.52,
              width: screenWidth * 0.90,
              height: screenHeight * 0.12,
              data: administracionLevels,
              title: "Programación"),

          // 5 - Programación avanzada
          _buildLayerButton(context,
              left: screenWidth * 0.05,
              top: screenHeight * 0.66,
              width: screenWidth * 0.90,
              height: screenHeight * 0.12,
              data: seguridadLevels,
              title: "Programación avanzada"),
        ],
      ),
    );
  }

  Widget _buildLayerButton(
      BuildContext context, {
        required double left,
        required double top,
        required double width,
        required double height,
        required Map<int, List<Map<String, dynamic>>> data,
        required String title,
      }) {
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
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}