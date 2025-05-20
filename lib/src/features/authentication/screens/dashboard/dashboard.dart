import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/profile_image_controller.dart';
import '../profile/profile_screen.dart'; // Adjust import as needed

/// A simple Dashboard screen with an AppBar and user profile avatar.
/// Tapping the avatar navigates to the ProfileScreen.
class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    // Access the ProfileImageController using GetX for reactive state management
    final profileImageController = Get.find<ProfileImageController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          // Reactively update the profile image using Obx
          Obx(
            () => GestureDetector(
              onTap: () {
                // Navigate to the ProfileScreen when the avatar is tapped
                Get.to(() => const ProfileScreen());
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 12.0),
                child: CircleAvatar(
                  radius: 20,
                  // Display the currently selected profile image
                  backgroundImage: AssetImage(
                    profileImageController.selectedImage.value,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),

      // Main body of the Dashboard
      body: const Center(child: Text('Welcome to Dashboard!')),
    );
  }
}
