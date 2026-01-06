import 'package:flutter/material.dart';
import 'package:pragma_design_system/pragma_design_system.dart';
import 'app_card_list/app_card_list_showcase.dart';
import 'app_empty_state_section/app_empty_state_section_showcase.dart';
import 'app_form_section/app_form_section_showcase.dart';
import 'app_product_list_item/app_product_list_item_showcase.dart';
import 'app_settings_group/app_settings_group_showcase.dart';

/// OrganismsListPage - A list of all organism showcase pages.
///
/// This page displays a list of all available organism showcase pages,
/// allowing users to navigate to each specific organism demonstration.
/// It serves as a central hub for exploring all organism components
/// in the design system.
class OrganismsListPage extends StatelessWidget {
  const OrganismsListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Organisms Showcase'),
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
            'Tap on any item to explore the organism showcase',
            variant: AppTextVariant.bodyMedium,
          ),
          const SizedBox(height: 24),
          ..._buildOrganismsList(context),
        ],
      ),
    );
  }

  /// Builds the list of organism showcase items
  List<Widget> _buildOrganismsList(BuildContext context) {
    final organisms = [
      OrganismShowcaseItem(
        title: 'App Card List',
        description: 'Lists of cards with various layouts and separators',
        icon: Icons.view_list,
        page: const AppCardListShowcase(),
      ),
      OrganismShowcaseItem(
        title: 'App Empty State Section',
        description: 'Complete empty state sections with actions',
        icon: Icons.inbox_outlined,
        page: const AppEmptyStateSectionShowcase(),
      ),
      OrganismShowcaseItem(
        title: 'App Form Section',
        description: 'Complete form sections with validation',
        icon: Icons.assignment,
        page: const AppFormSectionShowcase(),
      ),
      OrganismShowcaseItem(
        title: 'App Product List Item',
        description: 'Product list items for e-commerce layouts',
        icon: Icons.shopping_bag,
        page: const AppProductListItemShowcase(),
      ),
      OrganismShowcaseItem(
        title: 'App Settings Group',
        description: 'Settings groups with multiple configuration options',
        icon: Icons.settings,
        page: const AppSettingsGroupShowcase(),
      ),
    ];

    return organisms
        .map((organism) => _buildOrganismListItem(context, organism))
        .toList();
  }

  /// Builds an individual organism showcase list item
  Widget _buildOrganismListItem(
      BuildContext context, OrganismShowcaseItem organism) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: AppCard(
        child: ListTile(
          leading: Icon(
            organism.icon,
            size: 32,
            color: Theme.of(context).colorScheme.primary,
          ),
          title: AppText(
            organism.title,
            variant: AppTextVariant.titleMedium,
          ),
          subtitle: AppText(
            organism.description,
            variant: AppTextVariant.bodySmall,
          ),
          trailing: const Icon(Icons.arrow_forward_ios),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => organism.page,
              ),
            );
          },
        ),
      ),
    );
  }
}

/// Data class for organism showcase items
class OrganismShowcaseItem {
  const OrganismShowcaseItem({
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
