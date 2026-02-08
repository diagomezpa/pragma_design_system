import 'package:flutter/material.dart';

/// AppDivider - Un widget divisor consistente para separar contenido
/// Este átomo proporciona separación visual estandarizada entre elementos de UI
/// Soporta orientaciones horizontales y verticales con personalización
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
    final dividerColor = color ?? theme.colorScheme.outline;
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

    // Aplicar margen si se proporciona
    if (margin != null) {
      divider = Padding(
        padding: margin!,
        child: divider,
      );
    }

    return divider;
  }
}

/// Constructores factory para casos de uso comunes de divisores
extension AppDividerFactory on AppDivider {
  /// Crea un divisor horizontal delgado
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

  /// Crea un divisor horizontal grueso
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

  /// Crea un divisor vertical para separar contenido horizontalmente
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

  /// Crea un divisor de sección con margen estándar
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

  /// Crea un divisor de elemento de lista con padding
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

/// Enum que define la orientación del divisor
enum AppDividerOrientation {
  horizontal,
  vertical,
}