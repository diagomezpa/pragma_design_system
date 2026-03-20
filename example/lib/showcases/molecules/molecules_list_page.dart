import 'package:flutter/material.dart';
import 'package:pragma_design_system/pragma_design_system.dart';
import 'app_card_showcase.dart';
import 'app_empty_state_showcase.dart';
import 'app_price_showcase.dart';
import 'app_section_showcase.dart';
import 'app_form_field_page.dart';
import 'app_list_item_showcase.dart';

/// MoleculesListPage - A list of all molecule showcase pages.
///
/// This page displays a list of all available molecule showcase pages,
/// allowing users to navigate to each specific molecule demonstration.
/// It serves as a central hub for exploring all molecule components
/// in the design system.
class MoleculesListPage extends StatelessWidget {
  const MoleculesListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Molecules Showcase'),
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
            'Tap on any item to explore the molecule showcase',
            variant: AppTextVariant.bodyMedium,
          ),
          const SizedBox(height: 24),
          ..._buildMoleculesList(context),
        ],
      ),
    );
  }

  /// Builds the list of molecule showcase items
  List<Widget> _buildMoleculesList(BuildContext context) {
    final molecules = [
      MoleculeShowcaseItem(
        title: 'App Card',
        description: 'Card containers for content grouping',
        icon: Icons.credit_card,
        page: const AppCardShowcase(),
      ),
      MoleculeShowcaseItem(
        title: 'App Empty State',
        description: 'Empty state components for no-data scenarios',
        icon: Icons.inbox,
        page: const AppEmptyStateShowcase(),
      ),
      MoleculeShowcaseItem(
        title: 'App Price',
        description: 'Price display components for e-commerce',
        icon: Icons.attach_money,
        page: const AppPriceShowcase(),
      ),
      MoleculeShowcaseItem(
        title: 'App Section',
        description: 'Section containers with titles and content',
        icon: Icons.view_module,
        page: const AppSectionShowcase(),
      ),
      MoleculeShowcaseItem(
        title: 'Form Field',
        description: 'Form input components and validation',
        icon: Icons.edit_note,
        page: const ShowcasePage(),
      ),
      MoleculeShowcaseItem(
        title: 'List Item',
        description: 'List item components for various layouts',
        icon: Icons.format_list_bulleted,
        page: const AppListItemShowcase(),
      ),
    ];

    return molecules
        .map((molecule) => _buildMoleculeListItem(context, molecule))
        .toList();
  }

  /// Builds an individual molecule showcase list item
  Widget _buildMoleculeListItem(
      BuildContext context, MoleculeShowcaseItem molecule) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: AppCard(
        child: ListTile(
          leading: Icon(
            molecule.icon,
            size: 32,
            color: Theme.of(context).colorScheme.primary,
          ),
          title: AppText(
            molecule.title,
            variant: AppTextVariant.titleMedium,
          ),
          subtitle: AppText(
            molecule.description,
            variant: AppTextVariant.bodySmall,
          ),
          trailing: const Icon(Icons.arrow_forward_ios),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => molecule.page,
              ),
            );
          },
        ),
      ),
    );
  }
}

/// Data class for molecule showcase items
class MoleculeShowcaseItem {
  const MoleculeShowcaseItem({
    required this.title,
    required this.description,
    required this.icon,
    required this.page,
  });

  final String title;
  final String description;
  final IconData icon;
  final Widget page;
}
