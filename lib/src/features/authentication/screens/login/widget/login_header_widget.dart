import 'package:flutter/material.dart';

/// A simple stateless widget that displays the header section
/// for the login screen, including a welcome message and a subtitle.
class LoginHeaderWidget extends StatelessWidget {
  const LoginHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.start, // Align text to the start (left)
      children: [
        const SizedBox(height: 40), // Adds vertical spacing at the top
        Text(
          'Welcome to ISL Kids', // Main header text
          style: Theme.of(context)
              .textTheme
              .headlineSmall // Uses theme's headlineSmall style
              ?.copyWith(fontWeight: FontWeight.bold), // Makes font bold
        ),
        const SizedBox(height: 8), // Small space between header and subtitle
        Text(
          'Learn Indian Sign Language in a fun and easy way!', // Subtitle text
          style:
              Theme.of(
                context,
              ).textTheme.bodyLarge, // Uses bodyLarge style from theme
        ),
        const SizedBox(height: 30), // Adds space below the header section
      ],
    );
  }
}
