import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizzy/data/network/api_service.dart';
import 'package:quizzy/data/network/config.dart';
import 'package:quizzy/data/provider/room_provider.dart';
import 'package:quizzy/data/provider/ws.dart';
import 'package:quizzy/views/in-game/widgets/player_in_game_card.dart';

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
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final room = Provider.of<RoomProvider>(context, listen: false).room;
      print('État initial de la room: ${room?.id}');
      print('Nombre de joueurs: ${room?.players.length}');

      if (room != null) {
        final roomId = room.id;
        print('Tentative de connexion WebSocket pour la room: $roomId');
        _connectWebSocket(roomId);
      } else {
        print('Aucune room trouvée');
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

    print('JWT token trouvé, connexion au WebSocket...');
    final wsService = context.read<WebSocketService>();
    final url = 'ws://10.0.2.2:8080/api/v1/multiGame/ws?room_id=$roomId';
    final headers = {'Cookie': 'jwt_token=$jwt'};

    wsService.connect(context, url, headers, roomId);
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
    print('Dispose de JoinedGameLobbyPage');
    final wsService = context.read<WebSocketService>();
    wsService.disconnect();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final room = Provider.of<RoomProvider>(context).room;
    print('Build de JoinedGameLobbyPage - Nombre de joueurs: ${room?.players.length}');

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

            Expanded(
              child: GridView.count(
                physics: const BouncingScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1,
                children: room.players.map((player) {
                  print('Création d\'une carte pour le joueur: ${player.userPseudo}');
                  return PlayerInGameCard(
                    playerName: player.userPseudo,
                    playerAvatar: player.image.url
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
