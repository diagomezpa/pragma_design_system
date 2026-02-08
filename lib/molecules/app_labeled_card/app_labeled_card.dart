import 'package:flutter/material.dart';
import '../../atoms/app_text/app_text.dart';
import '../../atoms/app_spacer/app_spacer.dart';
import '../app_card/app_card.dart';

/// AppLabeledCard - A molecule component that combines a card with a descriptive label
///
/// This molecule follows Atomic Design principles by combining AppCard, AppText, and AppSpacer atoms
/// into a reusable component that provides consistent labeling and layout for content cards.
/// It encapsulates the common pattern of having a descriptive label at the top of a card
/// with content centered below.
///
/// Features:
/// - Uses AppCard internally for consistent card styling
/// - Displays a descriptive label using AppText with bodySmall variant
/// - Proper spacing between label and content using AppSpacerFactory
/// - Centers content below the label
/// - Reusable throughout the application
/// - Encapsulates layout logic to keep it out of showcase and other usage contexts
///
/// This molecule is particularly useful for:
/// - Design system documentation and showcases
/// - Feature demonstrations with labels
/// - Content cards that need descriptive headers
/// - Any scenario requiring labeled content in a card format
///
/// Example usage:
/// ```dart
/// AppLabeledCard(
///   label: 'Icon sizes comparison',
///   child: AppIconGroup(
///     icons: const [
///       AppIcon(Icons.star, size: AppIconSize.small),
///       AppIcon(Icons.star, size: AppIconSize.medium),
///       AppIcon(Icons.star, size: AppIconSize.large),
///     ],
///   ),
/// )
/// ```
class AppLabeledCard extends StatelessWidget {
  const AppLabeledCard({
    super.key,
    required this.label,
    required this.child,
    this.labelVariant = AppTextVariant.bodySmall,
    this.spacing = AppSpacerSize.small,
  });

  /// The descriptive label text to display at the top of the card
  final String label;

  /// The content widget to display below the label
  final Widget child;

  /// The text variant to use for the label (defaults to bodySmall)
  final AppTextVariant labelVariant;

  /// The spacing size between the label and content (defaults to small)
  final AppSpacerSize spacing;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Label at the top
          AppText(
            label,
            variant: labelVariant,
          ),
          
          // Spacing between label and content
          AppSpacer(
            size: spacing,
            direction: AppSpacerDirection.vertical,
          ),
          
          // Centered content
          Center(
            child: child,
          ),
        ],
      ),
    );
  }
}

/// Factory methods for common AppLabeledCard configurations
extension AppLabeledCardFactory on AppLabeledCard {
  /// Creates a labeled card with small spacing (default configuration)
  static AppLabeledCard small({
    required String label,
    required Widget child,
  }) {
    return AppLabeledCard(
      label: label,
      child: child,
      labelVariant: AppTextVariant.bodySmall,
      spacing: AppSpacerSize.small,
    );
  }

  /// Creates a labeled card with medium spacing for more visual separation
  static AppLabeledCard medium({
    required String label,
    required Widget child,
  }) {
    return AppLabeledCard(
      label: label,
      child: child,
      labelVariant: AppTextVariant.bodyMedium,
      spacing: AppSpacerSize.medium,
    );
  }

  /// Creates a labeled card with a larger label variant for emphasis
  static AppLabeledCard emphasized({
    required String label,
    required Widget child,
  }) {
    return AppLabeledCard(
      label: label,
      child: child,
      labelVariant: AppTextVariant.bodyLarge,
      spacing: AppSpacerSize.medium,
    );
  }
}