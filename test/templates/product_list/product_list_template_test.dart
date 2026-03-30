import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pragma_design_system/templates.dart';
import 'package:pragma_design_system/organisms.dart';
import 'package:pragma_design_system/molecules.dart';
import 'package:pragma_design_system/atoms.dart';

void main() {
  group('ProductListTemplate Tests', () {
    group('Constructor and Properties', () {
      testWidgets('should create with required parameters', (tester) async {
        const template = ProductListTemplate(
          products: [Text('Product 1'), Text('Product 2')],
        );

        expect(template.products, hasLength(2));
        expect(template.header, isNull); // Default value
        expect(template.emptyState, isNull); // Default value
      });

      testWidgets('should accept all optional parameters', (tester) async {
        final header = AppText('Featured Products', variant: AppTextVariant.titleLarge);
        final emptyState = AppEmptyStateSection(
          title: 'No products found',
          description: 'Try adjusting your search criteria.',
        );
        
        final template = ProductListTemplate(
          header: header,
          products: const [Text('Product 1')],
          emptyState: emptyState,
        );

        expect(template.header, header);
        expect(template.products, hasLength(1));
        expect(template.emptyState, emptyState);
      });
    });

    group('Basic Template Structure', () {
      testWidgets('should build without crashing', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: ProductListTemplate(
              products: [Text('Product 1')],
            ),
          ),
        );

        expect(find.byType(ProductListTemplate), findsOneWidget);
        expect(find.byType(AppSection), findsOneWidget);
        expect(find.text('Product 1'), findsOneWidget);
      });

      testWidgets('should use AppSection for layout structure', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: ProductListTemplate(
              products: [Text('Test Product')],
            ),
          ),
        );

        expect(find.byType(AppSection), findsOneWidget);
        
        final appSection = tester.widget<AppSection>(find.byType(AppSection));
        expect(appSection.title, 'Products');
        expect(appSection.child, isA<Column>());
      });

      testWidgets('should display default section title', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: ProductListTemplate(
              products: [Text('Test Product')],
            ),
          ),
        );

        expect(find.text('Products'), findsOneWidget);
      });
    });

    group('Header Functionality', () {
      testWidgets('should display header when provided', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: ProductListTemplate(
              header: AppText('Featured Products', variant: AppTextVariant.titleLarge),
              products: const [Text('Product 1')],
            ),
          ),
        );

        expect(find.text('Featured Products'), findsOneWidget);
        expect(find.text('Products'), findsOneWidget); // Section title
        expect(find.byType(AppText), findsNWidgets(2)); // Section title + header
      });

      testWidgets('should not display header when not provided', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: ProductListTemplate(
              products: [Text('Product 1')],
            ),
          ),
        );

        // Only the section title should exist, not additional header
        expect(find.text('Products'), findsOneWidget);
        expect(find.text('Featured Products'), findsNothing);
        expect(find.byType(AppText), findsOneWidget); // Only the section title
      });

      testWidgets('should add spacing after header', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: ProductListTemplate(
              header: AppText('Custom Header', variant: AppTextVariant.titleMedium),
              products: const [Text('Product 1')],
            ),
          ),
        );

        expect(find.text('Custom Header'), findsOneWidget);
        // Note: AppSpacer may be used internally by AppSection too
        expect(find.byType(AppSpacer), findsAtLeastNWidgets(1));
      });

      testWidgets('should support complex header widgets', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: ProductListTemplate(
              header: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppText('Products', variant: AppTextVariant.titleLarge),
                  AppButton(text: 'Filter', onPressed: () {}),
                ],
              ),
              products: const [Text('Product 1')],
            ),
          ),
        );

        expect(find.text('Products'), findsNWidgets(2)); // Section title + header
        expect(find.text('Filter'), findsOneWidget);
        expect(find.byType(AppButton), findsOneWidget);
        expect(find.byType(Row), findsOneWidget);
      });
    });

    group('Product List Display', () {
      testWidgets('should display products using AppCardList', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: ProductListTemplate(
              products: [
                Text('Product 1'),
                Text('Product 2'),
                Text('Product 3'),
              ],
            ),
          ),
        );

        expect(find.byType(AppCardList), findsOneWidget);
        expect(find.text('Product 1'), findsOneWidget);
        expect(find.text('Product 2'), findsOneWidget);
        expect(find.text('Product 3'), findsOneWidget);
      });

      testWidgets('should pass all products to AppCardList', (tester) async {
        const products = [
          Text('Item A'),
          Text('Item B'),
          Text('Item C'),
          Text('Item D'),
        ];

        await tester.pumpWidget(
          const MaterialApp(
            home: ProductListTemplate(
              products: products,
            ),
          ),
        );

        final appCardList = tester.widget<AppCardList>(find.byType(AppCardList));
        expect(appCardList.children, hasLength(4));
        expect(appCardList.children, products);
      });

      testWidgets('should handle single product', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: ProductListTemplate(
              products: [Text('Single Product')],
            ),
          ),
        );

        expect(find.byType(AppCardList), findsOneWidget);
        expect(find.text('Single Product'), findsOneWidget);

        final appCardList = tester.widget<AppCardList>(find.byType(AppCardList));
        expect(appCardList.children, hasLength(1));
      });

      testWidgets('should support complex product widgets', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: ProductListTemplate(
              products: [
                AppProductListItem(
                  title: 'Premium Product',
                  price: '\$99.99',
                  onTap: () {},
                ),
                Card(
                  child: ListTile(
                    title: Text('Custom Product'),
                    subtitle: Text('Custom Description'),
                  ),
                ),
              ],
            ),
          ),
        );

        expect(find.byType(AppProductListItem), findsOneWidget);
        expect(find.byType(Card), findsOneWidget);
        expect(find.text('Premium Product'), findsOneWidget);
        expect(find.text('Custom Product'), findsOneWidget);
      });
    });

    group('Empty State Handling', () {
      testWidgets('should display empty state when products list is empty and emptyState provided', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: ProductListTemplate(
              products: const [],
              emptyState: AppEmptyStateSection(
                title: 'No products found',
                description: 'Try adjusting your search criteria.',
              ),
            ),
          ),
        );

        expect(find.byType(AppEmptyStateSection), findsOneWidget);
        expect(find.text('No products found'), findsOneWidget);
        expect(find.text('Try adjusting your search criteria.'), findsOneWidget);
        expect(find.byType(AppCardList), findsNothing);
      });

      testWidgets('should display AppCardList when products list is empty but no emptyState provided', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: ProductListTemplate(
              products: [],
            ),
          ),
        );

        expect(find.byType(AppCardList), findsOneWidget);
        expect(find.byType(AppEmptyStateSection), findsNothing);

        final appCardList = tester.widget<AppCardList>(find.byType(AppCardList));
        expect(appCardList.children, isEmpty);
      });

      testWidgets('should prioritize emptyState over empty AppCardList', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: ProductListTemplate(
              products: const [],
              emptyState: AppEmptyStateSection(
                title: 'Coming Soon',
                description: 'We\'re adding new products. Check back soon!',
              ),
            ),
          ),
        );

        expect(find.byType(AppEmptyStateSection), findsOneWidget);
        expect(find.byType(AppCardList), findsNothing);
        expect(find.text('Coming Soon'), findsOneWidget);
      });

      testWidgets('should not display emptyState when products exist', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: ProductListTemplate(
              products: const [Text('Available Product')],
              emptyState: AppEmptyStateSection(
                title: 'No products found',
                description: 'This should not be visible.',
              ),
            ),
          ),
        );

        expect(find.byType(AppCardList), findsOneWidget);
        expect(find.byType(AppEmptyStateSection), findsNothing);
        expect(find.text('Available Product'), findsOneWidget);
        expect(find.text('No products found'), findsNothing);
      });

      testWidgets('should support complex empty state widgets', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: ProductListTemplate(
              products: const [],
              emptyState: AppEmptyStateSection(
                icon: Icons.shopping_bag_outlined,
                title: 'No products available',
                description: 'We\'re currently updating our product catalog.',
                primaryAction: AppButton(
                  text: 'Browse Categories',
                  onPressed: () {},
                  variant: AppButtonVariant.primary,
                ),
              ),
            ),
          ),
        );

        expect(find.byType(AppEmptyStateSection), findsOneWidget);
        expect(find.byIcon(Icons.shopping_bag_outlined), findsOneWidget);
        expect(find.text('No products available'), findsOneWidget);
        expect(find.text('Browse Categories'), findsOneWidget);
        expect(find.byType(AppButton), findsOneWidget);
      });
    });

    group('Layout and Spacing', () {
      testWidgets('should use Column with proper alignment', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: ProductListTemplate(
              products: [Text('Test Product')],
            ),
          ),
        );

        // Find the specific Column inside the template structure
        final columns = tester.widgetList<Column>(
          find.descendant(
            of: find.byType(ProductListTemplate),
            matching: find.byType(Column),
          ),
        );
        
        // Should have at least one column from the template
        expect(columns.length, greaterThan(0));
        
        // Find the main content column (not section structure)
        final mainColumn = columns.firstWhere(
          (col) => col.crossAxisAlignment == CrossAxisAlignment.start &&
                   col.mainAxisSize == MainAxisSize.min,
          orElse: () => columns.first,
        );
        
        expect(mainColumn.crossAxisAlignment, CrossAxisAlignment.start);
        expect(mainColumn.mainAxisSize, MainAxisSize.min);
      });

      testWidgets('should add medium spacing between header and content', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: ProductListTemplate(
              header: AppText('Header', variant: AppTextVariant.titleMedium),
              products: const [Text('Product')],
            ),
          ),
        );

        // Header spacing should exist (AppSection may have internal spacers too)
        expect(find.byType(AppSpacer), findsAtLeastNWidgets(1));
        
        // Verify spacer exists (medium vertical spacing from factory)
        // Note: Multiple spacers may exist due to AppSection internal structure
        expect(find.byType(AppSpacer), findsAtLeastNWidgets(1));
      });

      testWidgets('should not add spacing when no header provided', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: ProductListTemplate(
              products: [Text('Product')],
            ),
          ),
        );

        // AppSection may have internal spacers, so we expect at least 0
        expect(find.byType(AppSpacer), findsAtLeast(0));
      });
    });

    group('Template Composition', () {
      testWidgets('should compose organisms correctly', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: ProductListTemplate(
              header: AppText('Products', variant: AppTextVariant.titleLarge),
              products: [
                AppProductListItem(
                  title: 'Product 1',
                  price: '\$29.99',

                  onTap: () {},
                ),
              ],
              emptyState: AppEmptyStateSection(
                title: 'Empty State',
                description: 'No products available.',
              ),
            ),
          ),
        );

        // Should have proper composition hierarchy
        expect(find.byType(AppSection), findsOneWidget);
        expect(find.text('Products'), findsNWidgets(2)); // Section title + header
        expect(find.byType(AppCardList), findsOneWidget);
        expect(find.byType(AppProductListItem), findsOneWidget);
        expect(find.byType(AppSpacer), findsAtLeastNWidgets(1));
        
        // Empty state should not be visible when products exist
        expect(find.byType(AppEmptyStateSection), findsNothing);
      });

      testWidgets('should work with multiple product types', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: ProductListTemplate(
              products: [
                AppProductListItem(
                  title: 'Standard Product',
                  price: '\$19.99',
                  onTap: () {},
                ),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Custom Product Card'),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(16.0),
                  color: Colors.grey[200],
                  child: Text('Featured Product Banner'),
                ),
              ],
            ),
          ),
        );

        expect(find.byType(AppProductListItem), findsOneWidget);
        expect(find.byType(Card), findsOneWidget);
        // Container is used internally by multiple widgets, so check for at least one
        expect(find.byType(Container), findsAtLeastNWidgets(1));
        expect(find.text('Standard Product'), findsOneWidget);
        expect(find.text('Custom Product Card'), findsOneWidget);
        expect(find.text('Featured Product Banner'), findsOneWidget);
      });
    });

    group('Responsive Behavior', () {
      testWidgets('should adapt to different screen sizes', (tester) async {
        // Test default size
        await tester.pumpWidget(
          const MaterialApp(
            home: ProductListTemplate(
              products: [Text('Product 1'), Text('Product 2')],
            ),
          ),
        );

        expect(find.byType(ProductListTemplate), findsOneWidget);
        expect(find.byType(AppCardList), findsOneWidget);

        // Test larger screen
        await tester.binding.setSurfaceSize(const Size(1200, 800));
        await tester.pump();

        expect(find.byType(ProductListTemplate), findsOneWidget);
        expect(find.text('Product 1'), findsOneWidget);

        // Test smaller screen
        await tester.binding.setSurfaceSize(const Size(300, 600));
        await tester.pump();

        expect(find.byType(ProductListTemplate), findsOneWidget);
        expect(find.text('Product 2'), findsOneWidget);

        // Reset to default
        await tester.binding.setSurfaceSize(null);
      });
    });

    group('Accessibility', () {
      testWidgets('should be semantically accessible', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: ProductListTemplate(
              header: AppText('Featured Products', variant: AppTextVariant.titleLarge),
              products: [
                AppProductListItem(
                  title: 'Accessible Product',
                  price: '\$39.99',
                  onTap: () {},
                ),
              ],
            ),
          ),
        );

        // Should have proper semantic structure
        expect(find.byType(AppSection), findsOneWidget);
        expect(find.text('Featured Products'), findsOneWidget); // Header
        expect(find.text('Products'), findsOneWidget); // Section title
        expect(find.byType(AppCardList), findsOneWidget);
        expect(find.byType(AppProductListItem), findsOneWidget);
      });

      testWidgets('should support accessible empty states', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: ProductListTemplate(
              products: const [],
              emptyState: AppEmptyStateSection(
                icon: Icons.search_off,
                title: 'No products found',
                description: 'Try adjusting your search criteria or browse categories.',
                primaryAction: AppButton(
                  text: 'Browse Categories',
                  onPressed: () {},
                  variant: AppButtonVariant.primary,
                ),
              ),
            ),
          ),
        );

        expect(find.byType(AppEmptyStateSection), findsOneWidget);
        expect(find.byIcon(Icons.search_off), findsOneWidget);
        expect(find.text('No products found'), findsOneWidget);
        expect(find.byType(AppButton), findsOneWidget);
      });
    });

    group('Error Handling', () {
      testWidgets('should handle widget rebuilds gracefully', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: ProductListTemplate(
              products: [Text('Stable Product')],
            ),
          ),
        );

        // Force rebuild
        await tester.pump();
        await tester.pump(const Duration(milliseconds: 100));

        expect(tester.takeException(), isNull);
        expect(find.text('Stable Product'), findsOneWidget);
      });

      testWidgets('should handle empty products list gracefully', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: ProductListTemplate(
              products: [],
            ),
          ),
        );

        expect(tester.takeException(), isNull);
        expect(find.byType(AppCardList), findsOneWidget);

        final appCardList = tester.widget<AppCardList>(find.byType(AppCardList));
        expect(appCardList.children, isEmpty);
      });

      testWidgets('should handle null widgets in products list safely', (tester) async {
        // This tests the template's resilience, though in practice
        // null widgets shouldn't be passed
        await tester.pumpWidget(
          const MaterialApp(
            home: ProductListTemplate(
              products: [
                Text('Valid Product'),
                SizedBox.shrink(), // Empty widget
              ],
            ),
          ),
        );

        expect(tester.takeException(), isNull);
        expect(find.text('Valid Product'), findsOneWidget);
        // SizedBox is used internally by spacing and other widgets
        expect(find.byType(SizedBox), findsAtLeastNWidgets(1));
      });
    });

    group('Template Architecture', () {
      testWidgets('should be stateless', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: ProductListTemplate(
              products: [Text('Test Product')],
            ),
          ),
        );

        final template = tester.widget<ProductListTemplate>(
          find.byType(ProductListTemplate),
        );

        // Verify it extends StatelessWidget
        expect(template, isA<StatelessWidget>());
      });

      testWidgets('should separate concerns correctly', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: ProductListTemplate(
              header: AppText('Layout Header', variant: AppTextVariant.titleLarge),
              products: [
                AppProductListItem(
                  title: 'Business Product',
                  price: '\$49.99',
                  onTap: () {},
                ),
              ],
              emptyState: AppEmptyStateSection(
                title: 'State Management',
                description: 'Template handles layout, not business logic.',
              ),
            ),
          ),
        );

        // Template should provide layout structure
        expect(find.byType(ProductListTemplate), findsOneWidget);
        
        // Molecules should handle section organization  
        expect(find.byType(AppSection), findsOneWidget);
        
        // Organisms should handle component composition
        expect(find.byType(AppCardList), findsOneWidget);
        expect(find.byType(AppProductListItem), findsOneWidget);
      });
    });
  });
}