import 'package:flutter/material.dart';
import 'package:pragma_design_system/pragma_design_system.dart';

/// AppFormSection - Un organismo para agrupar campos de formulario con título y descripción
///
/// Este organismo proporciona una forma consistente de estructurar secciones de formulario
/// en toda la aplicación. Combina múltiples campos de formulario con título opcional,
/// descripción y elementos divisorios para crear layouts de formulario coherentes.
///
/// **Responsabilidad del organismo:**
/// - Agrupar campos relacionados en secciones lógicas
/// - Proveer estilo consistente para títulos y descripciones
/// - Mantener espaciado apropiado entre elementos del formulario
/// - Ofrecer separación visual opcional con divisores
///
/// **Composición:**
/// Usa átomos y moléculas del sistema de diseño:
/// - AppText para títulos y descripciones
/// - AppSpacer para espaciado consistente
/// - AppDivider para separación visual opcional
/// - Layout flexible para los hijos (campos de formulario)
///
/// **Patrones de diseño:**
/// - Sigue convenciones de secciones de formulario de Material 3
/// - Mantiene accesibilidad y consistencia de theming
/// - Soporta disposición flexible de contenido
/// - Usa espaciado semántico del sistema de diseño
class AppFormSection extends StatelessWidget {
  const AppFormSection({
    super.key,
    required this.title,
    this.description,
    required this.children,
    this.showDivider = false,
    this.padding,
  });

  /// Section title displayed prominently at the top
  final String title;

  /// Optional description text displayed below the title
  final String? description;

  /// Form fields and other widgets to display in this section
  final List<Widget> children;

  /// Whether to show a divider at the bottom of the section
  final bool showDivider;

  /// Optional padding around the entire section
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Section title
          AppText(
            title,
            variant: AppTextVariant.titleLarge,
            color: colorScheme.onSurface,
          ),

          // Section description (if provided)
          if (description != null) ...[
            const AppSpacer(size: AppSpacerSize.small),
            AppText(
              description!,
              variant: AppTextVariant.bodySmall,
              color: colorScheme.onSurfaceVariant,
            ),
          ],

          // Spacing before form content
          const AppSpacer(size: AppSpacerSize.medium),

          // Form fields and content
          ...children,

          // Optional bottom divider
          if (showDivider) ...[
            const AppSpacer(size: AppSpacerSize.medium),
            const AppDivider(),
          ],
        ],
      ),
    );
  }
}