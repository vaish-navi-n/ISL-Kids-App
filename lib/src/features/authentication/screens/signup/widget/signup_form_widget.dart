import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpFormWidget extends StatelessWidget {
  const SignUpFormWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Email input field
        const TextField(decoration: InputDecoration(labelText: 'Email')),
        const SizedBox(height: 16), // Spacer between fields
        // Password input field with hidden text
        const TextField(
          decoration: InputDecoration(labelText: 'Password'),
          obscureText: true,
        ),
        const SizedBox(height: 24), // Spacer before the button
        // Signup button, navigates to dashboard on press
        ElevatedButton(
          onPressed: () => Get.toNamed('/dashboard'),
          child: const Text("SIGNUP"),
        ),
        const SizedBox(height: 10), // Spacer before login prompt
        // Navigation to login screen for existing users
        TextButton(
          onPressed: () => Get.toNamed('/login'),
          child: const Text("Already have an account? LOGIN"),
        ),
      ],
    );
  }
}
