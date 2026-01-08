import 'package:flutter/material.dart';
import 'package:pragma_design_system/pragma_design_system.dart';

import '../shared/showcase_list_item.dart';
import 'product_list/product_list_page_showcase.dart';
import 'form/form_page_showcase.dart';
import 'dashboard/empty_state_dashboard_page_showcase.dart';
import 'settings/settings_page_showcase.dart';

/// OtherPagesListPage - A list page displaying all available Page showcases.
///
/// This page serves as the entry point for exploring Page implementations
/// in the design system example app. Pages represent the highest level of
/// Atomic Design methodology, providing complete user experiences with
/// real data, state management, and business logic.
///
/// In Atomic Design methodology:
/// - **Pages** are specific instances of templates with real representative content.
///   They provide data and state to templates without modifying template structure.
///   Business logic, data fetching, and user interactions live at the Page level.
///
/// This page provides:
/// - Overview of all available page showcase demonstrations
/// - Easy navigation to individual page implementations
/// - Educational content about Page layer responsibilities
/// - Consistent interface following example app conventions
///
/// Architecture:
/// - Lives in the example app (not the design system package)
/// - Uses shared `ShowcaseListItem` for consistent navigation
/// - Imports page showcases from their respective directories
/// - Demonstrates how Pages consume Templates in practice
class OtherPagesListPage extends StatelessWidget {
  /// Creates an other pages list page.
  const OtherPagesListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Other Pages'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const AppText(
            'Page Implementations',
            variant: AppTextVariant.titleLarge,
          ),
          const SizedBox(height: 8),
          const AppText(
            'Pages are complete user experiences that demonstrate how Templates work with real data, state management, and business logic. They represent the highest level of Atomic Design methodology.',
            variant: AppTextVariant.bodyMedium,
          ),
          const SizedBox(height: 8),
          const AppText(
            'Each showcase below demonstrates a different Page implementation pattern, showing how the design system components work together to create meaningful user experiences.',
            variant: AppTextVariant.bodySmall,
            color: Colors.grey,
          ),
          const SizedBox(height: 24),
          ..._buildPagesList(),
        ],
      ),
    );
  }

  /// Builds the list of page showcase items.
  List<Widget> _buildPagesList() {
    return [
      ShowcaseListItem(
        title: 'Product List Page',
        description: 'E-commerce product listing with state management and empty states',
        icon: Icons.shopping_bag_outlined,
        page: const ProductListPageShowcase(),
      ),
      ShowcaseListItem(
        title: 'Form Page',
        description: 'Complete form implementation with validation and user guidance',
        icon: Icons.edit_note_outlined,
        page: const FormPageShowcase(),
      ),
      ShowcaseListItem(
        title: 'Settings Page',
        description: 'Settings screen with organized content groups and navigation',
        icon: Icons.settings_outlined,
        page: const SettingsPageShowcase(),
      ),
      ShowcaseListItem(
        title: 'Empty State Dashboard',
        description: 'Dashboard empty state with user onboarding and motivation',
        icon: Icons.dashboard_outlined,
        page: const EmptyStateDashboardPageShowcase(),
      ),
    ];
  }
}