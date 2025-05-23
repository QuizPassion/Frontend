import 'dart:io';

import 'package:flutter/material.dart';
import 'package:quizzy/data/network/api_service.dart';
import 'package:quizzy/data/provider/user_provider.dart';
import 'package:provider/provider.dart';

class AuthViewModel extends ChangeNotifier {
  final ApiService _apiService = ApiService();

  Future<bool> login(BuildContext context, String username, String password) async {
    final isEmail = username.contains('@');

    try {
      final response = await _apiService.login(
        emailOrPseudo: username,
        password: password,
        isEmail: isEmail,
      );

      if (response.statusCode == 200) {
        // Récupérer l'instance de UserProvider à partir du contexte
        final userProvider = Provider.of<UserProvider>(context, listen: false);
        
        // Tu peux ici stocker un token, mettre à jour un User, etc.
        await userProvider.fetchUserProfile();
        debugPrint("Connexion réussie");
        return true;
      } else if (response.statusCode == 401) {
        // Erreur d'authentification
        debugPrint("Email ou mot de passe incorrect");
        return false;
      } else if (response.statusCode == 500) {
        // Erreur serveur
        debugPrint("Erreur serveur : ${response.data}");
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

  Future<bool> signUp({
    required BuildContext context,
    required String username,
    required String email,
    required String password,
    required File? avatarFile,
  }) async {
    try {
      final result = await _apiService.signUpWithFormData(
        username: username,
        email: email,
        password: password,
        avatarFile: avatarFile,
      );

      if (result.statusCode == 200) {
        // Récupérer l'instance de UserProvider à partir du contexte
        final userProvider = Provider.of<UserProvider>(context, listen: false);
        
        // Mettre à jour les données de l'utilisateur après l'inscription
        await userProvider.fetchUserProfile();
        return true;
      } else if (result.statusCode == 400) {
        debugPrint("Erreur de validation : ${result.data}");
        return false;
      } else if (result.statusCode == 500) {
        debugPrint("Erreur serveur : ${result.data}");
        return false;
      } else {
        debugPrint("Erreur inconnue : ${result.statusCode}");
        return false;
      }
    } catch (e) {
      debugPrint('Sign up error: $e');
      return false;
    }
  }
}
