import 'package:flutter/material.dart';
import 'package:pragma_design_system/pragma_design_system.dart';

/// AppCardList - Un organismo para mostrar una lista vertical de tarjetas con espaciado consistente
///
/// Este organismo proporciona una forma estructurada de mostrar múltiples tarjetas en
/// un layout vertical con espaciado apropiado, títulos opcionales y comportamiento
/// de desplazamiento flexible. Combina componentes del sistema de diseño para crear
/// interfaces basadas en tarjetas coherentes.
///
/// **Responsabilidad del organismo:**
/// - Organizar múltiples tarjetas en un layout vertical
/// - Proveer espaciado consistente entre tarjetas
/// - Ofrecer personalización opcional de título y separador
/// - Manejar layouts desplazables y no desplazables
/// - Mantener el espaciado y tema del sistema de diseño
///
/// **Lo que este organismo NO hace:**
/// - Peticiones de datos o llamadas a APIs
/// - Manejo de estados vacíos (usar AppEmptyState por separado)
/// - Lógica de negocio o gestión de estado
/// - Generación de contenido de tarjetas (las tarjetas deben estar preconstruidas)
/// - Lógica de navegación o enrutamiento
///
/// **Composición:**
/// Utiliza componentes del sistema de diseño:
/// - AppText para mostrar títulos opcionales
/// - AppSpacer para espaciado consistente
/// - AppDivider como separador por defecto
/// - ListView.separated o Column para la estructura del layout
///
/// **Ejemplos de uso:**
/// ```dart
/// // Lista básica de tarjetas
/// AppCardList(
///   children: [
///     AppCard(child: Text('Card 1')),
///     AppCard(child: Text('Card 2')),
///     AppCard(child: Text('Card 3')),
///   ],
/// )
///
/// // Lista de tarjetas con título y separador personalizado
/// AppCardList(
///   title: 'Recent Items',
///   children: cardWidgets,
///   separator: AppSpacer(size: AppSpacerSize.large),
///   isScrollable: true,
/// )
///
/// // Lista desplazable con padding personalizado
/// AppCardList(
///   title: 'Product Categories',
///   children: productCards,
///   isScrollable: true,
///   padding: EdgeInsets.all(16.0),
///   scrollPhysics: BouncingScrollPhysics(),
/// )
/// ```
class AppCardList extends StatelessWidget {
  const AppCardList({
    super.key,
    this.title,
    required this.children,
    this.separator,
    this.padding,
    this.isScrollable = false,
    this.scrollPhysics,
    this.shrinkWrap = true,
  });

  /// Optional title displayed at the top of the card list
  final String? title;

  /// List of card widgets to display (typically AppCard instances)
  final List<Widget> children;

  /// Optional separator widget between cards (defaults to AppSpacer.medium)
  final Widget? separator;

  /// Optional padding around the entire card list
  final EdgeInsetsGeometry? padding;

  /// Whether the card list should be scrollable (uses ListView when true, Column when false)
  final bool isScrollable;

  /// Scroll physics for scrollable lists (only applies when isScrollable is true)
  final ScrollPhysics? scrollPhysics;

  /// Whether to wrap content in minimum space (only applies when isScrollable is true)
  final bool shrinkWrap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    // Default separator if none provided
    final effectiveSeparator = separator ?? const AppSpacer(size: AppSpacerSize.medium);

    return Container(
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Optional title
          if (title != null) ...[
            AppText(
              title!,
              variant: AppTextVariant.titleLarge,
              color: colorScheme.onSurface,
            ),
            const AppSpacer(size: AppSpacerSize.large),
          ],

          // Card list content
          if (isScrollable)
            _buildScrollableList(effectiveSeparator)
          else
            _buildStaticList(effectiveSeparator),
        ],
      ),
    );
  }

  /// Builds a scrollable ListView.separated for the cards
  Widget _buildScrollableList(Widget effectiveSeparator) {
    return ListView.separated(
      shrinkWrap: shrinkWrap,
      physics: scrollPhysics,
      itemCount: children.length,
      separatorBuilder: (context, index) => effectiveSeparator,
      itemBuilder: (context, index) => children[index],
    );
  }

  /// Builds a static Column for the cards when scrolling is disabled
  Widget _buildStaticList(Widget effectiveSeparator) {
    if (children.isEmpty) {
      return const SizedBox.shrink();
    }

    final List<Widget> separatedChildren = [];

    for (int i = 0; i < children.length; i++) {
      separatedChildren.add(children[i]);
      
      // Add separator between items (not after the last item)
      if (i < children.length - 1) {
        separatedChildren.add(effectiveSeparator);
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: separatedChildren,
    );
  }
}