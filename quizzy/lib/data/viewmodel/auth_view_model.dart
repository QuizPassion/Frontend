import 'package:flutter/material.dart';
import 'package:quizzy/data/network/api_service.dart';

class AuthViewModel extends ChangeNotifier {
  final ApiService _apiService = ApiService();

  Future<bool> login(String username, String password) async {
    final isEmail = username.contains('@');

    try {
      final response = await _apiService.login(
        emailOrPseudo: username,
        password: password,
        isEmail: isEmail,
      );

      if (response.statusCode == 200) {
        // Tu peux ici stocker un token, mettre à jour un User, etc.
        return true;
      } else if (response.statusCode == 401) {
        // Erreur d'authentification
        debugPrint("Email ou mot de passe incorrect");
        return false;
      } else if (response.statusCode == 500) {
        // Erreur serveur
        debugPrint("Erreur serveur : ${response.body}");
        return false;
      } else {
        // Autres erreurs
        debugPrint("Erreur inconnue : ${response.statusCode}");
        return false;
      }
    } catch (e) {
      debugPrint("Erreur de connexion : $e");
      return false;
    }
  }
}
