import 'package:flutter/material.dart';

/// A reusable button widget for the "Forgot Password" screen options.
///
/// It displays an icon, a title, and a subtitle inside a styled container.
/// Useful for offering multiple password recovery methods (e.g., via Email or Phone).
class ForgetPasswordBtnWidget extends StatelessWidget {
  const ForgetPasswordBtnWidget({
    required this.btnIcon, // Icon to represent the method (e.g., email, phone)
    required this.title, // Title text (e.g., "Email", "Phone")
    required this.subTitle, // Subtitle text (e.g., "Reset via Email")
    required this.onTap, // Callback function triggered when tapped
    super.key,
  });

  final IconData btnIcon;
  final String title, subTitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, // Executes the callback when the widget is tapped
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0), // Rounded corners
          color: Colors.grey.shade200, // Light background color
        ),
        child: Row(
          children: [
            // Icon representing the reset method
            Icon(btnIcon, size: 60.0),
            const SizedBox(width: 10.0), // Space between icon and text
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Main title (e.g., "Email", "Phone")
                Text(title, style: Theme.of(context).textTheme.headlineSmall),
                // Subheading (e.g., "Reset via Email")
                Text(subTitle, style: Theme.of(context).textTheme.bodyMedium),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
