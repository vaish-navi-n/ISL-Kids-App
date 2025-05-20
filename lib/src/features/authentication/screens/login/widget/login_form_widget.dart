import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

/// A StatefulWidget that provides a login form with email and password fields.
/// It handles validation, Firebase authentication, loading state, and error feedback.
class LoginFormWidget extends StatefulWidget {
  const LoginFormWidget({super.key});

  @override
  State<LoginFormWidget> createState() => _LoginFormWidgetState();
}

class _LoginFormWidgetState extends State<LoginFormWidget> {
  final _formKey =
      GlobalKey<FormState>(); // Key to identify the form and manage validation

  // Controllers to read and control the input from email and password TextFormFields
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isLoading = false; // Tracks whether the login process is in progress

  /// This async function attempts to login the user using Firebase Authentication.
  /// It first validates the form, then shows a loading indicator while authenticating.
  /// On success, it navigates to the dashboard.
  /// On failure, it shows an error snackbar with a specific message based on FirebaseAuthException.
  Future<void> _loginUser() async {
    if (_formKey.currentState!.validate()) {
      // Validate user inputs
      setState(() => _isLoading = true); // Show loading spinner

      try {
        // Sign in with email and password via Firebase
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text,
        );

        // Navigate to dashboard after successful login, replacing all previous routes
        Get.offAllNamed('/dashboard');
      } on FirebaseAuthException catch (e) {
        // Custom error messages for common Firebase Auth failures
        String message = 'Login failed';
        if (e.code == 'user-not-found') {
          message = 'No user found for that email';
        } else if (e.code == 'wrong-password') {
          message = 'Wrong password provided';
        }

        // Show error snackbar at the bottom with red background
        Get.snackbar(
          'Error',
          message,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red.shade200,
        );
      } finally {
        setState(() => _isLoading = false); // Hide loading spinner
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey, // Attach the form key for validation
      child: Column(
        children: [
          // Email input field with validation
          TextFormField(
            controller: _emailController,
            decoration: const InputDecoration(labelText: 'Email'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter email';
              }
              return null; // Valid input
            },
          ),
          const SizedBox(height: 16), // Space between fields
          // Password input field with obscured text and validation
          TextFormField(
            controller: _passwordController,
            decoration: const InputDecoration(labelText: 'Password'),
            obscureText: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter password';
              }
              return null; // Valid input
            },
          ),
          const SizedBox(height: 24), // Space before button
          // Show a CircularProgressIndicator if loading, else show login button
          _isLoading
              ? const CircularProgressIndicator()
              : ElevatedButton(
                onPressed: _loginUser, // Trigger login on button press
                child: const Text("LOGIN"),
              ),
        ],
      ),
    );
  }
}
