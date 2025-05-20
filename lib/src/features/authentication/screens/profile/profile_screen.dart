import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../../../../constants/size.dart';
import '../../../../constants/text_strings.dart';

import 'widget/profile_menu_widget.dart';
import 'widget/streak_calendar_widget.dart';
import 'account_settings_screen.dart';
import 'widget/update_profile_pic_widget.dart';
import '../../../../utils/theme/theme_controller.dart';
import '../../controllers/profile_image_controller.dart';

/// ProfileScreen displays the user's profile information along with settings and logout options.
///
/// Features:
/// - Shows the user's profile picture, with an edit icon to update the picture via a dialog.
/// - Displays a streak calendar widget indicating user activity streaks.
/// - Provides menu options:
///    - Account Settings (navigates to AccountSettingsScreen)
///    - Logout (shows confirmation dialog before logging out)
/// - Supports dark and light themes, adapting colors accordingly.
/// - Theme toggle button in the app bar to switch between light and dark modes.
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Detect if the current theme is dark for adaptive UI coloring
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = isDark ? null : const Color(0xFFE6F4EA);

    // Colors for icons based on theme for better visibility
    final iconBackground = isDark ? Colors.lightGreenAccent : Colors.green;
    final iconColor = isDark ? Colors.black : Colors.white;

    // Controller to manage the selected profile image reactively
    final profileImageController = Get.find<ProfileImageController>();

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        leading: IconButton(
          onPressed: () => Get.back(), // Navigate back
          icon: const Icon(LineAwesomeIcons.angle_left),
        ),
        title: Text(
          tProfile, // Title from constants
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        actions: [
          // Reactive theme toggle button using GetX
          Obx(() {
            final isDark = ThemeController.to.themeMode == ThemeMode.dark;
            return IconButton(
              onPressed: () => ThemeController.to.toggleTheme(),
              icon: Icon(isDark ? LineAwesomeIcons.sun : LineAwesomeIcons.moon),
            );
          }),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(tDefaultSize),
        child: Column(
          children: [
            /// Profile Image with edit option
            Obx(
              () => Stack(
                children: [
                  // Circular profile image from selected image path
                  SizedBox(
                    width: 120,
                    height: 120,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image.asset(
                        profileImageController.selectedImage.value,
                      ),
                    ),
                  ),
                  // Positioned edit icon in bottom-right corner of the profile picture
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: () => Get.dialog(const UpdateProfilePicWidget()),
                      child: Container(
                        width: 35,
                        height: 35,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: iconBackground,
                        ),
                        child: Icon(
                          LineAwesomeIcons.pen,
                          color: iconColor,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),

            // Subtitle text below profile image
            Text(
              tProfileSubHeading,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 20),

            // Some spacing before the streak calendar
            const SizedBox(height: 30),
            const StreakCalendarWidget(), // Displays user streak activity
            const SizedBox(height: 30),
            const Divider(),
            const SizedBox(height: 10),

            // Menu item for Account Settings
            ProfileMenuWidget(
              title: "Account Settings",
              icon: LineAwesomeIcons.cog,
              iconBackground: iconBackground,
              iconColor: iconColor,
              onPress: () => Get.to(() => const AccountSettingsScreen()),
            ),
            const Divider(),
            const SizedBox(height: 10),

            // Menu item for Logout
            ProfileMenuWidget(
              title: "Logout",
              icon: LineAwesomeIcons.alternate_sign_out,
              iconBackground: iconBackground,
              iconColor: iconColor,
              textColor: Colors.red, // Logout text in red for emphasis
              endIcon: false,
              onPress: () {
                // Show confirmation dialog before logout
                Get.defaultDialog(
                  title: "LOGOUT",
                  titleStyle: const TextStyle(fontSize: 20),
                  content: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 15.0),
                    child: Text("Are you sure you want to logout?"),
                  ),
                  confirm: ElevatedButton(
                    onPressed:
                        () => Get.offAllNamed(
                          '/login',
                        ), // Navigate to login screen clearing stack
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent,
                    ),
                    child: const Text("Yes"),
                  ),
                  cancel: OutlinedButton(
                    onPressed: () => Get.back(), // Cancel and close dialog
                    child: const Text("No"),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
