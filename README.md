# Pragma Design System

Un Sistema de Diseño Flutter listo para producción construido sobre principios de **Atomic Design** que garantiza la separación de responsabilidades entre componentes UI, plantillas de layout y lógica de negocio mediante un patrón arquitectónico escalable.

## Visión Arquitectónica

El Pragma Design System aborda el desafío fundamental de construir interfaces de usuario consistentes y mantenibles a escala. En lugar de crear widgets aislados dispersos por toda la aplicación, este sistema establece un lenguaje unificado para la construcción de interfaces mediante composición predecible de componentes y límites arquitectónicos estrictos.

### El Problema que Resolvemos

Las aplicaciones Flutter modernas sufren de:
- **Inconsistencia de UI**: Componentes reimplementados de manera diferente en cada funcionalidad
- **Acoplamiento Estrecho**: Lógica de UI mezclada con lógica de negocio y gestión de datos
- **Pobre Escalabilidad**: Sin ruta clara para hacer crecer la complejidad del diseño
- **Overhead de Mantenimiento**: Los cambios requieren tocar múltiples archivos dispersos

### Nuestra Solución: Atomic Design + Límites Arquitectónicos

Este sistema de diseño implementa una arquitectura de tres capas:

1. **Capa de Componentes** (Atoms → Organisms): Componentes UI puros sin lógica de negocio
2. **Capa de Templates**: Estructuras de layout que definen organización de página sin datos
3. **Capa de Implementación** (Pages): Lógica de negocio, gestión de estado e integración de datos

Esta separación garantiza que los componentes permanezcan reutilizables, los templates se mantengan flexibles y la lógica de negocio permanezca aislada.

## Atomic Design en la Práctica

En lugar de principios atómicos teóricos, nuestra implementación se enfoca en patrones prácticos de desarrollo Flutter:

### Atoms: Elementos Fundacionales
Widgets de propósito único que encapsulan tokens de diseño e interacciones básicas. Cada átomo maneja una preocupación específica de UI: tipografía, espaciado, colores o entrada simple del usuario.

### Molecules: Unidades Funcionales
Combinaciones de átomos que crean componentes funcionales discretos. Estos manejan interacciones específicas del usuario pero permanecen agnósticos al contexto y sin estado.

### Organisms: Secciones Complejas
Secciones de interfaz autocontenidas que combinan moléculas para crear áreas significativas de interfaz de usuario. Representan zonas funcionales completas dentro de una página.

### Templates: Arquitectura de Layout
Estructuras sin estado que definen estructura de página, espaciado y relaciones entre componentes sin lógica de negocio o dependencias de datos.

### Pages: Experiencias Completas
Implementaciones completas que conectan templates con datos reales, gestión de estado, lógica de navegación y reglas de negocio.

## Cómo Templates y Pages Garantizan Separación de Responsabilidades

El patrón Template/Page es la piedra angular de nuestro enfoque arquitectónico:

### Template: Layout Puro
```dart
// FormPageTemplate define solo la estructura
FormPageTemplate(
  title: Widget,           // Cualquier widget de título
  sections: List<Widget>,  // Cualquier sección de formulario
  primaryAction: Widget?,  // Cualquier botón de acción
)
```

### Page: Implementación de Negocio
```dart
// FormPage proporciona funcionalidad real
class FormPage extends StatefulWidget {
  // Gestión de estado, validación, llamadas a API
  // Controladores, lógica de formulario, manejo de errores
  // Decisiones de navegación, persistencia de datos
}
```

**Ejemplo Real**: Nuestro `ProductListTemplate` define el layout para cualquier interfaz de lista, mientras que `ProductListPage` proporciona datos reales de productos, funcionalidad de búsqueda y comportamiento de navegación. El template puede reutilizarse para usuarios, órdenes o cualquier otra entidad creando diferentes implementaciones de Page.

**Beneficios**:
- Los templates permanecen testeable y predecibles
- Las páginas pueden ser desarrolladas por diferentes equipos
- Los cambios de layout no afectan la lógica de negocio
- Los cambios de lógica de negocio no rompen la estructura de UI

## Referencia de Componentes

### Atoms: Capa Fundacional
Elementos de construcción centrales que encapsulan tokens de diseño y funcionalidad básica:

| Componente | Archivo | Propósito |
|------------|---------|-----------|
| **AppButton** | `app_button.dart` | Botones interactivos con variantes (primary, secondary, outline) y diferentes estados |
| **AppText** | `app_text.dart` | Sistema tipográfico consistente con variantes semánticas (title, body, caption, etc.) |
| **AppIcon** | `app_icon.dart` | Iconografía estandarizada con tamaños y colores coherentes |
| **AppSpacer** | `app_spacer.dart` | Sistema de espaciado vertical y horizontal basado en tokens de diseño |
| **AppDivider** | `app_divider.dart` | Separadores visuales horizontales y verticales |
| **AppImage** | `app_image.dart` | Componente de imagen con manejo de carga y estados de error |

### Molecules: Componentes Funcionales
Componentes compuestos que combinan átomos en unidades funcionales cohesivas:

| Componente | Archivo | Propósito |
|------------|---------|-----------|
| **AppCard** | `app_card.dart` | Contenedor versátil con elevación, bordes redondeados e interactividad opcional |
| **AppFormField** | `app_form_field.dart` | Campo de formulario completo con label, validación y diferentes tipos de entrada |
| **AppListItem** | `app_list_item.dart` | Elemento de lista reutilizable con leading, trailing y contenido personalizable |
| **AppEmptyState** | `app_empty_state.dart` | Estado vacío motivacional con ilustración, mensaje y acción |
| **AppSection** | `app_section.dart` | Contenedor organizacional con título, descripción y contenido |
| **AppPrice** | `app_price.dart` | Componente especializado para mostrar precios con formato y moneda |

### Organisms: Secciones de Interfaz
Componentes complejos que crean secciones de interfaz autocontenidas:

| Componente | Archivo | Propósito |
|------------|---------|-----------|
| **AppFormSection** | `app_form_section.dart` | Agrupación lógica de campos de formulario con título y organización |
| **AppSettingsGroup** | `app_settings_group.dart` | Grupo organizado de elementos de configuración con separación visual |
| **AppEmptyStateSection** | `app_empty_state_section.dart` | Sección completa de estado vacío para páginas sin contenido |
| **AppProductListItem** | `app_product_list_item.dart` | Elemento especializado para mostrar productos con imagen, precio y acciones |
| **AppCardList** | `app_card_list.dart` | Lista organizada de tarjetas con spacing consistente y scroll |

### Templates: Arquitectura de Layout
Estructuras de página sin estado que definen patrones de layout sin lógica de negocio:

| Template | Archivo | Propósito |
|----------|---------|-----------|
| **FormPageTemplate** | `form_page_template.dart` | Layout optimizado para páginas de formularios con secciones y acciones |
| **ProductListTemplate** | `product_list_template.dart` | Layout para listados de productos con header, filtros y grid/lista |
| **SettingsPageTemplate** | `settings_page_template.dart` | Layout para páginas de configuración con grupos organizados |
| **EmptyStateDashboardTemplate** | `empty_state_dashboard_template.dart` | Layout para dashboards vacíos con onboarding |

### Pages: Implementaciones Completas
Implementaciones completas de página que combinan templates con lógica de negocio y datos:

| Página | Archivo | Template Usado | Propósito |
|--------|---------|----------------|-----------|
| **HomePage** | `home_page.dart` | - | Navegación principal del sistema de diseño con catálogo de componentes |
| **FormPage** | `form_page.dart` | `FormPageTemplate` | Formulario completo de registro con validación y gestión de estado |
| **ProductListPage** | `product_list_page.dart` | `ProductListTemplate` | Listado de productos con toggle entre estado poblado y vacío |
| **SettingsPage** | `settings_page.dart` | `SettingsPageTemplate` | Página de configuraciones organizadas por grupos funcionales |
| **EmptyStateDashboardPage** | `empty_state_dashboard_page.dart` | `EmptyStateDashboardTemplate` | Dashboard vacío con onboarding y llamadas a acción |

### Navegación del Sistema
Estructura de catálogo interactivo y navegación:

| Página | Archivo | Propósito |
|--------|---------|-----------|
| **MoleculesListPage** | `molecules_list_page.dart` | Catálogo navegable de todas las moléculas con links a showcases |
| **OrganismsListPage** | `organisms_list_page.dart` | Galería de organismos complejos con ejemplos interactivos |
| **TemplatesListPage** | `templates_list_page.dart` | Showcase de plantillas disponibles con previews |
| **OtherPagesListPage** | `other_pages_list_pages.dart` | Índice de páginas de ejemplo que usan templates reales |

### Componentes Compartidos
Infraestructura reutilizable para navegación y demostración:

| Componente | Archivo | Propósito |
|------------|---------|-----------|
| **ShowcaseListItem** | `showcase_list_item.dart` | Elemento de lista reutilizable para navegación entre showcases |

### Fundación del Sistema de Diseño
Tokens de diseño y configuración de temas que sustentan todos los componentes:

| Componente | Archivo | Propósito |
|------------|---------|-----------|
| **AppTheme** | `app_theme.dart` | Tema principal que integra todos los sistemas de diseño |
| **AppColors** | `app_colors.dart` | Paleta de colores semánticos y decorativos |
| **AppColorScheme** | `app_color_scheme.dart` | Esquemas de color para tema claro y oscuro |
| **AppTextTheme** | `app_text_theme.dart` | Sistema tipográfico con jerarquías y weights |
| **AppSpacing** | `app_spacing.dart` | Tokens de espaciado y sistema de grid |

### Sistema de Retroalimentación al Usuario
Utilidades para feedback temporal y notificaciones del sistema:

| Componente | Archivo | Propósito |
|------------|---------|-----------|
| **AppSnackbar** | `app_snackbar.dart` | Clase utilitaria para mostrar mensajes temporales de feedback |
| **AppSnackbarType** | `app_snackbar_type.dart` | Enum que define los tipos semánticos de feedback (success, error, info) |

### Documentación Interactiva
Páginas exhaustivas de showcase y navegación para exploración del sistema:

| Componente | Propósito |
|-----------|----------|
| **HomePage** | Hub de navegación del sistema de diseño y visión arquitectónica |
| **AtomsListPage** | Catálogo interactivo de componentes fundacionales |
| **MoleculesListPage** | Demostraciones de componentes funcionales con ejemplos en vivo |
| **OrganismsListPage** | Showcases de componentes complejos con patrones de interacción |
| **TemplatesListPage** | Galería de patrones de layout con ejemplos estructurales |
| **Individual Showcases** | Documentación detallada de componentes con ejemplos de uso |

## Métricas del Sistema

El sistema de diseño proporciona cobertura integral a través de la jerarquía de componentes:

- **21 Componentes Centrales** a través de niveles atómicos
- **4 Templates de Layout** para patrones comunes de página
- **5 Páginas de Implementación de Referencia**
- **20+ Páginas de Documentación Interactiva**
- **Sistema de Temas Completo** con tokens de diseño
- **Infraestructura de Feedback** para interacciones de usuario

## Documentación Interactiva

La aplicación example sirve como documentación viva del sistema de diseño. En lugar de documentación estática, los desarrolladores pueden:

- **Explorar Componentes**: Demos interactivos de cada componente con funcionalidad real
- **Entender Patrones**: Ver cómo los componentes se componen en secciones de interfaz más grandes
- **Probar Integraciones**: Experimentar cómo los templates y pages trabajan juntos
- **Validar Consistencia**: Confirmar consistencia visual y de comportamiento a través del sistema

Este enfoque asegura que la documentación se mantenga actualizada con la implementación y proporciona guía práctica para el uso de componentes.

## Adopción por Equipos

### Instalación

Añade el sistema de diseño a tu proyecto Flutter:

```yaml
dependencies:
  pragma_design_system:
    path: ../pragma_design_system
```

### Estrategia de Integración

**1. Comienza con el Sistema de Temas**
```dart
import 'package:pragma_design_system/pragma_design_system.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      // tu app
    );
  }
}
```

**2. Usa Átomos para Elementos UI Consistentes**
```dart
// Reemplaza botones inconsistentes con átomos del sistema de diseño
AppButton(
  text: 'Enviar',
  onPressed: handleSubmit,
  variant: AppButtonVariant.primary,
)

// Tipografía consistente a través de funcionalidades
AppText('Perfil de Usuario', variant: AppTextVariant.titleLarge)
```

**3. Construye con Moléculas para Componentes Complejos**
```dart
// Campos de formulario con patrones de validación incorporados
AppFormField(
  label: 'Dirección de Email',
  validator: EmailValidator(),
  onChanged: updateEmail,
)

// Items de lista con patrones de interacción consistentes
AppListItem(
  title: 'Configuración de Cuenta',
  trailing: AppIcon(Icons.arrow_forward_ios),
  onTap: () => navigator.pushSettingsPage(),
)
```

**4. Usa Templates para Estructura de Página**
```dart
// Separa layout de lógica de negocio
class UserProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FormPageTemplate(
      title: AppText('Editar Perfil'),
      sections: _buildProfileSections(),
      primaryAction: _buildSaveButton(),
    );
  }
  
  // La lógica de negocio permanece en la Page
  List<Widget> _buildProfileSections() { /* ... */ }
  Widget _buildSaveButton() { /* ... */ }
}
```

**5. Implementa Patrones de Feedback**
```dart
// Feedback consistente del usuario a través de la app
AppSnackbar.success(context, message: 'Perfil actualizado exitosamente');
AppSnackbar.error(context, message: 'Fallo en conexión de red');
AppSnackbar.info(context, message: 'Sincronización en progreso...');
```

### Flujo de Trabajo de Desarrollo

1. **Revisión de Diseño**: Verifica si los patrones necesarios existen en el sistema de diseño
2. **Componentes Primero**: Usa componentes existentes antes de construir UI personalizada
3. **Estrategia de Template**: Usa templates para nuevos layouts de página
4. **Contribución**: Extiende el sistema de diseño cuando falten patrones

### Mejores Prácticas

- **Favorece la Composición**: Combina componentes existentes en lugar de personalizarlos
- **Respeta Límites**: Mantén lógica de negocio en Pages, no en Templates
- **Consistencia de Tema**: Usa tokens de diseño en lugar de valores hardcodeados
- **Documentación Interactiva**: Referencia la app showcase para ejemplos de uso

## Ejemplos de Implementación de Referencia

El sistema de diseño incluye implementaciones completas de página que demuestran la separación adecuada Template/Page:

### ProductListPage
- **Template**: `ProductListTemplate` - Define estructura de layout de lista
- **Lógica de Page**: Gestión de datos de productos, funcionalidad de búsqueda, manejo de estado vacío
- **Demuestra**: Cómo las Pages proporcionan contexto de datos a Templates sin estado

### FormPage  
- **Template**: `FormPageTemplate` - Organiza secciones y acciones de formulario
- **Lógica de Page**: Validación de formulario, gestión de estado, manejo de envío
- **Demuestra**: Separación limpia entre estructura de layout y lógica de negocio de formulario

### SettingsPage
- **Template**: `SettingsPageTemplate` - Agrupa configuraciones en secciones lógicas
- **Lógica de Page**: Persistencia de configuraciones, enrutamiento de navegación, preferencias de usuario
- **Demuestra**: Cómo contenido complejo de página puede organizarse mediante composición de template

### EmptyStateDashboardPage
- **Template**: `EmptyStateDashboardTemplate` - Patrones de layout de onboarding
- **Lógica de Page**: Flujo de onboarding de usuario, seguimiento de engagement, enrutamiento de acciones
- **Demuestra**: Reutilización de template para diferentes contextos de estado vacío

## Principios Arquitectónicos

**1. Separación de Responsabilidades**
- Los templates manejan solo estructura de layout
- Las pages gestionan datos, estado y lógica de negocio
- Los componentes permanecen agnósticos al contexto y reutilizables

**2. Composición Predecible**
- Los componentes se componen hacia arriba a través de niveles atómicos
- Cada nivel construye sobre el anterior sin romper encapsulación
- Interfaces claras entre capas de componentes

**3. Templates Sin Estado**
- Todos los templates son widgets sin estado enfocados en layout
- Sin lógica de negocio, llamadas a API o gestión de estado en templates
- Los templates pueden ser probados independientemente de preocupaciones de datos

**4. Contexto Delimitado**
- Los componentes operan dentro de límites bien definidos
- Las dependencias fluyen hacia abajo a través de la jerarquía atómica
- La lógica de negocio permanece aislada en la capa Page

**5. Integración de Tokens de Diseño**
- Todas las propiedades visuales derivan de tokens de diseño centralizados
- Uso consistente de espaciado, tipografía y color a través de componentes
- Los cambios de tema se propagan automáticamente a través de la jerarquía de componentes

## Desarrollo Local

### Prerrequisitos
- Flutter SDK (versión estable más reciente)
- Dart SDK
- IDE compatible (VS Code, Android Studio, IntelliJ)

### Configuración

1. **Clonar e instalar dependencias**:
   ```bash
   git clone [repository-url]
   cd pragma_design_system
   flutter pub get
   ```

2. **Ejecutar la documentación interactiva**:
   ```bash
   cd example
   flutter pub get
   flutter run
   ```

### Explorando el Sistema

1. **Comienza con HomePage**: Navega a través de categorías de componentes
2. **Revisa Átomos**: Entiende los bloques de construcción fundacionales
3. **Explora Moléculas**: Ve patrones de componentes funcionales
4. **Estudia Organismos**: Observa composición de componentes complejos
5. **Examina Templates**: Entiende arquitectura de layout
6. **Prueba Pages**: Experimenta implementaciones completas

La app example demuestra todo el sistema de diseño en acción y sirve como referencia primaria para patrones de implementación.

---

**Construido como demostración de arquitectura Flutter escalable y sistemas de diseño listos para producción.**
