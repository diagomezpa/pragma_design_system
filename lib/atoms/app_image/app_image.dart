import 'package:flutter/material.dart';

/// AppImage - Una abstracción de widget de imagen con soporte de red
/// Este átomo proporciona manejo consistente de imágenes en toda la aplicación
/// Soporta imágenes de red y assets con estados de carga y error
class AppImage extends StatelessWidget {
  const AppImage({
    super.key,
    this.imageUrl,
    this.assetPath,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.borderRadius,
    this.placeholder,
    this.errorWidget,
    this.semanticLabel,
  }) : assert(
          (imageUrl != null && assetPath == null) ||
              (imageUrl == null && assetPath != null),
          'Provide either imageUrl or assetPath, but not both',
        );

  final String? imageUrl;
  final String? assetPath;
  final double? width;
  final double? height;
  final BoxFit fit;
  final BorderRadius? borderRadius;
  final Widget? placeholder;
  final Widget? errorWidget;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    Widget imageWidget;

    if (assetPath != null) {
      // Imagen de asset
      imageWidget = Image.asset(
        assetPath!,
        width: width,
        height: height,
        fit: fit,
        semanticLabel: semanticLabel,
        errorBuilder: (context, error, stackTrace) {
          return _buildErrorWidget(context);
        },
      );
    } else {
      // Imagen de red
      imageWidget = Image.network(
        imageUrl!,
        width: width,
        height: height,
        fit: fit,
        semanticLabel: semanticLabel,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return _buildLoadingWidget(context, loadingProgress);
        },
        errorBuilder: (context, error, stackTrace) {
          return _buildErrorWidget(context);
        },
      );
    }

    // Aplicar border radius si se proporciona
    if (borderRadius != null) {
      imageWidget = ClipRRect(
        borderRadius: borderRadius!,
        child: imageWidget,
      );
    }

    return imageWidget;
  }

  Widget _buildLoadingWidget(BuildContext context, ImageChunkEvent? loadingProgress) {
    if (placeholder != null) {
      return placeholder!;
    }

    return Container(
      width: width,
      height: height,
      color: Theme.of(context).colorScheme.surface,
      child: Center(
        child: CircularProgressIndicator(
          value: loadingProgress?.expectedTotalBytes != null
              ? loadingProgress!.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
              : null,
        ),
      ),
    );
  }

  Widget _buildErrorWidget(BuildContext context) {
    if (errorWidget != null) {
      return errorWidget!;
    }

    return Container(
      width: width,
      height: height,
      color: Theme.of(context).colorScheme.errorContainer,
      child: Icon(
        Icons.broken_image,
        color: Theme.of(context).colorScheme.onErrorContainer,
        size: (width != null && height != null) 
            ? (width! < height! ? width! : height!) * 0.5
            : 24,
      ),
    );
  }
}

/// Constructores factory para casos de uso comunes de imágenes
extension AppImageFactory on AppImage {
  /// Crea una imagen de avatar circular
  static Widget avatar({
    required String? imageUrl,
    required double size,
    String? assetPath,
    Widget? placeholder,
    Widget? errorWidget,
    String? semanticLabel,
  }) {
    return ClipOval(
      child: AppImage(
        imageUrl: imageUrl,
        assetPath: assetPath,
        width: size,
        height: size,
        fit: BoxFit.cover,
        placeholder: placeholder,
        errorWidget: errorWidget,
        semanticLabel: semanticLabel,
      ),
    );
  }

  /// Crea una imagen de miniatura con esquinas redondeadas
  static Widget thumbnail({
    required String? imageUrl,
    String? assetPath,
    double width = 80,
    double height = 80,
    double borderRadius = 8,
    Widget? placeholder,
    Widget? errorWidget,
    String? semanticLabel,
  }) {
    return AppImage(
      imageUrl: imageUrl,
      assetPath: assetPath,
      width: width,
      height: height,
      fit: BoxFit.cover,
      borderRadius: BorderRadius.circular(borderRadius),
      placeholder: placeholder,
      errorWidget: errorWidget,
      semanticLabel: semanticLabel,
    );
  }

  /// Crea una imagen de banner que llena el ancho disponible
  static Widget banner({
    required String? imageUrl,
    String? assetPath,
    double? height,
    double borderRadius = 0,
    Widget? placeholder,
    Widget? errorWidget,
    String? semanticLabel,
  }) {
    return AppImage(
      imageUrl: imageUrl,
      assetPath: assetPath,
      height: height,
      fit: BoxFit.cover,
      borderRadius: borderRadius > 0 ? BorderRadius.circular(borderRadius) : null,
      placeholder: placeholder,
      errorWidget: errorWidget,
      semanticLabel: semanticLabel,
    );
  }
}