import 'package:flutter/material.dart';
import 'package:pragma_design_system/pragma_design_system.dart';
import '../shared/showcase_list_item.dart';
import '../other_pages/other_pages_list_pages.dart';
import '../../feedback/app_snackbar_showcase.dart';
import '../../feedback/feedback_demo.dart';
import '../../feedback/practical_feedback_example.dart';
import '../../atoms/atoms_list_page.dart';
import '../../molecules/molecules_list_page.dart';
import '../organisms/organisms_list_page.dart';
import '../../templates/templates_list_page.dart';

/// HomePage - The main entry point of the Design System example app.
///
/// This page serves as the central dashboard for exploring the Pragma Design
/// System components organized by Atomic Design principles. It provides
/// navigation to different component categories and explains the purpose
/// of the example application.
///
/// Navigation Philosophy:
/// - Users first select a component category (Atoms, Molecules, Organisms, Templates)
/// - Each category leads to a list page showing all components in that category
/// - From list pages, users can navigate to individual component showcases
/// - This hierarchical approach provides clear organization and discovery
///
/// Atomic Design Exploration:
/// - **Atoms**: Fundamental building blocks that cannot be broken down further
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
          
          const SizedBox(height: 32),
          
          // Utilities Section
          const AppText(
            'System Utilities',
            variant: AppTextVariant.titleLarge,
          ),
          const SizedBox(height: 8),
          const AppText(
            'Test system-level utilities and feedback mechanisms.',
            variant: AppTextVariant.bodyMedium,
          ),
          const SizedBox(height: 24),
          ShowcaseListItem(
            title: 'Feedback System',
            description: 'Test temporal feedback messages with success, error, and info variants',
            icon: Icons.feedback_outlined,
            page: const AppSnackbarShowcase(),
          ),
          const SizedBox(height: 16),
          ShowcaseListItem(
            title: 'Quick Feedback Demo',
            description: 'Simple demo to quickly test the three feedback types',
            icon: Icons.play_circle_outline,
            page: const FeedbackDemo(),
          ),
          const SizedBox(height: 16),
          ShowcaseListItem(
            title: 'Practical Example',
            description: 'Real-world login form showing feedback integration',
            icon: Icons.assignment_outlined,
            page: const PracticalFeedbackExample(),
          ),
        ],
      ),
    );
  }

  /// Builds the list of navigation items for component categories.
  List<Widget> _buildNavigationList() {
    return [
      ShowcaseListItem(
        title: 'Atoms',
        description: 'Fundamental building blocks that cannot be broken down further without losing function',
        icon: Icons.grain,
        page: const AtomsListPage(),
      ),
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
        description: 'Complete page implementations demonstrating real content and user flows',
        icon: Icons.article_outlined,
        page: const OtherPagesListPage(),
      ),
    ];
  }
}

