import 'package:flutter/material.dart';
import '../../atoms/app_text/app_text.dart';
import 'package:pragma_design_system/pragma_design_system.dart';


/// AppSection - A reusable section molecule following Atomic Design principles
///
/// This molecule provides a consistent way to structure content sections throughout
/// the application. It combines AppText and AppSpacer atoms to create a standardized
/// section layout with title, optional description, and content area.
///
/// Features:
/// - Required title using AppText with title variant
/// - Optional description using AppText with bodySmall variant
/// - Configurable padding with sensible defaults
/// - Consistent spacing between elements using AppSpacer
/// - Flexible content area for any child widget
/// - Material 3 compliant styling
/// - Accessibility-friendly structure
///
/// This molecule is UI-only and does NOT include:
/// - Navigation logic
/// - Business logic
/// - State management
/// - User interactions beyond content display
///
/// Example usage:
/// ```dart
/// AppSection(
///   title: 'User Settings',
///   description: 'Manage your account preferences and privacy settings',
///   child: Column(
///     children: [
///       AppListItem(title: 'Notifications'),
///       AppListItem(title: 'Privacy'),
///     ],
///   ),
/// )
/// ```
class AppSection extends StatelessWidget {
  const AppSection({
    super.key,
    required this.title,
    this.description,
    required this.child,
    this.padding = const EdgeInsets.all(16.0),
  });

  /// Required title text displayed at the top of the section
  final String title;

  /// Optional description text displayed below the title
  final String? description;

  /// Required content widget rendered below the header
  final Widget child;

  /// Configurable padding around the entire section
  /// Defaults to EdgeInsets.all(16.0) for consistent spacing
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Padding(
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Section title
          AppText(
            title,
            variant: AppTextVariant.titleLarge,
            color: colorScheme.onSurface,
            fontWeight: FontWeight.w600,
          ),

          // Optional description with spacing
          if (description != null) ...[
            const AppSpacer(size: AppSpacerSize.small),
            AppText(
              description!,
              variant: AppTextVariant.bodySmall,
              color: colorScheme.onSurfaceVariant,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ],

          // Spacing before content
          const AppSpacer(size: AppSpacerSize.medium),

          // Section content
          child,
        ],
      ),
    );
  }
}
