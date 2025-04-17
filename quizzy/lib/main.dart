import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizzy/data/viewmodel/auth_view_model.dart';
import 'package:quizzy/views/home/home.dart';
import 'package:quizzy/views/welcome/welcome.dart';
import 'package:quizzy/views/login/login.dart';
import 'package:quizzy/views/signup/signup.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthViewModel()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Quizzy',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.black,
        useMaterial3: true,
      ),
      initialRoute: '/', // Tu peux adapter pour `/home` si déjà connecté
      routes: {
        '/': (context) => const WelcomePage(),
        '/login': (context) => const LoginPage(),
        '/signup': (context) => const SignUpPage(),
        '/home': (context) => const HomePage(),
      },
    );
  }
}
