import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

/// This screen is used to enter the OTP sent to the user's email during password reset.
class OTPScreen extends StatelessWidget {
  const OTPScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(
          24.0,
        ), // Adds padding around the entire screen
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center, // Centers content vertically
          children: [
            // Main heading text
            Text(
              "Verification",
              style: GoogleFonts.montserrat(
                fontWeight: FontWeight.bold,
                fontSize: 40.0,
              ),
            ),

            // Subtitle/instruction
            Text(
              "ENTER THE OTP SENT TO YOUR EMAIL",
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 30.0), // Adds spacing before the email text
            // Info text about the email
            Text(
              "We’ve sent a verification code to your email. support@islkids.app",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall,
            ),

            const SizedBox(height: 20.0), // Adds spacing before the OTP field
            // OTP input field (6 boxes)
            OtpTextField(
              numberOfFields: 6, // Total number of digits
              borderColor: Theme.of(context).primaryColor,
              showFieldAsBox: true, // Box-style OTP fields
              onSubmit:
                  (code) => print("OTP is => \$code"), // Handle OTP submit
            ),

            const SizedBox(height: 20.0), // Adds spacing before the button
            // 'Next' button to verify the OTP
            SizedBox(
              width: double.infinity, // Full width button
              child: ElevatedButton(
                onPressed: () {
                  // TODO: Add OTP verification logic here
                },
                child: const Text("Next"),
              ),
            ),

            // Option to resend OTP
            TextButton(
              onPressed: () {
                // TODO: Add resend OTP logic here
              },
              child: const Text("Resend OTP"),
            ),
          ],
        ),
      ),
    );
  }
}
