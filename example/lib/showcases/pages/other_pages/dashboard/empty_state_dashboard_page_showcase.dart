import 'package:flutter/material.dart';
import 'package:pragma_design_system/pragma_design_system.dart';
import 'package:pragma_design_system/pages/other_pages/dashboard/empty_state_dashboard_page.dart';

/// EmptyStateDashboardPageShowcase - Demonstrates UX for dashboards with no data.
///
/// This showcase serves as **living documentation** for empty state design patterns
/// in dashboard contexts. Unlike component showcases that demonstrate isolated widgets,
/// this showcase embeds a complete, interactive Empty State Dashboard Page to
/// demonstrate real-world user onboarding and guidance patterns.
///
/// **Why Empty Dashboards Are Common in Real Apps:**
/// Empty dashboards represent one of the most frequent user experience scenarios
/// across all types of applications:
///
/// - **New User Onboarding**: Every user starts with an empty dashboard on first login
/// - **Feature Adoption**: New features often begin with empty states until users engage
/// - **Seasonal Usage**: Analytics dashboards may be empty during off-seasons or holidays
/// - **Permission-Based Access**: Users may have dashboards that appear empty due to access restrictions
/// - **Data Migration**: System updates or migrations can temporarily result in empty dashboards
/// - **Progressive Disclosure**: Complex dashboards may start simple and grow based on user actions
///
/// Empty states are not edge cases—they're fundamental user experience moments
/// that can make or break user activation, engagement, and long-term retention.
/// Well-designed empty states transform potentially frustrating moments into
/// opportunities for user education and motivation.
///
/// **How This Page Demonstrates Design System Maturity:**
/// This showcase validates the complete design system working cohesively for critical UX moments:
///
/// 1. **Atoms** (AppIcon, AppText, AppButton) provide consistent visual vocabulary
/// 2. **Molecules** compose atoms into meaningful interactive components
/// 3. **Organisms** (AppEmptyStateSection) create complete empty state experiences
/// 4. **Templates** (EmptyStateDashboardTemplate) define consistent page structure
/// 5. **Pages** (EmptyStateDashboardPage) provide contextual content and user guidance
///
/// The fact that you can experience a fully realized empty state demonstrates
/// that the design system handles not just data-rich scenarios, but also the
/// equally important "no data" states that every application must address.
/// This comprehensive coverage proves the system's real-world applicability.
///
/// **Educational Value:**
/// By experiencing a real Empty State Dashboard in action, developers understand:
/// - How content strategy impacts user conversion at critical onboarding moments
/// - Why friendly, motivational copy matters more than technical accuracy
/// - How visual hierarchy guides users toward desired actions without overwhelming them
/// - The importance of clear value propositions in empty state messaging
/// - Real-world patterns for reducing user abandonment during initial app exploration
class EmptyStateDashboardPageShowcase extends StatelessWidget {
  /// Creates a showcase demonstrating empty state dashboard UX patterns and user guidance.
  const EmptyStateDashboardPageShowcase({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Empty State Dashboard Showcase'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Page title
            const AppText(
              'Empty State Dashboard Implementation',
              variant: AppTextVariant.titleLarge,
            ),

            const SizedBox(height: 16),

            // Educational description explaining empty state importance and patterns
            _buildEmptyStateDescription(context),

            const SizedBox(height: 32),

            // Visual separator
            Container(
              width: double.infinity,
              height: 1,
              color: Theme.of(context).colorScheme.outlineVariant,
            ),

            const SizedBox(height: 24),

            // Interactive empty state section header
            AppText(
              'Interactive Empty State Demo',
              variant: AppTextVariant.titleMedium,
              color: Theme.of(context).colorScheme.primary,
            ),

            const SizedBox(height: 8),

            AppText(
              'Experience the empty dashboard below to see how effective UX design transforms potentially frustrating "no data" moments into motivating user onboarding opportunities.',
              variant: AppTextVariant.bodyMedium,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),

            const SizedBox(height: 24),

            // Embedded EmptyStateDashboardPage - fully interactive and functional
            _buildEmbeddedEmptyStatePage(),
          ],
        ),
      ),
    );
  }

  /// Builds the educational description explaining empty state UX importance and design patterns.
  Widget _buildEmptyStateDescription(BuildContext context) {
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
            'About Empty State Dashboards',
            variant: AppTextVariant.titleMedium,
            color: colorScheme.primary,
          ),
          const SizedBox(height: 12),
          AppText(
            'This is an Empty State Dashboard - a critical user experience moment '
            'that occurs when dashboards have no data to display. These states are '
            'opportunities to guide, motivate, and onboard users effectively.',
            variant: AppTextVariant.bodyMedium,
            color: colorScheme.onSurfaceVariant,
          ),
          const SizedBox(height: 16),
          _buildEmptyStatePatternItem(
            context,
            'User Onboarding',
            'Empty states provide essential first-step guidance for new users learning the system.',
          ),
          const SizedBox(height: 12),
          _buildEmptyStatePatternItem(
            context,
            'Motivation & Encouragement',
            'Friendly copy and clear actions transform potentially frustrating moments into opportunities.',
          ),
          const SizedBox(height: 12),
          _buildEmptyStatePatternItem(
            context,
            'Value Communication',
            'Empty states preview the value users will receive after taking action.',
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
                  Icons.lightbulb_outline,
                  size: 20,
                  color: colorScheme.primary,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: AppText(
                    'The empty dashboard below is fully interactive. '
                    'Try the primary action to experience how empty states guide users toward engagement.',
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

  /// Builds individual empty state pattern explanation items with consistent styling.
  Widget _buildEmptyStatePatternItem(
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

  /// Builds the embedded EmptyStateDashboardPage with visual container styling.
  ///
  /// The EmptyStateDashboardPage is embedded without any modifications to demonstrate
  /// that it works as a complete, standalone implementation. This approach shows
  /// real empty state behavior rather than creating a simplified demo.
  ///
  /// Note: The EmptyStateDashboardPage is constrained to a specific height to prevent
  /// infinite layout constraints when embedding a Scaffold within a scrollable container.
  Widget _buildEmbeddedEmptyStatePage() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.grey.withOpacity(0.2),
          width: 1,
        ),
      ),
      // ClipRRect ensures the EmptyStateDashboardPage content respects the container boundaries
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        // Constrain height to prevent infinite layout issues when embedding Scaffold
        child: SizedBox(
          height: 500, // Fixed height to contain the empty state experience
          child: const EmptyStateDashboardPage(),
        ),
      ),
    );
  }
}
