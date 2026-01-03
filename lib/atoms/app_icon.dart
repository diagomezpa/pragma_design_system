import 'package:flutter/material.dart';

/// AppIcon - A reusable icon wrapper that provides consistent icon styling
/// This atom centralizes icon appearance and behavior across the application
/// Supports different sizes, colors, and interaction states
class AppIcon extends StatelessWidget {
  const AppIcon(
    this.icon, {
    super.key,
    this.size = AppIconSize.medium,
    this.color,
    this.onTap,
    this.semanticLabel,
  });

  final IconData icon;
  final AppIconSize size;
  final Color? color;
  final VoidCallback? onTap;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final iconColor = color ?? theme.iconTheme.color;
    
    final iconWidget = Icon(
      icon,
      size: _getIconSize(),
      color: iconColor,
      semanticLabel: semanticLabel,
    );

    // If no onTap callback is provided, return just the icon
    if (onTap == null) {
      return iconWidget;
    }

    // If onTap is provided, wrap in an interactive container
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(_getIconSize() / 2),
      child: Container(
        padding: EdgeInsets.all(_getPadding()),
        child: iconWidget,
      ),
    );
  }

  double _getIconSize() {
    switch (size) {
      case AppIconSize.extraSmall:
        return 12;
      case AppIconSize.small:
        return 16;
      case AppIconSize.medium:
        return 24;
      case AppIconSize.large:
        return 32;
      case AppIconSize.extraLarge:
        return 48;
    }
  }

  double _getPadding() {
    // Add padding only when interactive (has onTap)
    if (onTap == null) return 0;
    
    switch (size) {
      case AppIconSize.extraSmall:
        return 4;
      case AppIconSize.small:
        return 6;
      case AppIconSize.medium:
        return 8;
      case AppIconSize.large:
        return 10;
      case AppIconSize.extraLarge:
        return 12;
    }
  }
}

/// Factory constructor for commonly used icons with semantic meaning
extension AppIconFactory on AppIcon {
  /// Creates a close icon with appropriate semantics
  static AppIcon close({
    AppIconSize size = AppIconSize.medium,
    Color? color,
    VoidCallback? onTap,
  }) {
    return AppIcon(
      Icons.close,
      size: size,
      color: color,
      onTap: onTap,
      semanticLabel: 'Close',
    );
  }

  /// Creates a back arrow icon with appropriate semantics
  static AppIcon back({
    AppIconSize size = AppIconSize.medium,
    Color? color,
    VoidCallback? onTap,
  }) {
    return AppIcon(
      Icons.arrow_back,
      size: size,
      color: color,
      onTap: onTap,
      semanticLabel: 'Back',
    );
  }

  /// Creates a menu icon with appropriate semantics
  static AppIcon menu({
    AppIconSize size = AppIconSize.medium,
    Color? color,
    VoidCallback? onTap,
  }) {
    return AppIcon(
      Icons.menu,
      size: size,
      color: color,
      onTap: onTap,
      semanticLabel: 'Menu',
    );
  }

  /// Creates a search icon with appropriate semantics
  static AppIcon search({
    AppIconSize size = AppIconSize.medium,
    Color? color,
    VoidCallback? onTap,
  }) {
    return AppIcon(
      Icons.search,
      size: size,
      color: color,
      onTap: onTap,
      semanticLabel: 'Search',
    );
  }
}

/// Enum defining different icon sizes available in the design system
enum AppIconSize {
  extraSmall,
  small,
  medium,
  large,
  extraLarge,
}