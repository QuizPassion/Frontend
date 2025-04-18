import 'package:flutter/material.dart';
import 'package:quizzy/data/model/user.dart';
import 'package:quizzy/data/network/api_service.dart';

class UserProvider extends ChangeNotifier {
  User? _user;

  User? get user => _user;

  Future<void> fetchUserProfile() async {
    try {
      final response = await ApiService().getUserProfile();
      _user = User.fromJson(response.data);
      if (_user == null) {
        throw Exception("Erreur lors de la récupération du profil utilisateur");
      }
      print("Profil utilisateur récupéré : ${_user?.userPseudo}");
      notifyListeners();
    } catch (e) {
      print("Erreur : $e");
    }
  }

  // Mettre à jour le profil utilisateur
  void updateUser(User updatedUser) {
    _user = updatedUser;
    notifyListeners();
  }
}
