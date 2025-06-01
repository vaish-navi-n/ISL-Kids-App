import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isl_kids_app/src/features/authentication/repository/authentication_repository.dart'; // Import the AuthenticationRepository
import 'package:isl_kids_app/src/features/authentication/screens/signup/widget/signup_form_widget.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

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