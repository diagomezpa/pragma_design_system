import 'package:flutter/material.dart';

/// AppDivider - A consistent divider widget for separating content
/// This atom provides standardized visual separation between UI elements
/// Supports both horizontal and vertical orientations with customization
class AppDivider extends StatelessWidget {
  const AppDivider({
    super.key,
    this.orientation = AppDividerOrientation.horizontal,
    this.thickness,
    this.color,
    this.margin,
    this.indent = 0,
    this.endIndent = 0,
  });

  final AppDividerOrientation orientation;
  final double? thickness;
  final Color? color;
  final EdgeInsetsGeometry? margin;
  final double indent;
  final double endIndent;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final dividerColor = color ?? theme.dividerColor;
    final dividerThickness = thickness ?? theme.dividerTheme.thickness ?? 1.0;

    Widget divider;

    if (orientation == AppDividerOrientation.horizontal) {
      divider = Divider(
        thickness: dividerThickness,
        color: dividerColor,
        indent: indent,
        endIndent: endIndent,
        height: dividerThickness,
      );
    } else {
      divider = VerticalDivider(
        thickness: dividerThickness,
        color: dividerColor,
        indent: indent,
        endIndent: endIndent,
        width: dividerThickness,
      );
    }

    // Apply margin if provided
    if (margin != null) {
      divider = Padding(
        padding: margin!,
        child: divider,
      );
    }

    return divider;
  }
}

/// Factory constructors for common divider use cases
extension AppDividerFactory on AppDivider {
  /// Creates a thin horizontal divider
  static Widget thin({
    Color? color,
    EdgeInsetsGeometry? margin,
    double indent = 0,
    double endIndent = 0,
  }) {
    return AppDivider(
      orientation: AppDividerOrientation.horizontal,
      thickness: 0.5,
      color: color,
      margin: margin,
      indent: indent,
      endIndent: endIndent,
    );
  }

  /// Creates a thick horizontal divider
  static Widget thick({
    Color? color,
    EdgeInsetsGeometry? margin,
    double indent = 0,
    double endIndent = 0,
  }) {
    return AppDivider(
      orientation: AppDividerOrientation.horizontal,
      thickness: 2.0,
      color: color,
      margin: margin,
      indent: indent,
      endIndent: endIndent,
    );
  }

  /// Creates a vertical divider for separating content horizontally
  static Widget vertical({
    double? thickness,
    Color? color,
    EdgeInsetsGeometry? margin,
    double indent = 0,
    double endIndent = 0,
  }) {
    return AppDivider(
      orientation: AppDividerOrientation.vertical,
      thickness: thickness,
      color: color,
      margin: margin,
      indent: indent,
      endIndent: endIndent,
    );
  }

  /// Creates a section divider with standard margin
  static Widget section({
    Color? color,
    double thickness = 1.0,
  }) {
    return AppDivider(
      orientation: AppDividerOrientation.horizontal,
      thickness: thickness,
      color: color,
      margin: const EdgeInsets.symmetric(vertical: 16),
    );
  }

  /// Creates a list item divider with padding
  static Widget listItem({
    Color? color,
    double indent = 16,
    double endIndent = 16,
  }) {
    return AppDivider(
      orientation: AppDividerOrientation.horizontal,
      thickness: 0.5,
      color: color,
      indent: indent,
      endIndent: endIndent,
    );
  }
}

/// Enum defining divider orientation
enum AppDividerOrientation {
  horizontal,
  vertical,
}