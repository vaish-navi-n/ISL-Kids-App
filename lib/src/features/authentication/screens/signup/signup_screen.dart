import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:isl_kids_app/src/features/authentication/screens/signup/widget/signup_form_widget.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  // Function to register user with Firebase Authentication
  Future<void> registerUser(
    String email,
    String password,
    BuildContext context,
  ) async {
    try {
      // Initialize Firebase Authentication instance
      final auth = FirebaseAuth.instance;

      // Create user account using email and password
      await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      print("User registered: $email");

      // Show success message on successful registration
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Account created successfully!')));

      // Navigate to home/profile or login screen after successful signup
      // Uncomment the below line to enable navigation
      // Navigator.pushReplacementNamed(context, '/profile');
    } on FirebaseAuthException catch (e) {
      // Display error message in case of Firebase Authentication failure
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message ?? 'Registration failed')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Sign Up")),
      body: const Padding(
        padding: EdgeInsets.all(24.0),
        // Displays the signup form widget
        child: SignUpFormWidget(),
      ),
    );
  }
}
