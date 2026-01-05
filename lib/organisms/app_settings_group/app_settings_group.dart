import 'package:flutter/material.dart';

import '../../atoms/app_divider.dart';
import '../../atoms/app_spacer.dart';
import '../../atoms/app_text.dart';

/// AppSettingsGroup
///
/// An organism that groups related settings options in a clean, accessible,
/// and consistent visual container. This widget provides a standardized way
/// to organize settings items with optional titles, descriptions, and dividers.
///
/// **When to use:**
/// - Grouping related settings in a settings screen (e.g., "Account", "Privacy")
/// - Creating sections of configuration options
/// - Organizing form-like controls that belong together logically
/// - Building preference panels with clear visual separation
///
/// **When NOT to use:**
/// - For navigation menus (use dedicated navigation components)
/// - For data lists that aren't settings (use AppCardList or similar)
/// - For single isolated settings (use AppListItem directly)
/// - For complex forms with validation (use AppFormSection)
///
/// **Features:**
/// - Optional title and description for clear section identification
/// - Flexible children list accepting any widgets (commonly AppListItem)
/// - Configurable dividers between items for visual separation
/// - Optional card-like container styling
/// - Responsive padding and spacing using design system tokens
/// - Full Material 3 theming support for light/dark modes
///
/// Example:
/// ```dart
/// AppSettingsGroup(
///   title: 'Privacy & Security',
///   description: 'Manage your privacy settings and account security.',
///   children: [
///     AppListItem(
///       title: 'Two-Factor Authentication',
///       trailing: Switch(value: true, onChanged: (_) {}),
///     ),
///     AppListItem(
///       title: 'Data Export',
///       trailing: Icon(Icons.chevron_right),
///       onTap: () => navigateToDataExport(),
///     ),
///   ],
/// )
/// ```
class AppSettingsGroup extends StatelessWidget {
  const AppSettingsGroup({
    super.key,
    this.title,
    this.description,
    required this.children,
    this.showDividers = true,
    this.isCard = false,
    this.padding,
  });

  /// Optional title displayed at the top of the settings group.
  /// Uses titleMedium variant for appropriate hierarchy.
  final String? title;

  /// Optional description providing additional context about the group.
  /// Displayed below the title with subtle styling.
  final String? description;

  /// List of widgets representing individual settings items.
  /// While commonly AppListItem instances, any widgets can be provided
  /// to support custom settings controls and layouts.
  final List<Widget> children;

  /// Whether to show dividers between settings items.
  /// Defaults to true for clear visual separation.
  final bool showDividers;

  /// Whether to wrap the group in a card-like container.
  /// When true, applies surface color and elevation styling.
  final bool isCard;

  /// Custom padding around the group content.
  /// Defaults to comfortable spacing for settings screens.
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    // Build the main content column
    Widget content = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Title section with optional description
        if (title != null || description != null) ...[
          if (title != null) ...[
            AppText(
              title!,
              variant: AppTextVariant.titleMedium,
              color: colorScheme.onSurface,
            ),
            if (description != null) AppSpacerFactory.extraSmallVertical(),
          ],
          if (description != null) ...[
            AppText(
              description!,
              variant: AppTextVariant.bodySmall,
              color: colorScheme.onSurfaceVariant,
            ),
          ],
          AppSpacerFactory.mediumVertical(),
        ],

        // Settings items with optional dividers
        if (children.isNotEmpty) ...[
          for (int i = 0; i < children.length; i++) ...[
            children[i],
            
            // Add divider between items (but not after the last item)
            if (showDividers && i < children.length - 1) ...[
              AppSpacerFactory.smallVertical(),
              const AppDivider(),
              AppSpacerFactory.smallVertical(),
            ],
          ],
        ],
      ],
    );

    // Apply padding
    Widget paddedContent = Padding(
      padding: padding ?? const EdgeInsets.all(16),
      child: content,
    );

    // Apply card styling if requested
    if (isCard) {
      return Card(
        color: colorScheme.surface,
        elevation: 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: paddedContent,
      );
    }

    return paddedContent;
  }
}