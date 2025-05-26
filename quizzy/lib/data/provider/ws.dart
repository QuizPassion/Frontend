import 'dart:convert';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizzy/data/model/user.dart';
import 'package:quizzy/data/provider/room_provider.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class WebSocketService extends ChangeNotifier {
  WebSocketChannel? _channel;
  bool _isConnected = false;
  String? _roomId;
  BuildContext? _context;
  Timer? _pingTimer;

  bool get isConnected => _isConnected;
  String? get roomId => _roomId;

  // Connexion WS (appelée une fois)
  void connect(BuildContext context, String url, Map<String, String> headers, String roomId) {
    if (_isConnected) {
      print('Déjà connecté au WebSocket');
      return;
    }

    print('Tentative de connexion WebSocket à $url');

    _context = context;
    _roomId = roomId;
    _isConnected = true;

    try {
      _channel = IOWebSocketChannel.connect(
        Uri.parse(url),
        headers: headers,
      );

      print('Connexion WebSocket établie');

      notifyListeners();

      _channel!.stream.listen(
        (message) {
          print('\n=== NOUVEAU MESSAGE RECU ===');
          print('Message brut reçu via WS: $message');
          print('Type du message: ${message.runtimeType}');
          
          try {
            final decodedMessage = jsonDecode(message);
            print('Message décodé: $decodedMessage');
            print('Type du message décodé: ${decodedMessage.runtimeType}');
            print('Clés du message: ${decodedMessage.keys.toList()}');
            
            if (decodedMessage['type'] == 'join' && decodedMessage['content'] != null && _context != null) {
              print('Traitement du message join');
              print('Content brut: ${decodedMessage['content']}');
              print('Type content brut: ${decodedMessage['content'].runtimeType}');

              final contentRaw = decodedMessage['content'];
              final content = (contentRaw is String) ? jsonDecode(contentRaw) : contentRaw;
              print('Content décodé: $content');

              try {
                final user = UserRoom.fromJson(content);
                print('UserRoom créé: ${user.userPseudo}');
                final roomProvider = Provider.of<RoomProvider>(_context!, listen: false);
                roomProvider.updatePlayers([...roomProvider.room!.players, user]);
                print('Liste des joueurs mise à jour: ${roomProvider.room!.players}');
              } catch (e) {
                print('Erreur lors de la conversion du user : $e');
                print('Format attendu: {"user_pseudo": "...", "image": {"url": "..."}}');
              }
            }
            if (decodedMessage['type'] == 'question') {
              Navigator.pushNamed(context, "/inGame", arguments: decodedMessage['content']);
            }
          } catch (e) {
            print('Erreur lors du décodage du message: $e');
            print('Message qui a causé l\'erreur: $message');
          }
          print('=== FIN DU MESSAGE ===\n');
        },
        onDone: () {
          print('Connexion WebSocket fermée');
          _isConnected = false;
          notifyListeners();
        },
        onError: (error) {
          print('Erreur WebSocket: $error');
          _isConnected = false;
          notifyListeners();
        },
      );
    } catch (e) {
      print('Erreur lors de la création de la connexion WebSocket: $e');
      _isConnected = false;
      notifyListeners();
    }
  }

  // Envoi d'un message
  void send(dynamic data) {
    if (_isConnected && _channel != null) {
      print('Envoi d\'un message via WS: $data');
      _channel!.sink.add(data);
    } else {
      print('WS non connecté, impossible d\'envoyer');
    }
  }

  // Déconnexion WS
  void disconnect() {
    print('Déconnexion du WebSocket');
    if (_channel != null) {
      _channel!.sink.close();
      _channel = null;
      _isConnected = false;
      _context = null;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    disconnect();
    super.dispose();
  }
}
