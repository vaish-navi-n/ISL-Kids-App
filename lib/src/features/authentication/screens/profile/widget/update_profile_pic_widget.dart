import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/profile_image_controller.dart';
import '../../../../../constants/image_strings.dart';

/// A dialog widget that allows users to select and update their profile picture.
/// Displays a selection of preset avatar images in a grid layout.
/// On selecting an image, updates the profile picture via the ProfileImageController
/// and then closes the dialog.
class UpdateProfilePicWidget extends StatelessWidget {
  const UpdateProfilePicWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // Retrieve the ProfileImageController instance using GetX dependency injection
    final controller = Get.find<ProfileImageController>();

    // List of available avatar image asset paths
    final images = [tBoy1, tBoy2, tGirl1, tGirl2, tGirl3];

    return Dialog(
      // Semi-transparent purple background with rounded corners
      backgroundColor: const Color.fromARGB(255, 126, 76, 179).withOpacity(0.9),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        padding: const EdgeInsets.all(16),
        height: 320,
        child: Column(
          children: [
            // Title text at the top of the dialog
            const Text(
              'Select Profile Picture',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            // Wrap widget creates a responsive grid-like layout with spacing
            Wrap(
              spacing: 10, // Horizontal spacing between avatars
              runSpacing: 10, // Vertical spacing between rows
              children:
                  images.map((imagePath) {
                    return GestureDetector(
                      onTap: () {
                        // When an avatar is tapped, update the profile image in controller
                        controller.setImage(imagePath);
                        // Close the dialog
                        Get.back();
                      },
                      child: CircleAvatar(
                        radius: 40,
                        backgroundImage: AssetImage(
                          imagePath,
                        ), // Display avatar image
                      ),
                    );
                  }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
