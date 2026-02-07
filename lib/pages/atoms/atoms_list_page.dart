import 'package:flutter/material.dart';
import 'package:pragma_design_system/atoms/atoms_showcase.dart';
import 'package:pragma_design_system/pragma_design_system.dart';

import '../shared/showcase_list_item.dart';

/// AtomsListPage - Página de lista que muestra todos los showcases de átomos disponibles.
///
/// Esta página sirve como punto de entrada para explorar componentes tipo Atom
/// en la aplicación de ejemplo del sistema de diseño. Los átomos representan los componentes
/// más básicos de UI que no pueden dividirse en componentes más pequeños sin
/// perder su funcionalidad (por ejemplo, botones, texto, iconos).
///
/// En la metodología de Diseño Atómico:
/// - **Átomos** son los bloques de construcción fundamentales que no pueden
///   dividirse más sin perder su función. Estos elementos incluyen etiquetas HTML básicas
///   como entradas de formulario, botones, y otros elementos que no pueden dividirse más.
///
/// Esta página proporciona:
/// - Vista general de todas las páginas de showcase de átomos disponibles
/// - Navegación fácil hacia demostraciones individuales de átomos
/// - Interfaz consistente siguiendo las convenciones de la aplicación de ejemplo
///
/// Arquitectura:
/// - Vive en la aplicación de ejemplo (no en el paquete del sistema de diseño)
/// - Usa `ShowcaseListItem` compartido para navegación consistente
/// - Importa los showcases de átomos a través de su archivo barrel
class AtomsListPage extends StatelessWidget {
  /// Creates an atoms list page.
  const AtomsListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Atoms'),
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
            'Atoms are the fundamental building blocks of our design system. These basic components cannot be broken down further without losing their function.',
            variant: AppTextVariant.bodyMedium,
          ),
          const SizedBox(height: 24),
          ..._buildAtomsList(),
        ],
      ),
    );
  }

  /// Construye la lista de elementos de showcase de átomos.
  List<Widget> _buildAtomsList() {
    return [
      ShowcaseListItem(
        title: 'App Button',
        description: 'Button components with variants, sizes, and interactive states',
        icon: Icons.smart_button,
        page: const AppButtonShowcase(),
      ),
      ShowcaseListItem(
        title: 'App Divider',
        description: 'Visual separation components for content organization',
        icon: Icons.horizontal_rule,
        page: const AppDividerShowcase(),
      ),
      // Future atoms will be added here:
      // ShowcaseListItem(
      //   title: 'App Text',
      //   description: 'Text components with consistent typography and styling',
      //   icon: Icons.text_fields,
      //   page: const AppTextShowcase(),
      // ),
      // ShowcaseListItem(
      //   title: 'App Icon',
      //   description: 'Icon components for visual communication and navigation',
      //   icon: Icons.star,
      //   page: const AppIconShowcase(),
      // ),
      // ShowcaseListItem(
      //   title: 'App Spacer',
      //   description: 'Spacing components for consistent layout and rhythm',
      //   icon: Icons.space_bar,
      //   page: const AppSpacerShowcase(),
      // ),
      // ShowcaseListItem(
      //   title: 'App Image',
      //   description: 'Image components with loading states and error handling',
      //   icon: Icons.image,
      //   page: const AppImageShowcase(),
      // ),
    ];
  }
}
