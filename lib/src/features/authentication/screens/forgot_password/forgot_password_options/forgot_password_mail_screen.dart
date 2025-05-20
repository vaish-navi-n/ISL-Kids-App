import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'otp_screen.dart';

/// This screen allows the user to enter their email address to initiate the password reset process.
class ForgetPasswordMailScreen extends StatelessWidget {
  const ForgetPasswordMailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      // Ensures the UI avoids notches, status bar, etc.
      child: Scaffold(
        body: SingleChildScrollView(
          // Makes the content scrollable to avoid overflow
          padding: const EdgeInsets.all(
            24.0,
          ), // Adds padding around the content
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment
                    .center, // Center aligns child widgets horizontally
            children: [
              const SizedBox(height: 100), // Adds top spacing
              // Title text
              Text(
                "FORGOT PASSWORD",
                style: Theme.of(context).textTheme.headlineSmall,
                textAlign: TextAlign.center,
              ),

              const SizedBox(
                height: 10.0,
              ), // Spacing between title and subtitle
              // Subtitle/Instruction text
              Text(
                "Select one of the options given below to reset your password.",
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 30.0), // Spacing before the input field
              // Email input field
              TextFormField(
                decoration: const InputDecoration(
                  label: Text("Email"),
                  hintText: "Email",
                  prefixIcon: Icon(Icons.mail_outline_rounded),
                ),
              ),

              const SizedBox(height: 20.0), // Spacing before the button
              // Button to proceed to the OTP screen
              SizedBox(
                width: double.infinity, // Makes the button full-width
                child: ElevatedButton(
                  onPressed: () {
                    // Navigates to the OTP verification screen
                    Get.to(() => const OTPScreen());
                  },
                  child: const Text("Next"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
