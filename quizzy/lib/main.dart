import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizzy/core/widgets/search_with_qr.dart';
import 'package:quizzy/data/network/api_service.dart';
import 'package:quizzy/data/provider/quiz_provider.dart';
import 'package:quizzy/data/provider/user_provider.dart';
import 'package:quizzy/data/viewmodel/auth_view_model.dart';
import 'package:quizzy/domain/usercases/get_user_profile.dart';
import 'package:quizzy/views/create-quiz/all_quiz.dart';
import 'package:quizzy/views/create-quiz/create_quiz.dart';
import 'package:quizzy/views/home/home.dart';
import 'package:quizzy/views/home/qr_scanner_page.dart';
import 'package:quizzy/views/in-game/end_game.dart';
// import 'package:quizzy/views/in-game/game_loading.dart';
import 'package:quizzy/views/in-game/in_game.dart';
import 'package:quizzy/views/login/login.dart';
import 'package:quizzy/views/parameters/parameters.dart';
import 'package:quizzy/views/score/score.dart';
import 'package:quizzy/views/signup/signup.dart';
import 'package:quizzy/views/welcome/welcome.dart';

import 'views/create-quiz/create_quiz_questions.dart';
import 'views/in-game/created_game_lobby.dart';
import 'views/in-game/joined_game_lobby.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<GetUserProfile>(create: (_) => GetUserProfile(ApiService())),

        // Fournir UserProvider ici
        ChangeNotifierProvider(
          create: (context) => UserProvider(Provider.of<GetUserProfile>(context, listen: false)),
        ),
        
        ChangeNotifierProvider(create: (_) => AuthViewModel()),
        ChangeNotifierProvider(create: (_) => QuizProvider()),

      ],
      child: MaterialApp(
        title: 'Quizzy',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const WelcomePage(), // Page d'accueil ou première page
          '/login': (context) => const LoginPage(),
          '/signup': (context) => const SignUpPage(),
          '/parameters': (context) => const ParametersPage(), // Page des paramètres
          '/allQuiz': (context) => const AllQuizPage(), // Page des quiz
          '/createQuiz': (context) => const CreateQuizPage(), // Page de création de quiz
          '/score': (context) => const ScorePage(), // Score page
          '/home': (context) => const HomePage(), // Home page after login
          '/scanQr': (context) => const QrScanPage(), // qr code scanner page
          '/joinedGameLobby': (context) => const JoinedGameLobbyPage(),
          '/createdGameLobby': (context) => const CreatedGameLobbyPage(),
          // '/gameLoading': (context) => const GameLoading(),
          '/inGame': (context) => const InGame(),
          '/endGame': (context) => const EndGame(),
        },
        onGenerateRoute: (settings) {
          if (settings.name == '/createQuizQuestions') {
            final quizzData = settings.arguments as Map<String, dynamic>;
            return MaterialPageRoute(
              builder: (context) => CreateQuizQuestionsPage(quizData: quizzData,),
            );
          }
          return null; // Return null if no matching route is found
        },
      ),
    );
  }
}
