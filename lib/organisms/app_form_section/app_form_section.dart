import 'package:flutter/material.dart';
import 'package:pragma_design_system/pragma_design_system.dart';

/// AppFormSection - An organism for grouping form fields with title and description
///
/// This organism provides a consistent way to structure form sections throughout
/// the application. It combines multiple form fields with optional title, description,
/// and divider elements to create cohesive form layouts.
///
/// **Organism Responsibility:**
/// - Groups related form fields into logical sections
/// - Provides consistent title and description styling
/// - Maintains proper spacing between form elements
/// - Offers optional visual separation with dividers
///
/// **Composition:**
/// Uses design system atoms and molecules:
/// - AppText for titles and descriptions
/// - AppSpacer for consistent spacing
/// - AppDivider for optional visual separation
/// - Flexible children layout for form fields
///
/// **Design Patterns:**
/// - Follows Material 3 form section conventions
/// - Maintains accessibility and theming consistency
/// - Supports flexible content arrangement
/// - Uses semantic spacing from design system
class AppFormSection extends StatelessWidget {
  const AppFormSection({
    super.key,
    required this.title,
    this.description,
    required this.children,
    this.showDivider = false,
    this.padding,
  });

  /// Section title displayed prominently at the top
  final String title;

  /// Optional description text displayed below the title
  final String? description;

  /// Form fields and other widgets to display in this section
  final List<Widget> children;

  /// Whether to show a divider at the bottom of the section
  final bool showDivider;

  /// Optional padding around the entire section
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Section title
          AppText(
            title,
            variant: AppTextVariant.titleLarge,
            color: colorScheme.onSurface,
          ),

          // Section description (if provided)
          if (description != null) ...[
            const AppSpacer(size: AppSpacerSize.small),
            AppText(
              description!,
              variant: AppTextVariant.bodySmall,
              color: colorScheme.onSurfaceVariant,
            ),
          ],

          // Spacing before form content
          const AppSpacer(size: AppSpacerSize.medium),

          // Form fields and content
          ...children,

          // Optional bottom divider
          if (showDivider) ...[
            const AppSpacer(size: AppSpacerSize.medium),
            const AppDivider(),
          ],
        ],
      ),
    );
  }
}