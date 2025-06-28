import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../core/app_colors.dart';
import '../../core/app_fonts.dart';
import '../../core/widgets/background_decoration.dart';
import '../../data/viewmodel/auth_view_model.dart';
import '../../data/provider/user_provider.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  File? _avatar;
  bool _isLoading = false;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _avatar = File(pickedFile.path);
      });
    } else {
      _avatar = null;
    }
  }

  // email validation 
  bool _isEmailValid(String email) {
    final emailRegex = RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");
    return emailRegex.hasMatch(email);
  }

  bool _isPasswordValid(String password) {
    // At least 8 characters, 1 uppercase, 1 number, 1 special character
    final passwordRegex = RegExp(r'^(?=.*[A-Z])(?=.*\d)(?=.*[!@#\$&*~_\-\^%+=.,:;?/\\|<>]).{8,}$');
    return passwordRegex.hasMatch(password);
  }

  void _signUp() async {
    final username = _usernameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (username.isEmpty || email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill in all fields")),
      );
      return;
    }

    if (!_isEmailValid(email)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter a valid email")),
      );
      return;
    }

    if (!_isPasswordValid(password)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter a valid password : \nAt least 8 characters, 1 uppercase letter, 1 number, and 1 special character.")),
      );
      return;
    }

    setState(() => _isLoading = true);

    final authViewModel = Provider.of<AuthViewModel>(context, listen: false);
    final success = await authViewModel.signUp(
      context: context,
      username: username,
      email: email,
      password: password,
      avatarFile: _avatar,
    );

    setState(() => _isLoading = false);

    if (success) {
      // Si l'inscription réussit, récupérer le profil utilisateur
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      await userProvider.fetchUserProfile();

      // Naviguer vers la page d'accueil ou une page spécifique
      Navigator.pushNamed(context, '/home');
    } else {
      // Afficher un message d'erreur détaillé si l'inscription échoue
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Signup failed. Try again.")),
      );
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.anthraciteBlack,
      body: BackgroundDecoration(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Sign Up",
                  style: TextStyle(
                    fontFamily: AppFonts.montserrat,
                    color: Colors.white,
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 40),

                // Avatar picker
                GestureDetector(
                  onTap: _pickImage,
                  child: CircleAvatar(
                    radius: 40,
                    backgroundImage: _avatar != null ? FileImage(_avatar!) : null,
                    backgroundColor: AppColors.lightGrey,
                    child: _avatar == null
                        ? const Icon(Icons.camera_alt, color: Colors.white)
                        : null,
                  ),
                ),

                const SizedBox(height: 20),
                _buildTextField("Username", "Fan2StarWars", _usernameController),
                const SizedBox(height: 20),
                _buildTextField("Email", "fan2StarWars@gmail.com", _emailController),
                const SizedBox(height: 20),
                _buildTextField("Password", "************", _passwordController, obscure: true),
                const SizedBox(height: 40),

                // Sign Up Button
                SizedBox(
                  width: 270,
                  height: 40,
                  child: _isLoading
                      ? const Center(
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        )
                      : TextButton(
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          onPressed: _signUp,
                          child: Ink(
                            decoration: BoxDecoration(
                              gradient: AppColors.gradientLTR,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Container(
                              alignment: Alignment.center,
                              child: const Text(
                                "Sign Up",
                                style: TextStyle(
                                  fontFamily: AppFonts.lato,
                                  fontSize: 20,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                ),

                const SizedBox(height: 24),

                // Already have an account
                const Text(
                  "Already have an account ? Login here",
                  style: TextStyle(
                    fontFamily: AppFonts.lato,
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 10),

                // Login Button
                SizedBox(
                  width: 240,
                  height: 40,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, '/login');
                    },
                    child: Ink(
                      decoration: BoxDecoration(
                        gradient: AppColors.gradientRTL,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Container(
                        alignment: Alignment.center,
                        child: const Text(
                          "Login",
                          style: TextStyle(
                            fontFamily: AppFonts.lato,
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Helper function to build text fields
  Widget _buildTextField(String label, String hint, TextEditingController controller, {bool obscure = false}) {
    return SizedBox(
      width: 300,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontFamily: AppFonts.lato,
              fontSize: 20,
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 40,
            child: TextField(
              controller: controller,
              obscureText: obscure,
              enabled: !_isLoading,
              decoration: InputDecoration(
                hintText: hint,
                filled: true,
                fillColor: AppColors.lightGrey,
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 12),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
