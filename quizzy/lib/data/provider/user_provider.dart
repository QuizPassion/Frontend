// data/provider/user_provider.dart
import 'package:flutter/material.dart';
import 'package:quizzy/data/model/user.dart';
import 'package:quizzy/domain/usercases/get_user_profile.dart';

class UserProvider with ChangeNotifier {
  final GetUserProfile getUserProfile;
  User? _user;

  User? get user => _user;

  UserProvider(this.getUserProfile);

  Future<void> fetchUserProfile() async {
    try {
      _user = await getUserProfile.execute();
      notifyListeners();
    } catch (e) {
      print("Error fetching user profile: $e");
    }
  }
}
