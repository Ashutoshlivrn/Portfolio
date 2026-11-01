import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// App typography definitions using Google Fonts Inter and JetBrains/Fira Code for tech accents.
abstract class AppTypography {
  static TextStyle displayLarge(BuildContext context) => GoogleFonts.inter(
        fontSize: 48,
        fontWeight: FontWeight.w800,
        letterSpacing: -1.2,
      );

  static TextStyle displayMedium(BuildContext context) => GoogleFonts.inter(
        fontSize: 36,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.8,
      );

  static TextStyle headlineLarge(BuildContext context) => GoogleFonts.inter(
        fontSize: 28,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.5,
      );

  static TextStyle headlineMedium(BuildContext context) => GoogleFonts.inter(
        fontSize: 22,
        fontWeight: FontWeight.w600,
      );

  static TextStyle titleLarge(BuildContext context) => GoogleFonts.inter(
        fontSize: 18,
        fontWeight: FontWeight.w600,
      );

  static TextStyle bodyLarge(BuildContext context) => GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        height: 1.6,
      );

  static TextStyle bodyMedium(BuildContext context) => GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        height: 1.5,
      );

  static TextStyle labelMedium(BuildContext context) => GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.5,
      );

  static TextStyle codeFont({
    double fontSize = 13,
    FontWeight fontWeight = FontWeight.w500,
    Color? color,
  }) =>
      GoogleFonts.firaCode(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
      );
}
