import 'package:flutter/material.dart';
import 'package:pragma_design_system/pragma_design_system.dart';

/// EmptyStateDashboardTemplateShowcase
///
/// **Living Documentation and Visual Validation**
///
/// A comprehensive demonstration of EmptyStateDashboardTemplate usage across different
/// dashboard empty state scenarios. This showcase serves multiple purposes:
///
/// **Educational Goals:**
/// - Demonstrates proper template usage patterns for empty dashboards
/// - Shows how to compose organisms and atoms within the template
/// - Illustrates spacing, hierarchy, and visual design principles
/// - Provides copy-paste examples for common empty state layouts
///
/// **Template Validation:**
/// - Validates template flexibility across different dashboard complexities
/// - Tests responsive behavior and layout adaptation
/// - Ensures consistent spacing and visual hierarchy
/// - Demonstrates integration with the broader design system
///
/// **Showcase Scenarios:**
/// 1. **Default Empty Dashboard** - Complete layout with header, content, and footer
/// 2. **Minimal Empty State** - Simplest possible configuration with content only
/// 3. **Contextual Header Dashboard** - Complex header with actions and rich empty state
///
/// **Design System Integration:**
/// - Uses only existing design system components
/// - Demonstrates proper atom/molecule/organism composition
/// - Shows Material 3 theming and accessibility patterns
/// - Maintains consistent spacing using AppSpacer tokens
///
/// **For Developers:**
/// - Copy examples directly into your applications
/// - Understand when and how to use EmptyStateDashboardTemplate
/// - Learn proper empty state composition patterns
/// - See header and footer usage conventions
class EmptyStateDashboardTemplateShowcase extends StatelessWidget {
  const EmptyStateDashboardTemplateShowcase({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Showcase header
          AppText(
            'EmptyStateDashboardTemplate Examples',
            variant: AppTextVariant.headlineLarge,
          ),
          AppSpacerFactory.mediumVertical(),
          AppText(
            'Demonstrating empty state dashboard layouts with different configurations',
            variant: AppTextVariant.bodyLarge,
          ),
          AppSpacerFactory.extraLargeVertical(),

          // SCENARIO 1: Complete Dashboard Layout
          // Educational Focus: Full template usage with all optional components
          // Design Decisions: Header context, primary action, footer guidance
          _buildShowcaseSection(
            context,
            title: '1. Default Empty Dashboard - Complete Layout',
            description: 'Demonstrates full template usage with header context, main empty state, and footer guidance. Shows complete dashboard structure for first-time users.',
            child: EmptyStateDashboardTemplate(
              // Header provides dashboard context and potential actions
              header: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const AppText(
                    'Analytics Dashboard',
                    variant: AppTextVariant.titleLarge,
                  ),
                  AppButton(
                    text: 'Settings',
                    variant: AppButtonVariant.outline,
                    size: AppButtonSize.medium,
                    onPressed: () {}, // Mock action - showcase only
                  ),
                ],
              ),
              // Central empty state with clear guidance and action
              emptyState: AppEmptyStateSection(
                title: 'No data yet',
                description: 'Start creating content to see analytics and insights here. Your dashboard will show key metrics once you have data.',
                primaryAction: AppButton(
                  text: 'Create First Project',
                  variant: AppButtonVariant.primary,
                  size: AppButtonSize.large,
                  onPressed: () {}, // Mock action - showcase only
                ),
              ),
              // Footer provides additional help and context
              footer: const AppText(
                'Need help getting started? Visit our documentation or contact support.',
                variant: AppTextVariant.bodySmall,
              ),
            ),
          ),

          AppSpacerFactory.extraLargeVertical(),

          // SCENARIO 2: Minimal Configuration
          // Educational Focus: Simplest possible usage - content only
          // Design Decisions: No header or footer distractions, pure focus on action
          _buildShowcaseSection(
            context,
            title: '2. Minimal Empty State - Content Focus',
            description: 'Shows the simplest template configuration with only the required empty state content. Perfect for focused, single-purpose pages.',
            child: EmptyStateDashboardTemplate(
              // No header - immediate focus on empty state
              // No footer - clean, uncluttered experience
              emptyState: AppEmptyStateSection(
                title: 'Welcome to your workspace',
                description: 'This is where your projects will appear. Create your first project to get started.',
                primaryAction: AppButton(
                  text: 'Create Project',
                  variant: AppButtonVariant.primary,
                  size: AppButtonSize.large,
                  onPressed: () {}, // Mock action - showcase only
                ),
              ),
            ),
          ),

          AppSpacerFactory.extraLargeVertical(),

          // SCENARIO 3: Rich Contextual Dashboard
          // Educational Focus: Complex header with multiple elements and rich empty state
          // Design Decisions: Advanced header composition, detailed empty state guidance
          _buildShowcaseSection(
            context,
            title: '3. Contextual Header Dashboard - Rich Interface',
            description: 'Demonstrates advanced template usage with complex header composition and detailed empty state. Shows how to provide rich context while maintaining focus.',
            child: EmptyStateDashboardTemplate(
              // Complex header with title, breadcrumbs, and actions
              header: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Breadcrumb navigation context
                  const AppText(
                    'Home > Reports > Analytics',
                    variant: AppTextVariant.bodySmall,
                  ),
                  AppSpacerFactory.smallVertical(),
                  // Title and action row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const AppText(
                        'Monthly Analytics Report',
                        variant: AppTextVariant.headlineSmall,
                      ),
                      Row(
                        children: [
                          AppButton(
                            text: 'Refresh',
                            variant: AppButtonVariant.text,
                            size: AppButtonSize.medium,
                            onPressed: () {}, // Mock action - showcase only
                          ),
                          AppSpacerFactory.smallHorizontal(),
                          AppButton(
                            text: 'Export',
                            variant: AppButtonVariant.outline,
                            size: AppButtonSize.medium,
                            onPressed: () {}, // Mock action - showcase only
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              // Rich empty state with detailed guidance
              emptyState: AppEmptyStateSection(
                title: 'No report data available',
                description: 'Generate your first analytics report by connecting data sources and configuring your tracking parameters. Reports will appear here once data is collected.',
                primaryAction: AppButton(
                  text: 'Configure Analytics',
                  variant: AppButtonVariant.primary,
                  size: AppButtonSize.large,
                  onPressed: () {}, // Mock action - showcase only
                ),
              ),
              // No footer - header provides sufficient context
            ),
          ),

          // Bottom spacing for comfortable scrolling
          AppSpacerFactory.extraLargeVertical(),
        ],
      ),
    );
  }

  /// Builds a visually consistent showcase section with educational context.
  ///
  /// **Design System Role:**
  /// Creates a standardized container for each template demonstration with:
  /// - Clear section identification (title with primary color)
  /// - Educational description explaining design decisions
  /// - Visual separation through bordered containers
  /// - Consistent spacing using design system tokens
  ///
  /// **Educational Purpose:**
  /// Each section serves as a self-contained lesson showing:
  /// - When to use specific template patterns
  /// - How different components compose together
  /// - Visual hierarchy and spacing relationships
  /// - Real-world usage scenarios
  Widget _buildShowcaseSection(
    BuildContext context, {
    required String title,
    required String description,
    required Widget child,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section title with visual prominence
        AppText(
          title,
          variant: AppTextVariant.titleMedium,
        ),
        AppSpacerFactory.smallVertical(),
        
        // Educational description explaining the scenario
        AppText(
          description,
          variant: AppTextVariant.bodyMedium,
        ),
        AppSpacerFactory.mediumVertical(),
        
        // Template example with visual separation
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: Border.all(
              color: Theme.of(context).colorScheme.outline.withOpacity(0.2),
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: child,
        ),
      ],
    );
  }
}