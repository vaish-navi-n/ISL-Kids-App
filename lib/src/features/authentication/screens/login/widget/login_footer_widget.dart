import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// LoginFooterWidget provides the footer section for the login screen.
/// It includes:
/// - A button to sign in with Google (currently without logic),
/// - A prompt to navigate to the Sign Up screen if the user doesn't have an account.
class LoginFooterWidget extends StatelessWidget {
  const LoginFooterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize:
          MainAxisSize.min, // Wraps content vertically without extra space
      children: [
        const SizedBox(height: 20), // Spacing above the Google sign-in button
        // Google Sign-in button with icon and label
        TextButton.icon(
          onPressed: () {
            // TODO: Add Google sign-in authentication logic here
          },
          icon: const Icon(Icons.login),
          label: const Text('Sign in with Google'),
        ),

        const SizedBox(height: 10), // Spacing between buttons
        // Centered text button prompting users to sign up if they don't have an account
        Center(
          child: TextButton(
            onPressed:
                () => Get.toNamed(
                  '/signup',
                ), // Navigates to Sign Up screen using GetX
            child: const Text.rich(
              TextSpan(
                text: "Don't have an account? ",
                children: [
                  // "Sign Up" text with bold styling for emphasis
                  TextSpan(
                    text: "Sign Up",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
