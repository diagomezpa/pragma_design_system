import 'package:flutter/material.dart';

import '../../atoms/app_spacer/app_spacer.dart';
import '../../molecules/app_section/app_section.dart';
import '../../organisms/app_empty_state_section/app_empty_state_section.dart';

/// EmptyStateDashboardTemplate
///
/// A **template** that defines the structural layout for dashboard pages with no data.
/// This component operates at the Template layer of Atomic Design, composing
/// organisms and molecules to create consistent empty state page structure
/// without any business logic, navigation, or state management.
///
/// **IMPORTANT: This is a TEMPLATE, not a Page or Screen**
/// Templates define page structure and layout patterns. They are:
/// - Stateless and presentation-only
/// - Reusable across different dashboard contexts
/// - Focused on layout composition, not data or business logic
/// - Independent of specific dashboard types or business requirements
///
/// **Template vs Page/Screen:**
/// - Template: Layout structure with placeholder content areas for empty states
/// - Page/Screen: Complete implementation with data fetching, business logic, and navigation
///
/// **Atomic Design Level:**
/// Templates sit above organisms and below pages, focusing on:
/// - Content structure and hierarchy for empty dashboard states
/// - Spacing and layout relationships between contextual components
/// - Component composition patterns for consistent empty state presentation
/// - Responsive layout behavior across different screen sizes
///
/// **When to use this template:**
/// - Building dashboard pages that currently have no data to display
/// - Creating consistent empty state layouts across different dashboard types
/// - Defining page structure for onboarding or first-time user experiences
/// - When you need standardized empty state presentation with optional context
/// - Establishing consistent guidance patterns for user action in empty states
///
/// **When NOT to use this template:**
/// - For dashboards with data (use appropriate data-focused dashboard templates)
/// - When you need complex business logic or data fetching (create a page/screen instead)
/// - For simple empty states within existing layouts (use AppEmptyStateSection directly)
/// - When layout requirements are completely different from this structure
/// - For error states or loading states (use appropriate state-specific templates)
///
/// **Template Structure:**
/// ```
/// AppSection (provides consistent section styling)
/// └── Child: Column
///     ├── Header (optional - titles, breadcrumbs, context)
///     ├── AppSpacer (conditional spacing)
///     ├── EmptyState (required - AppEmptyStateSection)
///     ├── AppSpacer (conditional spacing)
///     └── Footer (optional - secondary actions, help links)
/// ```
///
/// **Usage Example:**
/// ```dart
/// EmptyStateDashboardTemplate(
///   header: Row(
///     children: [
///       AppText('Analytics Dashboard', variant: AppTextVariant.titleLarge),
///       Spacer(),
///       AppButton(text: 'Refresh', onPressed: () {}),
///     ],
///   ),
///   emptyState: AppEmptyStateSection(
///     title: 'No data yet',
///     description: 'Start creating content to see analytics here.',
///     action: AppButton(text: 'Create Content', onPressed: () {}),
///   ),
///   footer: AppText(
///     'Need help? Visit our documentation',
///     variant: AppTextVariant.bodySmall,
///   ),
/// )
/// ```
class EmptyStateDashboardTemplate extends StatelessWidget {
  /// Creates an empty state dashboard template with configurable header, content, and footer areas.
  ///
  /// This constructor defines the structural layout for empty dashboard pages
  /// without implementing any business logic, navigation, or state management.
  /// All parameters are focused on layout composition and user guidance.
  ///
  /// **Template Design Principles:**
  /// - Accepts pre-built widget components (organisms, molecules, atoms)
  /// - Defines spacing and layout relationships between contextual components
  /// - Remains agnostic to specific dashboard types or business logic
  /// - Provides consistent layout patterns across different empty state implementations
  /// - Focuses on user guidance and next-action clarity
  const EmptyStateDashboardTemplate({
    super.key,
    this.header,
    required this.emptyState,
    this.footer,
  });

  /// Optional header widget displayed at the top of the empty state template.
  ///
  /// **Template Role:** Provides a dedicated content area for dashboard context and navigation.
  /// **Common Usage:** AppText for titles, breadcrumbs, refresh buttons, or contextual actions.
  /// **Layout Impact:** When provided, adds large vertical spacing below using AppSpacer.
  /// **Design Intent:** Establishes dashboard context and provides space for user-oriented actions.
  /// **Visual Hierarchy:** Positioned above empty state content for clear information hierarchy.
  ///
  /// **Examples:**
  /// ```dart
  /// // Simple title header
  /// header: AppText('Analytics Dashboard', variant: AppTextVariant.titleLarge)
  /// 
  /// // Complex header with breadcrumbs and actions
  /// header: Column(
  ///   crossAxisAlignment: CrossAxisAlignment.start,
  ///   children: [
  ///     AppText('Home > Analytics', variant: AppTextVariant.bodySmall),
  ///     AppSpacerFactory.smallVertical(),
  ///     Row(
  ///       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  ///       children: [
  ///         AppText('Analytics Dashboard', variant: AppTextVariant.titleLarge),
  ///         AppButton(text: 'Refresh', onPressed: () {}),
  ///       ],
  ///     ),
  ///   ],
  /// )
  /// ```
  final Widget? header;

  /// Required empty state widget providing guidance and next actions.
  ///
  /// **Template Role:** Primary content area for empty state presentation and user guidance.
  /// **Expected Content:** AppEmptyStateSection organism with contextual messaging and actions.
  /// **Layout Behavior:** Centered within the template for optimal visual prominence.
  /// **Design Intent:** Clear communication of current state and available user actions.
  /// **User Experience:** Prevents confusion and guides users toward productive next steps.
  /// **Template Agnosticism:** Accepts any Widget for maximum reusability across contexts.
  ///
  /// **Examples:**
  /// ```dart
  /// // Standard empty state with action
  /// emptyState: AppEmptyStateSection(
  ///   title: 'No projects yet',
  ///   description: 'Create your first project to get started with the dashboard.',
  ///   action: AppButton(text: 'Create Project', onPressed: () {}),
  /// )
  /// 
  /// // Empty state with custom illustration
  /// emptyState: AppEmptyStateSection(
  ///   illustration: CustomIllustrationWidget(),
  ///   title: 'Welcome to Analytics',
  ///   description: 'Connect your data sources to see insights here.',
  ///   action: AppButton(text: 'Connect Data', onPressed: () {}),
  /// )
  /// ```
  final Widget emptyState;

  /// Optional footer widget displayed below the empty state content.
  ///
  /// **Template Role:** Provides additional context, help links, or secondary actions.
  /// **Common Usage:** Help text, documentation links, secondary actions, or status information.
  /// **Layout Position:** Bottom of template with spacing from empty state content.
  /// **Visual Hierarchy:** Least prominent area for supplementary information.
  /// **Design Intent:** Offers additional user support without competing with primary actions.
  /// **User Experience:** Provides escape hatches and additional assistance options.
  ///
  /// **Examples:**
  /// ```dart
  /// // Simple help text footer
  /// footer: AppText(
  ///   'Need help getting started? Visit our documentation',
  ///   variant: AppTextVariant.bodySmall,
  /// )
  /// 
  /// // Footer with multiple links
  /// footer: Wrap(
  ///   spacing: 16,
  ///   children: [
  ///     AppButton(text: 'Documentation', variant: AppButtonVariant.text),
  ///     AppButton(text: 'Support', variant: AppButtonVariant.text),
  ///     AppButton(text: 'Video Tutorial', variant: AppButtonVariant.text),
  ///   ],
  /// )
  /// ```
  final Widget? footer;

  @override
  Widget build(BuildContext context) {
    // AppSection provides consistent section styling and accessibility structure
    // Following design system patterns for sectioned dashboard content
    return AppSection(
      title: 'Dashboard', // Default section title for accessibility and screen readers
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // Left-aligned content for text readability
        mainAxisSize: MainAxisSize.min, // Efficient space usage - shrink to content
        children: [
          // Build header section with conditional rendering and spacing
          ..._buildHeaderSection(),
          
          // Main empty state content - central focus of the template
          emptyState, // Always present - provides user guidance and actions
          
          // Build footer section with conditional rendering and spacing
          ..._buildFooterSection(),
        ],
      ),
    );
  }

  /// Builds the optional header section with proper spacing.
  ///
  /// **Layout Logic:**
  /// - Only renders if header is provided
  /// - Adds large vertical spacing below header for visual separation
  /// - Creates clear hierarchy between context and main content
  List<Widget> _buildHeaderSection() {
    if (header == null) return [];
    
    return [
      header!, // Render dashboard context, navigation, or actions
      AppSpacerFactory.largeVertical(), // Generous spacing creates visual hierarchy
    ];
  }

  /// Builds the optional footer section with proper spacing.
  ///
  /// **Layout Logic:**
  /// - Only renders if footer is provided
  /// - Adds large vertical spacing above footer for content separation
  /// - Positions supplementary content below main empty state
  List<Widget> _buildFooterSection() {
    if (footer == null) return [];
    
    return [
      AppSpacerFactory.largeVertical(), // Clear separation from main content
      footer!, // Render help text, links, or secondary actions
    ];
  }
}