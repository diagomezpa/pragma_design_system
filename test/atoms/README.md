# Tests ATOMS - Pragma Design System

Este directorio contiene los tests unitarios para todos los componentes ATOMS del Design System, organizados en **estructura espejo** que refleja exactamente la organización de `lib/atoms/`.

## Estructura Espejo

```
test/atoms/
├── app_button/           # Tests para botones → lib/atoms/app_button/
├── app_divider/          # Tests para dividers → lib/atoms/app_divider/
├── app_icon/             # Tests para iconos → lib/atoms/app_icon/
├── app_image/            # Tests para imágenes → lib/atoms/app_image/
├── app_semantic_icons/   # Tests para iconos semánticos → lib/atoms/app_semantic_icons/
├── app_spacer/           # Tests para espaciado → lib/atoms/app_spacer/
└── app_text/             # Tests para textos → lib/atoms/app_text/
```

## Cobertura de Testing

### ✅ COMPLETADOS (207 tests)

- **AppText** (39 tests) - Todos los variants (headlineLarge, bodyMedium, etc.) + overrides + propiedades
- **AppButton** (36 tests) - 4 variants × 4 sizes + estados + iconos + loading  
- **AppSpacer** (35 tests) - 6 tamaños × 2 direcciones + factory methods + dimensiones custom
- **AppDivider** (25 tests) - Horizontal/vertical + propiedades + factory methods + edge cases
- **AppIcon** (34 tests) - 5 tamaños + interactividad + constructors + factory methods
- **AppImage** (29 tests) - Network/asset images + estados loading/error + factory methods
- **AppSemanticIcons** (34 tests) - Definiciones de iconos constantes + integración

## Comandos de Testing

```bash
# Ejecutar todos los tests de ATOMS
flutter test test/atoms/

# Ejecutar tests específicos por componente
flutter test test/atoms/app_text/
flutter test test/atoms/app_button/
flutter test test/atoms/app_spacer/

# Ejecutar con coverage
flutter test test/atoms/ --coverage
```

## Enfoque de Testing

Los tests siguen el patrón estándar de Flutter:
```dart
MaterialApp > Scaffold > Widget bajo test
```

### Áreas de Cobertura

1. **Rendering básico** - Widget se renderiza sin errores
2. **Propiedades** - Todas las props se aplican correctamente  
3. **Variants/States** - Diferentes estados y variantes
4. **Edge cases** - Casos límite y valores extremos
5. **Factory methods** - Constructors con nombre y métodos de conveniencia
6. **Interactividad** - Callbacks y eventos cuando aplican

## Siguientes Niveles

Una vez completado ATOMS (✅), el plan es:
- **MOLECULES** - Componentes que combinan atoms
- **ORGANISMS** - Secciones complejas con múltiples molecules  
- **TEMPLATES** - Layouts completos de página
- **FEEDBACK** - Modals, snackbars, dialogs

La estrategia prioriza ATOMS para **máxima cobertura** con **mínimo esfuerzo** según criterios de evaluación académica.