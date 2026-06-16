/*import 'package:flutter/material.dart';
import 'screens/Loginscreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // La app arranca en LoginScreen.
      // Desde ahí el usuario puede:
      //   → Iniciar sesión  →  Home
      //   → Crear cuenta    →  RegisterScreen  →  (volver al login)
      home: const LoginScreen(),
    );
  }
}*/

import 'package:flutter/material.dart';
import 'screens/home.dart';
//import 'screens/Registerscreen.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
  home: Home(), // la app arranca acá
    );
  }

}