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
      primaryAction: AppButton(text: 'Enviar', onPressed: submit),
    );
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
