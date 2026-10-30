import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user.dart';
import '../models/item.dart';
import '../models/user_item.dart';

class ApiService {

  static const String baseUrl =
      "http://192.168.1.36:5000";

// Apartado de los servicios de los usuarios

  static Future<User> login(
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
      final userJson = data["user"] as Map<String, dynamic>;
      return User.fromJson(userJson);
    }
    throw Exception(data["message"] ?? "Error al iniciar sesión");

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

    throw Exception(data["message"] ?? "No se pudo crear el usuario");

}

static Future<User> getUser(int userId) async {
  final response = await http.get(
    Uri.parse('$baseUrl/users/$userId'),
  );

  final data = jsonDecode(response.body);

  if (response.statusCode == 200) {
    return User.fromJson(data);
  }

  throw Exception(
    data['error'] ?? 'Error al obtener el usuario',
  );
}

// Apartado de los servicios de los items/usuarios

static Future<List<Item>> getItems() async {
  final response = await http.get(
    Uri.parse('$baseUrl/items'),
  );

  if (response.statusCode != 200) {
    throw Exception('Error al obtener los objetos');
  }

  final List<dynamic> data = jsonDecode(response.body);

  return data
      .map((json) => Item.fromJson(json))
      .toList();
}

static Future<void> buyItem(int userId, int itemId) async {
  final response = await http.post(
    Uri.parse('$baseUrl/users/$userId/items'),
    headers: {
      'Content-Type': 'application/json',
    },
    body: jsonEncode({
      'item_id': itemId,
    }),
  );

  if (response.statusCode != 200) {
    final data = jsonDecode(response.body);

    throw Exception(
      data['message'] ?? 'No se pudo comprar el objeto',
    );
  }
}

static Future<List<UserItem>> getUserItems(int userId) async {
  final response = await http.get(
    Uri.parse('$baseUrl/users/$userId/items'),
  );

  if (response.statusCode != 200) {
    throw Exception('Error al obtener el inventario');
  }

  final List<dynamic> data = jsonDecode(response.body);

  return data
      .map((json) => UserItem.fromJson(json))
      .toList();
}

// Apartado de servicios de los logros

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