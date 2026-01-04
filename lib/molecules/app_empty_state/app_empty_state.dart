import 'package:flutter/material.dart';
import 'package:pragma_design_system/pragma_design_system.dart';

/// AppEmptyState - A molecule for displaying empty states with optional actions
///
/// This molecule provides a consistent way to communicate empty states throughout
/// the application. It combines visual elements (icon or image), descriptive text,
/// and optional actions to guide users when content is unavailable.
///
/// **Composition:**
/// Uses only design system atoms (AppIcon, AppImage, AppText, AppButton, AppSpacer)
/// to maintain consistency and avoid direct Material widget dependencies.
///
/// **Visual Hierarchy:**
/// - Icon OR image (mutually exclusive, icon takes priority)
/// - Title text (required, using titleLarge variant)
/// - Description text (optional, using bodyLarge variant)
/// - Action button (optional, appears only when both label and callback provided)
///
/// **Usage:**
/// ```dart
/// // Basic empty state with icon
/// AppEmptyState(
///   title: 'No items found',
///   description: 'Try adjusting your search criteria',
///   icon: Icons.search_off,
/// )
///
/// // Empty state with image and action
/// AppEmptyState(
///   title: 'Welcome to the app',
///   description: 'Get started by adding your first item',
///   imageUrl: 'https://example.com/welcome.png',
///   actionLabel: 'Add Item',
///   onAction: () => print('Add item tapped'),
/// )
/// ```
class AppEmptyState extends StatelessWidget {
  const AppEmptyState({
    super.key,
    required this.title,
    this.description,
    this.icon,
    this.imageUrl,
    this.actionLabel,
    this.onAction,
    this.alignment = TextAlign.center,
  });

  /// Required title text displayed prominently
  final String title;

  /// Optional description text providing additional context
  final String? description;

  /// Optional icon displayed above the text (takes priority over image)
  final IconData? icon;

  /// Optional image URL displayed above the text (ignored if icon is provided)
  final String? imageUrl;

  /// Optional label for the action button
  final String? actionLabel;

  /// Optional callback for the action button
  final VoidCallback? onAction;

  /// Text alignment for title and description
  final TextAlign alignment;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Visual element - icon takes priority over image
          if (icon != null) ...[
            AppIcon(
              icon!,
              size: AppIconSize.extraLarge,
            ),
            const AppSpacer(size: AppSpacerSize.large),
          ] else if (imageUrl != null) ...[
            AppImage(
              imageUrl: imageUrl,
              width: 120,
              height: 120,
              fit: BoxFit.contain,
            ),
            const AppSpacer(size: AppSpacerSize.large),
          ],

          // Title text - always present
          AppText(
            title,
            variant: AppTextVariant.titleLarge,
            textAlign: alignment,
          ),

          // Description text - optional
          if (description != null) ...[
            const AppSpacer(size: AppSpacerSize.medium),
            AppText(
              description!,
              variant: AppTextVariant.bodyLarge,
              textAlign: alignment,
            ),
          ],

          // Action button - appears only if both label and callback are provided
          if (actionLabel != null && onAction != null) ...[
            const AppSpacer(size: AppSpacerSize.extraLarge),
            AppButton(
              text: actionLabel!,
              onPressed: onAction,
            ),
          ],
        ],
      ),
    );
  }
}