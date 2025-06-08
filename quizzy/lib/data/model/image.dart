class ImageQ {
  final int id;
  final String title;
  final String url;

  ImageQ({
    required this.id,
    required this.title,
    required this.url,
  });

  factory ImageQ.fromJson(Map<String, dynamic> json) {
    return ImageQ(
      id: json['ID'], // Si ID est null, assigner une valeur par défaut
      title: json['title'] ?? '', // Si title est null, assigner une chaîne vide
      url: json['url'], // Si url est null, assigner une chaîne vide
    );
  }
}