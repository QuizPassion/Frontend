import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quizzy/core/widgets/nav_bar.dart';

void main() {
  group('QuizzyNavBar Navigation Tests', () {
    
    testWidgets('Home button navigates to /home', (WidgetTester tester) async {
      bool onTapCalled = false;
      int tappedIndex = -1;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: QuizzyNavBar(
              currentIndex: 1, // Start with a different index
              onTap: (index) {
                onTapCalled = true;
                tappedIndex = index;
              },
              disabled: false,
            ),
          ),
          routes: {
            '/home': (context) => const Scaffold(body: Text('Home Page')),
          },
        ),
      );

      // Find and tap the Home button
      final homeButton = find.widgetWithText(GestureDetector, 'Home');
      expect(homeButton, findsOneWidget);
      
      await tester.tap(homeButton);
      await tester.pumpAndSettle();

      // Verify navigation occurred
      expect(find.text('Home Page'), findsOneWidget);
      expect(onTapCalled, isTrue);
      expect(tappedIndex, equals(0));
    });

    testWidgets('Create Quiz button navigates to /allQuiz', (WidgetTester tester) async {
      bool onTapCalled = false;
      int tappedIndex = -1;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: QuizzyNavBar(
              currentIndex: 0, // Start with a different index
              onTap: (index) {
                onTapCalled = true;
                tappedIndex = index;
              },
              disabled: false,
            ),
          ),
          routes: {
            '/allQuiz': (context) => const Scaffold(body: Text('All Quiz Page')),
          },
        ),
      );

      // Find and tap the Create Quiz button
      final createQuizButton = find.widgetWithText(GestureDetector, 'Create Quizz');
      expect(createQuizButton, findsOneWidget);
      
      await tester.tap(createQuizButton);
      await tester.pumpAndSettle();

      // Verify navigation occurred
      expect(find.text('All Quiz Page'), findsOneWidget);
      expect(onTapCalled, isTrue);
      expect(tappedIndex, equals(1));
    });

    testWidgets('Score button navigates to /score', (WidgetTester tester) async {
      bool onTapCalled = false;
      int tappedIndex = -1;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: QuizzyNavBar(
              currentIndex: 0, // Start with a different index
              onTap: (index) {
                onTapCalled = true;
                tappedIndex = index;
              },
              disabled: false,
            ),
          ),
          routes: {
            '/score': (context) => const Scaffold(body: Text('Score Page')),
          },
        ),
      );

      // Find and tap the Score button
      final scoreButton = find.widgetWithText(GestureDetector, 'Score');
      expect(scoreButton, findsOneWidget);
      
      await tester.tap(scoreButton);
      await tester.pumpAndSettle();

      // Verify navigation occurred
      expect(find.text('Score Page'), findsOneWidget);
      expect(onTapCalled, isTrue);
      expect(tappedIndex, equals(2));
    });

    testWidgets('Parameters button navigates to /parameters', (WidgetTester tester) async {
      bool onTapCalled = false;
      int tappedIndex = -1;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: QuizzyNavBar(
              currentIndex: 0, // Start with a different index
              onTap: (index) {
                onTapCalled = true;
                tappedIndex = index;
              },
              disabled: false,
            ),
          ),
          routes: {
            '/parameters': (context) => const Scaffold(body: Text('Parameters Page')),
          },
        ),
      );

      // Find and tap the Parameters button
      final parametersButton = find.widgetWithText(GestureDetector, 'Parameters');
      expect(parametersButton, findsOneWidget);
      
      await tester.tap(parametersButton);
      await tester.pumpAndSettle();

      // Verify navigation occurred
      expect(find.text('Parameters Page'), findsOneWidget);
      expect(onTapCalled, isTrue);
      expect(tappedIndex, equals(3));
    });

    testWidgets('Does not navigate when tapping current tab', (WidgetTester tester) async {
      bool onTapCalled = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: QuizzyNavBar(
              currentIndex: 0, // Home is current
              onTap: (index) {
                onTapCalled = true;
              },
              disabled: false,
            ),
          ),
          routes: {
            '/home': (context) => const Scaffold(body: Text('Home Page')),
          },
        ),
      );

      // Tap the currently selected Home button
      final homeButton = find.widgetWithText(GestureDetector, 'Home');
      await tester.tap(homeButton);
      await tester.pumpAndSettle();

      // Verify no navigation occurred (should stay on original page)
      expect(find.text('Home Page'), findsNothing);
      expect(onTapCalled, isFalse);
    });

    testWidgets('Does not navigate when disabled', (WidgetTester tester) async {
      bool onTapCalled = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: QuizzyNavBar(
              currentIndex: 0,
              onTap: (index) {
                onTapCalled = true;
              },
              disabled: true, // NavBar is disabled
            ),
          ),
          routes: {
            '/score': (context) => const Scaffold(body: Text('Score Page')),
          },
        ),
      );

      // Try to tap the Score button
      final scoreButton = find.widgetWithText(GestureDetector, 'Score');
      await tester.tap(scoreButton);
      await tester.pumpAndSettle();

      // Verify no navigation occurred
      expect(find.text('Score Page'), findsNothing);
      expect(onTapCalled, isFalse);
    });

    testWidgets('All navigation buttons are present', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: QuizzyNavBar(
              currentIndex: 0,
              onTap: (index) {},
              disabled: false,
            ),
          ),
        ),
      );

      // Verify all buttons are present
      expect(find.text('Home'), findsOneWidget);
      expect(find.text('Create Quizz'), findsOneWidget);
      expect(find.text('Score'), findsOneWidget);
      expect(find.text('Parameters'), findsOneWidget);

      // Verify all icons are present
      expect(find.byIcon(Icons.home), findsOneWidget);
      expect(find.byIcon(Icons.add_circle_outline), findsOneWidget);
      expect(find.byIcon(Icons.emoji_events), findsOneWidget);
      expect(find.byIcon(Icons.settings), findsOneWidget);
    });
  });
}
