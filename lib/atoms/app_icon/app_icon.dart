import 'package:flutter/material.dart';

/// AppIcon - Un envoltorio de ícono reutilizable que proporciona estilo consistente de íconos
/// Este átomo centraliza la apariencia y comportamiento de los íconos en toda la aplicación
/// Soporta diferentes tamaños, colores y estados de interacción
class AppIcon extends StatelessWidget {
  const AppIcon(
    this.icon, {
    super.key,
    this.size = AppIconSize.medium,
    this.color,
    this.onTap,
    this.semanticLabel,
  });

  /// Constructor nombrado para un ícono de cerrar con semántica
  const AppIcon.close({
    Key? key,
    AppIconSize size = AppIconSize.medium,
    Color? color,
    VoidCallback? onTap,
  }) : this(
          Icons.close,
          key: key,
          size: size,
          color: color,
          onTap: onTap,
          semanticLabel: 'Close',
        );

  /// Constructor nombrado para un ícono de retroceso con semántica
  const AppIcon.back({
    Key? key,
    AppIconSize size = AppIconSize.medium,
    Color? color,
    VoidCallback? onTap,
  }) : this(
          Icons.arrow_back,
          key: key,
          size: size,
          color: color,
          onTap: onTap,
          semanticLabel: 'Back',
        );

  /// Constructor nombrado para un ícono de menú con semántica
  const AppIcon.menu({
    Key? key,
    AppIconSize size = AppIconSize.medium,
    Color? color,
    VoidCallback? onTap,
  }) : this(
          Icons.menu,
          key: key,
          size: size,
          color: color,
          onTap: onTap,
          semanticLabel: 'Menu',
        );

  /// Constructor nombrado para un ícono de búsqueda con semántica
  const AppIcon.search({
    Key? key,
    AppIconSize size = AppIconSize.medium,
    Color? color,
    VoidCallback? onTap,
  }) : this(
          Icons.search,
          key: key,
          size: size,
          color: color,
          onTap: onTap,
          semanticLabel: 'Search',
        );

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

    // Si no se proporciona callback onTap, devolver solo el ícono
    if (onTap == null) {
      return iconWidget;
    }

    // Si se proporciona onTap, envolver en un contenedor interactivo
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
    // Agregar padding solo cuando es interactivo (tiene onTap)
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

/// Constructor factory para íconos comúnmente usados con significado semántico
extension AppIconFactory on AppIcon {
  /// Crea un ícono de cerrar con semántica apropiada
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

  /// Crea un ícono de flecha de retroceso con semántica apropiada
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

  /// Crea un ícono de menú con semántica apropiada
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

  /// Crea un ícono de búsqueda con semántica apropiada
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

/// Enum que define los diferentes tamaños de ícono disponibles en el sistema de diseño
enum AppIconSize {
  extraSmall,
  small,
  medium,
  large,
  extraLarge,
}