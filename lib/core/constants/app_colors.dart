import 'package:flutter/material.dart';

/// App color palette designed for high-contrast, modern developer portfolios.
/// Provides rich dark mode tones (slate/indigo/cyan) and clean light mode tones.
abstract class AppColors {
  // Dark Theme Palette (Default for modern tech portfolios)
  static const Color darkBackground = Color(0xFF0B0F19);
  static const Color darkSurface = Color(0xFF111827);
  static const Color darkCard = Color(0xFF1E293B);
  static const Color darkCardHover = Color(0xFF273549);
  static const Color darkBorder = Color(0xFF334155);

  // Light Theme Palette
  static const Color lightBackground = Color(0xFFF8FAFC);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightCard = Color(0xFFFFFFFF);
  static const Color lightCardHover = Color(0xFFF1F5F9);
  static const Color lightBorder = Color(0xFFE2E8F0);

  // Accent & Brand Colors
  static const Color primary = Color(0xFF38BDF8); // Electric Sky / Flutter Cyan
  static const Color primaryDark = Color(0xFF0284C7);
  static const Color secondary = Color(0xFF818CF8); // Indigo Purple
  static const Color accent = Color(0xFF34D399); // Mint Emerald (Success / Live)
  static const Color warning = Color(0xFFFBBF24); // Amber
  static const Color error = Color(0xFFF87171);

  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFF38BDF8), Color(0xFF818CF8)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient accentGradient = LinearGradient(
    colors: [Color(0xFF818CF8), Color(0xFFC084FC)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient cardGlowGradient = LinearGradient(
    colors: [Color(0x2238BDF8), Color(0x05818CF8)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Text Colors - Dark Mode
  static const Color textPrimaryDark = Color(0xFFF8FAFC);
  static const Color textSecondaryDark = Color(0xFF94A3B8);
  static const Color textMutedDark = Color(0xFF64748B);

  // Text Colors - Light Mode
  static const Color textPrimaryLight = Color(0xFF0F172A);
  static const Color textSecondaryLight = Color(0xFF475569);
  static const Color textMutedLight = Color(0xFF94A3B8);
}
