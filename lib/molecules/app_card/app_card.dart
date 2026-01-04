import 'package:flutter/material.dart';

/// AppCard - A versatile card molecule that provides a consistent surface container
/// 
/// This molecule serves as a flexible surface for grouping content with a consistent
/// visual treatment across the application. It provides elevation, rounded corners,
/// and optional interactivity while maintaining Material 3 design principles.
/// 
/// Features:
/// - Material 3 surface styling with proper theming support
/// - Rounded corners (12px) for modern aesthetics
/// - Subtle elevation using surface tint color
/// - Optional padding with sensible defaults
/// - Optional tap interaction with InkWell ripple effect
/// - Stateless design with callback-based interaction
/// - Transparent background handling (no disabled state needed)
/// 
/// Use this molecule for:
/// - Product cards
/// - Information summaries  
/// - Content sections
/// - Interactive containers
/// - Grouped content areas
/// 
/// Do NOT use for:
/// - Business logic or state management
/// - Navigation handling (pass callbacks instead)
/// - Complex layouts (compose with atoms instead)
/// - List items (use AppListItem instead)
/// 
/// Example usage:
/// ```dart
/// // Simple content card
/// AppCard(
///   child: Column(
///     children: [
///       AppText.subtitle('Product Title'),
///       AppSpacer.small(),
///       AppText.body('Product description here'),
///     ],
///   ),
/// )
/// 
/// // Interactive card with custom padding
/// AppCard(
///   padding: EdgeInsets.all(20.0),
///   onTap: () => print('Card tapped'),
///   child: Row(
///     children: [
///       AppIcon(Icons.shopping_cart),
///       AppSpacer.medium(),
///       AppText.body('Add to Cart'),
///     ],
///   ),
/// )
/// ```
class AppCard extends StatelessWidget {
  const AppCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16.0),
    this.onTap,
  });

  /// Required content widget rendered inside the card
  final Widget child;

  /// Configurable padding inside the card
  /// Defaults to EdgeInsets.all(16.0) for consistent spacing
  final EdgeInsetsGeometry padding;

  /// Optional callback fired when the card is tapped
  /// When provided, the card becomes interactive with ripple effect
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    // Create the card content
    final cardContent = Container(
      padding: padding,
      child: child,
    );

    // If no onTap callback is provided, return a simple card
    if (onTap == null) {
      return Card(
        elevation: 0,
        color: colorScheme.surface,
        surfaceTintColor: colorScheme.surfaceTint,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: cardContent,
      );
    }

    // If onTap is provided, wrap with Material + InkWell for interaction
    return Card(
      elevation: 0,
      color: colorScheme.surface,
      surfaceTintColor: colorScheme.surfaceTint,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      clipBehavior: Clip.antiAlias,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12.0),
          child: cardContent,
        ),
      ),
    );
  }
}