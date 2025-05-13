import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:quizzy/core/app_colors.dart';
import 'package:quizzy/core/app_fonts.dart';
import 'package:quizzy/core/widgets/quizzy_text_field.dart';
import 'package:quizzy/core/widgets/save_button.dart';
import 'package:quizzy/data/provider/quiz_provider.dart';

import '../../core/widgets/quizzy_scaffold.dart';

class CreateQuizPage extends StatefulWidget {
  const CreateQuizPage({super.key});

  @override
  State<CreateQuizPage> createState() => _CreateQuizPageState();
}

class _CreateQuizPageState extends State<CreateQuizPage> {
  @override
  void initState() {
    super.initState();

    // 🔁 Réinitialise les champs quand la page est ouverte
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<QuizProvider>(context, listen: false).reset();
    });
  }

  Future<void> _pickImage(BuildContext context) async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final image = File(pickedFile.path);
      context.read<QuizProvider>().setImage(image);
    }
  }

  @override
  Widget build(BuildContext context) {
    final quizProvider = Provider.of<QuizProvider>(context);

    final List<String> themes = [
      'Science',
      'History',
      'Music',
      'Sports',
      'Movies',
      'Geography',
      'Literature',
    ];

    return QuizzyScaffold(
      currentIndex: 1,
      onTap: (index) {
      },
      disabled: false,
      body: SingleChildScrollView(
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

              const Text(
                'Illustration Image',
                style: TextStyle(
                  fontFamily: AppFonts.lato,
                  fontSize: 18,
                  color: AppColors.lightGrey,
                ),
              ),
              const SizedBox(height: 12),

              Center(
                child: GestureDetector(
                  onTap: () => _pickImage(context),
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.deepLavender, width: 1),
                    ),
                    child: ClipOval(
                      child: quizProvider.imageFile != null
                          ? Image.file(quizProvider.imageFile!, fit: BoxFit.cover)
                          : const Icon(Icons.add_a_photo, color: AppColors.deepLavender),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 24),
              const Text(
                'Quiz name',
                style: TextStyle(
                  fontFamily: AppFonts.lato,
                  fontSize: 18,
                  color: AppColors.lightGrey,
                ),
              ),
              const SizedBox(height: 8),
              QuizzyTextField(
                hintText: 'Enter quiz name',
                controller: quizProvider.quizNameController,
              ),

              const SizedBox(height: 24),
              const Text(
                'Quiz description',
                style: TextStyle(
                  fontFamily: AppFonts.lato,
                  fontSize: 18,
                  color: AppColors.lightGrey,
                ),
              ),
              const SizedBox(height: 8),
              QuizzyTextField(
                hintText: 'Enter quiz description',
                controller: quizProvider.descriptionController,
                height: 108,
                maxLines: 5,
                minLines: 5,
              ),

              const SizedBox(height: 24),
              const Text(
                'Quiz theme',
                style: TextStyle(
                  fontFamily: AppFonts.lato,
                  fontSize: 18,
                  color: AppColors.lightGrey,
                ),
              ),
              const SizedBox(height: 8),
              DropdownButton<String>(
                value: quizProvider.selectedTheme,
                hint: const Text(
                  'Select a theme',
                  style: TextStyle(
                    color: AppColors.lightGrey,
                    fontSize: 18,
                    fontFamily: AppFonts.lato,
                  ),
                ),
                isExpanded: true,
                dropdownColor: AppColors.anthraciteBlack,
                iconEnabledColor: AppColors.lightGrey,
                items: themes.map((theme) {
                  return DropdownMenuItem<String>(
                    value: theme,
                    child: Text(
                      theme,
                      style: const TextStyle(
                        color: AppColors.lightGrey,
                        fontSize: 18,
                        fontFamily: AppFonts.lato,
                      ),
                    ),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  quizProvider.setTheme(newValue);
                },
              ),

              const SizedBox(height: 24),
              Center(
                child: quizProvider.isLoading
                    ? const CircularProgressIndicator(color: AppColors.deepLavender)
                    : SaveButton(
                        onPressed: () {
                          final quizData = {
                            'name': quizProvider.quizNameController.text,
                            'description': quizProvider.descriptionController.text,
                            'theme': quizProvider.selectedTheme,
                            'image': quizProvider.imageFile,
                          };

                          Navigator.pushNamed(
                            context,
                            '/createQuizQuestions',
                            arguments: quizData,
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
    );
  }
}
