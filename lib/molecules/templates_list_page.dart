import 'package:flutter/material.dart';
import 'package:pragma_design_system/pragma_design_system.dart';
import '../templates/empty_state_dashboard/empty_state_dashboard_template_showcase.dart';
import '../templates/form_pages/form_page_template_showcase.dart';
import '../templates/product_list/product_list_template_showcase.dart';
import '../templates/settings_page/settings_page_template_showcase.dart';

/// TemplatesListPage - A list of all template showcase pages.
///
/// This page displays a list of all available template showcase pages,
/// allowing users to navigate to each specific template demonstration.
/// It serves as a central hub for exploring all template components
/// in the design system.
class TemplatesListPage extends StatelessWidget {
  const TemplatesListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Templates Showcase'),
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
            'Tap on any item to explore the template showcase',
            variant: AppTextVariant.bodyMedium,
          ),
          const SizedBox(height: 24),
          ..._buildTemplatesList(context),
        ],
      ),
    );
  }

  /// Builds the list of template showcase items
  List<Widget> _buildTemplatesList(BuildContext context) {
    final templates = [
      TemplateShowcaseItem(
        title: 'Empty State Dashboard',
        description: 'Complete dashboard templates for empty states',
        icon: Icons.dashboard_outlined,
        page: const EmptyStateDashboardTemplateShowcase(),
      ),
      TemplateShowcaseItem(
        title: 'Form Pages',
        description: 'Complete form page templates with validation',
        icon: Icons.description,
        page: const FormPageTemplateShowcase(),
      ),
      TemplateShowcaseItem(
        title: 'Product List',
        description: 'Product listing page templates for e-commerce',
        icon: Icons.inventory_2,
        page: const ProductListTemplateShowcase(),
      ),
      TemplateShowcaseItem(
        title: 'Settings Page',
        description: 'Settings page templates with configuration groups',
        icon: Icons.settings_applications,
        page: const SettingsPageTemplateShowcase(),
      ),
    ];

    return templates
        .map((template) => _buildTemplateListItem(context, template))
        .toList();
  }

  /// Builds an individual template showcase list item
  Widget _buildTemplateListItem(
      BuildContext context, TemplateShowcaseItem template) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: AppCard(
        child: ListTile(
          leading: Icon(
            template.icon,
            size: 32,
            color: Theme.of(context).colorScheme.primary,
          ),
          title: AppText(
            template.title,
            variant: AppTextVariant.titleMedium,
          ),
          subtitle: AppText(
            template.description,
            variant: AppTextVariant.bodySmall,
          ),
          trailing: const Icon(Icons.arrow_forward_ios),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => template.page,
              ),
            );
          },
        ),
      ),
    );
  }
}

/// Data class for template showcase items
class TemplateShowcaseItem {
  const TemplateShowcaseItem({
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
