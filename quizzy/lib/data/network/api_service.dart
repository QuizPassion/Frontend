import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:quizzy/data/network/config.dart';

class ApiService {
  final http.Client _client;

  ApiService({http.Client? client}) : _client = client ?? http.Client();

  // =========== LOGIN ==============
  
  Future<http.Response> login({
    required String emailOrPseudo,
    required bool isEmail,
    required String password,
  }) async {
    final uri = Uri.parse('${Config.loginEndPoint}');

    try {
      final body = jsonEncode({
        if (isEmail) 'email': emailOrPseudo else 'user_pseudo': emailOrPseudo,
        'password': password,
      });

      final response = await _client.post(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: body,
      );

      return response;
    } catch (e) {
      throw Exception('Erreur de connexion : $e');
    }
  }
}
