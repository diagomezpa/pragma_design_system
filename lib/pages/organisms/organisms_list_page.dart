import 'package:flutter/material.dart';
import 'package:pragma_design_system/organisms/organisms_showcase.dart';
import 'package:pragma_design_system/pragma_design_system.dart';

import '../shared/showcase_list_item.dart';

/// OrganismsListPage - A list page displaying all available organism showcases.
///
/// This page serves as the entry point for exploring Organism components
/// in the design system example app. Organisms represent complex UI components
/// that combine multiple molecules and atoms to create distinct sections
/// of an interface (e.g., headers, forms, product lists, settings groups).
///
/// In Atomic Design methodology:
/// - **Organisms** are relatively complex UI components composed of groups
///   of molecules and/or atoms and/or other organisms. They form distinct
///   sections of an interface and serve as building blocks for templates
///   and pages, providing complete functional areas.
///
/// This page provides:
/// - Overview of all available organism showcase pages
/// - Easy navigation to individual organism demonstrations
/// - Consistent interface following example app conventions
///
/// Architecture:
/// - Lives in the example app (not the design system package)
/// - Uses shared `ShowcaseListItem` for consistent navigation
/// - Imports organism showcases via their barrel file
class OrganismsListPage extends StatelessWidget {
  /// Creates an organisms list page.
  const OrganismsListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Organisms'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const AppText(
            'Organism Components',
            variant: AppTextVariant.titleLarge,
          ),
          const SizedBox(height: 8),
          const AppText(
            'Organisms are complex UI components composed of groups of molecules and atoms. They form distinct sections of an interface and serve as building blocks for complete page layouts.',
            variant: AppTextVariant.bodyMedium,
          ),
          const SizedBox(height: 24),
          ..._buildOrganismsList(),
        ],
      ),
    );
  }

  /// Builds the list of organism showcase items.
  List<Widget> _buildOrganismsList() {
    return [
      ShowcaseListItem(
        title: 'App Card List',
        description: 'Lists of cards with various layouts and separators',
        icon: Icons.view_list,
        page: const AppCardListShowcase(),
      ),
      ShowcaseListItem(
        title: 'App Empty State Section',
        description: 'Complete empty state sections with actions and content',
        icon: Icons.inbox_outlined,
        page: const AppEmptyStateSectionShowcase(),
      ),
      ShowcaseListItem(
        title: 'App Form Section',
        description: 'Complete form sections with fields and validation',
        icon: Icons.assignment_outlined,
        page: const AppFormSectionShowcase(),
      ),
      ShowcaseListItem(
        title: 'App Product List Item',
        description: 'Complex product list items for e-commerce applications',
        icon: Icons.shopping_bag_outlined,
        page: const AppProductListItemShowcase(),
      ),
      ShowcaseListItem(
        title: 'App Settings Group',
        description: 'Settings group sections with organized configuration options',
        icon: Icons.settings_outlined,
        page: const AppSettingsGroupShowcase(),
      ),
    ];
  }
}