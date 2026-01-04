import 'package:flutter/material.dart';

/// AppTextTheme - Centralized typography system for the design system
///
/// This module provides a consistent, Material 3 compliant text theme that
/// adapts automatically to light and dark color schemes. The typography system
/// establishes a clear visual hierarchy and ensures optimal readability across
/// all components.
///
/// **Typography Principles:**
/// - **Hierarchy**: Clear distinction between headline, title, body, and label text
/// - **Readability**: Font sizes and weights optimized for mobile interfaces  
/// - **Accessibility**: Colors adapt to ensure sufficient contrast in all themes
/// - **Consistency**: Unified spacing and weight relationships across all styles
/// - **Material 3 Compliance**: Follows Google's latest typography guidelines
///
/// **Integration with AppText:**
/// This text theme integrates seamlessly with the AppText atom, providing
/// the foundation styles that AppText variants build upon. AppText's
/// _getBaseStyle() method relies on these theme definitions.
///
/// **Color Strategy:**
/// All text colors are derived from the provided ColorScheme to ensure
/// automatic adaptation between light and dark themes without hardcoded values.
///
/// Usage:
/// ```dart
/// final textTheme = appTextTheme(colorScheme);
/// final theme = ThemeData(
///   colorScheme: colorScheme,
///   textTheme: textTheme,
/// );
/// ```

/// Creates a Material 3 compliant TextTheme with adaptive colors.
///
/// The text theme establishes a typographic hierarchy optimized for mobile
/// interfaces while ensuring accessibility across light and dark themes.
/// All text colors automatically adapt based on the provided [colorScheme].
///
/// **Font Weight Hierarchy:**
/// - Headlines: Bold (700) for maximum impact and clear hierarchy
/// - Titles: Semi-bold (600) for section headers and important content
/// - Body: Regular (400) for optimal reading comfort  
/// - Labels: Medium (500) for UI elements and actions
///
/// **Size Progression:**
/// Font sizes follow a consistent scale that provides clear visual
/// distinction while maintaining readability at all device sizes.
TextTheme appTextTheme(ColorScheme colorScheme) {
  return TextTheme(
    // Headlines - Large display text for hero sections and major headings
    // Used for page titles and primary content headers
    headlineLarge: TextStyle(
      fontSize: 32.0,
      fontWeight: FontWeight.bold,
      letterSpacing: -0.25,
      height: 1.2,
      color: colorScheme.onSurface,
    ),
    
    // Medium headlines for section headers and secondary display text
    // Provides strong visual hierarchy below headlineLarge
    headlineMedium: TextStyle(
      fontSize: 28.0,
      fontWeight: FontWeight.bold,
      letterSpacing: 0,
      height: 1.3,
      color: colorScheme.onSurface,
    ),
    
    // Titles - Primary navigation and content section headers
    // Main heading style for cards, sections, and dialog titles
    titleLarge: TextStyle(
      fontSize: 22.0,
      fontWeight: FontWeight.w600,
      letterSpacing: 0,
      height: 1.3,
      color: colorScheme.onSurface,
    ),
    
    // Medium titles for subsections and secondary headings
    // Used in list headers, form sections, and supporting content
    titleMedium: TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.15,
      height: 1.4,
      color: colorScheme.onSurface,
    ),
    
    // Body text - Primary reading content
    // Main text style for paragraphs, descriptions, and content
    bodyLarge: TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.5,
      height: 1.5,
      color: colorScheme.onSurface,
    ),
    
    // Medium body text for supporting content
    // Secondary text style with good readability for longer content
    bodyMedium: TextStyle(
      fontSize: 14.0,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.25,
      height: 1.4,
      color: colorScheme.onSurface,
    ),
    
    // Small body text for captions and supplementary information
    // Used for metadata, timestamps, and subtle supporting text
    bodySmall: TextStyle(
      fontSize: 12.0,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.4,
      height: 1.3,
      color: colorScheme.onSurfaceVariant,
    ),
    
    // Labels - Interactive elements and UI components
    // Used for buttons, tabs, chips, and other actionable elements
    labelLarge: TextStyle(
      fontSize: 14.0,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.1,
      height: 1.4,
      color: colorScheme.onSurface,
    ),
  );
}