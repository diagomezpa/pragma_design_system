import 'package:flutter/material.dart';

/// AppText - Un widget de texto reutilizable que proporciona tipografía consistente
///
/// Este átomo centraliza el estilo de texto mapeando directamente a las propiedades
/// de Material 3 TextTheme. Asegura consistencia tipográfica en toda la aplicación
/// mientras proporciona sobreescrituras opcionales para casos de uso específicos.
///
/// **Dependencia del Tema:**
/// AppText requiere un TextTheme correctamente configurado en ThemeData. Usa AppTheme.light()
/// o AppTheme.dark() para asegurar que todos los estilos de texto requeridos estén disponibles.
/// El widget fallará rápidamente con un error descriptivo si la configuración del tema está incompleta.
///
/// **Mapeo de Variantes:**
/// Cada AppTextVariant mapea 1:1 a una propiedad de Material 3 TextTheme:
/// - headlineLarge → TextTheme.headlineLarge
/// - titleMedium → TextTheme.titleMedium
/// - bodyLarge → TextTheme.bodyLarge
/// - etc.
///
/// **Comportamiento de Sobreescritura:**
/// Los parámetros opcionales (color, fontWeight, decoration) se aplican de forma no destructiva
/// sobre el estilo base del tema. Esto preserva la consistencia del tema mientras permite
/// personalización contextual cuando se necesite.
///
/// Uso:
/// ```dart
/// // Usa el estilo bodyLarge del tema
/// AppText('Texto de cuerpo por defecto')
///
/// // Estilo del tema con sobreescritura de color  
/// AppText(
///   'Texto coloreado',
///   variant: AppTextVariant.titleLarge,
///   color: Theme.of(context).colorScheme.primary,
/// )
/// ```
class AppText extends StatelessWidget {
  const AppText(
    this.text, {
    super.key,
    this.variant = AppTextVariant.bodyLarge,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.fontWeight,
    this.decoration,
  });

  final String text;
  final AppTextVariant variant;
  final Color? color;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;
  final FontWeight? fontWeight;
  final TextDecoration? decoration;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    // Obtener estilo base de la variante
    TextStyle baseStyle = _getBaseStyle(theme);
    
    // Aplicar sobreescrituras personalizadas
    final style = baseStyle.copyWith(
      color: color,
      fontWeight: fontWeight,
      decoration: decoration,
    );

    return Text(
      text,
      style: style,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );
  }

  TextStyle _getBaseStyle(ThemeData theme) {
    final textTheme = theme.textTheme;
    
    switch (variant) {
      case AppTextVariant.headlineLarge:
        return textTheme.headlineLarge ?? 
            _throwMissingThemeError('headlineLarge');
      case AppTextVariant.headlineMedium:
        return textTheme.headlineMedium ?? 
            _throwMissingThemeError('headlineMedium');
      case AppTextVariant.headlineSmall:
        return textTheme.headlineSmall ?? 
            _throwMissingThemeError('headlineSmall');
      case AppTextVariant.titleLarge:
        return textTheme.titleLarge ?? 
            _throwMissingThemeError('titleLarge');
      case AppTextVariant.titleMedium:
        return textTheme.titleMedium ?? 
            _throwMissingThemeError('titleMedium');
      case AppTextVariant.titleSmall:
        return textTheme.titleSmall ?? 
            _throwMissingThemeError('titleSmall');
      case AppTextVariant.bodyLarge:
        return textTheme.bodyLarge ?? 
            _throwMissingThemeError('bodyLarge');
      case AppTextVariant.bodyMedium:
        return textTheme.bodyMedium ?? 
            _throwMissingThemeError('bodyMedium');
      case AppTextVariant.bodySmall:
        return textTheme.bodySmall ?? 
            _throwMissingThemeError('bodySmall');
      case AppTextVariant.labelLarge:
        return textTheme.labelLarge ?? 
            _throwMissingThemeError('labelLarge');
    }
  }

  /// Lanza un error descriptivo cuando falta configuración del tema
  Never _throwMissingThemeError(String styleName) {
    throw FlutterError(
      'AppText: Falta el estilo de texto "$styleName" en ThemeData.textTheme.\n'
      'Asegúrate de que tu app use AppTheme.light() o AppTheme.dark() que proporcionan '
      'configuración completa del tema de texto via appTextTheme().\n'
      'AppText requiere que todos los estilos de texto estén correctamente configurados en el tema.',
    );
  }
}

/// Enum que define las variantes de texto que mapean 1:1 a las propiedades de Material 3 TextTheme
///
/// Cada variante corresponde directamente a una propiedad TextTheme, asegurando
/// jerarquía tipográfica consistente y eliminando ambigüedad sobre qué estilo del tema usar.
/// Este diseño impone configuración apropiada del tema y falla rápidamente cuando faltan estilos.
enum AppTextVariant {
  /// Mapea a TextTheme.headlineLarge - Texto de display grande para secciones hero
  headlineLarge,
  
  /// Mapea a TextTheme.headlineMedium - Títulos medianos para cabeceras de sección
  headlineMedium,
  
  /// Mapea a TextTheme.headlineSmall - Títulos pequeños para cabeceras de subsección
  headlineSmall,
  
  /// Mapea a TextTheme.titleLarge - Títulos grandes para cabeceras de contenido primario
  titleLarge,
  
  /// Mapea a TextTheme.titleMedium - Títulos medianos para cabeceras de contenido secundario
  titleMedium,
  
  /// Mapea a TextTheme.titleSmall - Títulos pequeños para cabeceras de soporte
  titleSmall,
  
  /// Mapea a TextTheme.bodyLarge - Texto de cuerpo grande para contenido primario
  bodyLarge,
  
  /// Mapea a TextTheme.bodyMedium - Texto de cuerpo mediano para contenido secundario
  bodyMedium,
  
  /// Mapea a TextTheme.bodySmall - Texto de cuerpo pequeño para captions y metadatos
  bodySmall,
  
  /// Mapea a TextTheme.labelLarge - Etiquetas para botones y elementos interactivos
  labelLarge,
}