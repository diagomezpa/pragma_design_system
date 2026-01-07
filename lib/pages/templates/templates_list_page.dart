import 'package:flutter/material.dart';
import 'package:pragma_design_system/templates/templates_showcase.dart';
import 'package:pragma_design_system/pragma_design_system.dart';

import '../shared/showcase_list_item.dart';

/// TemplatesListPage - A list page displaying all available template showcases.
///
/// This page serves as the entry point for exploring Template components
/// in the design system example app. Templates represent page-level layout
/// structures that combine organisms, molecules, and atoms to create complete
/// page layouts (e.g., product listing pages, form pages, dashboard layouts).
///
/// In Atomic Design methodology:
/// - **Templates** consist of groups of organisms stitched together to form
///   complete page layouts. They focus on content structure rather than final
///   content, providing the skeletal framework that defines how components
///   work together on a page level.
///
/// Templates vs Pages:
/// - Templates define the layout structure and component arrangement
/// - Pages are specific instances of templates with real content
/// - Templates are reusable across multiple similar page types
///
/// This page provides:
/// - Overview of all available template showcase pages
/// - Easy navigation to individual template demonstrations
/// - Consistent interface following example app conventions
///
/// Architecture:
/// - Lives in the example app (not the design system package)
/// - Uses shared `ShowcaseListItem` for consistent navigation
/// - Imports template showcases via their barrel file
class TemplatesListPage extends StatelessWidget {
  /// Creates a templates list page.
  const TemplatesListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Templates'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const AppText(
            'Template Components',
            variant: AppTextVariant.titleLarge,
          ),
          const SizedBox(height: 8),
          const AppText(
            'Templates are page-level layout structures that combine organisms, molecules, and atoms. They define the skeletal framework and component arrangement for complete page layouts.',
            variant: AppTextVariant.bodyMedium,
          ),
          const SizedBox(height: 24),
          ..._buildTemplatesList(),
        ],
      ),
    );
  }

  /// Builds the list of template showcase items.
  List<Widget> _buildTemplatesList() {
    return [
      ShowcaseListItem(
        title: 'Product List Template',
        description: 'Complete product listing page templates for e-commerce',
        icon: Icons.inventory_2_outlined,
        page: const ProductListTemplateShowcase(),
      ),
      ShowcaseListItem(
        title: 'Form Page Template',
        description: 'Complete form page templates with validation and layout',
        icon: Icons.description_outlined,
        page: const FormPageTemplateShowcase(),
      ),
      ShowcaseListItem(
        title: 'Empty State Dashboard Template',
        description: 'Complete dashboard templates for empty state scenarios',
        icon: Icons.dashboard_outlined,
        page: const EmptyStateDashboardTemplateShowcase(),
      ),
      ShowcaseListItem(
        title: 'Settings Page Template',
        description: 'Complete settings page templates with organized sections',
        icon: Icons.settings_applications_outlined,
        page: const SettingsPageTemplateShowcase(),
      ),
    ];
  }
}