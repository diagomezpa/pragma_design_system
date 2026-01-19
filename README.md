# Pragma Design System

Sistema de diseño Flutter profesional basado en la metodología **Atomic Design**, que proporciona componentes reutilizables, templates consistentes y patrones de páginas escalables para aplicaciones Flutter modernas.

## Introducción

El **Pragma Design System** es un paquete Flutter que implementa un sistema de diseño completo siguiendo los principios de Atomic Design de Brad Frost. Este sistema facilita la creación de interfaces de usuario consistentes, mantenibles y escalables mediante la composición jerárquica de componentes.

### Objetivo del Paquete

- **Consistencia Visual**: Garantizar una experiencia de usuario uniforme en toda la aplicación
- **Reutilización**: Maximizar la reutilización de componentes en diferentes contextos
- **Escalabilidad**: Facilitar el mantenimiento y evolución del sistema de diseño
- **Separación de Responsabilidades**: Distinguir claramente entre layout (Templates) y lógica de negocio (Pages)
- **Desarrollo Eficiente**: Acelerar el desarrollo mediante componentes prefabricados y documentados

## Estructura del Sistema de Diseño

El sistema implementa la metodología **Atomic Design** con cinco niveles jerárquicos:

### 🔸 Atoms (Átomos)
Componentes básicos e indivisibles del sistema de diseño.
- **AppButton**: Botones interactivos con variantes y estados
- **AppText**: Componente de texto con tipografía consistente
- **AppIcon**: Iconografía estandarizada
- **AppSpacer**: Sistema de espaciado consistente
- **AppDivider**: Separadores visuales

### 🔸 Molecules (Moléculas)
Componentes funcionales compuestos por grupos de átomos.
- **AppFormField**: Campos de formulario con validación
- **AppListItem**: Elementos de lista reutilizables
- **AppEmptyState**: Estados vacíos motivacionales
- **AppCard**: Contenedores de contenido con elevación
- **AppSection**: Secciones organizacionales con títulos

### 🔸 Organisms (Organismos)
Componentes complejos que agrupan moléculas para crear secciones funcionales.
- **AppFormSection**: Agrupación lógica de campos de formulario
- **AppSettingsGroup**: Grupos organizados de configuraciones
- **AppEmptyStateSection**: Sección completa de estado vacío
- **AppProductListItem**: Elemento especializado para productos
- **AppCardList**: Listas organizadas de tarjetas

### 🔸 Templates (Plantillas)
Estructuras de página que definen el layout sin lógica de negocio.
- **FormPageTemplate**: Layout para páginas de formularios
- **ProductListTemplate**: Layout para listados de productos
- **SettingsPageTemplate**: Layout para páginas de configuración
- **EmptyStateDashboardTemplate**: Layout para dashboards vacíos

### 🔸 Pages (Páginas)
Implementaciones completas que combinan Templates con datos reales y lógica de negocio.

## Relación Templates ↔ Pages

- **Templates**: Se enfocan únicamente en la estructura visual y el layout
- **Pages**: Proporcionan datos reales, gestión de estado y lógica de negocio
- **Separación Clara**: Los Templates permanecen puros (sin estado), las Pages manejan toda la funcionalidad

## 📋 Listado Completo de Componentes

### 🔸 **Atoms (Átomos)**
Componentes fundamentales e indivisibles:

| Componente | Archivo | Propósito |
|------------|---------|-----------|
| **AppButton** | `app_button.dart` | Botones interactivos con variantes (primary, secondary, outline) y diferentes estados |
| **AppText** | `app_text.dart` | Sistema tipográfico consistente con variantes semánticas (title, body, caption, etc.) |
| **AppIcon** | `app_icon.dart` | Iconografía estandarizada con tamaños y colores coherentes |
| **AppSpacer** | `app_spacer.dart` | Sistema de espaciado vertical y horizontal basado en tokens de diseño |
| **AppDivider** | `app_divider.dart` | Separadores visuales horizontales y verticales |
| **AppImage** | `app_image.dart` | Componente de imagen con manejo de carga y estados de error |

### 🔸 **Molecules (Moléculas)**
Componentes funcionales que combinan átomos:

| Componente | Archivo | Propósito |
|------------|---------|-----------|
| **AppCard** | `app_card.dart` | Contenedor versátil con elevación, bordes redondeados e interactividad opcional |
| **AppFormField** | `app_form_field.dart` | Campo de formulario completo con label, validación y diferentes tipos de entrada |
| **AppListItem** | `app_list_item.dart` | Elemento de lista reutilizable con leading, trailing y contenido personalizable |
| **AppEmptyState** | `app_empty_state.dart` | Estado vacío motivacional con ilustración, mensaje y acción |
| **AppSection** | `app_section.dart` | Contenedor organizacional con título, descripción y contenido |
| **AppPrice** | `app_price.dart` | Componente especializado para mostrar precios con formato y moneda |

### 🔸 **Organisms (Organismos)**
Componentes complejos que agrupan moléculas:

| Componente | Archivo | Propósito |
|------------|---------|-----------|
| **AppFormSection** | `app_form_section.dart` | Agrupación lógica de campos de formulario con título y organización |
| **AppSettingsGroup** | `app_settings_group.dart` | Grupo organizado de elementos de configuración con separación visual |
| **AppEmptyStateSection** | `app_empty_state_section.dart` | Sección completa de estado vacío para páginas sin contenido |
| **AppProductListItem** | `app_product_list_item.dart` | Elemento especializado para mostrar productos con imagen, precio y acciones |
| **AppCardList** | `app_card_list.dart` | Lista organizada de tarjetas con spacing consistente y scroll |

### 🔸 **Templates (Plantillas)**
Estructuras de página que definen layouts:

| Template | Archivo | Propósito |
|----------|---------|-----------|
| **FormPageTemplate** | `form_page_template.dart` | Layout optimizado para páginas de formularios con secciones y acciones |
| **ProductListTemplate** | `product_list_template.dart` | Layout para listados de productos con header, filtros y grid/lista |
| **SettingsPageTemplate** | `settings_page_template.dart` | Layout para páginas de configuración con grupos organizados |
| **EmptyStateDashboardTemplate** | `empty_state_dashboard_template.dart` | Layout para dashboards vacíos con onboarding |

### 🔸 **Pages (Páginas de Ejemplo)**
Implementaciones completas que combinan Templates con datos reales:

| Página | Archivo | Template Usado | Propósito |
|--------|---------|----------------|-----------|
| **HomePage** | `home_page.dart` | - | Navegación principal del sistema de diseño con catálogo de componentes |
| **FormPage** | `form_page.dart` | `FormPageTemplate` | Formulario completo de registro con validación y gestión de estado |
| **ProductListPage** | `product_list_page.dart` | `ProductListTemplate` | Listado de productos con toggle entre estado poblado y vacío |
| **SettingsPage** | `settings_page.dart` | `SettingsPageTemplate` | Página de configuraciones organizadas por grupos funcionales |
| **EmptyStateDashboardPage** | `empty_state_dashboard_page.dart` | `EmptyStateDashboardTemplate` | Dashboard vacío con onboarding y llamadas a acción |

### 🔸 **Navigation & List Pages**
Páginas de navegación y catálogos del sistema:

| Página | Archivo | Propósito |
|--------|---------|-----------|
| **MoleculesListPage** | `molecules_list_page.dart` | Catálogo navegable de todas las moléculas con links a showcases |
| **OrganismsListPage** | `organisms_list_page.dart` | Galería de organismos complejos con ejemplos interactivos |
| **TemplatesListPage** | `templates_list_page.dart` | Showcase de plantillas disponibles con previews |
| **OtherPagesListPage** | `other_pages_list_pages.dart` | Índice de páginas de ejemplo que usan templates reales |

### 🔸 **Shared Components**
Componentes compartidos para navegación y showcase:

| Componente | Archivo | Propósito |
|------------|---------|-----------|
| **ShowcaseListItem** | `showcase_list_item.dart` | Elemento de lista reutilizable para navegación entre showcases |

### 🔸 **Theme (Sistema de Temas)**
Tokens de diseño y configuraciones visuales:

| Componente | Archivo | Propósito |
|------------|---------|-----------|
| **AppTheme** | `app_theme.dart` | Tema principal que integra todos los sistemas de diseño |
| **AppColors** | `app_colors.dart` | Paleta de colores semánticos y decorativos |
| **AppColorScheme** | `app_color_scheme.dart` | Esquemas de color para tema claro y oscuro |
| **AppTextTheme** | `app_text_theme.dart` | Sistema tipográfico con jerarquías y weights |
| **AppSpacing** | `app_spacing.dart` | Tokens de espaciado y sistema de grid |

### 🔸 **Feedback (Sistema de Retroalimentación)**
Utilidades para feedback temporal y notificaciones del sistema:

| Componente | Archivo | Propósito |
|------------|---------|-----------|
| **AppSnackbar** | `app_snackbar.dart` | Clase utilitaria para mostrar mensajes temporales de feedback |
| **AppSnackbarType** | `app_snackbar_type.dart` | Enum que define los tipos semánticos de feedback (success, error, info) |

### 🔸 **Showcase & Navigation**
Páginas de demostración y navegación del sistema:

| Componente | Propósito |
|------------|-----------|
| **HomePage** | Navegación principal del sistema de diseño |
| **AtomsListPage** | Catálogo navegable de todos los átomos |
| **MoleculesListPage** | Showcase interactivo de moléculas |
| **OrganismsListPage** | Demostración de organismos complejos |
| **TemplatesListPage** | Galería de templates disponibles |
| **Individual Showcases** | Páginas específicas para cada componente con ejemplos de uso |

### 📊 **Estadísticas del Sistema**

- **Total de Componentes**: 21 componentes principales + 10 páginas de ejemplo + 2 utilidades de feedback
- **Átomos**: 6 componentes fundamentales
- **Moléculas**: 6 componentes funcionales  
- **Organismos**: 5 componentes complejos
- **Templates**: 4 layouts de página
- **Pages**: 5 páginas de ejemplo completas
- **Navigation Pages**: 4 páginas de catálogo y navegación
- **Shared Components**: 1 componente de navegación reutilizable
- **Sistema de Tema**: 5 módulos de diseño
- **Sistema de Feedback**: 2 utilidades para retroalimentación temporal
- **Páginas de Showcase**: +20 páginas de demostración total

### 🏗️ **Arquitectura Completa**

**Flujo de Navegación:**
1. **HomePage** → Punto de entrada principal
2. **List Pages** → Catálogos por categoría (Molecules, Organisms, Templates, Pages)
3. **Individual Showcases** → Demostraciones específicas de cada componente
4. **Example Pages** → Implementaciones reales usando templates

**Separación de Responsabilidades:**
- **Components (Atoms → Templates)**: Lógica de UI reutilizable
- **Pages**: Implementación con datos reales y lógica de negocio
- **Showcase Pages**: Documentación interactiva
- **Navigation**: Estructura de exploración del sistema

Cada componente incluye:
- ✅ Documentación completa con JSDoc
- ✅ Ejemplos de uso en código
- ✅ Página de showcase interactiva
- ✅ Tipado fuerte con TypeScript/Dart
- ✅ Integración con sistema de temas
- ✅ Seguimiento de principios de Atomic Design

## Uso del Paquete

### Instalación

Añade el paquete a tu `pubspec.yaml`:

```yaml
dependencies:
  pragma_design_system:
    path: ../pragma_design_system
```

### Importación

```dart
import 'package:pragma_design_system/pragma_design_system.dart';
```

### Ejemplo de Uso

```dart
// Uso básico de un átomo
AppButton(
  text: 'Confirmar',
  onPressed: () => print('Botón presionado'),
  variant: AppButtonVariant.primary,
)

// Uso de una molécula
AppFormField(
  label: 'Email',
  hintText: 'Ingresa tu email',
  keyboardType: TextInputType.emailAddress,
  onChanged: (value) => handleEmailChange(value),
)

// Sistema de feedback temporal
AppSnackbar.success(context, message: 'Perfil actualizado exitosamente');
AppSnackbar.error(context, message: 'Error al conectar con el servidor');
AppSnackbar.info(context, message: 'Cargando datos del usuario...');

// Uso de un Template en una Page
class MyFormPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FormPageTemplate(
      title: AppText('Mi Formulario', variant: AppTextVariant.titleLarge),
      sections: [
        AppFormSection(
          title: 'Información Personal',
          children: [
            AppFormField(label: 'Nombre', hintText: 'Tu nombre'),
            AppFormField(label: 'Email', hintText: 'tu@email.com'),
          ],
        ),
      ],
      primaryAction: AppButton(
        text: 'Enviar', 
        onPressed: () {
          // Lógica de envío
          AppSnackbar.success(context, message: 'Formulario enviado correctamente');
        }
      ),
    );
  }
}
}
```

## Aplicación Example / Showcase

La aplicación example incluye showcases interactivos organizados por niveles de Atomic Design:

### Navegación Principal
- **AtomsListPage**: Catálogo de todos los átomos disponibles
- **MoleculesListPage**: Demostraciones de moléculas funcionales
- **OrganismsListPage**: Showcases de organismos complejos
- **TemplatesListPage**: Ejemplos de templates de página
- **Other Pages**: Páginas reales implementadas con el sistema

## Pages Showcase - Implementaciones Reales

### HomePage
**Propósito**: Navegación principal del sistema de diseño
- Punto de entrada a todos los showcases
- Demuestra la arquitectura de navegación
- Organización clara por niveles de Atomic Design

### ProductListPage
**Template**: `ProductListTemplate`
**Funcionalidad**: 
- Lista de productos con datos reales
- Toggle entre estado poblado y estado vacío
- Gestión de estado a nivel de Page
- Demuestra cómo las Pages proporcionan datos a Templates

### FormPage
**Template**: `FormPageTemplate`
**Funcionalidad**:
- Formulario completo de registro de usuario
- Validación en tiempo real
- Gestión de controladores de texto
- Dos secciones: Información de Cuenta e Información de Perfil
- Demuestra separación entre layout (Template) y lógica (Page)

### SettingsPage
**Template**: `SettingsPageTemplate`
**Funcionalidad**:
- Configuraciones organizadas en grupos lógicos
- Grupos: Perfil, Notificaciones, Privacidad
- Navegación y callbacks de interacción
- Demuestra organización de contenido para máxima escaneabilidad

### EmptyStateDashboardPage
**Template**: `EmptyStateDashboardTemplate`
**Funcionalidad**:
- Dashboard en estado vacío para nuevos usuarios
- Mensajería motivacional y onboarding
- Llamada a acción clara para engagement
- Demuestra cómo manejar estados "sin datos"

## Principios de Diseño

### 1. Reutilización
Cada componente está diseñado para ser reutilizable en múltiples contextos sin modificaciones.

### 2. Separación de Responsabilidades
- **Templates**: Layout y estructura visual únicamente
- **Pages**: Datos, estado y lógica de negocio
- **Componentes**: Funcionalidad específica sin acoplamientos

### 3. Templates sin Lógica
Los templates permanecen completamente stateless y libres de lógica de negocio.

### 4. Pages como Composición Final
Las Pages representan experiencias de usuario completas que combinan Templates con datos reales.

### 5. Consistencia Visual
Todos los componentes siguen las mismas convenciones de diseño, espaciado y tipografía.

### 6. Escalabilidad
La arquitectura permite agregar nuevos componentes y pages sin afectar la estructura existente.

## Cómo Ejecutar el Proyecto

### Prerrequisitos
- Flutter SDK (versión estable más reciente)
- Dart SDK
- Editor compatible (VS Code, Android Studio, IntelliJ)

### Pasos de Instalación

1. **Clonar el repositorio**:
   ```bash
   git clone [url-del-repositorio]
   cd pragma_design_system
   ```

2. **Instalar dependencias**:
   ```bash
   flutter pub get
   ```

3. **Navegar a la aplicación example**:
   ```bash
   cd example
   flutter pub get
   ```

4. **Ejecutar la aplicación showcase**:
   ```bash
   flutter run
   ```

### Exploración del Showcase

1. **Inicia desde HomePage**: Navega a través de los diferentes niveles
2. **Explora Atoms**: Revisa los componentes básicos y sus variantes
3. **Prueba Molecules**: Interactúa con componentes funcionales
4. **Analiza Organisms**: Observa la composición de componentes complejos
5. **Examina Templates**: Comprende las estructuras de layout
6. **Interactúa con Pages**: Experimenta con implementaciones reales y completas

La aplicación example sirve tanto como documentación interactiva del sistema como validación de que todos los niveles de Atomic Design funcionan correctamente en conjunto.

---

**Desarrollado como demostración de arquitectura Flutter y sistemas de diseño escalables.**
