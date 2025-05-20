import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import '../../../../../constants/colors.dart';

/// A customizable profile menu item widget used in profile screens or settings.
/// Displays an icon with background, a title, and optionally a trailing arrow icon.
class ProfileMenuWidget extends StatelessWidget {
  const ProfileMenuWidget({
    super.key,
    required this.title, // Text label of the menu item
    required this.icon, // IconData to show on the left
    required this.onPress, // Callback when the item is tapped
    this.endIcon =
        true, // Whether to show the trailing arrow icon (default true)
    this.textColor, // Optional text color override
    this.iconBackground, // Optional background color for the icon circle
    this.iconColor, // Optional color for the icon itself
  });

  final String title;
  final IconData icon;
  final VoidCallback onPress;
  final bool endIcon;
  final Color? textColor;

  /// Optional colors to customize icon background and icon color.
  final Color? iconBackground;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    // Determine if the device is using dark mode
    final isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;

    // Use provided colors or fallback to defaults based on theme
    final resolvedIconColor =
        iconColor ?? (isDark ? tPrimaryColor : tAccentColor);
    final resolvedIconBackground =
        iconBackground ?? resolvedIconColor.withOpacity(0.1);

    return ListTile(
      onTap: onPress,
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100), // Circular shape
          color: resolvedIconBackground, // Background color with opacity
        ),
        child: Icon(icon, color: resolvedIconColor), // Icon with chosen color
      ),
      title: Text(
        title,
        style: Theme.of(context).textTheme.bodyLarge?.apply(color: textColor),
      ),
      // Conditionally show trailing arrow icon inside a subtle circle
      trailing:
          endIcon
              ? Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: Colors.grey.withOpacity(0.1),
                ),
                child: const Icon(
                  LineAwesomeIcons.angle_right,
                  size: 18.0,
                  color: Colors.grey,
                ),
              )
              : null,
    );
  }
}
