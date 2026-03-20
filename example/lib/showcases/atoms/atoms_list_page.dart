import 'package:flutter/material.dart';
import 'package:pragma_design_system/pragma_design_system.dart';
import 'app_button_showcase.dart';

/// AtomsListPage - A list of all atom showcase pages.
///
/// This page displays a list of all available atom showcase pages,
/// allowing users to navigate to each specific atom demonstration.
/// It serves as a central hub for exploring all atom components
/// in the design system.
class AtomsListPage extends StatelessWidget {
  const AtomsListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Atoms Showcase'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const AppText(
            'Atom Components',
            variant: AppTextVariant.titleLarge,
          ),
          const SizedBox(height: 8),
          const AppText(
            'Tap on any item to explore the atom showcase',
            variant: AppTextVariant.bodyMedium,
          ),
          const SizedBox(height: 24),
          ..._buildAtomsList(context),
        ],
      ),
    );
  }

  /// Builds the list of atom showcase items
  List<Widget> _buildAtomsList(BuildContext context) {
    final atoms = [
      AtomShowcaseItem(
        title: 'App Button',
        description: 'Button components for user interactions',
        icon: Icons.smart_button,
        page: const AppButtonShowcase(),
      ),
      // Future atoms will be added here:
      // AtomShowcaseItem(
      //   title: 'App Text',
      //   description: 'Text components with consistent typography',
      //   icon: Icons.text_fields,
      //   page: const AppTextShowcase(),
      // ),
      // AtomShowcaseItem(
      //   title: 'App Icon',
      //   description: 'Icon components for visual communication',
      //   icon: Icons.star,
      //   page: const AppIconShowcase(),
      // ),
      // AtomShowcaseItem(
      //   title: 'App Spacer',
      //   description: 'Spacing components for layout consistency',
      //   icon: Icons.space_bar,
      //   page: const AppSpacerShowcase(),
      // ),
      // AtomShowcaseItem(
      //   title: 'App Image',
      //   description: 'Image components with loading and error states',
      //   icon: Icons.image,
      //   page: const AppImageShowcase(),
      // ),
      // AtomShowcaseItem(
      //   title: 'App Divider',
      //   description: 'Visual separation components for layouts',
      //   icon: Icons.horizontal_rule,
      //   page: const AppDividerShowcase(),
      // ),
    ];

    return atoms
        .map((atom) => _buildAtomListItem(context, atom))
        .toList();
  }

  /// Builds an individual atom showcase list item
  Widget _buildAtomListItem(
      BuildContext context, AtomShowcaseItem atom) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: AppCard(
        child: ListTile(
          leading: Icon(
            atom.icon,
            size: 32,
            color: Theme.of(context).colorScheme.primary,
          ),
          title: AppText(
            atom.title,
            variant: AppTextVariant.titleMedium,
          ),
          subtitle: AppText(
            atom.description,
            variant: AppTextVariant.bodySmall,
          ),
          trailing: const Icon(Icons.arrow_forward_ios),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => atom.page,
              ),
            );
          },
        ),
      ),
    );
  }
}

/// Data class for atom showcase items
class AtomShowcaseItem {
  const AtomShowcaseItem({
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