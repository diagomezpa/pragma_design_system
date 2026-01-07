import 'package:flutter/material.dart';
import 'package:pragma_design_system/molecules/molecules_showcase.dart';
import 'package:pragma_design_system/pragma_design_system.dart';

import '../shared/showcase_list_item.dart';

/// MoleculesListPage - A list page displaying all available molecule showcases.
///
/// This page serves as the entry point for exploring Molecule components
/// in the design system example app. Molecules represent UI components that
/// are composed of multiple atoms working together to form functional units
/// (e.g., form fields, list items, cards).
///
/// In Atomic Design methodology:
/// - **Molecules** are groups of atoms bonded together to form functional
///   components. They have their own properties and serve as the backbone
///   of our design system, providing reusable building blocks for more
///   complex interfaces.
///
/// This page provides:
/// - Overview of all available molecule showcase pages
/// - Easy navigation to individual molecule demonstrations
/// - Consistent interface following example app conventions
///
/// Architecture:
/// - Lives in the example app (not the design system package)
/// - Uses shared `ShowcaseListItem` for consistent navigation
/// - Imports molecule showcases via their barrel file
class MoleculesListPage extends StatelessWidget {
  /// Creates a molecules list page.
  const MoleculesListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Molecules'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const AppText(
            'Molecule Components',
            variant: AppTextVariant.titleLarge,
          ),
          const SizedBox(height: 8),
          const AppText(
            'Molecules are UI components composed of groups of atoms bonded together. They form functional units that serve as the backbone of our design system.',
            variant: AppTextVariant.bodyMedium,
          ),
          const SizedBox(height: 24),
          ..._buildMoleculesList(),
        ],
      ),
    );
  }

  /// Builds the list of molecule showcase items.
  List<Widget> _buildMoleculesList() {
    return [
      ShowcaseListItem(
        title: 'App Form Field',
        description: 'Form input components with labels and validation',
        icon: Icons.edit_note,
        page: const ShowcasePage(),
      ),
      ShowcaseListItem(
        title: 'App List Item',
        description: 'Reusable list item components for various layouts',
        icon: Icons.format_list_bulleted,
        page: const AppListItemShowcase(),
      ),
      ShowcaseListItem(
        title: 'App Empty State',
        description: 'Empty state components for no-data scenarios',
        icon: Icons.inbox,
        page: const AppEmptyStateShowcase(),
      ),
      ShowcaseListItem(
        title: 'App Section',
        description: 'Section containers with titles and organized content',
        icon: Icons.view_module,
        page: const AppSectionShowcase(),
      ),
      ShowcaseListItem(
        title: 'App Card',
        description: 'Card containers for content grouping and elevation',
        icon: Icons.credit_card,
        page: const AppCardShowcase(),
      ),
      ShowcaseListItem(
        title: 'App Price',
        description: 'Price display components for e-commerce applications',
        icon: Icons.attach_money,
        page: const AppPriceShowcase(),
      ),
    ];
  }
}