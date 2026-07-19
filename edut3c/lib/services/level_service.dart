import 'dart:convert';
import 'package:http/http.dart' as http;

import 'api_service.dart';

class LevelService {

  static Future<Map<String, dynamic>> completeLevel({
    required int userId,
    required int levelId,
  }) async {

    final response = await http.post(
      Uri.parse("${ApiService.baseUrl}/levels/$levelId/complete"),
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "user_id": userId,
      }),
    );

    final data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return data;
    }

    throw Exception(data["message"]);
  }
}