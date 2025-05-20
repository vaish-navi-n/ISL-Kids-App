import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // App title displayed at the center
            Text(
              "Welcome to ISL Kids App",
              style: Theme.of(context).textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),

            const SizedBox(
              height: 40,
            ), // Adds spacing between title and buttons
            // Login Button
            SizedBox(
              width: double.infinity, // Expands button to full width
              child: ElevatedButton(
                onPressed:
                    () => Get.toNamed('/login'), // Navigate to login screen
                child: const Text("Login"),
              ),
            ),

            const SizedBox(height: 20), // Adds spacing between buttons
            // Signup Button
            SizedBox(
              width: double.infinity, // Expands button to full width
              child: OutlinedButton(
                onPressed:
                    () => Get.toNamed('/signup'), // Navigate to signup screen
                child: const Text("Signup"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
