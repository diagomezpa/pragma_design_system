import 'package:flutter/material.dart';
import '../atoms/app_text.dart';
import '../atoms/app_button.dart';
import '../atoms/app_spacer.dart';

/// AppDialog - A utility class for displaying modal dialogs with consistent styling
/// 
/// This utility provides a semantic API for showing modal dialogs throughout the
/// application while maintaining Atomic Design principles. It serves as a
/// system-level feedback mechanism that integrates seamlessly with the design
/// system's theming, typography, and component styling.
/// 
/// Features:
/// - Static show method for easy dialog presentation
/// - Customizable title, content, and actions
/// - Integration with AppText, AppButton, and theme system
/// - Automatic theming with Material 3 design compliance
/// - Generic return type support for dialog results
/// - Proper Navigator handling and dismissal
/// - Consistent spacing using AppSpacer
/// - Rounded corners matching design system standards
/// 
/// Design System Classification:
/// This utility falls outside the traditional Atomic Design hierarchy
/// (Atoms → Molecules → Organisms → Templates → Pages) as it represents
/// a system-level modal mechanism rather than a structural component.
/// 
/// Usage:
/// ```dart
/// // Simple dialog with title and content
/// AppDialog.show(
///   context: context,
///   title: 'Confirm Action',
///   content: AppText(
///     'Are you sure you want to proceed?',
///     variant: AppTextVariant.bodyMedium,
///   ),
/// );
/// 
/// // Dialog with custom actions
/// final result = await AppDialog.show<bool>(
///   context: context,
///   title: 'Delete Item',
///   content: AppText(
///     'This action cannot be undone.',
///     variant: AppTextVariant.bodyMedium,
///   ),
///   actions: [
///     AppButton(
///       text: 'Cancel',
///       onPressed: () => Navigator.pop(context, false),
///       variant: AppButtonVariant.secondary,
///     ),
///     AppButton(
///       text: 'Delete',
///       onPressed: () => Navigator.pop(context, true),
///       variant: AppButtonVariant.primary,
///     ),
///   ],
/// );
/// 
/// // Dialog with widget content
/// AppDialog.show(
///   context: context,
///   title: 'Settings',
///   child: MyCustomSettingsWidget(),
/// );
/// ```
/// 
/// Architecture:
/// - Static method provides clean, discoverable API
/// - Encapsulates showDialog complexity
/// - Uses theme-aware styling for consistency
/// - Maintains visual hierarchy through AppText variants
/// - Supports both string content and custom widgets
class AppDialog {
  /// Private constructor to prevent instantiation
  /// This class should only be used through its static method
  const AppDialog._();
  
  /// Shows a modal dialog with consistent design system styling
  /// 
  /// This method creates and displays an AlertDialog with design system
  /// theming and components. It supports both simple text content and
  /// complex widget content for maximum flexibility.
  /// 
  /// Type Parameters:
  /// [T] - The type of value that can be returned by the dialog
  /// 
  /// Parameters:
  /// [context] - BuildContext for accessing theme and Navigator
  /// [title] - Optional title text displayed at the top of the dialog
  /// [content] - Optional content widget (mutually exclusive with child)
  /// [child] - Optional custom widget content (mutually exclusive with content)
  /// [actions] - List of action buttons (typically AppButton widgets)
  /// [barrierDismissible] - Whether tapping outside dismisses the dialog
  /// 
  /// Returns:
  /// [Future<T?>] - Future that completes with the dialog result
  static Future<T?> show<T>({
    required BuildContext context,
    String? title,
    AppText? content,
    Widget? child,
    List<Widget>? actions,
    bool barrierDismissible = true,
  }) {
    // Ensure only one content type is provided
    assert(
      (content != null) ^ (child != null) || (content == null && child == null),
      'Either content or child can be provided, not both',
    );
    
    return showDialog<T>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (BuildContext context) => _AppDialogWidget<T>(
        title: title,
        content: content,
        child: child,
        actions: actions,
      ),
    );
  }
}

/// Internal widget that builds the actual dialog structure
/// 
/// This widget encapsulates the dialog layout and styling logic,
/// ensuring consistent appearance across all dialog instances.
class _AppDialogWidget<T> extends StatelessWidget {
  const _AppDialogWidget({
    this.title,
    this.content,
    this.child,
    this.actions,
  });
  
  final String? title;
  final AppText? content;
  final Widget? child;
  final List<Widget>? actions;
  
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    return AlertDialog(
      // Apply design system styling
      backgroundColor: colorScheme.surface,
      surfaceTintColor: colorScheme.surfaceTint,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24.0),
      ),
      titlePadding: const EdgeInsets.fromLTRB(24.0, 24.0, 24.0, 0.0),
      contentPadding: EdgeInsets.fromLTRB(
        24.0,
        title != null ? 16.0 : 24.0,
        24.0,
        actions != null ? 8.0 : 24.0,
      ),
      actionsPadding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      
      // Title with design system typography
      title: title != null
          ? AppText(
              title!,
              variant: AppTextVariant.titleMedium,
              color: colorScheme.onSurface,
            )
          : null,
      
      // Content area with proper spacing
      content: _buildContent(),
      
      // Actions with proper spacing
      actions: _buildActions(),
    );
  }
  
  /// Builds the content area of the dialog
  Widget? _buildContent() {
    if (content != null && child != null) {
      // Both content and child provided, show both with spacing
      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          content!,
          const AppSpacer(size: AppSpacerSize.medium),
          child!,
        ],
      );
    } else if (content != null) {
      // Only AppText content
      return content!;
    } else if (child != null) {
      // Only custom widget content
      return child;
    }
    
    // No content provided
    return null;
  }
  
  /// Builds the actions area with proper spacing
  List<Widget>? _buildActions() {
    if (actions == null || actions!.isEmpty) {
      return null;
    }
    
    // Add spacing between actions if multiple are provided
    if (actions!.length == 1) {
      return actions;
    }
    
    final spacedActions = <Widget>[];
    for (int i = 0; i < actions!.length; i++) {
      spacedActions.add(actions![i]);
      // Add spacing between actions (but not after the last one)
      if (i < actions!.length - 1) {
        spacedActions.add(const SizedBox(width: 8.0));
      }
    }
    
    return spacedActions;
  }
}