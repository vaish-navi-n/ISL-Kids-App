import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isl_kids_app/src/features/authentication/screens/forgot_password/forgot_password_options/forgot_password_bottom_sheet.dart';

/// LoginScreen is a stateless widget that provides a UI for user login
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // App bar with title
      appBar: AppBar(title: const Text("Login")),

      // Main body content with padding
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch, // Full-width widgets
          children: [
            // Email input field
            const TextField(decoration: InputDecoration(labelText: 'Email')),

            const SizedBox(height: 16),

            // Password input field
            const TextField(
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true, // Hides text for password security
            ),

            const SizedBox(height: 10),

            // "Forgot Password?" link aligned to the right
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  // Opens the bottom sheet for password reset options
                  ForgetPasswordScreen.buildShowModalBottomSheet(context);
                },
                child: const Text("Forgot Password?"),
              ),
            ),

            const SizedBox(height: 10),

            // Login button that navigates to the dashboard
            ElevatedButton(
              onPressed:
                  () => Get.toNamed('/dashboard'), // TODO: Add auth logic
              child: const Text("Login"),
            ),

            const SizedBox(height: 10),

            // Google login button (visual only for now)
            TextButton.icon(
              onPressed: () {
                // TODO: Add Google sign-in logic
              },
              icon: Image.asset('assets/images/google_logo.png', height: 24),
              label: const Text("Login with Google"),
            ),

            const Spacer(), // Pushes the signup link to the bottom
            // Signup prompt
            Center(
              child: TextButton(
                onPressed:
                    () => Get.toNamed('/signup'), // Navigate to signup screen
                child: const Text("Don't have an account? Sign Up"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
