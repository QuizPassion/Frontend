import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:quizzy/data/model/quiz_request.dart';
import 'package:quizzy/data/network/config.dart';
import 'package:http_parser/http_parser.dart';
import 'package:quizzy/utils/mime_utils.dart';

class ApiService {
  static final ApiService _instance = ApiService._internal();

  late final Dio _dio;
  final CookieJar cookieJar = CookieJar(); // En mémoire uniquement

  factory ApiService() {
    return _instance;
  }

  ApiService._internal() {
    BaseOptions options = BaseOptions(
      baseUrl: Config.baseUrl,
      headers: {'Content-Type': 'application/json'},
      validateStatus: (status) => status != null,
    );

    _dio = Dio(options);
    _dio.interceptors.add(CookieManager(cookieJar));
  }

  // =========== LOGIN ============
  Future<Response> login({
    required String emailOrPseudo,
    required bool isEmail,
    required String password,
  }) async {
    final body = {
      if (isEmail) 'email': emailOrPseudo else 'user_pseudo': emailOrPseudo,
      'password': password,
    };

    final response = await _dio.post('${Config.loginEndPoint}', data: body);
  
    return response;
  }

  // =========== SIGNUP ============
  Future<Response> signUpWithFormData({
    required String username,
    required String email,
    required String password,
    File? avatarFile,
  }) async {
    FormData formData = FormData.fromMap({
      'user_pseudo': username,
      'email': email,
      'password': password,
      if (avatarFile != null)
        'image': await MultipartFile.fromFile(
          avatarFile.path,
          filename: avatarFile.path.split('/').last,
          contentType: MediaType('image', getMimeType(avatarFile.path)),
        ),
    });

    final options = Options(
      headers: {
        'Content-Type': 'multipart/form-data',
      },
    );

    final response = await _dio.post('${Config.signupEndpoint}', data: formData, options: options);

    return response;
  }

  // =========== FETCH QUIZZES ============
  Future<List<Quiz>> fetchCommunityQuizzes() async {
    final response = await _dio.get('${Config.quizEndpoint}');

    if (response.statusCode == 200) {
      final data = response.data as List;
      print('=== RÉPONSE DU SERVEUR ===');
      print('Status code: ${response.statusCode}');
      print('Response data: ${response.data}');
      print('========================');
      
      return data.map((json) => Quiz.fromJson(json)).toList();
    } else if (response.statusCode == 401) {
      throw Exception('Non autorisé : le token/cookie est manquant ou invalide.');
    } else {
      print('Erreur : ${response.statusCode}');
      throw Exception('Erreur serveur : ${response.statusCode}');
    }
  }

  // ============ FETCH USER PROFILE ============
  Future<Response> getUserProfile() async {
    final cookies = await cookieJar.loadForRequest(Uri.parse(Config.baseUrl));
    print('Cookies envoyés pour récupérer le user: $cookies');

    final response = await _dio.get('${Config.userProfileEndpoint}');
    if (response.statusCode == 200) {
      return response;
    } else if (response.statusCode == 401) {
      throw Exception('Non autorisé : le token/cookie est manquant ou invalide.');
    } else {
      print('Erreur : ${response.statusCode}');
      throw Exception('Erreur serveur : ${response.statusCode}');
    }
  }

  // ============ CREATE QUIZ ============
  Future<Response> createQuiz({
    required String name,
    required String description,
    required String theme,
    File? avatarFile,
  }) async {
    print('=== DONNÉES ENVOYÉES AU SERVEUR ===');
    print('Name: $name');
    print('Description: $description');
    print('Theme: $theme');
    print('Avatar file: $avatarFile');
    print('================================');

    FormData formData = FormData.fromMap({
      'title': name,
      'description': description,
      'theme': theme,
      if (avatarFile != null)
        'image': await MultipartFile.fromFile(
          avatarFile.path,
          filename: avatarFile.path.split('/').last,
          contentType: MediaType('image', getMimeType(avatarFile.path)),
        ),
    });

    final response = await _dio.post(
      Config.createQuizEndpoint,
      data: formData,
    );

    print('=== RÉPONSE DU SERVEUR ===');
    print('Status code: ${response.statusCode}');
    print('Response data: ${response.data}');
    print('========================');
    if (response.statusCode == 200 || response.statusCode == 201) {
      print('✅ Quiz créé avec succès');
    } else {
      print('❌ Erreur de création de quiz');
    }
    return response;
  }

  // ============ CREATE QUESTION ============
  Future<Response> createQuestion({
    required String quizId,
    required String question,
    required List<Map<String, dynamic>> options,
  }) async {
    // Constructing the request body
    FormData formData = FormData.fromMap({
      'quiz_id': quizId,
      'question': question,
      'options': jsonEncode(options),
    });
    print('FormData: $options'); // Debugging line to check the FormData

    final response = await _dio.post(
      '${Config.createQuestionEndpoint}',
      data: formData,
    );

    return response;
  }

  // ============ FETCH ALL MY QUIZZES ============
  Future<List<Quiz>> fetchMyQuizzes() async {
    final response = await _dio.get('${Config.myQuizzesEndpoint}');
    if (response.statusCode == 200) {
      final data = response.data as List;
      return data.map((json) => Quiz.fromJson(json)).toList();
    } else if (response.statusCode == 401) {
      throw Exception('Non autorisé : le token/cookie est manquant ou invalide.');
    } else {
      print('Erreur : ${response.statusCode}');
      throw Exception('Erreur serveur : ${response.statusCode}');
    }
  }

  // ============ CREATE GAME SESSION ============
  Future<Response> createGameSession(String code) async {
    final response = await _dio.post(
      '${Config.createGameSessionEndpoint}?code=$code',
    );
    return response;
  }

  // ============ JOIN GAME SESSION ============
  Future<Response> joinGameSession(String code) async {
    final response = await _dio.post(
      '${Config.joinGameSessionEndpoint}?pass=$code',
    );
    return response;
  }
}