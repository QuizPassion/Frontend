import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizzy/data/model/Room.dart';
import 'package:quizzy/data/model/quiz_request.dart';
import 'package:quizzy/data/model/user.dart';
import 'package:quizzy/data/provider/quiz_provider.dart';
import 'package:quizzy/data/provider/room_provider.dart';
import '../../core/app_colors.dart';
import '../../core/app_fonts.dart';
import '../../core/widgets/quizzy_text_field.dart';
import '../../core/widgets/search_with_qr.dart';
import 'qr_scanner_page.dart';
import 'widgets/quiz_card.dart';
import 'widgets/quiz_card_group.dart';
import '../../data/network/api_service.dart';
import '../../core/widgets/quizzy_scaffold.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _searchQuizController = TextEditingController();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    // Fetch quizzes when the widget is initialized
    _searchQuizController.addListener(() {
      final query = _searchQuizController.text;
      if (query.isNotEmpty) {
        Provider.of<allQuizProvider>(context, listen: false).filterQuizzes(query);
      } else {
        Provider.of<allQuizProvider>(context, listen: false).resetFilter();
      }
    });
  }
  
  // ignore: non_constant_identifier_names
  Future<String> JoinGameSession(String code) async {
    setState(() => _isLoading = true);
    try {
      final response = await ApiService().joinGameSession(code);
      if (response.statusCode == 200 || response.statusCode == 201) {
        print(
          '===========================\n'
          'Réponse de l\'API: ${response.data}\n'
          '==========================='
        );
        final data = jsonDecode(response.data);
        final roomId = data['room_id'].toString();
        final playersJSON = data['players'] as List<dynamic>;
        final hostId = data['host_id'].toString();
        final players = playersJSON.map((player) => UserRoom.fromJson(player)).toList();
        for (var player in players) {
          print('Player: ${player.userPseudo}, Image URL: ${player.image.url}');
        }
        print('Session créée avec succès: $roomId');
        print('===========================');
        print('Room ID: $roomId');
        print('Players JSON: $players');
        print('===========================');

        Provider.of<RoomProvider>(context, listen: false).setRoom(Room(
          players: players,
          id: roomId,
          code : code,
          hostId: hostId,
          ));
          
        return roomId;
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

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return QuizzyScaffold(
      currentIndex: 0,
      onTap: (index) {
      },
      disabled: false,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Multiplayer',
                style: TextStyle(
                  fontFamily: AppFonts.montserrat,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: AppColors.lightGrey,
                ),
              ),
              const SizedBox(height: 8),

              // Join game search bar
              SearchWithQrRow(
                hintText: 'Search and join a game',
                controller: _searchController,
                onQrTap: () async {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const QrScanPage()),
                  );
                  if (result != null) {
                    print("Scanned QR Code: $result");
                    _searchController.text = result;
                  }
                },
              ),
              ElevatedButton(
                onPressed: () {
                  final code = _searchController.text;
                  print(code);
                    JoinGameSession(code).then((roomId) {
                      if (roomId.isNotEmpty) {
                        Navigator.pushNamed(context, '/joinedGameLobby', arguments: roomId);
                      }
                    });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.royalPurple,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                child: const Text(
                  'temporary',
                  style: TextStyle(
                    color: AppColors.lightGrey
                  ),
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'ou',
                style: TextStyle(
                  color: AppColors.lightGrey,
                  fontSize: 18,
                  fontFamily: AppFonts.lato,
                ),
              ),
              const SizedBox(height: 8),

              // Create game button
              SizedBox(
                width: 350,
                height: 42,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pushNamed(context, '/createdGameLobby');
                  },
                  icon: const Icon(
                    Icons.add_circle_outline,
                    color: AppColors.lightGrey,
                    size: 26,
                  ),
                  label: const Text(
                    'Create your own game',
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: AppFonts.lato,
                      color: AppColors.lightGrey,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.royalPurple,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    elevation: 0,
                    minimumSize: const Size(350, 42),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              const Text(
                'Solo',
                style: TextStyle(
                  fontFamily: AppFonts.montserrat,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: AppColors.lightGrey,
                ),
              ),
              const SizedBox(height: 8),
              // Search quiz search bar
              QuizzyTextField(
                hintText: 'Search for a quiz',
                prefixIcon: Icons.search,
                height: 42,
                controller: _searchQuizController,
              ),

              Consumer<allQuizProvider>(
              builder: (context, provider, _) {
                final filteredQuizzes = provider.quizzes;
                if (_searchQuizController.text.isEmpty || filteredQuizzes.isEmpty) {
                  return const SizedBox(); // Ne rien afficher si vide
                }
                return Container(
                  margin: const EdgeInsets.only(top: 8),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 10,
                        color: Colors.black.withOpacity(0.1),
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: ListView.builder(
                    shrinkWrap: true, // Important pour que ça s'affiche bien dans un scroll
                    itemCount: filteredQuizzes.length,
                    itemBuilder: (context, index) {
                      final quiz = filteredQuizzes[index];
                      return ListTile(
                        title: Text(quiz.title,
                          style: const TextStyle(
                            color: AppColors.lightGrey,
                            fontFamily: AppFonts.lato,
                            fontSize: 16,
                          ),
                        ),
                        onTap: () {
                          // Action si l'utilisateur clique sur un quiz suggéré
                          print("Quiz sélectionné: ${quiz.title}");
                          // Tu pourrais naviguer vers le quiz ou remplir le champ avec le titre :
                          _searchQuizController.text = quiz.title;
                          provider.resetFilter(); // Masquer la liste
                        },
                      );
                    },
                  ),
                );
              },
            ),


              const SizedBox(height: 24),
              FutureBuilder<List<Quiz>>(
                future: ApiService().fetchCommunityQuizzes(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    print('Erreur FutureBuilder: ${snapshot.error}');
                    return Text('Erreur : ${snapshot.error}');
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    print('Aucune donnée reçue du serveur');
                    return const Text('Aucun quiz trouvé.');
                  }

                  // Assuming the API returns a list of quizzes
                  Provider.of<allQuizProvider>(context, listen: false).setAllQuizzes(snapshot.data!);

                  final quizzes = snapshot.data!;
                  print('Nombre de quiz reçus: ${quizzes.length}');

                  return QuizCardGroup(
                    title: 'Quiz from the community',
                    cards: quizzes
                        .map((quiz) => QuizCardSmall(label: quiz.title, imageUrl: quiz.image?.url))
                        .toList(),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
