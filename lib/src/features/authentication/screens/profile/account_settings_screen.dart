import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// A screen that allows users to manage their account settings.
/// Provides two primary actions:
/// 1. Reset Progress - Resets the user's progress with a confirmation dialog.
/// 2. Delete Account - Permanently deletes the user's account with a confirmation dialog.
///
/// The screen adapts its colors based on the current theme (dark or light).
/// It also displays a decorative image at the bottom.
///
/// Uses GetX for navigation, dialogs, and snackbars.
class AccountSettingsScreen extends StatelessWidget {
  const AccountSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Determine if current theme is dark to adjust colors accordingly
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Button color varies by theme: lighter red for dark mode, standard red for light mode
    final buttonColor = isDark ? Colors.red.shade300 : Colors.red;

    // Background color is light green in light mode; defaults in dark mode
    final backgroundColor = isDark ? null : const Color(0xFFE6F4EA);

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        title: const Text('Account Settings'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(), // Navigate back when pressed
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            /// Reset Progress Button
            FilledButton(
              style: FilledButton.styleFrom(backgroundColor: buttonColor),
              onPressed: () {
                // Show confirmation dialog before resetting progress
                Get.defaultDialog(
                  title: "Reset Progress",
                  titleStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  content: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Text("This will reset your progress. Are you sure?"),
                  ),
                  confirm: ElevatedButton(
                    onPressed: () {
                      // TODO: Implement reset progress logic here
                      Get.back(); // Close dialog
                      Get.snackbar(
                        "Progress Reset",
                        "Your progress has been reset.",
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent,
                    ),
                    child: const Text("Yes"),
                  ),
                  cancel: OutlinedButton(
                    onPressed: () => Get.back(), // Close dialog without action
                    child: const Text("No"),
                  ),
                );
              },
              child: const Text("Reset Progress"),
            ),
            const SizedBox(height: 20),

            /// Delete Account Button
            FilledButton(
              style: FilledButton.styleFrom(backgroundColor: buttonColor),
              onPressed: () {
                // Show confirmation dialog before deleting account
                Get.defaultDialog(
                  title: "Delete Account",
                  titleStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  content: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Text(
                      "This will permanently delete your account. Are you sure?",
                    ),
                  ),
                  confirm: ElevatedButton(
                    onPressed: () {
                      // TODO: Implement account deletion logic here
                      Get.back(); // Close dialog
                      Get.snackbar(
                        "Account Deleted",
                        "Your account has been deleted.",
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent,
                    ),
                    child: const Text("Delete"),
                  ),
                  cancel: OutlinedButton(
                    onPressed: () => Get.back(), // Close dialog without action
                    child: const Text("Cancel"),
                  ),
                );
              },
              child: const Text("Delete Account"),
            ),
            const SizedBox(height: 20),

            /// Decorative image to add visual interest at the bottom of the screen
            Expanded(
              child: Center(
                child: Image.asset(
                  'assets/images/two_peeps.png',
                  width: 500,
                  height: 500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
