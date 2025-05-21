import 'package:flutter/material.dart';

/// Predefined color schemes for toast notifications
class ToastColors {
  // Private constructor to prevent instantiation
  ToastColors._();

  /// Colors for error toasts
  static Color get errorBackground => const Color(0xFFFF3A54);
  static Color get errorBorder => const Color(0xFFFF1F3D);
  static LinearGradient get errorGradient => const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xFFFF3A54), Color(0xFFFF5252)],
      );

  /// Colors for warning toasts
  static Color get warningBackground => const Color(0xFFFFB302);
  static Color get warningBorder => const Color(0xFFFFA000);
  static LinearGradient get warningGradient => const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xFFFFD54F), Color(0xFFFFB302)],
      );

  /// Colors for success toasts
  static Color get successBackground => const Color(0xFF2DCE89);
  static Color get successBorder => const Color(0xFF24B47E);
  static LinearGradient get successGradient => const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xFF2DCE89), Color(0xFF00B0FF)],
      );

  /// Colors for info toasts
  static Color get infoBackground => const Color(0xFF11CDEF);
  static Color get infoBorder => const Color(0xFF0FB5D4);
  static LinearGradient get infoGradient => const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xFF11CDEF), Color(0xFF007BFF)],
      );

  /// Colors for text
  static Color get lightText => Colors.white;
  static Color get darkText => Colors.black87;
}

/// Configure the appearance of toast notifications
class ToastTheme {
  /// Primary background color
  final Color backgroundColor;

  /// Border color
  final Color borderColor;

  /// Text color
  final Color textColor;

  /// Icon color
  final Color iconColor;

  /// Icon to display
  final IconData iconData;

  /// Optional gradient background
  final LinearGradient? gradient;

  /// Border radius for the toast container
  final double borderRadius;

  /// Border width
  final double borderWidth;

  /// Padding inside the toast
  final EdgeInsetsGeometry padding;

  /// Create a custom toast theme
  const ToastTheme({
    required this.backgroundColor,
    required this.borderColor,
    required this.iconData,
    this.textColor = Colors.white,
    this.iconColor = Colors.white,
    this.gradient,
    this.borderRadius = 8.0,
    this.borderWidth = 1.0,
    this.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
  });

  /// Error theme (red)
  factory ToastTheme.error() => ToastTheme(
        backgroundColor: ToastColors.errorBackground,
        borderColor: ToastColors.errorBorder,
        iconData: Icons.error_outline,
        gradient: ToastColors.errorGradient,
      );

  /// Warning theme (amber)
  factory ToastTheme.warning() => ToastTheme(
        backgroundColor: ToastColors.warningBackground,
        borderColor: ToastColors.warningBorder,
        iconData: Icons.warning_amber_outlined,
        textColor: ToastColors.darkText,
        iconColor: ToastColors.darkText,
        gradient: ToastColors.warningGradient,
      );

  /// Success theme (green)
  factory ToastTheme.success() => ToastTheme(
        backgroundColor: ToastColors.successBackground,
        borderColor: ToastColors.successBorder,
        iconData: Icons.check_circle_outline,
        gradient: ToastColors.successGradient,
      );

  /// Info theme (blue)
  factory ToastTheme.info() => ToastTheme(
        backgroundColor: ToastColors.infoBackground,
        borderColor: ToastColors.infoBorder,
        iconData: Icons.info_outline,
        gradient: ToastColors.infoGradient,
      );
}
