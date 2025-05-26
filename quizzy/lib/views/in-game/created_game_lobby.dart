import 'dart:math';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizzy/core/widgets/confirm_exit.dart';
import 'package:quizzy/core/widgets/quizzy_scaffold.dart';
import 'package:quizzy/data/model/Room.dart';
import 'package:quizzy/data/model/user.dart';
import 'package:quizzy/data/network/config.dart';
import 'package:quizzy/data/provider/quiz_provider.dart';
import 'package:quizzy/data/provider/room_provider.dart';
import 'package:quizzy/data/provider/user_provider.dart';
import 'package:quizzy/data/provider/ws.dart';
import 'package:quizzy/views/in-game/widgets/start_game_btn.dart';
import 'package:cookie_jar/cookie_jar.dart';

import '../../core/app_colors.dart';
import '../../core/app_fonts.dart';
import '../../core/widgets/quizzy_text_field.dart';
import '../../core/widgets/search_with_qr.dart';
import '../../data/network/api_service.dart';
import 'widgets/player_in_game_card.dart';
import 'qr_code_display_page.dart';

class CreatedGameLobbyPage extends StatefulWidget {
  const CreatedGameLobbyPage({super.key});

  @override
  _CreatedGameLobbyPageState createState() => _CreatedGameLobbyPageState();
}

class _CreatedGameLobbyPageState extends State<CreatedGameLobbyPage> {
  late final String code;
  late final String roomId;
  bool _isLoading = false;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    code = _generateCode();
    _initializeGameSession();

    // Fetch quizzes when the widget is initialized
    _searchController.addListener(() {
      final query = _searchController.text;
      if (query.isNotEmpty) {
        Provider.of<allQuizProvider>(context, listen: false).filterQuizzes(query);
      } else {
        Provider.of<allQuizProvider>(context, listen: false).resetFilter();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    Provider.of<QuizProvider>(context, listen: false).clearQuiz();
  }

  String _generateCode() {
    const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    return List.generate(10, (index) => chars[Random().nextInt(chars.length)]).join();
  }

  Future<void> _initializeGameSession() async {
    setState(() => _isLoading = true);
    roomId = await _createGameSession();
    if (roomId.isNotEmpty) {
      await _connectWebSocket();
    }
    setState(() => _isLoading = false);
  }

  Future<String> _createGameSession() async {
    setState(() => _isLoading = true);
    try {
      final response = await ApiService().createGameSession(code);
      if (response.statusCode == 200 || response.statusCode == 201) {
        final UserProvider userProvider = Provider.of<UserProvider>(context, listen: false);
        final data = response.data['room_id'];
        final code = response.data['code'];
        final hostId = response.data['host_id'];
        final players = [
          UserRoom(userPseudo: userProvider.user!.userPseudo, image: userProvider.user!.image, userId: userProvider.user!.id.toString())
        ];
        final room = Room(
          players: players,
          id: data,
          code: code,
          hostId: hostId,
        );
        Provider.of<RoomProvider>(context, listen: false).setRoom(room);
        print('Room ID: $data');
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
      _showError('Erreur d\'authentification.');
      Navigator.of(context).pushNamedAndRemoveUntil('/login', (route) => false);
      return;
    }

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


  void _startGame() {
    final quizProvider = Provider.of<QuizProvider>(context, listen: false);
    if (quizProvider.quiz == null) {
      _showError('Please select a quiz before starting the game.');
      return;
    }

    // Fait une requête http pour démarrer le jeu
    ApiService().startGameSession(roomId, quizProvider.quiz!.id).then((response) {
      if (response.statusCode == 200 || response.statusCode == 201) {
        _showError('Game started successfully');
      } else {
        _showError('Failed to start the game. Please try again.');
      }
    }).catchError((error) {
      _showError('An error occurred while starting the game: $error');
    });
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {

    final roomProvider = Provider.of<RoomProvider>(context);
    final countPlayers = roomProvider.room?.players.length ?? 0;
    final players = roomProvider.room?.players ?? [];


    return QuizzyScaffold(
      currentIndex: 8,
      onTap: (_) {
      },
      disabled: true,
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
                    Expanded(
                      child: Consumer<QuizProvider>(
                        builder: (context, provider, child) {
                          return Text(
                            provider.quiz?.title ?? 'Aléatoire 🎲',
                            style: const TextStyle(
                              fontFamily: AppFonts.montserrat,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: AppColors.lightGrey,
                            ),
                          );
                        },
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.logout, color: AppColors.lightGrey, size: 32),
                      onPressed: () => showConfirmExitDialog(context),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                QuizzyTextField(
                  hintText: 'Search for a quiz',
                  controller: _searchController,
                  prefixIcon: Icons.search,
                  height: 42,
                ),
                Consumer<allQuizProvider>(
                  builder: (context, provider, _) {
                    final filteredQuizzes = provider.quizzes;
                    if (_searchController.text.isEmpty || filteredQuizzes.isEmpty) {
                      return const SizedBox(); // Ne rien afficher si vide
                    }

                    final itemCount = filteredQuizzes.length;
                    final itemHeight = 48.0;
                    final maxHeight = 200.0;
                    final height = (itemCount * itemHeight).clamp(0, maxHeight);

                    return SizedBox(
                      height: height.toDouble(),
                      child: ListView.builder(
                        itemCount: filteredQuizzes.length,
                        itemBuilder: (context, index) {
                          final quiz = filteredQuizzes[index];
                          return ListTile(
                            title: Text(
                              quiz.title,
                              style: const TextStyle(
                                color: AppColors.lightGrey,
                                fontFamily: AppFonts.lato,
                                fontSize: 16,
                              ),
                            ),
                            onTap: () {
                              _searchController.text = quiz.title;
                              Provider.of<QuizProvider>(context, listen: false).setQuiz(quiz);
                              provider.resetFilter();
                              _searchController.clear();
                            },
                          );
                        },
                      ),
                    );
                  },
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => QrCodeDisplayPage(code: code),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 16),
                Text(
                  "$countPlayers / 10",
                  style: const TextStyle(
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
                    children: players.map((player) {
                      return PlayerInGameCard(
                        playerName: player.userPseudo,
                        playerAvatar: player.image.url,
                      );
                    }).toList(),
                  ),
                ),

                // Bottom Fixed Area
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
                            _startGame();
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
    );
  }
}
