import 'package:flutter/material.dart';
import 'package:pragma_design_system/pragma_design_system.dart';

/// ShowcaseListItem - Un elemento de lista reutilizable para navegar a las páginas de showcase.
///
/// This widget is specifically designed for the example application and is NOT
/// part of the design system. It provides a consistent interface for displaying
/// elementos de showcase a través de diferentes categorías (Molecules, Organisms, Templates, Pages).
///
/// The widget encapsulates the common pattern of displaying a title, description,
/// icono y comportamiento de navegación usados en las pantallas de la lista de showcase.
///
/// Usage:
/// ```dart
/// ShowcaseListItem(
///   title: 'App Button',
///   description: 'Interactive button components',
///   icon: Icons.smart_button,
///   page: const AppButtonShowcase(),
/// )
/// ```
///
/// This widget is used in:
/// - MoleculesListPage
/// - OrganismsListPage
/// - TemplatesListPage
/// - And other showcase list screens in the example app
class ShowcaseListItem extends StatelessWidget {
  /// Crea un widget elemento de lista para showcase.
  ///
  /// All parameters are required:
  /// - [title]: El nombre a mostrar del elemento de showcase
  /// - [description]: Una breve descripción de lo que el showcase demuestra
  /// - [icon]: The icon to display alongside the title
  /// - [page]: The destination widget to navigate to when tapped
  const ShowcaseListItem({
    super.key,
    required this.title,
    required this.description,
    required this.icon,
    required this.page,
  });

  /// El título a mostrar del elemento de showcase
  final String title;

  /// Una breve descripción de lo que el showcase demuestra
  final String description;

  /// The icon to display alongside the title
  final IconData icon;

  /// The destination page to navigate to when the item is tapped
  final Widget page;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: AppCard(
        child: ListTile(
          leading: Icon(
            icon,
            size: 32,
            color: Theme.of(context).colorScheme.primary,
          ),
          title: AppText(
            title,
            variant: AppTextVariant.titleMedium,
          ),
          subtitle: AppText(
            description,
            variant: AppTextVariant.bodySmall,
          ),
          trailing: const Icon(Icons.arrow_forward_ios),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => page,
              ),
            );
          },
        ),
      ),
    );
  }
}