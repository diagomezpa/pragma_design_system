import 'package:flutter/material.dart';

import '../../atoms/app_spacer.dart';
import '../../organisms/app_settings_group/app_settings_group.dart';

/// SettingsPageTemplate
///
/// A **template** that defines the structural layout for application settings pages.
/// This component operates at the Template layer of Atomic Design, composing
/// organisms and molecules to create consistent settings page structure
/// without any business logic, navigation, or state management.
///
/// **IMPORTANT: This is a TEMPLATE, not a Page or Screen**
/// Templates define page structure and layout patterns. They are:
/// - Stateless and presentation-only
/// - Reusable across different settings contexts
/// - Focused on layout composition, not data or business logic
/// - Independent of specific settings types or business requirements
///
/// **Template vs Page/Screen:**
/// - Template: Layout structure with placeholder content areas for settings
/// - Page/Screen: Complete implementation with data fetching, business logic, and navigation
///
/// **Atomic Design Level:**
/// Templates sit above organisms and below pages, focusing on:
/// - Content structure and hierarchy for settings pages
/// - Spacing and layout relationships between settings groups
/// - Component composition patterns for consistent settings presentation
/// - Responsive layout behavior across different screen sizes
///
/// **When to use this template:**
/// - Building application settings pages (profile, privacy, notifications, preferences)
/// - Creating consistent settings page layouts across different settings categories
/// - Defining page structure for user configuration screens
/// - When you need standardized settings presentation with grouped organization
/// - Establishing consistent settings navigation and hierarchy patterns
///
/// **When NOT to use this template:**
/// - For non-settings content pages (use appropriate domain templates)
/// - When you need complex business logic or data fetching (create a page/screen instead)
/// - For simple settings that don't need grouping (use AppSettingsGroup directly)
/// - When layout requirements are completely different from this structure
/// - For single-setting pages or inline setting controls
///
/// **Template Structure:**
/// ```
/// SingleChildScrollView (enables scrolling for long settings lists)
/// └── Column (with standard padding)
///     ├── Title (optional - page context and hierarchy)
///     ├── AppSpacer (conditional spacing)
///     ├── Settings Groups (AppSettingsGroup list with spacing)
///     └── Bottom Spacer (comfortable scrolling experience)
/// ```
///
/// **Usage Example:**
/// ```dart
/// SettingsPageTemplate(
///   title: AppText('Account Settings', variant: AppTextVariant.headlineSmall),
///   groups: [
///     AppSettingsGroup(
///       title: 'Profile',
///       items: [
///         AppListItem(title: 'Edit Profile', onTap: () {}),
///         AppListItem(title: 'Change Password', onTap: () {}),
///       ],
///     ),
///     AppSettingsGroup(
///       title: 'Privacy',
///       items: [
///         AppListItem(title: 'Privacy Settings', onTap: () {}),
///         AppListItem(title: 'Data Usage', onTap: () {}),
///       ],
///     ),
///   ],
/// )
/// ```
class SettingsPageTemplate extends StatelessWidget {
  /// Creates a settings page template with configurable title and grouped settings.
  ///
  /// This constructor defines the structural layout for settings pages
  /// without implementing any business logic, navigation, or state management.
  /// All parameters are focused on layout composition and settings organization.
  ///
  /// **Template Design Principles:**
  /// - Accepts pre-built widget components (organisms, molecules, atoms)
  /// - Defines spacing and layout relationships between settings groups
  /// - Remains agnostic to specific settings types or business logic
  /// - Provides consistent layout patterns across different settings implementations
  /// - Focuses on content organization and visual hierarchy
  const SettingsPageTemplate({
    super.key,
    this.title,
    required this.groups,
  });

  /// Optional title widget displayed at the top of the settings template.
  ///
  /// **Template Role:** Provides a dedicated content area for settings page context and hierarchy.
  /// **Common Usage:** AppText for page titles, breadcrumbs, or contextual headers.
  /// **Layout Impact:** When provided, adds large vertical spacing below using AppSpacer.
  /// **Design Intent:** Establishes settings page context and visual hierarchy.
  /// **Visual Hierarchy:** Positioned above settings groups for clear information structure.
  ///
  /// **Examples:**
  /// ```dart
  /// // Simple page title
  /// title: AppText('Account Settings', variant: AppTextVariant.headlineSmall)
  /// 
  /// // Complex header with subtitle
  /// title: Column(
  ///   crossAxisAlignment: CrossAxisAlignment.start,
  ///   children: [
  ///     AppText('Settings', variant: AppTextVariant.headlineSmall),
  ///     AppSpacerFactory.smallVertical(),
  ///     AppText('Manage your account and preferences', variant: AppTextVariant.bodyMedium),
  ///   ],
  /// )
  /// ```
  final Widget? title;

  /// Required list of settings group widgets arranged vertically.
  ///
  /// **Template Role:** Primary content area for organized settings groups.
  /// **Expected Content:** AppSettingsGroup organisms containing related settings items.
  /// **Layout Behavior:** Groups are spaced using AppSpacer.largeVertical for visual separation.
  /// **Design Intent:** Logical organization of settings with clear group boundaries.
  /// **User Experience:** Enables easy scanning and navigation of related settings.
  /// **Template Agnosticism:** Accepts any Widget list for maximum reusability across contexts.
  ///
  /// **Examples:**
  /// ```dart
  /// // Standard settings groups
  /// groups: [
  ///   AppSettingsGroup(
  ///     title: 'Account',
  ///     items: [
  ///       AppListItem(title: 'Profile Information', onTap: () {}),
  ///       AppListItem(title: 'Security', onTap: () {}),
  ///     ],
  ///   ),
  ///   AppSettingsGroup(
  ///     title: 'Preferences',
  ///     items: [
  ///       AppListItem(title: 'Notifications', onTap: () {}),
  ///       AppListItem(title: 'Language', onTap: () {}),
  ///     ],
  ///   ),
  /// ]
  /// 
  /// // Mixed content groups
  /// groups: [
  ///   CustomSettingsSection(...),
  ///   AppSettingsGroup(...),
  ///   AdvancedSettingsWidget(...),
  /// ]
  /// ```
  final List<Widget> groups;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      // Standard padding for consistent settings page margins
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

          // Settings groups with automatic spacing between multiple groups
          ..._buildSettingsGroups(),

          // Bottom padding ensures comfortable scrolling experience
          AppSpacerFactory.extraLargeVertical(),
        ],
      ),
    );
  }

  /// Builds the settings groups list with proper spacing between multiple groups.
  ///
  /// **Layout Logic:**
  /// - Renders each group widget directly
  /// - Adds spacing between groups (but not after the last group)
  /// - Uses AppSpacer.largeVertical for visual separation
  /// - Maintains clear visual hierarchy between different settings categories
  List<Widget> _buildSettingsGroups() {
    final List<Widget> settingsWidgets = [];
    
    for (int i = 0; i < groups.length; i++) {
      // Add the settings group widget
      settingsWidgets.add(groups[i]);
      
      // Add spacing between groups (not after the last group)
      if (i < groups.length - 1) {
        settingsWidgets.add(AppSpacerFactory.largeVertical());
      }
    }
    
    return settingsWidgets;
  }
}