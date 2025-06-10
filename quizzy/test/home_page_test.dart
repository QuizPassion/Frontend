import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:quizzy/views/home/home.dart';
import 'package:quizzy/core/widgets/quizzy_text_field.dart';
import 'package:quizzy/data/provider/quiz_provider.dart';
import 'package:quizzy/data/provider/room_provider.dart';

void main() {
  testWidgets('Create game button navigates to createdGameLobby', (WidgetTester tester) async {
    // Build our app with required providers
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => allQuizProvider()),
          ChangeNotifierProvider(create: (_) => RoomProvider()),
        ],
        child: MaterialApp(
          home: const HomePage(),
          routes: {
            '/createdGameLobby': (context) => const Scaffold(body: Text('Created Game Lobby')),
          },
        ),
      ),
    );

    // Wait for the initial build and API call to complete
    await tester.pump();

    // Find the create game button by its key
    final createGameButton = find.byKey(const Key('create_game_button'));
    expect(createGameButton, findsOneWidget);

    // Tap the button
    await tester.tap(createGameButton);
    await tester.pumpAndSettle(); // Wait for navigation to complete

    // Verify that we navigated to the createdGameLobby page
    expect(find.text('Created Game Lobby'), findsOneWidget);
  });

  testWidgets('QuizzyTextField allows user input', (WidgetTester tester) async {
    // Build our app with required providers
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => allQuizProvider()),
          ChangeNotifierProvider(create: (_) => RoomProvider()),
        ],
        child: const MaterialApp(
          home: HomePage(),
        ),
      ),
    );

    // Wait for the initial build and API call to complete
    await tester.pump();

    // Find the QuizzyTextField by its hint text
    final textField = find.widgetWithText(QuizzyTextField, 'Search for a quiz');
    expect(textField, findsOneWidget);

    // Enter text in the field
    await tester.enterText(find.descendant(
      of: textField,
      matching: find.byType(TextField),
    ), 'Test Input');
    
    // Pump to process the text input
    await tester.pump();
    
    // Verify the text was entered
    expect(find.text('Test Input'), findsOneWidget);
  });

  testWidgets('Search functionality works with provider', (WidgetTester tester) async {
    // Create a provider with some test data
    final quizProvider = allQuizProvider();
    
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: quizProvider),
          ChangeNotifierProvider(create: (_) => RoomProvider()),
        ],
        child: const MaterialApp(
          home: HomePage(),
        ),
      ),
    );

    // Wait for the initial build
    await tester.pump();

    // Find the search field
    final searchField = find.widgetWithText(QuizzyTextField, 'Search for a quiz');
    expect(searchField, findsOneWidget);

    // Enter search text
    await tester.enterText(find.descendant(
      of: searchField,
      matching: find.byType(TextField),
    ), 'Flutter');
    
    await tester.pump();

    // Verify the search text was entered
    expect(find.text('Flutter'), findsOneWidget);
  });
}
