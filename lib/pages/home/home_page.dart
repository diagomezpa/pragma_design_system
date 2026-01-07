import 'package:flutter/material.dart';
import 'package:pragma_design_system/pragma_design_system.dart';

import '../molecules/molecules_list_page.dart';
import '../organisms/organisms_list_page.dart';
import '../templates/templates_list_page.dart';
import '../shared/showcase_list_item.dart';

/// HomePage - The main entry point of the Design System example app.
///
/// This page serves as the central dashboard for exploring the Pragma Design
/// System components organized by Atomic Design principles. It provides
/// navigation to different component categories and explains the purpose
/// of the example application.
///
/// Navigation Philosophy:
/// - Users first select a component category (Molecules, Organisms, Templates)
/// - Each category leads to a list page showing all components in that category
/// - From list pages, users can navigate to individual component showcases
/// - This hierarchical approach provides clear organization and discovery
///
/// Atomic Design Exploration:
/// - **Molecules**: Groups of atoms working together as functional units
/// - **Organisms**: Complex components combining multiple molecules/atoms
/// - **Templates**: Page-level layout structures and component arrangements
/// - **Pages**: Specific instances of templates with real content (future)
///
/// Architecture:
/// - Lives in the example app as the main entry point
/// - Uses shared `ShowcaseListItem` for consistent navigation
/// - Imports list pages (not individual showcases) for clean separation
/// - Provides educational context about the Design System structure
class HomePage extends StatelessWidget {
  /// Creates the main home page.
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pragma Design System'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // Header Section
          const AppText(
            'Design System Showcase',
            variant: AppTextVariant.headlineLarge,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          const AppText(
            'Explore our Design System components organized by Atomic Design principles. Each category contains reusable components that work together to create consistent, beautiful user interfaces.',
            variant: AppTextVariant.bodyLarge,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          
          // Navigation Section
          const AppText(
            'Explore Components',
            variant: AppTextVariant.titleLarge,
          ),
          const SizedBox(height: 8),
          const AppText(
            'Navigate to different component categories to discover and interact with our Design System elements.',
            variant: AppTextVariant.bodyMedium,
          ),
          const SizedBox(height: 24),
          ..._buildNavigationList(),
        ],
      ),
    );
  }

  /// Builds the list of navigation items for component categories.
  List<Widget> _buildNavigationList() {
    return [
      ShowcaseListItem(
        title: 'Molecules',
        description: 'Functional components made from groups of atoms working together',
        icon: Icons.group_work_outlined,
        page: const MoleculesListPage(),
      ),
      ShowcaseListItem(
        title: 'Organisms',
        description: 'Complex components combining molecules and atoms into distinct sections',
        icon: Icons.account_tree_outlined,
        page: const OrganismsListPage(),
      ),
      ShowcaseListItem(
        title: 'Templates',
        description: 'Page-level layout structures that define component arrangements',
        icon: Icons.web_outlined,
        page: const TemplatesListPage(),
      ),
      ShowcaseListItem(
        title: 'Pages',
        description: 'Complete page examples with real content and user flows',
        icon: Icons.article_outlined,
        page: const _PagesPlaceholderPage(),
      ),
    ];
  }
}

/// Temporary placeholder page for Pages category.
/// TODO: Replace with actual PagesListPage when Pages are implemented.
class _PagesPlaceholderPage extends StatelessWidget {
  const _PagesPlaceholderPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pages'),
        centerTitle: true,
      ),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.construction_outlined,
                size: 64,
                color: Colors.grey,
              ),
              SizedBox(height: 16),
              AppText(
                'Pages Coming Soon',
                variant: AppTextVariant.titleLarge,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 8),
              AppText(
                'Complete page examples with real content and user flows will be available in future updates.',
                variant: AppTextVariant.bodyMedium,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}