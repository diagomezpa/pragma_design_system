import 'package:flutter/material.dart';
import '../../atoms/app_text/app_text.dart';
import '../../atoms/app_icon/app_icon.dart';
import '../../atoms/app_spacer/app_spacer.dart';

/// AppFormField - A reusable form field molecule following Atomic Design principles
///
/// This molecule combines multiple atoms (AppText, AppIcon) to create a consistent
/// form field component across the application. It follows Material 3 design guidelines
/// and provides accessibility features out of the box.
///
/// Features:
/// - Material 3 styling with proper theming support
/// - Label, hint, helper text, and error text support
/// - Error text overrides helper text when both are provided
/// - Prefix and suffix icon support using AppIcon
/// - Obscure text support for password fields
/// - Proper spacing and accessibility
/// - Stateless design with callback-based interaction
///
/// Example usage:
/// ```dart
/// AppFormField(
///   label: 'Email',
///   hintText: 'Enter your email address',
///   helperText: 'We will never share your email',
///   prefixIcon: AppIcon(Icons.email),
///   onChanged: (value) => print('Email: $value'),
/// )
/// ```
class AppFormField extends StatelessWidget {
  const AppFormField({
    super.key,
    this.label,
    this.hintText,
    this.helperText,
    this.errorText,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.enabled = true,
    this.controller,
    this.initialValue,
    this.keyboardType,
    this.textInputAction,
    this.maxLines = 1,
    this.onChanged,
    this.onSubmitted,
    this.focusNode,
    this.autofocus = false,
  });

  /// Optional label text displayed above the field
  final String? label;

  /// Hint text displayed inside the field when empty
  final String? hintText;

  /// Helper text displayed below the field (overridden by errorText)
  final String? helperText;

  /// Error text displayed below the field (overrides helperText)
  final String? errorText;

  /// Optional icon displayed at the beginning of the field
  final AppIcon? prefixIcon;

  /// Optional icon displayed at the end of the field
  final AppIcon? suffixIcon;

  /// Whether to obscure the text (for password fields)
  final bool obscureText;

  /// Whether the field is enabled for interaction
  final bool enabled;

  /// Controller for managing the field's text content
  final TextEditingController? controller;

  /// Initial value for the field (ignored if controller is provided)
  final String? initialValue;

  /// Keyboard type for the field
  final TextInputType? keyboardType;

  /// Text input action for the field
  final TextInputAction? textInputAction;

  /// Maximum number of lines (null for unlimited)
  final int? maxLines;

  /// Callback fired when the field value changes
  final ValueChanged<String>? onChanged;

  /// Callback fired when the user submits the field
  final ValueChanged<String>? onSubmitted;

  /// Focus node for managing field focus
  final FocusNode? focusNode;

  /// Whether the field should automatically receive focus
  final bool autofocus;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Label
        if (label != null) ...[
          AppText(
            label!,
            variant: AppTextVariant.bodySmall,
            color: enabled
                ? colorScheme.onSurfaceVariant
                : colorScheme.onSurface.withOpacity(0.38),
            fontWeight: FontWeight.w500,
          ),
          const AppSpacer(size: AppSpacerSize.extraSmall),
        ],

        // Text Field
        TextFormField(
          controller: controller,
          initialValue: controller == null ? initialValue : null,
          obscureText: obscureText,
          enabled: enabled,
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          maxLines: maxLines,
          onChanged: onChanged,
          onFieldSubmitted: onSubmitted,
          focusNode: focusNode,
          autofocus: autofocus,
          style: theme.textTheme.bodyLarge?.copyWith(
            color: enabled
                ? colorScheme.onSurface
                : colorScheme.onSurface.withOpacity(0.38),
          ),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: theme.textTheme.bodyLarge?.copyWith(
              color: colorScheme.onSurfaceVariant.withOpacity(0.6),
            ),
            prefixIcon: prefixIcon != null
                ? Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: prefixIcon,
                  )
                : null,
            suffixIcon: suffixIcon != null
                ? Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: suffixIcon,
                  )
                : null,
            // Material 3 outlined style
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide(
                color: colorScheme.outline,
                width: 1.0,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide(
                color: colorScheme.outline,
                width: 1.0,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide(
                color: colorScheme.primary,
                width: 2.0,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide(
                color: colorScheme.error,
                width: 1.0,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide(
                color: colorScheme.error,
                width: 2.0,
              ),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide(
                color: colorScheme.onSurface.withOpacity(0.12),
                width: 1.0,
              ),
            ),
            filled: true,
            fillColor: enabled
                ? colorScheme.surface
                : colorScheme.onSurface.withOpacity(0.04),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 16.0,
            ),
            // Remove default error text since we handle it separately
            errorText: null,
          ),
        ),

        // Helper or Error Text
        if (errorText != null || helperText != null) ...[
          const AppSpacer(size: AppSpacerSize.extraSmall),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: AppText(
              errorText ?? helperText!,
              variant: AppTextVariant.bodySmall,
              color: errorText != null
                  ? colorScheme.error
                  : enabled
                      ? colorScheme.onSurfaceVariant
                      : colorScheme.onSurface.withOpacity(0.38),
            ),
          ),
        ],
      ],
    );
  }
}
