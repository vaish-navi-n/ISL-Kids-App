import 'package:flutter/material.dart';

/// A reusable widget for displaying a form header
/// that includes an image, a title, and a subtitle.
class FormHeaderWidget extends StatelessWidget {
  // Constructor with optional and required parameters
  const FormHeaderWidget({
    super.key,
    this.imageColor, // Optional: color overlay for the image
    this.heightBetween = 20.0, // Space between image and text
    required this.image, // Required: path to the image asset
    required this.title, // Required: main heading text
    required this.subTitle, // Required: subheading/description text
    this.imageHeight = 0.2, // Fraction of screen height the image should occupy
    this.textAlign, // Optional: alignment for subtitle text
    this.crossAxisAlignment =
        CrossAxisAlignment.start, // Alignment of the column's children
  });

  // Properties of the widget
  final Color? imageColor;
  final double imageHeight;
  final double heightBetween;
  final String image, title, subTitle;
  final CrossAxisAlignment crossAxisAlignment;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    // Get the size of the screen to calculate image height
    final size = MediaQuery.of(context).size;

    return Column(
      crossAxisAlignment:
          crossAxisAlignment, // Align children horizontally in the column
      children: [
        // Display the image from asset with optional color and scaled height
        Image(
          image: AssetImage(image),
          color: imageColor,
          height: size.height * imageHeight,
        ),
        // Add vertical space between image and text
        SizedBox(height: heightBetween),

        // Display the title using the app's headline style
        Text(title, style: Theme.of(context).textTheme.headlineSmall),

        // Display the subtitle with optional alignment and body text style
        Text(
          subTitle,
          textAlign: textAlign,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }
}
