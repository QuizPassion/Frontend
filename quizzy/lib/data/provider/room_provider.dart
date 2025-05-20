import 'package:flutter/material.dart';
import 'package:quizzy/data/model/Room.dart';
import 'package:quizzy/data/model/user.dart';

class RoomProvider extends ChangeNotifier {
  Room? _room;

  Room? get room => _room;

  void setRoom(Room room) {
    _room = room;
    notifyListeners();
  }

  void clearRoom() {
    _room = null;
    notifyListeners();
  }

  void updatePlayers(List<UserRoom> newPlayers) {
    if (_room != null) {
      _room = Room(
        id: _room!.id,
        code: _room!.code,
        players: newPlayers,
        hostId: _room!.hostId,
      );
      notifyListeners();
    }
  }
}
