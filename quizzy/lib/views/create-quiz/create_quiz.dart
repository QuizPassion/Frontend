import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quizzy/core/app_colors.dart';
import 'package:quizzy/core/app_fonts.dart';
import 'package:quizzy/core/widgets/quizzy_text_field.dart';
import 'package:quizzy/core/widgets/save_button.dart';

import '../../core/widgets/quizzy_scaffold.dart';

class CreateQuizPage extends StatefulWidget {
  const CreateQuizPage({super.key});

  @override
  State<CreateQuizPage> createState() => _CreateQuizPageState();
}

class _CreateQuizPageState extends State<CreateQuizPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  String? selectedTheme;
  File? imageFile;
  bool isLoading = false;

  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
    }
  }

  void _saveQuiz() {
    if (nameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Le nom du quiz est requis")),
      );
      return;
    }

    final quizData = {
      'quiz_name': nameController.text,
      'description': descriptionController.text,
      'theme': selectedTheme,
      'image': imageFile,
    };

    print('=== DONNÉES DU QUIZ ===');
    print('Nom du quiz: ${nameController.text}');
    print('Description: ${descriptionController.text}');
    print('Thème: $selectedTheme');
    print('Image: $imageFile');
    print('=====================');

    Navigator.pushNamed(context, '/createQuizQuestions', arguments: quizData);
  }

  @override
  Widget build(BuildContext context) {

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
                  onTap: () => _pickImage(),
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.deepLavender, width: 1),
                    ),
                    child: ClipOval(
                      child: imageFile != null
                          ? Image.file(imageFile!, fit: BoxFit.cover)
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
                controller: nameController,
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
                controller: descriptionController,
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
                value: selectedTheme,
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
                  setState(() {
                    selectedTheme = newValue;
                  });
                },
              ),

              const SizedBox(height: 24),
              Center(
                child: isLoading
                    ? const CircularProgressIndicator(color: AppColors.deepLavender)
                    : SaveButton(
                        onPressed: () {
                          _saveQuiz();
                        },
                      ),
              ),
            ],
          ),
        ),
    );
  }
}
