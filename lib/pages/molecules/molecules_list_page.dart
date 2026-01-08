import 'package:flutter/material.dart';
import 'package:pragma_design_system/molecules/molecules_showcase.dart';
import 'package:pragma_design_system/pragma_design_system.dart';

import '../shared/showcase_list_item.dart';

/// MoleculesListPage - Página de lista que muestra todos los showcases de moléculas disponibles.
///
/// Esta página sirve como punto de entrada para explorar componentes tipo Molecule.
/// en la aplicación de ejemplo del sistema de diseño. Las moléculas representan componentes de UI que
/// están compuestos de múltiples átomos que trabajan juntos para formar unidades funcionales
/// (por ejemplo, campos de formulario, elementos de lista, tarjetas).
///
/// En la metodología de Diseño Atómico:
/// - **Moléculas** son grupos de átomos unidos para formar componentes funcionales.
///   Tienen sus propias propiedades y sirven como la columna vertebral
///   de nuestro sistema de diseño, proporcionando bloques de construcción reutilizables para interfaces
///   más complejas.
///
/// Esta página proporciona:
/// - Vista general de todas las páginas de showcase de moléculas disponibles
/// - Navegación fácil hacia demostraciones individuales de moléculas
/// - Interfaz consistente siguiendo las convenciones de la aplicación de ejemplo
///
/// Arquitectura:
/// - Vive en la aplicación de ejemplo (no en el paquete del sistema de diseño)
/// - Usa `ShowcaseListItem` compartido para navegación consistente
/// - Importa los showcases de moléculas a través de su archivo barrel
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

  /// Construye la lista de elementos de showcase de moléculas.
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