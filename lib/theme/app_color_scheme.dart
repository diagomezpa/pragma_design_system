import 'package:flutter/material.dart';
import 'app_colors.dart';

/// AppColorScheme - Centralized Material 3 ColorScheme factory
///
/// This module bridges our semantic design tokens (AppColors) with Flutter's
/// Material 3 ColorScheme system. By centralizing ColorScheme creation here,
/// we ensure:
///
/// 1. **Consistency**: All themes use the same color mapping logic
/// 2. **Maintainability**: Color changes only need to be made in AppColors  
/// 3. **Type Safety**: Compile-time verification of color assignments
/// 4. **Material 3 Compliance**: Proper mapping to Material Design specifications
/// 5. **Design System Integrity**: Single source of truth for color relationships
///
/// This approach separates semantic color tokens from Material implementation
/// details, allowing the design system to evolve independently while maintaining
/// Flutter framework compatibility.
///
/// Usage:
/// ```dart
/// // Create theme with centralized color schemes
/// final lightTheme = ThemeData(
///   colorScheme: lightColorScheme(),
/// );
/// 
/// final darkTheme = ThemeData(  
///   colorScheme: darkColorScheme(),
/// );
/// ```

/// Creates a Material 3 compliant light ColorScheme using AppColors.light tokens.
///
/// Maps semantic design tokens to Material 3 ColorScheme properties,
/// ensuring proper color relationships and accessibility standards.
/// All colors are sourced from AppColors.light to maintain consistency.
ColorScheme lightColorScheme() {
  const colors = AppColors.light;
  
  return ColorScheme(
    // Theme brightness - determines default text and icon colors
    brightness: Brightness.light,
    
    // Primary color system - main brand colors
    primary: colors.primary,
    onPrimary: colors.onPrimary,
    primaryContainer: colors.primary,
    onPrimaryContainer: colors.onPrimary,
    
    // Secondary color system - supporting brand colors
    secondary: colors.secondary,
    onSecondary: colors.onSecondary,
    secondaryContainer: colors.secondary,
    onSecondaryContainer: colors.onSecondary,
    
    // Tertiary color system - using secondary as fallback
    tertiary: colors.secondary,
    onTertiary: colors.onSecondary,
    tertiaryContainer: colors.secondary,
    onTertiaryContainer: colors.onSecondary,
    
    // Error color system - semantic error colors
    error: colors.error,
    onError: colors.onError,
    errorContainer: colors.error,
    onErrorContainer: colors.onError,
    
    // Background color system - main app background
    background: colors.background,
    onBackground: colors.onSurface,
    
    // Surface color system - elevated component backgrounds
    surface: colors.surface,
    onSurface: colors.onSurface,
    surfaceVariant: colors.surface,
    onSurfaceVariant: colors.onSurfaceVariant,
    
    // Outline system - borders and dividers
    outline: colors.outline,
    outlineVariant: colors.outline,
    
    // Additional surface colors - using existing tokens
    inverseSurface: colors.onSurface,
    onInverseSurface: colors.surface,
    inversePrimary: colors.onPrimary,
    
    // Surface tinting - subtle elevation indication
    surfaceTint: colors.primary,
    
    // Deprecated but still used by some widgets
    shadow: const Color(0xFF000000),
    scrim: const Color(0xFF000000),
  );
}

/// Creates a Material 3 compliant dark ColorScheme using AppColors.dark tokens.
///
/// Maps semantic design tokens to Material 3 ColorScheme properties,
/// optimized for dark theme accessibility and visual comfort.
/// All colors are sourced from AppColors.dark to maintain consistency.
ColorScheme darkColorScheme() {
  const colors = AppColors.dark;
  
  return ColorScheme(
    // Theme brightness - determines default text and icon colors
    brightness: Brightness.dark,
    
    // Primary color system - main brand colors
    primary: colors.primary,
    onPrimary: colors.onPrimary,
    primaryContainer: colors.primary,
    onPrimaryContainer: colors.onPrimary,
    
    // Secondary color system - supporting brand colors
    secondary: colors.secondary,
    onSecondary: colors.onSecondary,
    secondaryContainer: colors.secondary,
    onSecondaryContainer: colors.onSecondary,
    
    // Tertiary color system - using secondary as fallback
    tertiary: colors.secondary,
    onTertiary: colors.onSecondary,
    tertiaryContainer: colors.secondary,
    onTertiaryContainer: colors.onSecondary,
    
    // Error color system - semantic error colors  
    error: colors.error,
    onError: colors.onError,
    errorContainer: colors.error,
    onErrorContainer: colors.onError,
    
    // Background color system - main app background
    background: colors.background,
    onBackground: colors.onSurface,
    
    // Surface color system - elevated component backgrounds
    surface: colors.surface,
    onSurface: colors.onSurface,
    surfaceVariant: colors.surface,
    onSurfaceVariant: colors.onSurfaceVariant,
    
    // Outline system - borders and dividers
    outline: colors.outline,
    outlineVariant: colors.outline,
    
    // Additional surface colors - using existing tokens
    inverseSurface: colors.onSurface,
    onInverseSurface: colors.surface,
    inversePrimary: colors.onPrimary,
    
    // Surface tinting - subtle elevation indication
    surfaceTint: colors.primary,
    
    // Deprecated but still used by some widgets
    shadow: const Color(0xFF000000),
    scrim: const Color(0xFF000000),
  );
}