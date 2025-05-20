import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizzy/data/network/api_service.dart';
import 'package:quizzy/data/network/config.dart';
import 'package:quizzy/data/provider/room_provider.dart';
import 'package:quizzy/views/in-game/widgets/player_in_game_card.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../../core/app_colors.dart';
import '../../core/app_fonts.dart';
import '../../core/widgets/quizzy_scaffold.dart';
import '../../core/widgets/search_with_qr.dart';

class JoinedGameLobbyPage extends StatefulWidget {
  const JoinedGameLobbyPage({super.key});
  
  @override
  State<JoinedGameLobbyPage> createState() => _JoinedGameLobbyPageState();
}

class _JoinedGameLobbyPageState extends State<JoinedGameLobbyPage> {
  late WebSocketChannel _channel;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final room = Provider.of<RoomProvider>(context, listen: false).room;

      if (room != null) {
        final roomId = room.id;
        _connectWebSocket(roomId);
      } else {
        _showError('Aucune room trouvée.');
        Navigator.of(context).pushReplacementNamed('/home');
      }
    });
  }

  Future<void> _connectWebSocket(String roomId) async {
    final jwt = await _getJwtTokenFromCookies();
    if (jwt == null || jwt.isEmpty) {
      print('JWT token not found in cookies: $jwt');
      _showError('Erreur d\'authentification. Veuillez vous reconnecter.');
      Navigator.of(context).pushReplacementNamed('/login');
      return;
    }

    _channel = IOWebSocketChannel.connect(
      Uri.parse('ws://10.0.2.2:8080/api/v1/multiGame/ws?room_id=$roomId'),
      headers: {
        'Cookie': 'jwt_token=$jwt',
      },
    );

    _channel.stream.listen((message) {
      print('Message reçu : $message');
      // Tu pourrais ajouter ici le traitement des messages
    });
  }

  Future<String?> _getJwtTokenFromCookies() async {
    final uri = Uri.parse(Config.baseUrl);
    final cookies = await ApiService().cookieJar.loadForRequest(uri);
    final jwtCookie = cookies.firstWhere(
      (cookie) => cookie.name == 'jwt_token',
      orElse: () => Cookie('jwt_token', ''),
    );
    return jwtCookie.value.isNotEmpty ? jwtCookie.value : null;
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  void dispose() {
    _channel.sink.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final room = Provider.of<RoomProvider>(context).room;

    if (room == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return QuizzyScaffold(
      currentIndex: 8,
      onTap: (index) {},
      disabled: false,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Row with Title and Exit Icon
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    'Quiz Room',
                    style: const TextStyle(
                      fontFamily: AppFonts.montserrat,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: AppColors.lightGrey,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.logout, color: AppColors.lightGrey, size: 32),
                  onPressed: () {
                    Navigator.pushNamed(context, '/home');
                  },
                ),
              ],
            ),

            const SizedBox(height: 24),

            const Text(
              'Invite your friends using this code',
              style: TextStyle(
                fontFamily: AppFonts.lato,
                fontSize: 16,
                color: AppColors.lightGrey,
              ),
            ),

            const SizedBox(height: 8),

            QrRow(
              codeText: room.code,
              onQrTap: () {
                // Peut-être afficher un QR code ?
              },
            ),

            const SizedBox(height: 16),

            const Center(
              child: Text(
                'Host :',
                style: TextStyle(
                  fontFamily: AppFonts.lato,
                  fontSize: 18,
                  color: AppColors.lightGrey,
                ),
              ),
            ),
            Center(
              child: Text(
                room.hostId,
                style: const TextStyle(
                  fontFamily: AppFonts.montserrat,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.lightGrey,
                ),
              ),
            ),

            const SizedBox(height: 16),

            // ⚠️ Correction ici : Remplacer Expanded dans un scrollable
            Expanded(
              child: GridView.count(
                physics: const BouncingScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1,
                children: room.players.map((player) => PlayerInGameCard(playerName: player.userPseudo, playerAvatar: player.image.url)).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
