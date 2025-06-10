import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quizzy/views/home/home.dart';
import 'package:quizzy/core/widgets/quizzy_text_field.dart';

void main() {
  testWidgets('Create game button navigates to createdGameLobby', (WidgetTester tester) async {
    // Build our app and trigger a frame
    await tester.pumpWidget(
      MaterialApp(
        home: const HomePage(),
        routes: {
          '/createdGameLobby': (context) => const Scaffold(body: Text('Created Game Lobby')),
        },
      ),
    );

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
    // Build our app and trigger a frame
    await tester.pumpWidget(
      const MaterialApp(
        home: HomePage(),
      ),
    );

    // Find the QuizzyTextField by its hint text
    final textField = find.widgetWithText(QuizzyTextField, 'Search for a quiz');
    expect(textField, findsOneWidget);

    // Enter text in the field
    await tester.enterText(find.descendant(
      of: textField,
      matching: find.byType(TextField),
    ), 'Test Input');
    
    // Verify the text was entered
    expect(find.text('Test Input'), findsOneWidget);
  });
}


// coming from your `FutureBuilder` in the HomePage that calls `ApiService().fetchCommunityQuizzes()`. 
// We are running tests without a real backend, the API call is failing with a 400 error
// this doesn't affect the test logic.