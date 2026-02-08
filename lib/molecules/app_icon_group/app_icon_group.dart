import 'package:flutter/material.dart';
import '../../atoms/app_icon/app_icon.dart';
import '../../atoms/app_spacer/app_spacer.dart';

/// AppIconGroup - A molecule component for displaying multiple icons in a row
///
/// This molecule follows Atomic Design principles by combining AppIcon atoms
/// into a reusable component that handles layout, spacing, and alignment internally.
/// It encapsulates the common pattern of displaying multiple icons horizontally
/// with consistent spacing and alignment.
///
/// Features:
/// - Displays a list of AppIcon widgets in a horizontal row
/// - Consistent spacing and alignment across all use cases
/// - Reusable throughout the application
/// - Encapsulates layout logic to keep it out of showcase pages
/// - Follows design system spacing and layout principles
///
/// This molecule is particularly useful for:
/// - Design system documentation and showcases
/// - Toolbar icon groups
/// - Action button groups
/// - Icon comparison displays
/// - Any scenario requiring multiple icons in a row
///
/// Example usage:
/// ```dart
/// AppIconGroup(
///   icons: const [
///     AppIcon(Icons.star, size: AppIconSize.large),
///     AppIcon(Icons.favorite, size: AppIconSize.large),
///     AppIcon(Icons.home, size: AppIconSize.large),
///   ],
/// )
/// ```
class AppIconGroup extends StatelessWidget {
  const AppIconGroup({
    super.key,
    required this.icons,
    this.mainAxisAlignment = MainAxisAlignment.spaceEvenly,
    this.spacing = AppSpacerSize.medium,
    this.includeVerticalPadding = true,
  });

  /// List of AppIcon widgets to display in the group
  final List<AppIcon> icons;

  /// How the icons should be aligned along the main (horizontal) axis
  final MainAxisAlignment mainAxisAlignment;

  /// Spacing between icons (uses AppSpacer for consistency)
  final AppSpacerSize spacing;

  /// Whether to include vertical padding around the icon group
  final bool includeVerticalPadding;

  @override
  Widget build(BuildContext context) {
    // Handle empty list
    if (icons.isEmpty) {
      return const SizedBox.shrink();
    }

    // For better space management, use Wrap instead of Row
    // This allows icons to wrap to the next line if needed
    Widget iconGroup = Wrap(
      alignment: _getWrapAlignment(),
      spacing: _getSpacingValue(),
      runSpacing: _getSpacingValue(),
      children: icons,
    );

    // Optionally wrap with vertical padding for better visual presentation
    if (includeVerticalPadding) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const AppSpacer(
            size: AppSpacerSize.medium,
            direction: AppSpacerDirection.vertical,
          ),
          iconGroup,
          const AppSpacer(
            size: AppSpacerSize.medium,
            direction: AppSpacerDirection.vertical,
          ),
        ],
      );
    }

    return iconGroup;
  }

  /// Converts MainAxisAlignment to WrapAlignment for Wrap widget
  WrapAlignment _getWrapAlignment() {
    switch (mainAxisAlignment) {
      case MainAxisAlignment.start:
        return WrapAlignment.start;
      case MainAxisAlignment.center:
        return WrapAlignment.center;
      case MainAxisAlignment.end:
        return WrapAlignment.end;
      case MainAxisAlignment.spaceEvenly:
        return WrapAlignment.spaceEvenly;
      case MainAxisAlignment.spaceBetween:
        return WrapAlignment.spaceBetween;
      case MainAxisAlignment.spaceAround:
        return WrapAlignment.spaceAround;
    }
  }

  /// Gets the spacing value in pixels from AppSpacerSize
  double _getSpacingValue() {
    switch (spacing) {
      case AppSpacerSize.extraSmall:
        return 4.0;
      case AppSpacerSize.small:
        return 8.0;
      case AppSpacerSize.medium:
        return 16.0;
      case AppSpacerSize.large:
        return 24.0;
      case AppSpacerSize.extraLarge:
        return 32.0;
      case AppSpacerSize.huge:
        return 48.0;
    }
  }
}

/// Factory methods for common AppIconGroup configurations
extension AppIconGroupFactory on AppIconGroup {
  /// Creates an icon group with even spacing (spaceEvenly)
  static AppIconGroup even({
    required List<AppIcon> icons,
    AppSpacerSize spacing = AppSpacerSize.medium,
    bool includeVerticalPadding = true,
  }) {
    return AppIconGroup(
      icons: icons,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      spacing: spacing,
      includeVerticalPadding: includeVerticalPadding,
    );
  }

  /// Creates an icon group with center alignment
  static AppIconGroup center({
    required List<AppIcon> icons,
    AppSpacerSize spacing = AppSpacerSize.medium,
    bool includeVerticalPadding = true,
  }) {
    return AppIconGroup(
      icons: icons,
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: spacing,
      includeVerticalPadding: includeVerticalPadding,
    );
  }

  /// Creates an icon group aligned to the start (left)
  static AppIconGroup start({
    required List<AppIcon> icons,
    AppSpacerSize spacing = AppSpacerSize.medium,
    bool includeVerticalPadding = true,
  }) {
    return AppIconGroup(
      icons: icons,
      mainAxisAlignment: MainAxisAlignment.start,
      spacing: spacing,
      includeVerticalPadding: includeVerticalPadding,
    );
  }
}