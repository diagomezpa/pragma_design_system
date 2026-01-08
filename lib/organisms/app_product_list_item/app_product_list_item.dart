import 'package:flutter/material.dart';
import 'package:pragma_design_system/pragma_design_system.dart';


class AppProductListItem extends StatelessWidget {
  const AppProductListItem({
    super.key,
    required this.title,
    this.subtitle,
    this.imageUrl,
    this.price,
    this.trailingAction,
    this.onTap,
    this.isEnabled = true,
  });

  /// Título del producto (requerido) - mostrado como el encabezado principal
  final String title;

  /// Subtítulo/descripcion del producto (opcional) - mostrado debajo del título
  final String? subtitle;

  /// URL de la imagen del producto (opcional) - mostrada como elemento visual principal
  final String? imageUrl;

  /// Precio del producto (opcional) - mostrado con énfasis debajo de la descripción
  final String? price;

  /// Widget opcional al final (botones, íconos) para acciones del producto
  final Widget? trailingAction;

  /// Callback que se dispara cuando se pulsa el elemento de producto
  final VoidCallback? onTap;

  /// Indica si el elemento de producto está habilitado para interacción
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
                // Leading product image with spacing
                if (imageUrl != null) ...[
                  _buildProductImage()!,
                  const AppSpacer(
                    size: AppSpacerSize.medium,
                    direction: AppSpacerDirection.horizontal,
                  ),
                ],

                // Product information content
                Expanded(
                  child: _buildProductContent(colorScheme),
                ),

                // Trailing action with spacing
                if (trailingAction != null) ...[
                  const AppSpacer(
                    size: AppSpacerSize.medium,
                    direction: AppSpacerDirection.horizontal,
                  ),
                  SizedBox(
                    width: 40.0,
                    height: 40.0,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: trailingAction,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Builds the product image widget for the leading position
  Widget? _buildProductImage() {
    if (imageUrl == null) return null;

    return SizedBox(
      width: 56,
      height: 56,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: AppImage(
          imageUrl: imageUrl,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  /// Builds the main product content area with title, subtitle, and price
  Widget _buildProductContent(ColorScheme colorScheme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Product title
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

        // Product subtitle (if provided)
        if (subtitle != null) ...[
          const AppSpacer(size: AppSpacerSize.extraSmall),
          AppText(
            subtitle!,
            variant: AppTextVariant.bodyMedium,
            color: isEnabled
                ? colorScheme.onSurfaceVariant
                : colorScheme.onSurface.withOpacity(0.38),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],

        // Product price (if provided) - visually separated and emphasized
        if (price != null) ...[
          const AppSpacer(size: AppSpacerSize.extraSmall),
          AppText(
            price!,
            variant: AppTextVariant.titleMedium,
            color: isEnabled
                ? colorScheme.primary
                : colorScheme.primary.withOpacity(0.38),
            fontWeight: FontWeight.w600,
          ),
        ],
      ],
    );
  }
}