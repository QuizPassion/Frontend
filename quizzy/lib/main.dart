import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizzy/data/network/api_service.dart';
import 'package:quizzy/data/provider/quiz_provider.dart';
import 'package:quizzy/data/provider/room_provider.dart';
import 'package:quizzy/data/provider/user_provider.dart';
import 'package:quizzy/data/provider/ws.dart';
import 'package:quizzy/data/viewmodel/auth_view_model.dart';
import 'package:quizzy/domain/usercases/get_user_profile.dart';
import 'package:quizzy/views/create-quiz/all_quiz.dart';
import 'package:quizzy/views/create-quiz/create_quiz.dart';
import 'package:quizzy/views/home/home.dart';
import 'package:quizzy/views/home/qr_scanner_page.dart';
import 'package:quizzy/views/in-game/end_game.dart';
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
  const MyApp({super.key});

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
        ChangeNotifierProvider(create: (_) => WebSocketService()),
        ChangeNotifierProvider(create: (_) => RoomProvider()),
        ChangeNotifierProvider(create: (_) => allQuizProvider()),
        ChangeNotifierProvider(create: (_) => QuizProvider()),


      ],
      child: MaterialApp(
        title: 'Quizzy',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const WelcomePage(), // Welcome page, user can choose to login or signup
          '/login': (context) => const LoginPage(), // Login page, user can login 
          '/signup': (context) => const SignUpPage(), // Login page, user can login 
          '/parameters': (context) => const ParametersPage(), // Parameters page, user can change their parameters
          '/allQuiz': (context) => const AllQuizPage(), // Page were user can see all the quizzes they've created
          '/createQuiz': (context) => const CreateQuizPage(), // Page were the user can create a quiz
          '/score': (context) => const ScorePage(), // Score page
          '/home': (context) => const HomePage(), // Home page after login
          '/scanQr': (context) => const QrScanPage(), // qr code scanner page
          '/joinedGameLobby': (context) => const JoinedGameLobbyPage(),
          // '/gameLoading': (context) => const GameLoading(),
          '/inGame': (context) => InGame(),
          '/endGame': (context) => const EndGame(),
        },
        onGenerateRoute: (settings) {
          if (settings.name == '/createQuizQuestions') {
            final quizzData = settings.arguments as Map<String, dynamic>;
            return MaterialPageRoute(
              builder: (context) => CreateQuizQuestionsPage(quizData: quizzData,),
            );
          }

          if (settings.name == '/createdGameLobby') {
            return MaterialPageRoute(
              builder: (context) => ChangeNotifierProvider(
                create: (_) => QuizProvider(),
                child: const CreatedGameLobbyPage(),
              ),
            );
          }


          return null; // Return null if no matching route is found
        },
      ),
    );
  }
}
