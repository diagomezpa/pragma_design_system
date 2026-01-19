import 'package:flutter/material.dart';
import '../atoms/app_text.dart';
import 'app_snackbar_type.dart';

/// AppSnackbar - A utility class for displaying temporary feedback messages
/// 
/// This utility provides a semantic API for showing consistent feedback messages
/// throughout the application without breaking Atomic Design principles. It serves
/// as a system-level feedback mechanism that integrates seamlessly with the
/// design system's theming and typography.
/// 
/// Features:
/// - Semantic API with success, error, and info variants
/// - Automatic dismissal of previous snackbars
/// - Material 3 design compliance with floating behavior
/// - Integration with AppText and theme color schemes
/// - Consistent 2-second duration for optimal UX
/// - No external dependencies beyond Flutter framework
/// 
/// Design System Classification:
/// This utility falls outside the traditional Atomic Design hierarchy
/// (Atoms → Molecules → Organisms → Templates → Pages) as it represents
/// a system-level feedback mechanism rather than a structural component.
/// 
/// Usage:
/// ```dart
/// // Success feedback
/// AppSnackbar.success(context, message: 'Profile updated successfully');
/// 
/// // Error feedback  
/// AppSnackbar.error(context, message: 'Failed to save changes');
/// 
/// // Informational feedback
/// AppSnackbar.info(context, message: 'Loading your data...');
/// ```
/// 
/// Architecture:
/// - Static methods provide clean, discoverable API
/// - Encapsulates ScaffoldMessenger complexity
/// - Uses theme-aware colors for semantic meaning
/// - Maintains visual consistency through AppText
class AppSnackbar {
  /// Private constructor to prevent instantiation
  /// This class should only be used through its static methods
  const AppSnackbar._();
  
  /// Standard duration for all snackbar messages (2 seconds)
  static const Duration _duration = Duration(seconds: 2);
  
  /// Shows a success feedback message with positive visual treatment
  /// 
  /// Typically used for confirming successful operations like:
  /// - Data saved successfully
  /// - Profile updated
  /// - Action completed
  /// 
  /// [context] - BuildContext for accessing theme and ScaffoldMessenger
  /// [message] - Success message to display to the user
  static void success(BuildContext context, {required String message}) {
    _showSnackbar(
      context,
      message: message,
      type: AppSnackbarType.success,
    );
  }
  
  /// Shows an error feedback message with critical visual treatment
  /// 
  /// Typically used for communicating failures or errors like:
  /// - Network connection issues
  /// - Validation failures
  /// - Server errors
  /// 
  /// [context] - BuildContext for accessing theme and ScaffoldMessenger
  /// [message] - Error message to display to the user
  static void error(BuildContext context, {required String message}) {
    _showSnackbar(
      context,
      message: message,
      type: AppSnackbarType.error,
    );
  }
  
  /// Shows an informational feedback message with neutral visual treatment
  /// 
  /// Typically used for providing status updates like:
  /// - Loading states
  /// - Process updates
  /// - General notifications
  /// 
  /// [context] - BuildContext for accessing theme and ScaffoldMessenger
  /// [message] - Informational message to display to the user
  static void info(BuildContext context, {required String message}) {
    _showSnackbar(
      context,
      message: message,
      type: AppSnackbarType.info,
    );
  }
  
  /// Internal method that handles the actual snackbar creation and display
  /// 
  /// This method:
  /// 1. Clears any existing snackbar to prevent stacking
  /// 2. Determines appropriate colors based on feedback type
  /// 3. Creates Material 3 compliant SnackBar with floating behavior
  /// 4. Uses AppText for consistent typography
  /// 5. Shows the snackbar through ScaffoldMessenger
  /// 
  /// [context] - BuildContext for accessing theme and messenger
  /// [message] - Text content to display
  /// [type] - Semantic type that determines visual treatment
  static void _showSnackbar(
    BuildContext context, {
    required String message,
    required AppSnackbarType type,
  }) {
    // Clear any existing snackbar to prevent stacking
    ScaffoldMessenger.of(context).clearSnackBars();
    
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    // Determine colors based on feedback type
    final (backgroundColor, foregroundColor) = switch (type) {
      AppSnackbarType.success => (
        colorScheme.primaryContainer,
        colorScheme.onPrimaryContainer,
      ),
      AppSnackbarType.error => (
        colorScheme.errorContainer,
        colorScheme.onErrorContainer,
      ),
      AppSnackbarType.info => (
        colorScheme.surfaceContainerHighest,
        colorScheme.onSurface,
      ),
    };
    
    // Create and show the snackbar
    final snackbar = SnackBar(
      content: AppText(
        message,
        variant: AppTextVariant.bodyMedium,
        color: foregroundColor,
      ),
      backgroundColor: backgroundColor,
      behavior: SnackBarBehavior.floating,
      duration: _duration,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      margin: const EdgeInsets.all(16.0),
    );
    
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }
}
