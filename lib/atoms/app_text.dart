import 'package:flutter/material.dart';

/// AppText - A reusable text widget that centralizes text styles
/// This atom provides consistent typography across the application
/// Supports different text variants and customization options
class AppText extends StatelessWidget {
  const AppText(
    this.text, {
    super.key,
    this.variant = AppTextVariant.body,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.fontWeight,
  });

  final String text;
  final AppTextVariant variant;
  final Color? color;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;
  final FontWeight? fontWeight;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    // Get base style from variant
    TextStyle baseStyle = _getBaseStyle(theme);
    
    // Apply custom overrides
    final style = baseStyle.copyWith(
      color: color,
      fontWeight: fontWeight,
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
    switch (variant) {
      case AppTextVariant.headline1:
        return theme.textTheme.headlineLarge ?? const TextStyle(fontSize: 32, fontWeight: FontWeight.bold);
      case AppTextVariant.headline2:
        return theme.textTheme.headlineMedium ?? const TextStyle(fontSize: 28, fontWeight: FontWeight.bold);
      case AppTextVariant.headline3:
        return theme.textTheme.headlineSmall ?? const TextStyle(fontSize: 24, fontWeight: FontWeight.bold);
      case AppTextVariant.title:
        return theme.textTheme.titleLarge ?? const TextStyle(fontSize: 22, fontWeight: FontWeight.w600);
      case AppTextVariant.subtitle:
        return theme.textTheme.titleMedium ?? const TextStyle(fontSize: 16, fontWeight: FontWeight.w500);
      case AppTextVariant.body:
        return theme.textTheme.bodyLarge ?? const TextStyle(fontSize: 16);
      case AppTextVariant.bodySmall:
        return theme.textTheme.bodyMedium ?? const TextStyle(fontSize: 14);
      case AppTextVariant.caption:
        return theme.textTheme.bodySmall ?? const TextStyle(fontSize: 12);
      case AppTextVariant.button:
        return theme.textTheme.labelLarge ?? const TextStyle(fontSize: 14, fontWeight: FontWeight.w500);
    }
  }
}

/// Enum defining different text variants available in the design system
enum AppTextVariant {
  headline1,
  headline2,
  headline3,
  title,
  subtitle,
  body,
  bodySmall,
  caption,
  button,
}