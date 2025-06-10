import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quizzy/core/widgets/nav_bar.dart';

void main() {
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
              print('Home button tapped - Index: $index');
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
            currentIndex: 0, 
            onTap: (index) {
              onTapCalled = true;
              tappedIndex = index;
              print('Create Quiz button tapped - Index: $index');
            },
            disabled: false,
          ),
        ),
        routes: {
          '/allQuiz': (context) => const Scaffold(body: Text('All Quiz Page')),
        },
      ),
    );

    final createQuizButton = find.widgetWithText(GestureDetector, 'Create Quizz');
    expect(createQuizButton, findsOneWidget);
    
    await tester.tap(createQuizButton);
    await tester.pumpAndSettle();

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
            currentIndex: 0, 
            onTap: (index) {
              onTapCalled = true;
              tappedIndex = index;
              print('Score button tapped - Index: $index');
            },
            disabled: false,
          ),
        ),
        routes: {
          '/score': (context) => const Scaffold(body: Text('Score Page')),
        },
      ),
    );

    final scoreButton = find.widgetWithText(GestureDetector, 'Score');
    expect(scoreButton, findsOneWidget);
    
    await tester.tap(scoreButton);
    await tester.pumpAndSettle();

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
            currentIndex: 0,
            onTap: (index) {
              onTapCalled = true;
              tappedIndex = index;
              print('Parameters button tapped - Index: $index');
            },
            disabled: false,
          ),
        ),
        routes: {
          '/parameters': (context) => const Scaffold(body: Text('Parameters Page')),
        },
      ),
    );

    final parametersButton = find.widgetWithText(GestureDetector, 'Parameters');
    expect(parametersButton, findsOneWidget);
    
    await tester.tap(parametersButton);
    await tester.pumpAndSettle();

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
              print('Current tab tapped - should not navigate');
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

    // Verify no navigation occurred
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
              print('Disabled nav bar tapped - should not work');
            },
            disabled: true,
          ),
        ),
        routes: {
          '/score': (context) => const Scaffold(body: Text('Score Page')),
        },
      ),
    );

    final scoreButton = find.widgetWithText(GestureDetector, 'Score');
    await tester.tap(scoreButton);
    await tester.pumpAndSettle();

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
}
