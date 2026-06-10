import 'package:flutter/material.dart';
import 'StationScreens.dart';
import '../data/SoftwareData.dart';

class SoftwareScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Software")),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/videos/capas de sofware.jpeg',
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildButton(context, "1  S.O", fundamentosLevels, "S.O"),
                SizedBox(height: 28),
                _buildButton(context, "2  Capas", direccionamientoLevels, "Capas"),
                SizedBox(height: 28),
                _buildButton(context, "3  Aplicaciones", infraestructuraLevels, "Aplicaciones"),
                SizedBox(height: 28),
                _buildButton(context, "4  Programación", administracionLevels, "Programación"),
                SizedBox(height: 28),
                _buildButton(context, "5  Programación avanzada", seguridadLevels, "Programación avanzada"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButton(
      BuildContext context,
      String label,
      Map<int, List<Map<String, dynamic>>> data,
      String title,
      ) {
    return SizedBox(
      width: 260,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black.withOpacity(0.55),
          foregroundColor: Colors.cyanAccent,
          side: BorderSide(color: Colors.cyanAccent, width: 1.5),
          padding: EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: () {
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
        child: Text(
          label,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
