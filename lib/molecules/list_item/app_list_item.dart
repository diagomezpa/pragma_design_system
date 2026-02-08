import 'package:flutter/material.dart';
import '../../atoms/app_text/app_text.dart';
import '../../atoms/app_spacer/app_spacer.dart';

/// AppListItem - A reusable list item molecule following Atomic Design principles
///
/// This molecule combines atoms (AppText, AppSpacer) to create a consistent
/// list item component across the application. It follows Material 3 design guidelines
/// and provides a standardized UI for lists, menus, product lists, and carts.
///
/// Features:
/// - Material 3 styling with proper theming support
/// - Required title and optional subtitle using AppText
/// - Optional leading and trailing widgets
/// - Tap interaction with InkWell and ripple effect
/// - Enabled/disabled state with opacity changes
/// - Proper spacing and alignment similar to ListTile
/// - Stateless design with callback-based interaction
///
/// This molecule is UI-only and does NOT include:
/// - Navigation logic
/// - Business logic
/// - State management
///
/// Example usage:
/// ```dart
/// AppListItem(
///   leading: AppIcon(Icons.person),
///   title: 'User Profile',
///   subtitle: 'Manage your account settings',
///   trailing: AppIcon(Icons.arrow_forward_ios),
///   onTap: () => print('Profile tapped'),
/// )
/// ```
class AppListItem extends StatelessWidget {
  const AppListItem({
    super.key,
    this.leading,
    required this.title,
    this.subtitle,
    this.trailing,
    this.onTap,
    this.isEnabled = true,
  });

  /// Optional leading widget (typically an icon or avatar)
  final Widget? leading;

  /// Required title text displayed prominently
  final String title;

  /// Optional subtitle text displayed below the title
  final String? subtitle;

  /// Optional trailing widget (typically an icon or action button)
  final Widget? trailing;

  /// Callback fired when the list item is tapped
  final VoidCallback? onTap;

  /// Whether the list item is enabled for interaction
  final bool isEnabled;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    // Calculate opacity for disabled state
    final opacity = isEnabled ? 1.0 : 0.38;

    return Opacity(
      opacity: opacity,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: isEnabled ? onTap : null,
          borderRadius: BorderRadius.circular(8.0),
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 12.0,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Leading widget with spacing
                if (leading != null) ...[
                  SizedBox(
                    width: 40.0,
                    height: 40.0,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: leading,
                    ),
                  ),
                  const AppSpacer(
                    size: AppSpacerSize.medium,
                    direction: AppSpacerDirection.horizontal,
                  ),
                ],

                // Title and subtitle content
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Title
                      AppText(
                        title,
                        variant: AppTextVariant.bodyLarge,
                        color: isEnabled
                            ? colorScheme.onSurface
                            : colorScheme.onSurface.withOpacity(0.38),
                        fontWeight: FontWeight.w500,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),

                      // Subtitle if provided
                      if (subtitle != null) ...[
                        const AppSpacer(size: AppSpacerSize.extraSmall),
                        AppText(
                          subtitle!,
                          variant: AppTextVariant.bodySmall,
                          color: isEnabled
                              ? colorScheme.onSurfaceVariant
                              : colorScheme.onSurface.withOpacity(0.38),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ],
                  ),
                ),

                // Trailing widget with spacing
                if (trailing != null) ...[
                  const AppSpacer(
                    size: AppSpacerSize.medium,
                    direction: AppSpacerDirection.horizontal,
                  ),
                  Flexible(
                    child: trailing!,
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
