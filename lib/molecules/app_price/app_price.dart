import 'package:flutter/material.dart';
import 'package:pragma_design_system/pragma_design_system.dart';

/// AppPrice - A molecule for displaying product prices with discount support
///
/// This molecule provides a consistent way to display prices throughout
/// e-commerce interfaces. It handles regular prices, discounted prices,
/// and highlighted prices with proper typography hierarchy.
///
/// **Features:**
/// - Regular price display with proper formatting
/// - Discount price display with strike-through original price
/// - Highlight mode for emphasized pricing
/// - Consistent currency formatting
/// - Theme-aware styling with no hardcoded colors
/// - Flexible text alignment
///
/// **Pricing Logic:**
/// - Single price: displays value normally
/// - Discounted price: shows original with line-through + new price emphasized
/// - Highlight mode: uses stronger typography for main price
///
/// **Usage:**
/// ```dart
/// // Regular price
/// AppPrice(value: 120000)
///
/// // Discounted price
/// AppPrice(
///   value: 150000,
///   discountedValue: 120000,
/// )
///
/// // Highlighted price
/// AppPrice(
///   value: 99000,
///   highlight: true,
/// )
/// ```
class AppPrice extends StatelessWidget {
  const AppPrice({
    super.key,
    required this.value,
    this.currency = '\$',
    this.discountedValue,
    this.highlight = false,
    this.alignment = TextAlign.left,
  });

  /// Original price value (required)
  final double value;

  /// Currency symbol (defaults to "$")
  final String currency;

  /// Optional discounted price - when provided, shows original price with strike-through
  final double? discountedValue;

  /// Whether to highlight the price with stronger typography
  final bool highlight;

  /// Text alignment for the price display
  final TextAlign alignment;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    // If there's a discount, show both prices
    if (discountedValue != null) {
      return Column(
        crossAxisAlignment: _getCrossAxisAlignment(),
        mainAxisSize: MainAxisSize.min,
        children: [
          // Original price with strike-through
          AppText(
            _formatPrice(value),
            variant: AppTextVariant.bodyMedium,
            decoration: TextDecoration.lineThrough,
            color: theme.colorScheme.onSurfaceVariant,
            textAlign: alignment,
          ),
          
          // Discounted price (emphasized)
          AppText(
            _formatPrice(discountedValue!),
            variant: highlight ? AppTextVariant.titleLarge : AppTextVariant.titleMedium,
            color: theme.colorScheme.primary,
            fontWeight: FontWeight.w600,
            textAlign: alignment,
          ),
        ],
      );
    }
    
    // Single price display
    return AppText(
      _formatPrice(value),
      variant: highlight ? AppTextVariant.titleLarge : AppTextVariant.bodyLarge,
      fontWeight: highlight ? FontWeight.w600 : FontWeight.w500,
      color: highlight ? theme.colorScheme.primary : theme.colorScheme.onSurface,
      textAlign: alignment,
    );
  }

  /// Formats the price value with currency and proper number formatting
  String _formatPrice(double price) {
    // Format without decimals and add thousand separators
    final formatted = price.toStringAsFixed(0).replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]}.',
    );
    
    return '$currency $formatted';
  }

  /// Converts TextAlign to CrossAxisAlignment for Column widget
  CrossAxisAlignment _getCrossAxisAlignment() {
    switch (alignment) {
      case TextAlign.left:
      case TextAlign.start:
        return CrossAxisAlignment.start;
      case TextAlign.right:
      case TextAlign.end:
        return CrossAxisAlignment.end;
      case TextAlign.center:
        return CrossAxisAlignment.center;
      case TextAlign.justify:
        return CrossAxisAlignment.stretch;
    }
  }
}