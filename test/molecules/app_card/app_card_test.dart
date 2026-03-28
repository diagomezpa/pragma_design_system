import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pragma_design_system/molecules.dart';
import 'package:pragma_design_system/atoms.dart';

void main() {
  group('AppCard Tests', () {
    group('Basic Rendering', () {
      testWidgets('should render with required child parameter', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppCard(
                child: Text('Test Content'),
              ),
            ),
          ),
        );

        expect(find.byType(AppCard), findsOneWidget);
        expect(find.text('Test Content'), findsOneWidget);
        expect(find.byType(Card), findsOneWidget);
      });

      testWidgets('should render child widget correctly', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppCard(
                child: Column(
                  children: [
                    Icon(Icons.star),
                    Text('Multi Widget Content'),
                  ],
                ),
              ),
            ),
          ),
        );

        expect(find.byIcon(Icons.star), findsOneWidget);
        expect(find.text('Multi Widget Content'), findsOneWidget);
        expect(find.byType(Column), findsOneWidget);
      });

      testWidgets('should render with design system atoms as children', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppCard(
                child: Column(
                  children: [
                    AppText('Card Title', variant: AppTextVariant.titleMedium),
                    AppIcon(Icons.shopping_cart, size: AppIconSize.medium),
                  ],
                ),
              ),
            ),
          ),
        );

        expect(find.byType(AppText), findsOneWidget);
        expect(find.byType(AppIcon), findsOneWidget);
        expect(find.text('Card Title'), findsOneWidget);
        expect(find.byIcon(Icons.shopping_cart), findsOneWidget);
      });
    });

    group('Padding Properties', () {
      testWidgets('should apply default padding of 16.0 on all sides', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppCard(
                child: Text('Padded Content'),
              ),
            ),
          ),
        );

        final container = tester.widget<Container>(
          find.descendant(
            of: find.byType(Card),
            matching: find.byType(Container),
          ),
        );

        expect(container.padding, const EdgeInsets.all(16.0));
      });

      testWidgets('should apply custom padding when provided', (tester) async {
        const customPadding = EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0);
        
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppCard(
                padding: customPadding,
                child: Text('Custom Padded Content'),
              ),
            ),
          ),
        );

        final container = tester.widget<Container>(
          find.descendant(
            of: find.byType(Card),
            matching: find.byType(Container),
          ),
        );

        expect(container.padding, customPadding);
      });

      testWidgets('should apply zero padding when specified', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppCard(
                padding: EdgeInsets.zero,
                child: Text('No Padding Content'),
              ),
            ),
          ),
        );

        final container = tester.widget<Container>(
          find.descendant(
            of: find.byType(Card),
            matching: find.byType(Container),
          ),
        );

        expect(container.padding, EdgeInsets.zero);
      });

      testWidgets('should apply asymmetric padding correctly', (tester) async {
        const asymmetricPadding = EdgeInsets.only(
          left: 8.0,
          right: 16.0,
          top: 12.0,
          bottom: 20.0,
        );
        
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppCard(
                padding: asymmetricPadding,
                child: Text('Asymmetric Padding'),
              ),
            ),
          ),
        );

        final container = tester.widget<Container>(
          find.descendant(
            of: find.byType(Card),
            matching: find.byType(Container),
          ),
        );

        expect(container.padding, asymmetricPadding);
      });
    });

    group('Interactivity', () {
      testWidgets('should not be interactive when onTap is null', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppCard(
                child: Text('Non-interactive Card'),
              ),
            ),
          ),
        );

        // Should not have InkWell or Material for interaction
        expect(find.byType(InkWell), findsNothing);
        // Should only have the base Card widget
        expect(find.byType(Card), findsOneWidget);
      });

      testWidgets('should be interactive when onTap is provided', (tester) async {
        bool tapped = false;
        
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppCard(
                onTap: () => tapped = true,
                child: const Text('Interactive Card'),
              ),
            ),
          ),
        );

        // Should have InkWell for interaction
        expect(find.byType(InkWell), findsOneWidget);
        expect(find.byType(Material), findsWidgets);
        expect(find.byType(Card), findsOneWidget);
        
        // Tap the card
        await tester.tap(find.byType(AppCard));
        await tester.pump();
        
        expect(tapped, isTrue);
      });

      testWidgets('should trigger onTap callback when card is tapped', (tester) async {
        int tapCount = 0;
        
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppCard(
                onTap: () => tapCount++,
                child: const Text('Tappable Card'),
              ),
            ),
          ),
        );

        // Tap multiple times
        await tester.tap(find.byType(AppCard));
        await tester.tap(find.byType(AppCard));
        await tester.tap(find.byType(AppCard));
        await tester.pump();
        
        expect(tapCount, 3);
      });

      testWidgets('should provide proper ripple area when tapped', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppCard(
                onTap: () {},
                child: const Text('Ripple Test'),
              ),
            ),
          ),
        );

        final inkWell = tester.widget<InkWell>(find.byType(InkWell));
        expect(inkWell.borderRadius, BorderRadius.circular(12.0));
      });
    });

    group('Material Design Properties', () {
      testWidgets('should have correct Card shape with 12px border radius', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppCard(
                child: Text('Shaped Card'),
              ),
            ),
          ),
        );

        final card = tester.widget<Card>(find.byType(Card));
        final shape = card.shape as RoundedRectangleBorder;
        expect(shape.borderRadius, BorderRadius.circular(12.0));
      });

      testWidgets('should have zero elevation', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppCard(
                child: Text('Flat Card'),
              ),
            ),
          ),
        );

        final card = tester.widget<Card>(find.byType(Card));
        expect(card.elevation, 0);
      });

      testWidgets('should use Material 3 surface color from theme', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            theme: ThemeData.light().copyWith(
              colorScheme: ColorScheme.light().copyWith(
                surface: const Color(0xFF123456),
                surfaceTint: const Color(0xFF654321),
              ),
            ),
            home: const Scaffold(
              body: AppCard(
                child: Text('Themed Card'),
              ),
            ),
          ),
        );

        final card = tester.widget<Card>(find.byType(Card));
        expect(card.color, const Color(0xFF123456));
        expect(card.surfaceTintColor, const Color(0xFF654321));
      });

      testWidgets('should handle theme changes correctly', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            theme: ThemeData.dark(),
            home: const Scaffold(
              body: AppCard(
                child: Text('Dark Theme Card'),
              ),
            ),
          ),
        );

        final card = tester.widget<Card>(find.byType(Card));
        final theme = ThemeData.dark();
        expect(card.color, theme.colorScheme.surface);
        expect(card.surfaceTintColor, theme.colorScheme.surfaceTint);
      });
    });

    group('Layout and Composition', () {
      testWidgets('should compose well with other molecules', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppCard(
                child: Column(
                  children: [
                    AppText('Title', variant: AppTextVariant.titleLarge),
                    AppSpacer(size: AppSpacerSize.medium),
                    AppText('Description', variant: AppTextVariant.bodyMedium),
                  ],
                ),
              ),
            ),
          ),
        );

        expect(find.byType(AppCard), findsOneWidget);
        expect(find.byType(AppText), findsNWidgets(2));
        expect(find.byType(AppSpacer), findsOneWidget);
        expect(find.text('Title'), findsOneWidget);
        expect(find.text('Description'), findsOneWidget);
      });

      testWidgets('should maintain child widget layout', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppCard(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Left'),
                    Text('Right'),
                  ],
                ),
              ),
            ),
          ),
        );

        final row = tester.widget<Row>(find.byType(Row));
        expect(row.mainAxisAlignment, MainAxisAlignment.spaceBetween);
        expect(find.text('Left'), findsOneWidget);
        expect(find.text('Right'), findsOneWidget);
      });

      testWidgets('should handle empty child widgets', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppCard(
                child: SizedBox.shrink(),
              ),
            ),
          ),
        );

        expect(find.byType(AppCard), findsOneWidget);
        expect(find.byType(SizedBox), findsOneWidget);
      });
    });

    group('Edge Cases', () {
      testWidgets('should handle very large padding values', (tester) async {
        const largePadding = EdgeInsets.all(100.0);
        
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppCard(
                padding: largePadding,
                child: Text('Large Padding'),
              ),
            ),
          ),
        );

        final container = tester.widget<Container>(
          find.descendant(
            of: find.byType(Card),
            matching: find.byType(Container),
          ),
        );

        expect(container.padding, largePadding);
        expect(find.text('Large Padding'), findsOneWidget);
      });

      testWidgets('should handle complex nested widget structures', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppCard(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Icon(Icons.star),
                        Expanded(
                          child: Column(
                            children: [
                              Text('Nested Title'),
                              Text('Nested Subtitle'),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Divider(),
                    Text('Bottom Content'),
                  ],
                ),
              ),
            ),
          ),
        );

        expect(find.byType(AppCard), findsOneWidget);
        expect(find.byIcon(Icons.star), findsOneWidget);
        expect(find.text('Nested Title'), findsOneWidget);
        expect(find.text('Nested Subtitle'), findsOneWidget);
        expect(find.text('Bottom Content'), findsOneWidget);
        expect(find.byType(Divider), findsOneWidget);
      });

      testWidgets('should handle null onTap callback gracefully', (tester) async {
        // Explicitly set onTap to null
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppCard(
                onTap: null,
                child: Text('Null Callback'),
              ),
            ),
          ),
        );

        expect(find.byType(AppCard), findsOneWidget);
        expect(find.byType(InkWell), findsNothing);
        expect(find.text('Null Callback'), findsOneWidget);
      });
    });

    group('Accessibility and Semantics', () {
      testWidgets('should support semantic labels from child widgets', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppCard(
                child: Semantics(
                  label: 'Product Card',
                  child: const Text('Product Name'),
                ),
              ),
            ),
          ),
        );

        expect(find.byType(AppCard), findsOneWidget);
        expect(find.text('Product Name'), findsOneWidget);
        
        // Find the specific Semantics widget with our label
        final labeledSemantics = find.byWidgetPredicate((widget) =>
            widget is Semantics && 
            widget.properties.label == 'Product Card'
        );
        expect(labeledSemantics, findsOneWidget);
      });

      testWidgets('should be focusable when interactive', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppCard(
                onTap: () {},
                child: const Text('Focusable Card'),
              ),
            ),
          ),
        );

        final inkWell = tester.widget<InkWell>(find.byType(InkWell));
        expect(inkWell.focusNode, isNull); // Default focus behavior
        expect(inkWell.autofocus, isFalse);
      });
    });
  });
}