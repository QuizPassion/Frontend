import 'package:quizzy/data/model/image.dart';

class User {
  final int id;
  final String userPseudo;
  final String email;
  final String password;
  final String role;
  final ImageQ image;

  User({
    required this.id,
    required this.userPseudo,
    required this.email,
    required this.password,
    required this.role,
    required this.image,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['ID'], // Si ID est null, assigner une valeur par défaut
      userPseudo: json['UserPseudo'], // Si UserPseudo est null, assigner une chaîne vide
      email: json['Email'] ?? '', // Si Email est null, assigner une chaîne vide
      password: json['Password'] ?? '', // Si Password est null, assigner une chaîne vide
      role: json['Role'] ?? '', // Si Role est null, assigner une chaîne vide
      image: ImageQ.fromJson(json['Image']), // Assurez-vous de gérer l'objet Image séparément
    );
  }
}

class UserRoom {
  final String userPseudo;
  final ImageQ image;
  final String userId;

  UserRoom({
    required this.userPseudo,
    required this.image,
    required this.userId,
  });

  factory UserRoom.fromJson(Map<String, dynamic> json) {
    return UserRoom(
      userPseudo: json['user_pseudo'] ?? '', // Si user_pseudo est null, assigner une chaîne vide
      image: ImageQ.fromJson(json['image']), // Assurez-vous de gérer l'objet Image séparément
      userId: json['user_id'].toString(), // Si user_id est null, assigner une chaîne vide
    );
  }
}