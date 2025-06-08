class Score {
  String playerName;
  String avatarUrl;
  int score;

  Score({required this.playerName, required this.score, required this.avatarUrl});

  factory Score.fromJson(Map<String, dynamic> json) {
    return Score(
      playerName: json['name'] as String,
      score: json['score'] as int,
      avatarUrl: json['avatar'] as String,
    );
  }
}