import 'package:flutter/material.dart';
import '../../../core/app_colors.dart';
import '../../../core/app_fonts.dart';

class AnswerQuestionCard extends StatefulWidget {
  const AnswerQuestionCard({super.key});

  @override
  State<AnswerQuestionCard> createState() => _AnswerQuestionCardState();
}

class _AnswerQuestionCardState extends State<AnswerQuestionCard> {
  final List<bool> _selectedAnswers = [false, false, false];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
      decoration: BoxDecoration(
        color: AppColors.anthraciteBlack,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
          color: AppColors.deepLavender,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'What color is George Washington\'s white horse ?',
            style: TextStyle(
              color: AppColors.lightGrey,
              fontFamily: AppFonts.lato,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 12),

          // answer options
          ..._buildOption('He is white', 0), // replace with actual answers
          ..._buildOption('He is yellow', 1),
          ..._buildOption('He is green', 2),

          // confirm button
          Align(
            alignment: Alignment.bottomRight,
            child: SizedBox(
              height: 30,
              width: 90,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.royalPurple,
                  padding: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                onPressed: () {
                  // Navigator.pushNamed(context, '/endGame');
                },
                child: const Center( 
                  child: Text(
                    'Confirm',
                    style: TextStyle(
                      color: AppColors.lightGrey,
                      fontFamily: AppFonts.lato,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
          )

        ],
      ),
    );
  }

  List<Widget> _buildOption(String text, int index) {
    return [
      Row(
        children: [
          Checkbox(
            value: _selectedAnswers[index],
            onChanged: (val) {
              setState(() {
                _selectedAnswers[index] = val ?? false;
              });
            },
            side: const BorderSide(color: AppColors.lightGrey, width: 1),
            checkColor: AppColors.anthraciteBlack,
            activeColor: AppColors.lightGrey,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                color: AppColors.lightGrey,
                fontFamily: AppFonts.lato,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    ];
  }
}
