import 'package:flutter/material.dart';
import 'package:isl_kids_app/src/constants/text_strings.dart';
import 'package:isl_kids_app/src/constants/image_strings.dart';

/// A footer widget for the Sign Up screen.
///
/// This widget provides:
/// - A separator with "OR" text to distinguish between sign-up methods.
/// - A Google sign-in button styled as an outlined button with the Google logo and label.
/// - A TextButton that navigates the user to the login screen if they already have an account.
///
/// Usage:
/// Place this widget at the bottom of the sign-up form to offer alternative sign-in options
/// and a link to the login screen.
class SignUpFooterWidget extends StatelessWidget {
  const SignUpFooterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20.0), // Spacing above "OR" text
        const Text("OR"), // Separator text
        const SizedBox(height: 10.0), // Spacing below "OR"
        // Google sign-in button with logo and label
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: () {}, // TODO: Add Google sign-in logic
            icon: const Image(image: AssetImage(tGoogleLogoImage), width: 20.0),
            label: Text(tSignInWithGoogle.toUpperCase()),
          ),
        ),
        const SizedBox(height: 10.0), // Spacing below Google button
        // Text button prompting users to login if they already have an account
        TextButton(
          onPressed: () {
            Navigator.pushNamed(context, '/login'); // Navigate to login screen
          },
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: tAlreadyHaveAnAccount,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                TextSpan(
                  text: " ${tLogin.toUpperCase()}",
                  style: const TextStyle(
                    color: Colors.blue,
                  ), // Highlighted login text
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
