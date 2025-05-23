import 'package:quizzy/data/model/user.dart';

class Room {
  final String id;
  final String code;
  List<UserRoom> players;
  final String hostId;

  Room({
    required this.id,
    required this.code,
    required this.players,
    required this.hostId,
  });
}
