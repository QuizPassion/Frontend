import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quizzy/views/create-quiz/widgets/created_quizz_card.dart';

void main() {
  testWidgets('CreatedQuizzCard shows up correctly', (WidgetTester tester) async {
    // Create the widget with null image
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Center(
            child: SizedBox(
              width: 350, // Match the width in your actual app
              child: CreatedQuizzCard(
                quizName: 'My Test Quiz',
                quizDescription: 'This is a test quiz description',
                quizImageUrl: null, // No image to avoid HTTP errors
              ),
            ),
          ),
        ),
      ),
    );

    await tester.pump();

    // Check if the card shows up
    expect(find.byType(CreatedQuizzCard), findsOneWidget);
    print('✅ CreatedQuizzCard widget found');

    // Check if the quiz name shows up
    expect(find.text('My Test Quiz'), findsOneWidget);
    print('✅ Quiz name "My Test Quiz" found');

    // Check if the description shows up
    expect(find.text('This is a test quiz description'), findsOneWidget);
    print('✅ Quiz description found');

  });
}
