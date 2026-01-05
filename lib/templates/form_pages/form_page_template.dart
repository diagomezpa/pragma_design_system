import 'package:flutter/material.dart';

import '../../atoms/app_spacer.dart';
import '../../organisms/app_form_section/app_form_section.dart';

/// FormPageTemplate
///
/// A **template** that defines the structural layout for full-form pages.
/// This component operates at the Template layer of Atomic Design, composing
/// organisms and atoms to create consistent form page structure without any
/// business logic, form validation, or state management.
///
/// **IMPORTANT: This is a TEMPLATE, not a Page or Screen**
/// Templates define page structure and layout patterns. They are:
/// - Stateless and presentation-only
/// - Reusable across different contexts
/// - Focused on layout composition, not data or logic
/// - Independent of specific business requirements
///
/// **Template vs Page/Screen:**
/// - Template: Layout structure with placeholder content areas
/// - Page/Screen: Complete implementation with data, logic, and navigation
///
/// **Atomic Design Level:**
/// Templates sit above organisms and below pages, focusing on:
/// - Content structure and hierarchy
/// - Spacing and layout relationships
/// - Component composition patterns
/// - Responsive layout behavior
///
/// **When to use this template:**
/// - Building multi-section form pages (registration, settings, profiles)
/// - Creating consistent form page layouts across the application
/// - Defining page structure for data entry screens
/// - When you need a reusable form layout with multiple sections
///
/// **When NOT to use this template:**
/// - For single-section forms (use AppFormSection organism directly)
/// - When you need form validation or state management (create a page/screen instead)
/// - For non-form content pages (use appropriate domain templates)
/// - When layout requirements are completely different from this structure
///
/// **Template Structure:**
/// ```
/// SingleChildScrollView
/// └── Column (with padding)
///     ├── Title (optional)
///     ├── AppSpacer (if title exists)
///     ├── Form Sections (AppFormSection list)
///     ├── AppSpacer (if actions exist)
///     └── Action Area (optional)
///         ├── Primary Action
///         ├── AppSpacer (if both actions)
///         └── Secondary Action (optional)
/// ```
///
/// **Usage Example:**
/// ```dart
/// FormPageTemplate(
///   title: AppText('Create Account', variant: AppTextVariant.titleLarge),
///   sections: [
///     AppFormSection(
///       title: 'Personal Information',
///       children: [AppFormField(label: 'Name', ...)],
///     ),
///     AppFormSection(
///       title: 'Account Settings',
///       children: [AppFormField(label: 'Email', ...)],
///     ),
///   ],
///   primaryAction: AppButton(text: 'Submit', onPressed: () {}),
///   secondaryAction: AppButton(text: 'Cancel', onPressed: () {}),
/// )
/// ```
class FormPageTemplate extends StatelessWidget {
  /// Creates a form page template with configurable layout sections and actions.
  ///
  /// This constructor defines the structural layout for form pages without
  /// implementing any business logic, validation, or state management.
  /// All parameters are focused on layout composition and visual hierarchy.
  ///
  /// **Template Design Principles:**
  /// - Accepts pre-built widget components (organisms, molecules, atoms)
  /// - Defines spacing and layout relationships between components
  /// - Remains agnostic to specific form content or business logic
  /// - Provides consistent layout patterns across different form implementations
  const FormPageTemplate({
    super.key,
    this.title,
    required this.sections,
    this.primaryAction,
    this.secondaryAction,
  });

  /// Optional title widget displayed at the top of the form template.
  ///
  /// **Template Role:** Provides a dedicated content area for form page titles.
  /// **Common Usage:** AppText widget with headlineSmall or titleLarge variant.
  /// **Layout Impact:** When provided, adds spacing below using AppSpacer.largeVertical.
  /// **Design Intent:** Establishes visual hierarchy and page context.
  ///
  /// Example:
  /// ```dart
  /// title: AppText('User Registration', variant: AppTextVariant.headlineSmall)
  /// ```
  final Widget? title;

  /// Required list of form section widgets arranged vertically.
  ///
  /// **Template Role:** Primary content area for form sections and fields.
  /// **Expected Content:** AppFormSection organisms containing related form fields.
  /// **Layout Behavior:** Sections are spaced using AppSpacer.largeVertical between items.
  /// **Design Intent:** Groups logically related form controls with consistent spacing.
  /// **Flexibility:** Accepts any Widget list for maximum template reusability.
  ///
  /// Example:
  /// ```dart
  /// sections: [
  ///   AppFormSection(title: 'Personal Info', children: [...]),
  ///   AppFormSection(title: 'Account Settings', children: [...]),
  /// ]
  /// ```
  final List<Widget> sections;

  /// Optional primary action widget for the main form submission or completion.
  ///
  /// **Template Role:** Defines primary action area with prominent visual treatment.
  /// **Common Usage:** AppButton with primary variant and large size.
  /// **Layout Position:** Top position in action area with full-width stretch.
  /// **Visual Hierarchy:** Most prominent action, typically for form submission.
  /// **Design Intent:** Clear call-to-action for primary user flow.
  ///
  /// Example:
  /// ```dart
  /// primaryAction: AppButton(
  ///   text: 'Create Account',
  ///   variant: AppButtonVariant.primary,
  ///   size: AppButtonSize.large,
  /// )
  /// ```
  final Widget? primaryAction;

  /// Optional secondary action widget for alternative or cancel actions.
  ///
  /// **Template Role:** Provides secondary action area below primary action.
  /// **Common Usage:** AppButton with outline, secondary, or text variant.
  /// **Layout Position:** Below primary action with medium spacing separation.
  /// **Visual Hierarchy:** Less prominent than primary action, for alternative flows.
  /// **Design Intent:** Escape hatch or alternative user actions (Cancel, Save Draft, etc.).
  ///
  /// Example:
  /// ```dart
  /// secondaryAction: AppButton(
  ///   text: 'Save as Draft',
  ///   variant: AppButtonVariant.outline,
  ///   size: AppButtonSize.large,
  /// )
  /// ```
  final Widget? secondaryAction;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      // Standard padding for consistent form page margins
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Page title section with conditional spacing
          if (title != null) ...[
            title!,
            AppSpacerFactory.largeVertical(), // Creates visual separation from content
          ],

          // Form sections with automatic spacing between multiple sections
          ..._buildFormSections(),

          // Action buttons area with conditional rendering and spacing
          ..._buildActionArea(),

          // Bottom padding ensures comfortable scrolling experience
          AppSpacerFactory.extraLargeVertical(),
        ],
      ),
    );
  }

  /// Builds the form sections list with proper spacing between multiple sections.
  ///
  /// **Layout Logic:**
  /// - Renders each section widget directly
  /// - Adds spacing between sections (but not after the last section)
  /// - Uses AppSpacer.largeVertical for visual separation
  List<Widget> _buildFormSections() {
    final List<Widget> formWidgets = [];
    
    for (int i = 0; i < sections.length; i++) {
      // Add the section widget
      formWidgets.add(sections[i]);
      
      // Add spacing between sections (not after the last section)
      if (i < sections.length - 1) {
        formWidgets.add(AppSpacerFactory.largeVertical());
      }
    }
    
    return formWidgets;
  }

  /// Builds the action area with primary and secondary buttons.
  ///
  /// **Layout Logic:**
  /// - Only renders if at least one action is provided
  /// - Primary action rendered first (top position)
  /// - Medium spacing between primary and secondary actions
  /// - Both actions use full-width stretch layout
  /// - Extra large spacing separates actions from form content
  List<Widget> _buildActionArea() {
    // Return empty list if no actions are provided
    if (primaryAction == null && secondaryAction == null) {
      return [];
    }

    return [
      AppSpacerFactory.extraLargeVertical(), // Separation from form content
      Column(
        crossAxisAlignment: CrossAxisAlignment.stretch, // Full-width buttons
        mainAxisSize: MainAxisSize.min,
        children: [
          // Primary action (main call-to-action)
          if (primaryAction != null) primaryAction!,
          
          // Spacing between actions when both are present
          if (primaryAction != null && secondaryAction != null)
            AppSpacerFactory.mediumVertical(),
          
          // Secondary action (alternative or cancel action)
          if (secondaryAction != null) secondaryAction!,
        ],
      ),
    ];
  }
}