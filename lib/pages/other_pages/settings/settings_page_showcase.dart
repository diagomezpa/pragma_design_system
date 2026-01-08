import 'package:flutter/material.dart';
import 'package:pragma_design_system/pragma_design_system.dart';
import 'package:pragma_design_system/pages/other_pages/settings/settings_page.dart';

/// SettingsPageShowcase - Demonstrates a real Settings Page built from a Template.
///
/// This showcase serves as **living documentation** for the Page layer in
/// Atomic Design methodology, specifically focusing on Settings page implementation.
/// Unlike component showcases that demonstrate isolated widgets, this showcase
/// embeds a complete, interactive Settings Page to demonstrate real-world
/// content organization and user interaction patterns.
///
/// **Why Settings Pages Are Ideal Page Examples:**
/// Settings screens represent perfect examples of Page-level responsibilities
/// and demonstrate the full power of Atomic Design hierarchy:
///
/// - **Content Strategy**: Pages organize settings into logical, scannable groups
/// - **Information Architecture**: Pages decide which settings belong together
/// - **User Experience**: Pages handle navigation flow and interaction patterns
/// - **Business Context**: Pages understand app-wide settings and user preferences
/// - **Accessibility**: Pages ensure proper semantic structure and screen reader support
/// - **Localization**: Pages adapt content for different user contexts and languages
///
/// Settings pages are particularly valuable because they showcase how Templates
/// provide consistent layout structure while Pages provide meaningful content
/// organization that directly impacts user productivity and satisfaction.
///
/// **How This Demonstrates Atomic Design Hierarchy:**
/// This showcase validates the complete design system working in harmony:
///
/// 1. **Atoms** (AppIcon, AppText, AppSpacer) provide consistent visual building blocks
/// 2. **Molecules** (AppListItem) compose atoms into reusable settings row components
/// 3. **Organisms** (AppSettingsGroup) group molecules into logical settings sections
/// 4. **Templates** (SettingsPageTemplate) define page structure and visual hierarchy
/// 5. **Pages** (SettingsPage) provide real content organization and interaction logic
///
/// The fact that you can interact with fully functional settings demonstrates
/// that all layers work seamlessly together without tight coupling, proving
/// the design system's architectural maturity and real-world applicability.
///
/// **Educational Value:**
/// By experiencing a real Settings Page in action, developers understand:
/// - How content organization impacts user experience and task completion
/// - Why grouping and visual hierarchy matter for settings scannability
/// - How Templates enable consistent layouts across different settings contexts
/// - The scalability benefits of separating content strategy from layout structure
/// - Real-world patterns for building complex, user-friendly settings interfaces
class SettingsPageShowcase extends StatelessWidget {
  /// Creates a showcase demonstrating real Settings Page implementation and design patterns.
  const SettingsPageShowcase({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings Page Showcase'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Page title
            const AppText(
              'Settings Page Implementation',
              variant: AppTextVariant.titleLarge,
            ),

            const SizedBox(height: 16),

            // Educational description explaining Page vs Template responsibilities
            _buildPageDescription(context),

            const SizedBox(height: 32),

            // Visual separator
            Container(
              width: double.infinity,
              height: 1,
              color: Theme.of(context).colorScheme.outlineVariant,
            ),

            const SizedBox(height: 24),

            // Interactive settings section header
            AppText(
              'Interactive Settings Demo',
              variant: AppTextVariant.titleMedium,
              color: Theme.of(context).colorScheme.primary,
            ),

            const SizedBox(height: 8),

            AppText(
              'Explore the settings below to experience real Page-level content organization, visual hierarchy, and user interaction patterns.',
              variant: AppTextVariant.bodyMedium,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),

            const SizedBox(height: 24),

            // Embedded SettingsPage - fully interactive and functional
            _buildEmbeddedSettingsPage(),
          ],
        ),
      ),
    );
  }

  /// Builds the educational description explaining Settings Page architecture and benefits.
  Widget _buildPageDescription(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colorScheme.surfaceVariant.withOpacity(0.3),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: colorScheme.outlineVariant,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(
            'About Settings Pages in Atomic Design',
            variant: AppTextVariant.titleMedium,
            color: colorScheme.primary,
          ),
          const SizedBox(height: 12),
          AppText(
            'This is a Settings Page - a complete implementation built from a Template. '
            'Settings pages demonstrate how Atomic Design enables both visual consistency '
            'and meaningful content organization for complex user interfaces.',
            variant: AppTextVariant.bodyMedium,
            color: colorScheme.onSurfaceVariant,
          ),
          const SizedBox(height: 16),
          _buildPageResponsibilityItem(
            context,
            'Content Organization',
            'Pages group settings logically for optimal user scannability and task completion.',
          ),
          const SizedBox(height: 12),
          _buildPageResponsibilityItem(
            context,
            'Visual Hierarchy',
            'Pages use design system components to create clear information architecture.',
          ),
          const SizedBox(height: 12),
          _buildPageResponsibilityItem(
            context,
            'Template Integration',
            'Pages leverage Templates for consistent layout while providing real content strategy.',
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: colorScheme.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.settings_outlined,
                  size: 20,
                  color: colorScheme.primary,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: AppText(
                    'The settings below are fully interactive. '
                    'Try tapping different options to see how Pages handle user interactions and navigation logic.',
                    variant: AppTextVariant.bodySmall,
                    color: colorScheme.primary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Builds individual Page responsibility explanation items with consistent styling.
  Widget _buildPageResponsibilityItem(
    BuildContext context,
    String title,
    String description,
  ) {
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 2),
          width: 6,
          height: 6,
          decoration: BoxDecoration(
            color: colorScheme.primary,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(
                title,
                variant: AppTextVariant.labelLarge,
                color: colorScheme.onSurface,
              ),
              const SizedBox(height: 4),
              AppText(
                description,
                variant: AppTextVariant.bodySmall,
                color: colorScheme.onSurfaceVariant,
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// Builds the embedded SettingsPage with visual container styling.
  ///
  /// The SettingsPage is embedded without any modifications to demonstrate
  /// that it works as a complete, standalone implementation. This approach
  /// shows real Settings page behavior rather than creating a simplified demo.
  ///
  /// Note: The SettingsPage is constrained to a specific height to prevent
  /// infinite layout constraints when embedding a Scaffold within a scrollable container.
  Widget _buildEmbeddedSettingsPage() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.grey.withOpacity(0.2),
          width: 1,
        ),
      ),
      // ClipRRect ensures the SettingsPage content respects the container boundaries
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        // Constrain height to prevent infinite layout issues when embedding Scaffold
        child: SizedBox(
          height: 600, // Fixed height to contain the settings experience
          child: const SettingsPage(),
        ),
      ),
    );
  }
}
