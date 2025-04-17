import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import '../../core/app_colors.dart';
import '../../core/app_fonts.dart';
import '../../core/widgets/app_bar.dart';
import '../../core/widgets/background_decoration.dart';
import '../../core/widgets/nav_bar.dart';
import '../../core/widgets/quizzy_text_field.dart';
import '../../core/widgets/save_button.dart';

class CreateQuizPage extends StatefulWidget {
  const CreateQuizPage({super.key});

  @override
  State<CreateQuizPage> createState() => _CreateQuizPageState();
}

class _CreateQuizPageState extends State<CreateQuizPage> {
  File? _imageFile;

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const QuizzyAppBar(),
      backgroundColor: AppColors.anthraciteBlack,
      body: BackgroundDecoration(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  'Create your quiz',
                  style: TextStyle(
                    fontFamily: AppFonts.montserrat,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: AppColors.lightGrey,
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Illustration Image
              const Text(
                'Illustration Image',
                style: TextStyle(
                  fontFamily: AppFonts.lato,
                  fontSize: 18,
                  color: AppColors.lightGrey,
                ),
              ),
              const SizedBox(height: 12),

              // Image picker
              Center(
                child: GestureDetector(
                  onTap: _pickImage,
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColors.deepLavender,
                        width: 1,
                      ),
                    ),
                    child: ClipOval(
                      child: _imageFile != null
                          ? Image.file(_imageFile!,
                              fit: BoxFit
                                  .cover) // doesn't work on the web but should work on mobile
                          : const Icon(Icons.add_a_photo,
                              color: AppColors.deepLavender),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Quiz name
              const Text(
                'Quiz name',
                style: TextStyle(
                  fontFamily: AppFonts.lato,
                  fontSize: 18,
                  color: AppColors.lightGrey,
                ),
              ),
              const SizedBox(height: 8),
              const QuizzyTextField(
                hintText: 'Enter quiz name',
              ),
              const SizedBox(height: 24),

              // Quiz description
              const Text(
                'Quiz description',
                style: TextStyle(
                  fontFamily: AppFonts.lato,
                  fontSize: 18,
                  color: AppColors.lightGrey,
                ),
              ),
              const SizedBox(height: 8),
              const QuizzyTextField(
                hintText: 'Enter quiz description',
                height: 108,
                maxLines: 5,
                minLines: 5,
              ),

              const SizedBox(height: 24),

              // Quiz theme
              const Text(
                'Quiz theme',
                style: TextStyle(
                  fontFamily: AppFonts.lato,
                  fontSize: 18,
                  color: AppColors.lightGrey,
                ),
              ),
              const SizedBox(height: 8),

              const QuizzyTextField(
                hintText: 'Search for a theme',
                prefixIcon: Icons.search,
                height: 42,
              ),
              const SizedBox(height: 8),

              Center(
                child: Text(
                  'or',
                  style: TextStyle(
                    fontFamily: AppFonts.lato,
                    fontSize: 18,
                    color: AppColors.lightGrey,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              const QuizzyTextField(
                hintText: 'Write the theme',
              ),

              const SizedBox(height: 24),

              Center(
                child: SaveButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/createQuizQuestions');
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: QuizzyNavBar(
        currentIndex: 1,
        onTap: (index) {},
      ),
    );
  }
}
