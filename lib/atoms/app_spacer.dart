import 'package:flutter/material.dart';

/// AppSpacer - A standardized spacing widget for consistent layouts
/// This atom provides predefined spacing values that maintain design consistency
/// Supports both horizontal and vertical spacing with various size options
class AppSpacer extends StatelessWidget {
  const AppSpacer({
    super.key,
    this.size = AppSpacerSize.medium,
    this.direction = AppSpacerDirection.vertical,
    this.width,
    this.height,
  });

  /// Custom spacer with explicit dimensions
  const AppSpacer.custom({
    super.key,
    this.width,
    this.height,
  })  : size = AppSpacerSize.medium,
        direction = AppSpacerDirection.vertical;

  final AppSpacerSize size;
  final AppSpacerDirection direction;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    // If custom dimensions are provided, use them
    if (width != null || height != null) {
      return SizedBox(
        width: width,
        height: height,
      );
    }

    // Use predefined spacing based on size and direction
    final spacing = _getSpacing();

    if (direction == AppSpacerDirection.horizontal) {
      return SizedBox(width: spacing);
    } else {
      return SizedBox(height: spacing);
    }
  }

  double _getSpacing() {
    switch (size) {
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

/// Factory constructors for common spacing use cases
extension AppSpacerFactory on AppSpacer {
  /// Creates extra small vertical spacing (4px)
  static Widget extraSmallVertical() {
    return const AppSpacer(
      size: AppSpacerSize.extraSmall,
      direction: AppSpacerDirection.vertical,
    );
  }

  /// Creates small vertical spacing (8px)
  static Widget smallVertical() {
    return const AppSpacer(
      size: AppSpacerSize.small,
      direction: AppSpacerDirection.vertical,
    );
  }

  /// Creates medium vertical spacing (16px)
  static Widget mediumVertical() {
    return const AppSpacer(
      size: AppSpacerSize.medium,
      direction: AppSpacerDirection.vertical,
    );
  }

  /// Creates large vertical spacing (24px)
  static Widget largeVertical() {
    return const AppSpacer(
      size: AppSpacerSize.large,
      direction: AppSpacerDirection.vertical,
    );
  }

  /// Creates extra large vertical spacing (32px)
  static Widget extraLargeVertical() {
    return const AppSpacer(
      size: AppSpacerSize.extraLarge,
      direction: AppSpacerDirection.vertical,
    );
  }

  /// Creates huge vertical spacing (48px)
  static Widget hugeVertical() {
    return const AppSpacer(
      size: AppSpacerSize.huge,
      direction: AppSpacerDirection.vertical,
    );
  }

  /// Creates extra small horizontal spacing (4px)
  static Widget extraSmallHorizontal() {
    return const AppSpacer(
      size: AppSpacerSize.extraSmall,
      direction: AppSpacerDirection.horizontal,
    );
  }

  /// Creates small horizontal spacing (8px)
  static Widget smallHorizontal() {
    return const AppSpacer(
      size: AppSpacerSize.small,
      direction: AppSpacerDirection.horizontal,
    );
  }

  /// Creates medium horizontal spacing (16px)
  static Widget mediumHorizontal() {
    return const AppSpacer(
      size: AppSpacerSize.medium,
      direction: AppSpacerDirection.horizontal,
    );
  }

  /// Creates large horizontal spacing (24px)
  static Widget largeHorizontal() {
    return const AppSpacer(
      size: AppSpacerSize.large,
      direction: AppSpacerDirection.horizontal,
    );
  }

  /// Creates extra large horizontal spacing (32px)
  static Widget extraLargeHorizontal() {
    return const AppSpacer(
      size: AppSpacerSize.extraLarge,
      direction: AppSpacerDirection.horizontal,
    );
  }

  /// Creates huge horizontal spacing (48px)
  static Widget hugeHorizontal() {
    return const AppSpacer(
      size: AppSpacerSize.huge,
      direction: AppSpacerDirection.horizontal,
    );
  }

  /// Creates a flexible spacer that expands to fill available space
  static Widget flexible({int flex = 1}) {
    return Expanded(
      flex: flex,
      child: const SizedBox.shrink(),
    );
  }
}

/// Enum defining different spacing sizes available in the design system
enum AppSpacerSize {
  extraSmall, // 4px
  small,      // 8px
  medium,     // 16px
  large,      // 24px
  extraLarge, // 32px
  huge,       // 48px
}

/// Enum defining spacing direction
enum AppSpacerDirection {
  horizontal,
  vertical,
}