import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../core/app_colors.dart';
import '../../core/app_fonts.dart';
import '../../core/widgets/background_decoration.dart';
import '../../data/viewmodel/auth_view_model.dart';

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

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _avatar = File(pickedFile.path);
      });
    } else {
      _avatar = null; // Reset avatar if no image is picked
    }
  }

  void _signUp() async {
    final username = _usernameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final avatarFile = _avatar;

    if (username.isEmpty || email.isEmpty || password.isEmpty || avatarFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill in all fields and select an image")),
      );
      return;
    }

    final authViewModel = Provider.of<AuthViewModel>(context, listen: false);
    final success = await authViewModel.signUp(
      username: username,
      email: email,
      password: password,
      avatarFile: avatarFile,
    );

    if (success) {
      Navigator.pushNamed(context, '/home');
    } else {
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
                  "Inscription",
                  style: TextStyle(
                    fontFamily: AppFonts.montserrat,
                    color: Colors.white,
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 40),

                // Avatar Picker
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

                // Username
                _buildTextField("Username", "Fan2StarWars", _usernameController),
                const SizedBox(height: 20),

                // Email
                _buildTextField("Email", "fan2StarWars@gmail.com", _emailController),
                const SizedBox(height: 20),

                // Password
                _buildTextField("Password", "************", _passwordController, obscure: true),
                const SizedBox(height: 40),

                // Sign Up Button
                SizedBox(
                  width: 270,
                  height: 40,
                  child: TextButton(
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

                const Text(
                  "Already have an account ? Login here",
                  style: TextStyle(
                    fontFamily: AppFonts.lato,
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 10),

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
