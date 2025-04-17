import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:quizzy/data/network/config.dart';
import 'package:http_parser/http_parser.dart';
import 'package:quizzy/utils/mime_utils.dart';


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

  // =========== SIGNUP ==============
  Future<http.Response> signUpWithFormData({
    required String username,
    required String email,
    required String password,
    File? avatarFile,
  }) async {
    var uri = Uri.parse('${Config.signupEndpoint}');
    var request = http.MultipartRequest('POST', uri);

    request.fields['user_pseudo'] = username;
    request.fields['email'] = email;
    request.fields['password'] = password;

    if (avatarFile != null) {
      request.files.add(await http.MultipartFile.fromPath(
        'image',
        avatarFile.path,
        contentType: MediaType('image', getMimeType(avatarFile.path)),
      ));
    }

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    return response;
  }
}
