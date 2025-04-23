// domain/usecases/get_user_profile.dart
import 'package:quizzy/data/model/user.dart';
import 'package:quizzy/data/network/api_service.dart';

class GetUserProfile {
  final ApiService apiService;

  GetUserProfile(this.apiService);

  Future<User> execute() async {
    final response = await apiService.getUserProfile();
    if (response.statusCode == 200) {
      return User.fromJson(response.data);
    } else {
      throw Exception('Failed to fetch user profile');
    }
  }
}
