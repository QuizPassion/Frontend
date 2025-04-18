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
import '../../data/network/api_service.dart';

class CreateQuizPage extends StatefulWidget {
  const CreateQuizPage({super.key});

  @override
  State<CreateQuizPage> createState() => _CreateQuizPageState();
}

class _CreateQuizPageState extends State<CreateQuizPage> {
  final _quizNameController = TextEditingController();
  final _descriptionController = TextEditingController();
  String? _selectedTheme; // Variable pour stocker le thème sélectionné
  final List<String> _themes = [
    'Science',
    'History',
    'Music',
    'Sports',
    'Movies',
    'Geography',
    'Literature',
  ]; // Liste de thèmes prédéfinis

  File? _imageFile;
  bool _isLoading = false;

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  Future<void> _submitQuiz() async {
    final name = _quizNameController.text.trim();
    final desc = _descriptionController.text.trim();
    final theme = _selectedTheme; // Récupère le thème sélectionné

    print('Name: $name, Description: $desc, Theme: $theme');

    if (name.isEmpty || desc.isEmpty || theme == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill in all fields")),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final response = await ApiService().createQuiz(
        name: name,
        description: desc,
        theme: theme,
        avatarFile: _imageFile,
      );

      print('Response: ${response.statusCode}'); // Affiche la réponse de l'API dans la console

      if (response.statusCode == 200) {
        final quizIdString = response.data['quiz_id'];
        final quizId = int.tryParse(quizIdString.toString());

        print('Quiz ID: $quizId'); // Affiche l'ID du quiz dans la console

        if (quizId is int) {
          // Si quiz_id est déjà un int, on le passe directement
          Navigator.pushNamed(
            context,
            '/createQuizQuestions',
            arguments: quizId,
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Invalid quiz ID format')),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to create quiz: ${response.statusCode}')),
        );
      }
    } catch (e) {
      print('Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('An error occurred while creating the quiz')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _quizNameController.dispose();
    _descriptionController.dispose();
    super.dispose();
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
                  onTap: _pickImage,
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.deepLavender, width: 1),
                    ),
                    child: ClipOval(
                      child: _imageFile != null
                          ? Image.file(_imageFile!, fit: BoxFit.cover)
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
                controller: _quizNameController,
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
                controller: _descriptionController,
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
                value: _selectedTheme,
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
                items: _themes.map((theme) {
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
                    _selectedTheme = newValue;
                  });
                },
              ),

              const SizedBox(height: 24),
              Center(
                child: _isLoading
                    ? const CircularProgressIndicator(color: AppColors.deepLavender)
                    : SaveButton(onPressed: _submitQuiz),
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
