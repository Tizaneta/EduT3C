import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {

  // ── MODO MOCK ──────────────────────────────────
  // Bypass temporal del backend real mientras se resuelve
  // la conexión MySQL/Flask. En true, LoginScreen y RegisterScreen
  // saltean la llamada HTTP y simulan una respuesta exitosa.
  // Para volver a la API real: cambiar esto a false. No se tocó
  // ni se borró la lógica de negocio real, solo se la salteó.
  static const bool mockMode = true;

  // 10.0.2.2 es la IP especial que el emulador Android usa
  // para redirigir al localhost de la máquina host.
  // Si en algún momento probás en un celular físico en vez del
  // emulador, acá va a hacer falta la IP LAN real de tu compu
  // (la que te da ipconfig / ifconfig), no esta.
  static const String baseUrl =
      "http://10.0.2.2:5000";

  static Future<Map<String, dynamic>> login(
      String email,
      String password,
      ) async {

    final response = await http.post(
      Uri.parse("$baseUrl/login"),
      headers: {
        "Content-Type": "application/json"
      },
      body: jsonEncode({
        "email": email,
        "password": password,
      }),
    );
    final data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return data;
    }
    throw Exception(data["message"]);

  }
  static Future<Map<String, dynamic>> register(
      String username,
      String email,
      String password,
      ) async {

    final response = await http.post(
      Uri.parse("$baseUrl/users"),
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "username": username,
        "email": email,
        "password": password,
      }),
    );

    final data = jsonDecode(response.body);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return data;
    }

    throw Exception(data["message"]);
  }
}