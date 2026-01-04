import 'package:flutter/material.dart';

/// AppText - A reusable text widget that provides consistent typography
///
/// This atom centralizes text styling by mapping directly to Material 3 TextTheme
/// properties. It ensures typography consistency across the application while
/// providing optional overrides for specific use cases.
///
/// **Theme Dependency:**
/// AppText requires a properly configured TextTheme in ThemeData. Use AppTheme.light()
/// or AppTheme.dark() to ensure all required text styles are available. The widget
/// will fail fast with a descriptive error if theme configuration is incomplete.
///
/// **Variant Mapping:**
/// Each AppTextVariant maps 1:1 to a Material 3 TextTheme property:
/// - headlineLarge → TextTheme.headlineLarge
/// - titleMedium → TextTheme.titleMedium
/// - bodyLarge → TextTheme.bodyLarge
/// - etc.
///
/// **Override Behavior:**
/// Optional parameters (color, fontWeight, decoration) are applied non-destructively
/// on top of the theme's base style. This preserves theme consistency while allowing
/// contextual customization when needed.
///
/// Usage:
/// ```dart
/// // Uses theme's bodyLarge style
/// AppText('Default body text')
///
/// // Theme style with color override  
/// AppText(
///   'Colored text',
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
    
    // Get base style from variant
    TextStyle baseStyle = _getBaseStyle(theme);
    
    // Apply custom overrides
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

  /// Throws a descriptive error when theme configuration is missing
  Never _throwMissingThemeError(String styleName) {
    throw FlutterError(
      'AppText: Missing text style "$styleName" in ThemeData.textTheme.\n'
      'Ensure your app uses AppTheme.light() or AppTheme.dark() which provide '
      'complete text theme configuration via appTextTheme().\n'
      'AppText requires all text styles to be properly configured in the theme.',
    );
  }
}

/// Enum defining text variants that map 1:1 to Material 3 TextTheme properties
///
/// Each variant corresponds directly to a TextTheme property, ensuring consistent
/// typography hierarchy and eliminating ambiguity about which theme style to use.
/// This design enforces proper theme configuration and fails fast when styles are missing.
enum AppTextVariant {
  /// Maps to TextTheme.headlineLarge - Large display text for hero sections
  headlineLarge,
  
  /// Maps to TextTheme.headlineMedium - Medium headlines for section headers  
  headlineMedium,
  
  /// Maps to TextTheme.headlineSmall - Small headlines for subsection headers
  headlineSmall,
  
  /// Maps to TextTheme.titleLarge - Large titles for primary content headers
  titleLarge,
  
  /// Maps to TextTheme.titleMedium - Medium titles for secondary content headers
  titleMedium,
  
  /// Maps to TextTheme.titleSmall - Small titles for supporting headers
  titleSmall,
  
  /// Maps to TextTheme.bodyLarge - Large body text for primary content
  bodyLarge,
  
  /// Maps to TextTheme.bodyMedium - Medium body text for secondary content  
  bodyMedium,
  
  /// Maps to TextTheme.bodySmall - Small body text for captions and metadata
  bodySmall,
  
  /// Maps to TextTheme.labelLarge - Labels for buttons and interactive elements
  labelLarge,
}