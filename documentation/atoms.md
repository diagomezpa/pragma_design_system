# Atoms: Componentes Fundacionales

![Atoms Demo](Atoms.gif)

Elementos de construcción centrales que encapsulan tokens de diseño y funcionalidad básica:

| Componente | Archivo | Propósito |
|------------|---------|-----------|
| **AppButton** | `app_button.dart` | Botones interactivos con variantes (primary, secondary, outline) y diferentes estados |
| **AppText** | `app_text.dart` | Sistema tipográfico consistente con variantes semánticas (title, body, caption, etc.) |
| **AppIcon** | `app_icon.dart` | Iconografía estandarizada con tamaños y colores coherentes |
| **AppSpacer** | `app_spacer.dart` | Sistema de espaciado vertical y horizontal basado en tokens de diseño |
| **AppDivider** | `app_divider.dart` | Separadores visuales horizontales y verticales |
| **AppImage** | `app_image.dart` | Componente de imagen con manejo de carga y estados de error |

## Fundación del Sistema de Diseño
Tokens de diseño y configuración de temas que sustentan todos los componentes:

| Componente | Archivo | Propósito |
|------------|---------|-----------|
| **AppTheme** | `app_theme.dart` | Tema principal que integra todos los sistemas de diseño |
| **AppColors** | `app_colors.dart` | Paleta de colores semánticos y decorativos |
| **AppColorScheme** | `app_color_scheme.dart` | Esquemas de color para tema claro y oscuro |
| **AppTextTheme** | `app_text_theme.dart` | Sistema tipográfico con jerarquías y weights |
| **AppSpacing** | `app_spacing.dart` | Tokens de espaciado y sistema de grid |

## Sistema de Retroalimentación al Usuario
Utilidades para feedback temporal y notificaciones del sistema:

| Componente | Archivo | Propósito |
|------------|---------|-----------|
| **AppSnackbar** | `app_snackbar.dart` | Clase utilitaria para mostrar mensajes temporales de feedback |
| **AppSnackbarType** | `app_snackbar_type.dart` | Enum que define los tipos semánticos de feedback (success, error, info) |