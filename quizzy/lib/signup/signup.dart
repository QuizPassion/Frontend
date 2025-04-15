import 'package:flutter/material.dart';
import '../core/app_colors.dart';
import '../core/app_fonts.dart';
import '../core/widgets/background_decoration.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

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
                // Title
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

                // Username
                SizedBox(
                  width: 300,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "Username",
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: AppFonts.lato,
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(height: 8),
                      SizedBox(
                        height: 40,
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: "Fan2StarWars",
                            filled: true,
                            fillColor: AppColors.lightGrey,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(5)),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: EdgeInsets.symmetric(horizontal: 12),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),


                const SizedBox(height: 20),

                // Email
                SizedBox(
                  width: 300,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "Email",
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: AppFonts.lato,
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(height: 8),
                      SizedBox(
                        height: 40,
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: "fan2StarWars@gmail.com",
                            filled: true,
                            fillColor: AppColors.lightGrey,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(5)),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: EdgeInsets.symmetric(horizontal: 12),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // Password 
                SizedBox(
                  width: 300,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "Password",
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: AppFonts.lato,
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(height: 8),
                      SizedBox(
                        height: 40,
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: "************",
                            filled: true,
                            fillColor: AppColors.lightGrey,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(5)),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: EdgeInsets.symmetric(horizontal: 12),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 40),

                // SignUp 
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
                    onPressed: () {
                      Navigator.pushNamed(context, '/home');
                    },
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

                // Login
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
}
