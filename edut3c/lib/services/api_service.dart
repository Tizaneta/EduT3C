import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {

  static const String baseUrl =
      "http://192.168.1.36:5000";

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
static Future<List<dynamic>> getAchievements() async {
  final response = await http.get(
    Uri.parse("$baseUrl/achievements"),
  );

  final data = jsonDecode(response.body);

  if (response.statusCode == 200) {
    return data;
  }

  throw Exception("No se pudieron obtener los logros");
}
static Future<List<dynamic>> getUserAchievements(int userId) async {
  final response = await http.get(
    Uri.parse("$baseUrl/users/$userId/achievements"),
  );

  final data = jsonDecode(response.body);

  if (response.statusCode == 200) {
    return data;
  }

  throw Exception(data["message"]);
}
static Future<void> unlockAchievement(
    int userId,
    int achievementId,
) async {

  final response = await http.post(
    Uri.parse("$baseUrl/users/$userId/achievements"),
    headers: {
      "Content-Type": "application/json",
    },
    body: jsonEncode({
      "achievement_id": achievementId,
    }),
  );

  if (response.statusCode != 201) {
    final data = jsonDecode(response.body);
    throw Exception(data["message"]);
  }
}
}


