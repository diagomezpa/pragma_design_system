import 'package:flutter/material.dart';

/// AppSpacer - Un widget de espaciado estandarizado para layouts consistentes
/// Este átomo proporciona valores de espaciado predefinidos que mantienen consistencia de diseño
/// Soporta espaciado horizontal y vertical con varias opciones de tamaño
class AppSpacer extends StatelessWidget {
  const AppSpacer({
    super.key,
    this.size = AppSpacerSize.medium,
    this.direction = AppSpacerDirection.vertical,
    this.width,
    this.height,
  });

  /// Espaciador personalizado con dimensiones explícitas
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
    // Si se proporcionan dimensiones personalizadas, usarlas
    if (width != null || height != null) {
      return SizedBox(
        width: width,
        height: height,
      );
    }

    // Usar espaciado predefinido basado en tamaño y dirección
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

/// Constructores factory para casos de uso comunes de espaciado
extension AppSpacerFactory on AppSpacer {
  /// Crea espaciado vertical extra pequeño (4px)
  static Widget extraSmallVertical() {
    return const AppSpacer(
      size: AppSpacerSize.extraSmall,
      direction: AppSpacerDirection.vertical,
    );
  }

  /// Crea espaciado vertical pequeño (8px)
  static Widget smallVertical() {
    return const AppSpacer(
      size: AppSpacerSize.small,
      direction: AppSpacerDirection.vertical,
    );
  }

  /// Crea espaciado vertical mediano (16px)
  static Widget mediumVertical() {
    return const AppSpacer(
      size: AppSpacerSize.medium,
      direction: AppSpacerDirection.vertical,
    );
  }

  /// Crea espaciado vertical grande (24px)
  static Widget largeVertical() {
    return const AppSpacer(
      size: AppSpacerSize.large,
      direction: AppSpacerDirection.vertical,
    );
  }

  /// Crea espaciado vertical extra grande (32px)
  static Widget extraLargeVertical() {
    return const AppSpacer(
      size: AppSpacerSize.extraLarge,
      direction: AppSpacerDirection.vertical,
    );
  }

  /// Crea espaciado vertical enorme (48px)
  static Widget hugeVertical() {
    return const AppSpacer(
      size: AppSpacerSize.huge,
      direction: AppSpacerDirection.vertical,
    );
  }

  /// Crea espaciado horizontal extra pequeño (4px)
  static Widget extraSmallHorizontal() {
    return const AppSpacer(
      size: AppSpacerSize.extraSmall,
      direction: AppSpacerDirection.horizontal,
    );
  }

  /// Crea espaciado horizontal pequeño (8px)
  static Widget smallHorizontal() {
    return const AppSpacer(
      size: AppSpacerSize.small,
      direction: AppSpacerDirection.horizontal,
    );
  }

  /// Crea espaciado horizontal mediano (16px)
  static Widget mediumHorizontal() {
    return const AppSpacer(
      size: AppSpacerSize.medium,
      direction: AppSpacerDirection.horizontal,
    );
  }

  /// Crea espaciado horizontal grande (24px)
  static Widget largeHorizontal() {
    return const AppSpacer(
      size: AppSpacerSize.large,
      direction: AppSpacerDirection.horizontal,
    );
  }

  /// Crea espaciado horizontal extra grande (32px)
  static Widget extraLargeHorizontal() {
    return const AppSpacer(
      size: AppSpacerSize.extraLarge,
      direction: AppSpacerDirection.horizontal,
    );
  }

  /// Crea espaciado horizontal enorme (48px)
  static Widget hugeHorizontal() {
    return const AppSpacer(
      size: AppSpacerSize.huge,
      direction: AppSpacerDirection.horizontal,
    );
  }

  /// Crea un espaciador flexible que se expande para llenar el espacio disponible
  static Widget flexible({int flex = 1}) {
    return Expanded(
      flex: flex,
      child: const SizedBox.shrink(),
    );
  }
}

/// Enum que define los diferentes tamaños de espaciado disponibles en el sistema de diseño
enum AppSpacerSize {
  extraSmall, // 4px
  small,      // 8px
  medium,     // 16px
  large,      // 24px
  extraLarge, // 32px
  huge,       // 48px
}

/// Enum que define la dirección del espaciado
enum AppSpacerDirection {
  horizontal,
  vertical,
}