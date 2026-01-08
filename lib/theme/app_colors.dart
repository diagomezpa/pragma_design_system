import 'package:flutter/painting.dart';

/// AppColors - Tokens de color semánticos para el sistema de diseño
///
/// This class provides color tokens following Material 3 design principles.
/// Colors are defined semantically based on their purpose and meaning, 
/// not tied to specific UI components.
///
/// The color system includes both light and dark variants to ensure
/// accessibility and visual consistency across different user preferences
/// and system settings.
///
/// Usage:
/// ```dart
/// // Access light theme colors
/// final lightColors = AppColors.light;
/// Color primaryColor = lightColors.primary;
///
/// // Access dark theme colors  
/// final darkColors = AppColors.dark;
/// Color primaryColor = darkColors.primary;
/// ```
class AppColors {
  const AppColors._({
    required this.primary,
    required this.onPrimary,
    required this.secondary,
    required this.onSecondary,
    required this.background,
    required this.surface,
    required this.error,
    required this.onError,
    required this.onSurface,
    required this.onSurfaceVariant,
    required this.outline,
  });

  /// Primary brand color used for key components and actions.
  /// Should be the most prominent color in your design system.
  /// Used for primary buttons, selected states, and brand elements.
  final Color primary;

  /// Color used for text and icons on top of primary color.
  /// Must provide sufficient contrast against primary for accessibility.
  final Color onPrimary;

  /// Secondary brand color for supporting elements.
  /// Complements the primary color and provides visual hierarchy.
  /// Used for secondary buttons, toggles, and accent elements.
  final Color secondary;

  /// Color used for text and icons on top of secondary color.
  /// Must provide sufficient contrast against secondary for accessibility.
  final Color onSecondary;

  /// Primary background color for the app.
  /// Used as the main canvas color behind all content.
  /// Should be neutral and provide good readability.
  final Color background;

  /// Surface color for elevated components.
  /// Used for cards, sheets, dialogs, and other elevated surfaces.
  /// Typically slightly different from background to show elevation.
  final Color surface;

  /// Error color for indicating problems and destructive actions.
  /// Used for error messages, form validation, and warning states.
  /// Should be clearly distinguishable and attention-grabbing.
  final Color error;

  /// Color used for text and icons on top of error color.
  /// Must provide sufficient contrast against error for accessibility.
  final Color onError;

  /// Primary color for text and icons on surface colors.
  /// Used for body text, headlines, and primary content.
  /// Should have high contrast against surface and background.
  final Color onSurface;

  /// Secondary color for text and icons on surface colors.
  /// Used for supporting text, captions, and disabled content.
  /// Has medium contrast - less prominent than onSurface.
  final Color onSurfaceVariant;

  /// Outline color for borders and dividers.
  /// Used for component outlines, dividers, and subtle separators.
  /// Provides gentle visual separation without being intrusive.
  final Color outline;

  /// Light theme color scheme optimized for fintech applications.
  /// Features clean, professional colors with high contrast ratios.
  /// Primary color uses a trustworthy blue suitable for financial apps.
  static const light = AppColors._(
    // Primary - Professional blue for trust and reliability
    primary: Color(0xFF1565C0),        // Blue 800
    onPrimary: Color(0xFFFFFFFF),      // Pure white

    // Secondary - Complementary teal for accent elements  
    secondary: Color(0xFF00796B),      // Teal 700
    onSecondary: Color(0xFFFFFFFF),    // Pure white

    // Neutrals - Clean and minimal background system
    background: Color(0xFFFAFAFA),     // Very light grey
    surface: Color(0xFFFFFFFF),        // Pure white

    // Semantic colors - Clear error indication
    error: Color(0xFFD32F2F),          // Red 700
    onError: Color(0xFFFFFFFF),        // Pure white

    // Text colors - High contrast for readability
    onSurface: Color(0xFF212121),      // Grey 900 - primary text
    onSurfaceVariant: Color(0xFF757575), // Grey 600 - secondary text
    
    // Outline - Subtle borders and dividers
    outline: Color(0xFFE0E0E0),        // Grey 300
  );

  /// Dark theme color scheme optimized for true dark environments.
  /// Features deep blacks with high contrast and accessibility.
  /// Reduces eye strain in low-light conditions while maintaining readability.
  static const dark = AppColors._(
    // Primary - Brighter blue for dark theme visibility
    primary: Color(0xFF42A5F5),        // Blue 400
    onPrimary: Color(0xFF000000),      // True black

    // Secondary - Vivid teal for dark theme accent
    secondary: Color(0xFF4DB6AC),      // Teal 300  
    onSecondary: Color(0xFF000000),    // True black

    // Neutrals - True dark background system
    background: Color(0xFF000000),     // True black
    surface: Color(0xFF121212),        // Very dark grey

    // Semantic colors - Accessible error for dark theme
    error: Color(0xFFEF5350),          // Red 400
    onError: Color(0xFF000000),        // True black

    // Text colors - High contrast white text
    onSurface: Color(0xFFFFFFFF),      // Pure white - primary text
    onSurfaceVariant: Color(0xFFBDBDBD), // Grey 400 - secondary text
    
    // Outline - Visible borders for dark theme
    outline: Color(0xFF424242),        // Grey 800
  );
}