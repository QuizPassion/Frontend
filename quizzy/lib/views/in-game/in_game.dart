
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizzy/data/model/question.dart';
import 'package:quizzy/data/provider/user_provider.dart';
import 'package:quizzy/data/provider/ws.dart';
import '../../core/app_colors.dart';
import '../../core/app_fonts.dart';
import '../../core/widgets/confirm_exit.dart';
import '../../core/widgets/quizzy_scaffold.dart';

class InGame extends StatefulWidget {
  const InGame({super.key});

  @override
  State<InGame> createState() => _InGameState();
}

class _InGameState extends State<InGame> {
  bool _loaded = false;
  Question? question;
  final Set<int> selectedAnswerIds = {};

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!_loaded) {
      final args = ModalRoute.of(context)?.settings.arguments;
      if (args != null && args is Map<String, dynamic>) {
        question = Question.fromJson(args);
        print('Question reçue : ${question!.text}');
      }

      _loaded = true;
    }
  }

  void toggleAnswer(int answerId) {
    setState(() {
      if (selectedAnswerIds.contains(answerId)) {
        selectedAnswerIds.remove(answerId);
      } else {
        selectedAnswerIds.add(answerId);
      }

      print('Réponses sélectionnées : $selectedAnswerIds');

      // ➕ Ici tu peux appeler ta fonction WebSocket :
      // sendAnswersToBackend(selectedAnswerIds.toList());
    });
  }

  void sendAnswersToBackend(List<int> answers) {
    // Implémente ici la logique pour envoyer les réponses au backend via WebSocket
    // Par exemple :
    Provider.of<WebSocketService>(context, listen: false).send(jsonEncode({
      'type': 'answer',
      'content': {
        'player_id': Provider.of<UserProvider>(context, listen: false).user?.id.toString(),
        'answer_id': answers,
        'question_id': question?.id,
        'time': 5, // Exemple de temps, à adapter selon tes besoins
      },
    }));
  }

  @override
  Widget build(BuildContext context) {
    return QuizzyScaffold(
      currentIndex: 8,
      onTap: (_) {},
      disabled: true,
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Quiz sur les jedi dans Star Wars',
                  style: TextStyle(
                    fontFamily: AppFonts.montserrat,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: AppColors.lightGrey,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                Text(
                  'Question 1/15',
                  style: TextStyle(
                    fontFamily: AppFonts.montserrat,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.lightGrey,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  '1/20 joueurs ont répondu',
                  style: TextStyle(
                    fontFamily: AppFonts.lato,
                    fontSize: 16,
                    color: AppColors.lightGrey,
                  ),
                ),
                const SizedBox(height: 20),

                if (question != null)
                  Text(
                    question!.text,
                    style: TextStyle(
                      fontFamily: AppFonts.lato,
                      fontSize: 18,
                      color: AppColors.lightGrey,
                    ),
                  )
                else
                  const CircularProgressIndicator(),

                const SizedBox(height: 20),

                // Réponses multiples
                if (question != null)
                  ...question!.choices.map((choice) {
                    final isSelected = selectedAnswerIds.contains(choice.id);

                    return GestureDetector(
                      onTap: () => toggleAnswer(choice.id),
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 6),
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        decoration: BoxDecoration(
                          color: isSelected ? AppColors.royalPurple : Colors.grey[200],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              isSelected ? Icons.check_box : Icons.check_box_outline_blank,
                              color: isSelected ? Colors.white : Colors.grey,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                choice.text,
                                style: TextStyle(
                                  fontFamily: AppFonts.lato,
                                  fontSize: 16,
                                  color: isSelected ? Colors.white : Colors.black87,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList()
                else
                  const CircularProgressIndicator(),

                const Spacer(),

                ElevatedButton(
                  onPressed: () {
                    // Ici tu peux envoyer les réponses sélectionnées au backend
                    sendAnswersToBackend(selectedAnswerIds.toList());
                    print('Réponses envoyées : $selectedAnswerIds');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.dynamicOrange,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  child: const Text('temporary'),
                ),
                const SizedBox(height: 12),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => showConfirmExitDialog(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.royalPurple,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    child: const Text(
                      'Quit Game',
                      style: TextStyle(
                        color: AppColors.lightGrey,
                        fontFamily: AppFonts.lato,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
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
