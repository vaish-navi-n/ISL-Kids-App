import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TTextTheme {
  // Light theme text styles
  static TextTheme lightTextTheme = TextTheme(
    // Headline style using Montserrat font with a dark color
    headlineSmall: GoogleFonts.montserrat(color: Colors.black87),

    // Title style using Poppins font with deep purple color and custom size
    titleMedium: GoogleFonts.poppins(color: Colors.deepPurple, fontSize: 24),

    // Body text style using Poppins font with readable dark color and size
    bodyLarge: GoogleFonts.poppins(color: Colors.black87, fontSize: 16),
  );

  // Dark theme text styles
  static TextTheme darkTextTheme = TextTheme(
    // Headline style using Montserrat font with a lighter shade for dark mode
    headlineSmall: GoogleFonts.montserrat(color: Colors.white70),

    // Title style using Poppins font with a white shade and custom size for dark mode
    titleMedium: GoogleFonts.poppins(color: Colors.white60, fontSize: 24),

    // Body text style using Poppins font with a readable light shade and size
    bodyLarge: GoogleFonts.poppins(color: Colors.white70, fontSize: 16),
  );
}
