import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizzy/data/provider/ws.dart';
import '../app_colors.dart';
import '../app_fonts.dart';

Future<void> showConfirmExitDialog(BuildContext context) async {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext ctx) {
      return Dialog(
        backgroundColor: AppColors.anthraciteBlack,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
          side: const BorderSide(color: AppColors.royalPurple, width: 1),
        ),
        child: SizedBox(
          width: 250,
          height: 250,
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Be careful',
                      style: TextStyle(
                        fontFamily: AppFonts.montserrat,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: AppColors.lightGrey,
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Are you sure you want to leave the game ?',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: AppFonts.lato,
                        fontSize: 18,
                        color: AppColors.lightGrey,
                      ),
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop(); // Close dialog
                          Provider.of<WebSocketService>(context, listen: false).disconnect();
                          Navigator.pushNamedAndRemoveUntil(
                              context, '/home', (route) => false);
                          
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.royalPurple,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        child: const Text(
                          'Confirm',
                          style: TextStyle(
                            fontFamily: AppFonts.lato,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColors.lightGrey,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 8,
                right: 8,
                child: IconButton(
                  icon: const Icon(Icons.close, color: AppColors.lightGrey),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
