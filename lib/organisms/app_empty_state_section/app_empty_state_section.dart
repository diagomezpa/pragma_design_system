import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../atoms/app_button.dart';
import '../../atoms/app_image.dart';
import '../../atoms/app_spacer.dart';
import '../../atoms/app_text.dart';

/// AppEmptyStateSection
///
/// An organism that displays a self-contained, presentation-only empty state
/// for a section that has no content. This widget is stateless and fully
/// configurable via constructor parameters — it does not perform any data
/// fetching or business logic.
///
/// Features:
/// - Optional icon (`icon`) or image (`imageUrl`) — mutually exclusive.
/// - Required `title` and optional `description`.
/// - Optional `primaryAction` and `secondaryAction` widgets. Actions are
///   stacked vertically with spacing.
/// - Uses `AppText`, `AppSpacer`, `AppButton` (passed in as widgets), and
///   `AppImage` to remain consistent with the design system.
/// - Centered layout by default; main axis alignment and text alignment
///   are configurable.
/// - Responsive: constrains content width for large screens and adapts to
///   available space.
///
/// Example:
/// ```dart
/// AppEmptyStateSection(
///   icon: Icons.folder_open,
///   title: 'No items yet',
///   description: 'Try creating a new item to get started.',
///   primaryAction: AppButton(
///     text: 'Create',
///     onPressed: () => doCreate(),
///   ),
/// )
/// ```
class AppEmptyStateSection extends StatelessWidget {
  const AppEmptyStateSection({
    super.key,
    this.icon,
    this.imageUrl,
    required this.title,
    this.description,
    this.primaryAction,
    this.secondaryAction,
    this.padding,
    this.textAlign = TextAlign.center,
    this.mainAxisAlignment = MainAxisAlignment.center,
  }) : assert(
          !(icon != null && imageUrl != null),
          'Provide either `icon` or `imageUrl`, not both.',
        );

  /// Optional leading icon for the empty state. Mutually exclusive with
  /// `imageUrl`.
  final IconData? icon;

  /// Optional network image URL to show instead of the icon.
  final String? imageUrl;

  /// Required title string that summarizes the empty state.
  final String title;

  /// Optional longer description describing next steps or context.
  final String? description;

  /// Optional primary action widget that serves as the main call-to-action.
  /// 
  /// This action is positioned prominently at the top of the action area
  /// and typically represents the primary user flow (e.g., "Create New Item",
  /// "Get Started"). While commonly an `AppButton` with primary styling,
  /// any widget can be provided to support custom interaction patterns.
  /// Rendered above `secondaryAction` to establish clear visual hierarchy.
  final Widget? primaryAction;

  /// Optional secondary action widget that provides an alternative user path.
  /// 
  /// This action appears below the primary action and typically represents
  /// secondary flows such as "Learn More", "Skip", or "Browse Examples".
  /// The visual treatment should be more subtle than the primary action
  /// to maintain proper hierarchy. While commonly an `AppButton` with
  /// secondary/outline styling or a `TextButton`, any widget can be used
  /// to accommodate diverse interaction needs.
  final Widget? secondaryAction;

  /// Optional padding around the content. Defaults to comfortable
  /// symmetric horizontal padding for responsive layouts.
  final EdgeInsetsGeometry? padding;

  /// Alignment for text. Defaults to `TextAlign.center`.
  final TextAlign textAlign;

  /// Vertical alignment of the internal column. Defaults to `center`.
  final MainAxisAlignment mainAxisAlignment;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return LayoutBuilder(builder: (context, constraints) {
      // Keep content reasonably narrow on very wide screens
      final maxWidth = math.min(560.0, constraints.maxWidth * 0.9);

      return Padding(
        padding:
            padding ?? const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: maxWidth),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: mainAxisAlignment,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (imageUrl != null) ...[
                  // Use AppImage for consistent loading/error handling
                  AppImage(
                    imageUrl: imageUrl,
                    width: 200,
                    height: 160,
                    fit: BoxFit.contain,
                    semanticLabel: title,
                    placeholder: const SizedBox(
                      width: 200,
                      height: 160,
                      child: Center(child: CircularProgressIndicator()),
                    ),
                  ),
                ] else if (icon != null) ...[
                  Icon(
                    icon,
                    size: 72,
                    color: colorScheme.primary,
                    semanticLabel: title,
                  ),
                ],

                // Spacing after media when present
                if (imageUrl != null || icon != null)
                  AppSpacerFactory.mediumVertical(),

                // Title
                AppText(
                  title,
                  variant: AppTextVariant.titleLarge,
                  textAlign: textAlign,
                  color: colorScheme.onSurface,
                ),

                if (description != null) ...[
                  AppSpacerFactory.smallVertical(),
                  AppText(
                    description!,
                    variant: AppTextVariant.bodyMedium,
                    textAlign: textAlign,
                    color: colorScheme.onSurfaceVariant,
                  ),
                ],

                // Actions: stacked vertically with spacing
                if (primaryAction != null || secondaryAction != null) ...[
                  AppSpacerFactory.largeVertical(),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (primaryAction != null) ...[
                        Align(
                          alignment: Alignment.center,
                          child: primaryAction!,
                        ),
                      ],
                      if (primaryAction != null && secondaryAction != null)
                        AppSpacerFactory.mediumVertical(),
                      if (secondaryAction != null) ...[
                        Align(
                          alignment: Alignment.center,
                          child: secondaryAction!,
                        ),
                      ],
                    ],
                  ),
                ],
              ],
            ),
          ),
        ),
      );
    });
  }
}
