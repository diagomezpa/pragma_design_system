import 'package:flutter/material.dart';
import 'package:pragma_design_system/pragma_design_system.dart';
import 'empty_state_dashboard_template_showcase.dart';
import 'form_page_template_showcase.dart';
import 'product_list_template_showcase.dart';
import 'settings_page_template_showcase.dart';

/// TemplatesListPage - Una lista de todas las páginas de showcase de plantillas.
///
/// Esta página muestra una lista de todas las páginas de showcase de plantillas disponibles,
/// permitiendo a los usuarios navegar a cada demostración específica de plantilla.
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
