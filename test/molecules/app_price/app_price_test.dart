import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pragma_design_system/molecules.dart';
import 'package:pragma_design_system/atoms.dart';

void main() {
  group('AppPrice Tests', () {
    group('Basic Rendering', () {
      testWidgets('should render with required value parameter', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppPrice(value: 120000),
            ),
          ),
        );

        expect(find.byType(AppPrice), findsOneWidget);
        expect(find.text('\$ 120.000'), findsOneWidget);
        expect(find.byType(AppText), findsOneWidget);
      });

      testWidgets('should render simple price without discount', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppPrice(
                value: 50000,
                currency: '€',
              ),
            ),
          ),
        );

        expect(find.text('€ 50.000'), findsOneWidget);
        expect(find.byType(AppText), findsOneWidget);
        expect(find.byType(Column), findsNothing); // No discount structure
      });
    });

    group('Price Formatting', () {
      testWidgets('should format price with default currency symbol', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppPrice(value: 1500),
            ),
          ),
        );

        expect(find.text('\$ 1.500'), findsOneWidget);
      });

      testWidgets('should format price with custom currency symbol', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppPrice(
                value: 250000,
                currency: '€',
              ),
            ),
          ),
        );

        expect(find.text('€ 250.000'), findsOneWidget);
      });

      testWidgets('should format prices with thousand separators', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: Column(
                children: [
                  AppPrice(value: 1000),
                  AppPrice(value: 10000),
                  AppPrice(value: 100000),
                  AppPrice(value: 1000000),
                ],
              ),
            ),
          ),
        );

        expect(find.text('\$ 1.000'), findsOneWidget);
        expect(find.text('\$ 10.000'), findsOneWidget);
        expect(find.text('\$ 100.000'), findsOneWidget);
        expect(find.text('\$ 1.000.000'), findsOneWidget);
      });

      testWidgets('should format small values correctly', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: Column(
                children: [
                  AppPrice(value: 1),
                  AppPrice(value: 99),
                  AppPrice(value: 500),
                ],
              ),
            ),
          ),
        );

        expect(find.text('\$ 1'), findsOneWidget);
        expect(find.text('\$ 99'), findsOneWidget);
        expect(find.text('\$ 500'), findsOneWidget);
      });

      testWidgets('should handle zero value', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppPrice(value: 0),
            ),
          ),
        );

        expect(find.text('\$ 0'), findsOneWidget);
      });

      testWidgets('should support different currency symbols', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: Column(
                children: [
                  AppPrice(value: 12000, currency: '¥'),
                  AppPrice(value: 15000, currency: '£'),
                  AppPrice(value: 18000, currency: 'COP'),
                  AppPrice(value: 20000, currency: 'USD'),
                ],
              ),
            ),
          ),
        );

        expect(find.text('¥ 12.000'), findsOneWidget);
        expect(find.text('£ 15.000'), findsOneWidget);
        expect(find.text('COP 18.000'), findsOneWidget);
        expect(find.text('USD 20.000'), findsOneWidget);
      });
    });

    group('Discount Functionality', () {
      testWidgets('should render discounted price with original price crossed out', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppPrice(
                value: 200000,
                discountedValue: 150000,
              ),
            ),
          ),
        );

        expect(find.text('\$ 200.000'), findsOneWidget); // Original price
        expect(find.text('\$ 150.000'), findsOneWidget); // Discounted price
        expect(find.byType(Column), findsOneWidget);
        expect(find.byType(AppText), findsNWidgets(2));
      });

      testWidgets('should apply line-through decoration to original price', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppPrice(
                value: 100000,
                discountedValue: 80000,
              ),
            ),
          ),
        );

        final textWidgets = tester.widgetList<AppText>(find.byType(AppText));
        final originalPriceWidget = textWidgets.first;
        final discountedPriceWidget = textWidgets.last;

        expect(originalPriceWidget.decoration, TextDecoration.lineThrough);
        expect(originalPriceWidget.text, '\$ 100.000');
        expect(discountedPriceWidget.text, '\$ 80.000');
        expect(discountedPriceWidget.decoration, isNull);
      });

      testWidgets('should use correct text variants for discount prices', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppPrice(
                value: 50000,
                discountedValue: 40000,
              ),
            ),
          ),
        );

        final textWidgets = tester.widgetList<AppText>(find.byType(AppText));
        final originalPriceWidget = textWidgets.first;
        final discountedPriceWidget = textWidgets.last;

        expect(originalPriceWidget.variant, AppTextVariant.bodyMedium);
        expect(discountedPriceWidget.variant, AppTextVariant.titleMedium);
        expect(discountedPriceWidget.fontWeight, FontWeight.w600);
      });

      testWidgets('should handle highlighted discount prices', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppPrice(
                value: 80000,
                discountedValue: 60000,
                highlight: true,
              ),
            ),
          ),
        );

        final textWidgets = tester.widgetList<AppText>(find.byType(AppText));
        final discountedPriceWidget = textWidgets.last;

        expect(discountedPriceWidget.variant, AppTextVariant.titleLarge);
        expect(discountedPriceWidget.fontWeight, FontWeight.w600);
      });
    });

    group('Highlight Mode', () {
      testWidgets('should render highlighted single price with stronger typography', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppPrice(
                value: 90000,
                highlight: true,
              ),
            ),
          ),
        );

        final textWidget = tester.widget<AppText>(find.byType(AppText));
        expect(textWidget.variant, AppTextVariant.titleLarge);
        expect(textWidget.fontWeight, FontWeight.w600);
        expect(textWidget.text, '\$ 90.000');
      });

      testWidgets('should render normal single price with regular typography', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppPrice(
                value: 90000,
                highlight: false,
              ),
            ),
          ),
        );

        final textWidget = tester.widget<AppText>(find.byType(AppText));
        expect(textWidget.variant, AppTextVariant.bodyLarge);
        expect(textWidget.fontWeight, FontWeight.w500);
      });
    });

    group('Text Alignment', () {
      testWidgets('should use left alignment by default', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppPrice(value: 30000),
            ),
          ),
        );

        final textWidget = tester.widget<AppText>(find.byType(AppText));
        expect(textWidget.textAlign, TextAlign.left);
      });

      testWidgets('should support center alignment', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppPrice(
                value: 30000,
                alignment: TextAlign.center,
              ),
            ),
          ),
        );

        final textWidget = tester.widget<AppText>(find.byType(AppText));
        expect(textWidget.textAlign, TextAlign.center);
      });

      testWidgets('should support right alignment', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppPrice(
                value: 30000,
                alignment: TextAlign.right,
              ),
            ),
          ),
        );

        final textWidget = tester.widget<AppText>(find.byType(AppText));
        expect(textWidget.textAlign, TextAlign.right);
      });

      testWidgets('should apply alignment to discount price structure', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppPrice(
                value: 60000,
                discountedValue: 50000,
                alignment: TextAlign.center,
              ),
            ),
          ),
        );

        final column = tester.widget<Column>(find.byType(Column));
        expect(column.crossAxisAlignment, CrossAxisAlignment.center);

        final textWidgets = tester.widgetList<AppText>(find.byType(AppText));
        for (final textWidget in textWidgets) {
          expect(textWidget.textAlign, TextAlign.center);
        }
      });

      testWidgets('should handle different alignment values correctly', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Column(
                children: const [
                  AppPrice(value: 10000, alignment: TextAlign.start),
                  AppPrice(value: 10000, alignment: TextAlign.end),
                  AppPrice(value: 10000, alignment: TextAlign.justify),
                ],
              ),
            ),
          ),
        );

        final textWidgets = tester.widgetList<AppText>(find.byType(AppText)).toList();
        expect(textWidgets[0].textAlign, TextAlign.start);
        expect(textWidgets[1].textAlign, TextAlign.end);
        expect(textWidgets[2].textAlign, TextAlign.justify);
      });
    });

    group('Theme Integration', () {
      testWidgets('should use correct colors from theme for single price', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            theme: ThemeData.light(),
            home: const Scaffold(
              body: AppPrice(value: 25000),
            ),
          ),
        );

        final theme = ThemeData.light();
        final textWidget = tester.widget<AppText>(find.byType(AppText));
        expect(textWidget.color, theme.colorScheme.onSurface);
      });

      testWidgets('should use primary color for highlighted single price', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            theme: ThemeData.light(),
            home: const Scaffold(
              body: AppPrice(
                value: 25000,
                highlight: true,
              ),
            ),
          ),
        );

        final theme = ThemeData.light();
        final textWidget = tester.widget<AppText>(find.byType(AppText));
        expect(textWidget.color, theme.colorScheme.primary);
      });

      testWidgets('should use correct colors for discount prices', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            theme: ThemeData.light(),
            home: const Scaffold(
              body: AppPrice(
                value: 40000,
                discountedValue: 30000,
              ),
            ),
          ),
        );

        final theme = ThemeData.light();
        final textWidgets = tester.widgetList<AppText>(find.byType(AppText));
        final originalPriceWidget = textWidgets.first;
        final discountedPriceWidget = textWidgets.last;

        expect(originalPriceWidget.color, theme.colorScheme.onSurfaceVariant);
        expect(discountedPriceWidget.color, theme.colorScheme.primary);
      });

      testWidgets('should adapt to custom theme colors', (tester) async {
        const customPrimary = Color(0xFF123456);
        const customOnSurface = Color(0xFF654321);
        const customOnSurfaceVariant = Color(0xFF888888);

        await tester.pumpWidget(
          MaterialApp(
            theme: ThemeData.light().copyWith(
              colorScheme: ColorScheme.light().copyWith(
                primary: customPrimary,
                onSurface: customOnSurface,
                onSurfaceVariant: customOnSurfaceVariant,
              ),
            ),
            home: const Scaffold(
              body: Column(
                children: [
                  AppPrice(value: 10000, highlight: true),
                  AppPrice(value: 20000, discountedValue: 15000),
                ],
              ),
            ),
          ),
        );

        final allTextWidgets = tester.widgetList<AppText>(find.byType(AppText)).toList();
        
        // Highlighted single price should use custom primary
        expect(allTextWidgets[0].color, customPrimary);
        
        // Original discount price should use custom onSurfaceVariant
        expect(allTextWidgets[1].color, customOnSurfaceVariant);
        
        // Discounted price should use custom primary
        expect(allTextWidgets[2].color, customPrimary);
      });

      testWidgets('should work with dark theme', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            theme: ThemeData.dark(),
            home: const Scaffold(
              body: AppPrice(
                value: 35000,
                discountedValue: 28000,
              ),
            ),
          ),
        );

        final darkTheme = ThemeData.dark();
        final textWidgets = tester.widgetList<AppText>(find.byType(AppText));
        final originalPriceWidget = textWidgets.first;
        final discountedPriceWidget = textWidgets.last;

        expect(originalPriceWidget.color, darkTheme.colorScheme.onSurfaceVariant);
        expect(discountedPriceWidget.color, darkTheme.colorScheme.primary);
      });
    });

    group('Edge Cases', () {
      testWidgets('should handle very large price values', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppPrice(value: 999999999),
            ),
          ),
        );

        expect(find.text('\$ 999.999.999'), findsOneWidget);
        expect(find.byType(AppPrice), findsOneWidget);
      });

      testWidgets('should handle decimal values correctly', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: Column(
                children: [
                  AppPrice(value: 1999.99),
                  AppPrice(value: 500.50),
                  AppPrice(value: 100.01),
                ],
              ),
            ),
          ),
        );

        // Verify that prices are displayed (exact format may vary)
        expect(find.byType(AppPrice), findsNWidgets(3));
        expect(find.byType(AppText), findsNWidgets(3));
        
        // Check that formatted text contains expected numbers
        final allText = find.byType(AppText);
        expect(allText, findsNWidgets(3));
      });

      testWidgets('should handle discount same as original price', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppPrice(
                value: 100000,
                discountedValue: 100000,
              ),
            ),
          ),
        );

        expect(find.text('\$ 100.000'), findsNWidgets(2)); // Same price shown twice
        expect(find.byType(AppText), findsNWidgets(2));
        expect(find.byType(Column), findsOneWidget);
      });

      testWidgets('should handle discount higher than original (edge case)', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppPrice(
                value: 80000,
                discountedValue: 100000,
              ),
            ),
          ),
        );

        expect(find.text('\$ 80.000'), findsOneWidget); // Original
        expect(find.text('\$ 100.000'), findsOneWidget); // "Discount"
        expect(find.byType(Column), findsOneWidget);
      });

      testWidgets('should handle empty currency string', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppPrice(
                value: 50000,
                currency: '',
              ),
            ),
          ),
        );

        expect(find.text(' 50.000'), findsOneWidget); // Space but no currency symbol
      });
    });

    group('Design System Integration', () {
      testWidgets('should use AppText atoms exclusively', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppPrice(
                value: 120000,
                discountedValue: 100000,
                highlight: true,
              ),
            ),
          ),
        );

        expect(find.byType(AppText), findsNWidgets(2));
        expect(find.byType(AppPrice), findsOneWidget);
      });

      testWidgets('should compose well with other molecules', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppCard(
                child: Column(
                  children: const [
                    AppText('Product Name', variant: AppTextVariant.titleMedium),
                    SizedBox(height: 8),
                    AppPrice(
                      value: 200000,
                      discountedValue: 150000,
                      highlight: true,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );

        expect(find.byType(AppCard), findsOneWidget);
        expect(find.byType(AppPrice), findsOneWidget);
        expect(find.text('Product Name'), findsOneWidget);
        expect(find.text('\$ 200.000'), findsOneWidget);
        expect(find.text('\$ 150.000'), findsOneWidget);
      });
    });

    group('Accessibility', () {
      testWidgets('should maintain semantic structure for prices', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppPrice(
                value: 75000,
                discountedValue: 60000,
              ),
            ),
          ),
        );

        // Prices should be rendered as separate AppText elements
        final textWidgets = tester.widgetList<AppText>(find.byType(AppText));
        expect(textWidgets, hasLength(2));
        
        // Original price should have line-through for screen readers
        final originalPrice = textWidgets.first;
        expect(originalPrice.decoration, TextDecoration.lineThrough);
      });

      testWidgets('should support semantic properties', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Semantics(
                label: 'Special offer price',
                child: const AppPrice(
                  value: 120000,
                  discountedValue: 90000,
                ),
              ),
            ),
          ),
        );

        expect(find.byType(AppPrice), findsOneWidget);
        
        final semanticWidget = find.byWidgetPredicate((widget) =>
            widget is Semantics && 
            widget.properties.label == 'Special offer price'
        );
        expect(semanticWidget, findsOneWidget);
      });
    });
  });
}