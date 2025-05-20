import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'forgot_password_mail_screen.dart';

/// This class contains a static method to show a modal bottom sheet for password reset options.
class ForgetPasswordScreen {
  /// Builds and shows a modal bottom sheet with options to reset password via Email or Phone.
  static Future<dynamic> buildShowModalBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          20.0,
        ), // Rounded top corners for bottom sheet
      ),
      builder:
          (context) => Container(
            padding: const EdgeInsets.all(
              24.0,
            ), // Adds padding inside the bottom sheet
            child: Column(
              mainAxisSize: MainAxisSize.min, // Takes only the space needed
              crossAxisAlignment:
                  CrossAxisAlignment
                      .start, // Aligns text and widgets to the start
              children: [
                // Title
                Text(
                  "Make Selection!",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                // Subtitle/Description
                Text(
                  "Select one of the options given below to reset your password.",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 30.0),

                // Button for resetting via Email
                ForgetPasswordBtnWidget(
                  onTap: () {
                    Navigator.pop(context); // Closes the bottom sheet
                    Get.to(
                      () => const ForgetPasswordMailScreen(),
                    ); // Navigates to email reset screen
                  },
                  title: "Email",
                  subTitle: "Reset via Email Verification",
                  btnIcon: Icons.mail_outline_rounded,
                ),

                const SizedBox(height: 20.0),

                // Button for resetting via Phone (to be implemented)
                ForgetPasswordBtnWidget(
                  onTap: () {
                    // TODO: Add phone verification logic here
                  },
                  title: "Phone Number",
                  subTitle: "Reset via Phone Verification",
                  btnIcon: Icons.mobile_friendly_rounded,
                ),
              ],
            ),
          ),
    );
  }
}

/// A reusable button widget used in the modal bottom sheet to represent password reset methods.
class ForgetPasswordBtnWidget extends StatelessWidget {
  const ForgetPasswordBtnWidget({
    required this.btnIcon, // Icon to visually represent the reset method
    required this.title, // Main title (e.g., Email, Phone)
    required this.subTitle, // Description or subtext
    required this.onTap, // Callback function executed on tap
    super.key,
  });

  final IconData btnIcon;
  final String title, subTitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, // Executes the tap callback
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 20,
          horizontal: 10.0,
        ), // Padding inside the button
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            10.0,
          ), // Rounded corners for button
          color: Colors.grey.shade200, // Light grey background
        ),
        child: Row(
          children: [
            // Icon representing the method
            Icon(btnIcon, size: 60.0),
            const SizedBox(width: 10.0),
            // Title and subtitle stacked vertically
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: Theme.of(context).textTheme.headlineSmall),
                Text(subTitle, style: Theme.of(context).textTheme.bodyMedium),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
