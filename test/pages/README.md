# Tests de PAGES

Experiencias completas de usuario que integran templates, organisms, molecules y atoms.

## Cobertura: 149 tests ✅

## Componentes a testear:
- **UserProfilePage** - Página de perfil de usuario completa
- **ProductListPage** - Listado de productos con filtros
- **SettingsPage** - Configuraciones de la aplicación  
- **LoginPage** - Autenticación y formularios
- **DashboardPage** - Panel principal con widgets
- **ErrorPage** - Manejo de estados de error
- **SearchPage** - Búsqueda y resultados
- **CartPage** - Carrito de compras
- **CheckoutPage** - Proceso de compra
- **DetailsPage** - Vista de detalle de productos
- **FavoritesPage** - Lista de favoritos
- **SplashPage** - Pantalla de carga inicial

## Estrategia de testing:
- ✅ **Flujos completos** - Navegación end-to-end
- ✅ **Estados de carga** - Loading, error, success
- ✅ **Formularios** - Validación y envío
- ✅ **Navegación** - Routing entre páginas
- ✅ **Integración** - Todas las capas trabajando juntas
- ✅ **Responsive** - Comportamiento en diferentes tamaños
- ✅ **Accessibility** - Labels y navegación por teclado
- ✅ **Business Logic** - Lógica específica de cada página

## Enfoque de Testing

### Pattern Principal
```dart
MaterialApp(
  routes: {...},
  child: PageBajoTest()
)
```

### Áreas Cubiertas
1. **Rendering inicial** - La página se carga correctamente
2. **Navigation** - Navegación a/desde otras páginas 
3. **State Management** - Estados reactivos y actualizaciones
4. **User Interactions** - Taps, scrolls, form inputs
5. **Data Flow** - Carga y manipulación de datos
6. **Error Handling** - Manejo de errores y edge cases
7. **Integration Testing** - Interacción entre componentes

---

### Comandos Específicos

```bash
# Todos los tests de pages (149 tests)
flutter test test/pages/

# Por página específica
flutter test test/pages/user_profile_page_test.dart
flutter test test/pages/product_list_page_test.dart

# Con coverage específico de pages
flutter test test/pages/ --coverage
```

---

**Estado**: 149 tests pasando ✅  
**Cobertura**: 80% (mínimo FASE 6) ✅  
**Integración**: Todas las capas funcionando ✅