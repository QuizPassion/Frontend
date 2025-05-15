import 'dart:convert';
import 'dart:math';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizzy/data/network/config.dart';
import 'package:quizzy/data/provider/user_provider.dart';
import 'package:quizzy/views/in-game/widgets/start_game_btn.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:cookie_jar/cookie_jar.dart';

import '../../core/app_colors.dart';
import '../../core/app_fonts.dart';
import '../../core/widgets/app_bar.dart';
import '../../core/widgets/nav_bar.dart';
import '../../core/widgets/quizzy_text_field.dart';
import '../../core/widgets/search_with_qr.dart';
import '../../data/provider/quiz_provider.dart';
import '../../data/network/api_service.dart';
import 'widgets/player_in_game_card.dart';

class CreatedGameLobbyPage extends StatefulWidget {
  const CreatedGameLobbyPage({super.key});

  @override
  State<CreatedGameLobbyPage> createState() => _CreatedGameLobbyPageState();
}

class _CreatedGameLobbyPageState extends State<CreatedGameLobbyPage> {
  late final String code;
  late final String roomId;
  late WebSocketChannel _channel;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    code = _generateCode();
    _initializeGameSession();
  }

  @override
  void dispose() {
    _channel.sink.close();
    super.dispose();
  }

  String _generateCode() {
    const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    return List.generate(10, (index) => chars[Random().nextInt(chars.length)]).join();
  }

  Future<void> _initializeGameSession() async {
    roomId = await _createGameSession();
    if (roomId.isNotEmpty) {
      await _connectWebSocket();
    }
  }

  Future<String> _createGameSession() async {
    setState(() => _isLoading = true);
    try {
      final response = await ApiService().createGameSession(code);
      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = response.data['room_id'];
        print('Session créée avec succès: $data');
        return data;
      } else {
        _showError('Erreur ${response.statusCode} lors de la création de la session.');
        return '';
      }
    } catch (e) {
      _showError('Erreur lors de la création de la session : $e');
      return '';
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _connectWebSocket() async {
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
  Widget build(BuildContext context) {
    final quizProvider = Provider.of<QuizProvider>(context);
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    return Scaffold(
      appBar: const QuizzyAppBar(),
      backgroundColor: AppColors.anthraciteBlack,
      body: Stack(
        children: [
          if (_isLoading)
            const Center(child: CircularProgressIndicator()),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Expanded(
                      child: Text(
                        'Quiz on the jedi in star wars',
                        style: TextStyle(
                          fontFamily: AppFonts.montserrat,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: AppColors.lightGrey,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.logout, color: AppColors.lightGrey, size: 32),
                      onPressed: () => Navigator.pushNamed(context, '/home'),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                QuizzyTextField(
                  hintText: 'Search for a quiz',
                  controller: quizProvider.quizNameController,
                  prefixIcon: Icons.search,
                  height: 42,
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
                  codeText: code,
                  onQrTap: () {
                    // QR functionality
                  },
                ),
                const SizedBox(height: 16),
                const Text(
                  'Players 1/20',
                  style: TextStyle(
                    fontFamily: AppFonts.lato,
                    fontSize: 16,
                    color: AppColors.lightGrey,
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
                    children: [
                      PlayerInGameCard(playerName: userProvider.user!.userPseudo),
                    ],
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: Column(
                      children: [
                        const Text(
                          'Launch the game as soon as you are ready',
                          style: TextStyle(
                            fontFamily: AppFonts.lato,
                            fontSize: 16,
                            color: AppColors.lightGrey,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 12),
                        StartGameButton(
                          onPressed: () {
                            _channel.sink.add(jsonEncode({
                              "type": "join",
                              "content": {
                                "room": roomId,
                                "user": userProvider.user!.userPseudo,
                              }
                            }));
                          },
                        ),

                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: QuizzyNavBar(
        currentIndex: 4,
        onTap: (index) {},
      ),
    );
  }
}
