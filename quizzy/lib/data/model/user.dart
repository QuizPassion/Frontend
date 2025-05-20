class User {
  final int id;
  final String userPseudo;
  final String email;
  final String password;
  final String role;
  final Image image;

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
      image: Image.fromJson(json['Image']), // Assurez-vous de gérer l'objet Image séparément
    );
  }
}

class Image {
  final int id;
  final String title;
  final String url;

  Image({
    required this.id,
    required this.title,
    required this.url,
  });

  factory Image.fromJson(Map<String, dynamic> json) {
    return Image(
      id: json['ID'], // Si ID est null, assigner une valeur par défaut
      title: json['title'] ?? '', // Si title est null, assigner une chaîne vide
      url: json['url'], // Si url est null, assigner une chaîne vide
    );
  }
}

class UserRoom {
  final String userPseudo;
  final Image image;

  UserRoom({
    required this.userPseudo,
    required this.image,
  });

  UserRoom.fromJson(Map<String, dynamic> json)
      : userPseudo = json['user_pseudo'] ?? '',
        image = Image.fromJson(json['image'] ?? {});
}