import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pragma_design_system/organisms.dart';
import 'package:pragma_design_system/molecules.dart';
import 'package:pragma_design_system/atoms.dart';
import 'package:pragma_design_system/pages.dart';

void main() {
  group('ProductListPage Tests', () {
    group('Basic Page Structure', () {
      testWidgets('should build without crashing', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: ProductListPage(),
          ),
        );

        expect(find.byType(ProductListPage), findsOneWidget);
        expect(find.byType(Scaffold), findsOneWidget);
        expect(find.byType(AppBar), findsOneWidget);
      });

      testWidgets('should display correct app bar title', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: ProductListPage(),
          ),
        );

        expect(find.text('Product List Page'), findsOneWidget);
        expect(find.widgetWithText(AppBar, 'Product List Page'), findsOneWidget);
      });

      testWidgets('should use ProductListTemplate for body', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: ProductListPage(),
          ),
        );

        expect(find.byType(ProductListTemplate), findsOneWidget);
      });

      testWidgets('should display toggle button in app bar', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: ProductListPage(),
          ),
        );

        // Should find Clear button in AppBar
        expect(find.text('Clear'), findsOneWidget);
        // AppBar should contain the toggle button
        expect(find.descendant(
          of: find.byType(AppBar), 
          matching: find.byType(AppButton)
        ), findsOneWidget);
      });
    });

    group('Page State Management', () {
      testWidgets('should start with products visible', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: ProductListPage(),
          ),
        );

        // Should show Clear button when products are visible
        expect(find.text('Clear'), findsOneWidget);
        expect(find.text('Show'), findsNothing);
        
        // Should display header text for populated state
        expect(find.text('Discover our curated selection of premium products'), findsOneWidget);
      });

      testWidgets('should toggle between products and empty state', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: ProductListPage(),
          ),
        );

        // Initial state - products visible
        expect(find.text('Clear'), findsOneWidget);
        expect(find.text('Discover our curated selection of premium products'), findsOneWidget);

        // Toggle to empty state
        await tester.tap(find.text('Clear'));
        await tester.pump();

        expect(find.text('Show'), findsOneWidget);
        expect(find.text('Browse our complete product catalog'), findsOneWidget);
        
        // Toggle back to products state
        await tester.tap(find.text('Show'));
        await tester.pump();

        expect(find.text('Clear'), findsOneWidget);
        expect(find.text('Discover our curated selection of premium products'), findsOneWidget);
      });

      testWidgets('should maintain state consistency across toggles', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: ProductListPage(),
          ),
        );

        // Track expected state after each toggle
        String expectedText = 'Clear'; // Start with products visible
        
        // Toggle multiple times and check expected state
        for (int i = 0; i < 3; i++) {
          await tester.tap(find.text(expectedText));
          await tester.pump();
          
          // Update expected text for next iteration
          expectedText = expectedText == 'Clear' ? 'Show' : 'Clear';
        }

        // Should be in empty state after 3 toggles (Clear → Show → Clear → Show)
        expect(find.text('Show'), findsOneWidget);
        expect(find.text('Browse our complete product catalog'), findsOneWidget);
      });
    });

    group('Header Content', () {
      testWidgets('should display header with correct structure', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: ProductListPage(),
          ),
        );

        expect(find.text('Our Products'), findsOneWidget);
        expect(find.text('Discover our curated selection of premium products'), findsOneWidget);
      });

      testWidgets('should update header description based on state', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: ProductListPage(),
          ),
        );

        // Products state
        expect(find.text('Discover our curated selection of premium products'), findsOneWidget);
        
        // Empty state
        await tester.tap(find.text('Clear'));
        await tester.pump();
        
        expect(find.text('Browse our complete product catalog'), findsOneWidget);
        expect(find.text('Discover our curated selection of premium products'), findsNothing);
      });

      testWidgets('should use correct text variants for header', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: ProductListPage(),
          ),
        );

        final titleWidget = tester.widget<AppText>(
          find.widgetWithText(AppText, 'Our Products'),
        );
        expect(titleWidget.variant, AppTextVariant.headlineMedium);
      });
    });

    group('Product List Display', () {
      testWidgets('should display mock products when in products state', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: ProductListPage(),
          ),
        );

        // Check for mock product names
        expect(find.text('Premium Wireless Headphones'), findsOneWidget);
        expect(find.text('Ergonomic Office Chair'), findsOneWidget);
        expect(find.text('Smart Water Bottle'), findsOneWidget);
        expect(find.text('Minimalist Desk Lamp'), findsOneWidget);
      });

      testWidgets('should display product categories', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: ProductListPage(),
          ),
        );

        expect(find.text('Electronics'), findsOneWidget);
        expect(find.text('Furniture'), findsOneWidget);
        expect(find.text('Health & Fitness'), findsOneWidget);
        expect(find.text('Lighting'), findsOneWidget);
      });

      testWidgets('should display product prices', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: ProductListPage(),
          ),
        );

        expect(find.text('\$299.99'), findsOneWidget);
        expect(find.text('\$459.00'), findsOneWidget);
        expect(find.text('\$79.99'), findsOneWidget);
        expect(find.text('\$129.50'), findsOneWidget);
      });

      testWidgets('should use AppProductListItem components', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: ProductListPage(),
          ),
        );

        expect(find.byType(AppProductListItem), findsNWidgets(4));
      });

      testWidgets('should not display products in empty state', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: ProductListPage(),
          ),
        );

        // Switch to empty state
        await tester.tap(find.text('Clear'));
        await tester.pump();

        expect(find.text('Premium Wireless Headphones'), findsNothing);
        expect(find.text('Ergonomic Office Chair'), findsNothing);
        expect(find.byType(AppProductListItem), findsNothing);
      });
    });

    group('Empty State Display', () {
      testWidgets('should display empty state when no products', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: ProductListPage(),
          ),
        );

        // Switch to empty state
        await tester.tap(find.text('Clear'));
        await tester.pump();

        expect(find.byType(AppEmptyStateSection), findsOneWidget);
        expect(find.text('No products available'), findsOneWidget);
        expect(find.text('We\'re currently updating our product catalog. Check back soon for new arrivals and exciting deals!'), 
               findsOneWidget);
      });

      testWidgets('should display empty state icon', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: ProductListPage(),
          ),
        );

        await tester.tap(find.text('Clear'));
        await tester.pump();

        expect(find.byIcon(Icons.shopping_bag_outlined), findsOneWidget);
      });

      testWidgets('should display empty state actions', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: ProductListPage(),
          ),
        );

        await tester.tap(find.text('Clear'));
        await tester.pump();

        expect(find.text('Browse Categories'), findsOneWidget);
        expect(find.text('Get Notified'), findsOneWidget);
      });

      testWidgets('should not display empty state when products are shown', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: ProductListPage(),
          ),
        );

        // Should not show empty state in initial products state
        expect(find.text('No products available'), findsNothing);
        expect(find.text('Browse Categories'), findsNothing);
      });
    });

    group('User Interactions', () {
      testWidgets('should handle product tap interactions', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: ProductListPage(),
          ),
        );

        // Tap on a product
        await tester.tap(find.text('Premium Wireless Headphones'));
        await tester.pump();

        expect(find.text('Tapped on Premium Wireless Headphones'), findsOneWidget);
        expect(find.byType(SnackBar), findsOneWidget);
      });

      testWidgets('should handle multiple product taps', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: ProductListPage(),
          ),
        );

        await tester.tap(find.text('Ergonomic Office Chair'));
        await tester.pump();

        expect(find.text('Tapped on Ergonomic Office Chair'), findsOneWidget);
      });

      testWidgets('should handle browse categories action', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: ProductListPage(),
          ),
        );

        await tester.tap(find.text('Clear'));
        await tester.pump();

        await tester.tap(find.text('Browse Categories'));
        await tester.pump();

        expect(find.text('Navigate to categories page'), findsOneWidget);
      });

      testWidgets('should handle get notified action', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: ProductListPage(),
          ),
        );

        await tester.tap(find.text('Clear'));
        await tester.pump();

        await tester.tap(find.text('Get Notified'));
        await tester.pump();

        expect(find.text('Notification preferences updated'), findsOneWidget);
      });
    });

    group('MockProduct Data Model', () {
      test('should create MockProduct with all properties', () {
        const product = MockProduct(
          id: 'test-id',
          name: 'Test Product',
          price: 99.99,
          imageUrl: 'test-url',
          category: 'Test Category',
          inStock: true,
        );

        expect(product.id, 'test-id');
        expect(product.name, 'Test Product');
        expect(product.price, 99.99);
        expect(product.imageUrl, 'test-url');
        expect(product.category, 'Test Category');
        expect(product.inStock, true);
      });

      test('should support out of stock products', () {
        const product = MockProduct(
          id: 'test-id',
          name: 'Test Product',
          price: 99.99,
          imageUrl: 'test-url',
          category: 'Test Category',
          inStock: false,
        );

        expect(product.inStock, false);
      });
    });

    group('Template Integration', () {
      testWidgets('should pass correct data to ProductListTemplate', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: ProductListPage(),
          ),
        );

        // Check that ProductListTemplate exists
        expect(find.byType(ProductListTemplate), findsOneWidget);
        
        // Check header content is visible
        expect(find.text('Our Products'), findsOneWidget);
        expect(find.text('Discover our curated selection of premium products'), findsOneWidget);
      });

      testWidgets('should update template data on state change', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: ProductListPage(),
          ),
        );

        // Toggle state
        await tester.tap(find.text('Clear'));
        await tester.pump();

        // Check that template exists and empty state is visible
        expect(find.byType(ProductListTemplate), findsOneWidget);
        expect(find.text('Browse our complete product catalog'), findsOneWidget);
        expect(find.text('No products available'), findsOneWidget);
      });
    });

    group('Responsive Behavior', () {
      testWidgets('should work on different screen sizes', (tester) async {
        // Test default size
        await tester.pumpWidget(
          const MaterialApp(
            home: ProductListPage(),
          ),
        );

        expect(find.byType(ProductListPage), findsOneWidget);

        // Test larger screen
        await tester.binding.setSurfaceSize(const Size(1200, 800));
        await tester.pump();

        expect(find.byType(ProductListPage), findsOneWidget);
        expect(find.text('Our Products'), findsOneWidget);

        // Test smaller screen
        await tester.binding.setSurfaceSize(const Size(300, 600));
        await tester.pump();

        expect(find.byType(ProductListPage), findsOneWidget);
        expect(find.text('Our Products'), findsOneWidget);

        // Reset to default
        await tester.binding.setSurfaceSize(null);
      });
    });

    group('Accessibility', () {
      testWidgets('should be semantically accessible', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: ProductListPage(),
          ),
        );

        // Check for semantic structure
        expect(find.byType(Scaffold), findsOneWidget);
        expect(find.byType(AppBar), findsOneWidget);
        expect(find.byType(AppText), findsAtLeastNWidgets(1));
        
        // Check for interactive elements
        expect(find.byType(AppButton), findsAtLeastNWidgets(1));
        expect(find.byType(AppProductListItem), findsAtLeastNWidgets(1));
      });

      testWidgets('should provide accessible empty state', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: ProductListPage(),
          ),
        );

        await tester.tap(find.text('Clear'));
        await tester.pump();

        expect(find.byType(AppEmptyStateSection), findsOneWidget);
        expect(find.byIcon(Icons.shopping_bag_outlined), findsOneWidget);
      });
    });

    group('Error Handling', () {
      testWidgets('should handle rapid state changes', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: ProductListPage(),
          ),
        );

        // Rapid toggling using specific button text
        for (int i = 0; i < 10; i++) {
          final buttonText = i % 2 == 0 ? 'Clear' : 'Show';
          await tester.tap(find.text(buttonText));
          await tester.pump();
        }

        expect(tester.takeException(), isNull);
        expect(find.byType(ProductListPage), findsOneWidget);
      });

      testWidgets('should handle widget rebuilds gracefully', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: ProductListPage(),
          ),
        );

        // Force rebuild
        await tester.pump();
        await tester.pump(const Duration(milliseconds: 100));

        expect(tester.takeException(), isNull);
        expect(find.text('Our Products'), findsOneWidget);
      });
    });
  });
}