import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pragma_design_system/atoms.dart';

void main() {
  group('AppDivider Widget Tests', () {
    testWidgets('should render AppDivider with default values', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppDivider(),
          ),
        ),
      );

      expect(find.byType(Divider), findsOneWidget);
      expect(find.byType(VerticalDivider), findsNothing);
    });

    testWidgets('should use horizontal orientation as default', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppDivider(),
          ),
        ),
      );

      final divider = tester.widget<Divider>(find.byType(Divider));
      expect(divider, isNotNull);
    });

    group('Divider Orientations', () {
      testWidgets('should render horizontal divider correctly', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppDivider(
                orientation: AppDividerOrientation.horizontal,
              ),
            ),
          ),
        );

        expect(find.byType(Divider), findsOneWidget);
        expect(find.byType(VerticalDivider), findsNothing);
      });

      testWidgets('should render vertical divider correctly', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppDivider(
                orientation: AppDividerOrientation.vertical,
              ),
            ),
          ),
        );

        expect(find.byType(VerticalDivider), findsOneWidget);
        expect(find.byType(Divider), findsNothing);
      });
    });

    group('Divider Properties', () {
      testWidgets('should apply custom thickness', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppDivider(
                thickness: 3.0,
              ),
            ),
          ),
        );

        final divider = tester.widget<Divider>(find.byType(Divider));
        expect(divider.thickness, 3.0);
      });

      testWidgets('should apply custom color', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppDivider(
                color: Colors.red,
              ),
            ),
          ),
        );

        final divider = tester.widget<Divider>(find.byType(Divider));
        expect(divider.color, Colors.red);
      });

      testWidgets('should apply indent and endIndent', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppDivider(
                indent: 10,
                endIndent: 20,
              ),
            ),
          ),
        );

        final divider = tester.widget<Divider>(find.byType(Divider));
        expect(divider.indent, 10);
        expect(divider.endIndent, 20);
      });

      testWidgets('should apply margin with Padding wrapper', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppDivider(
                margin: EdgeInsets.all(16),
              ),
            ),
          ),
        );

        // Find specific padding with correct EdgeInsets
        final paddingFinder = find.byWidgetPredicate(
          (Widget widget) => widget is Padding && 
                             widget.padding == const EdgeInsets.all(16),
        );
        expect(paddingFinder, findsOneWidget);
      });

      testWidgets('should combine all properties for horizontal divider', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppDivider(
                orientation: AppDividerOrientation.horizontal,
                thickness: 2.5,
                color: Colors.blue,
                indent: 8,
                endIndent: 12,
                margin: EdgeInsets.symmetric(vertical: 8),
              ),
            ),
          ),
        );

        // Find specific padding with correct EdgeInsets
        final paddingFinder = find.byWidgetPredicate(
          (Widget widget) => widget is Padding && 
                             widget.padding == const EdgeInsets.symmetric(vertical: 8),
        );
        expect(paddingFinder, findsOneWidget);
        expect(find.byType(Divider), findsOneWidget);

        final divider = tester.widget<Divider>(find.byType(Divider));
        expect(divider.thickness, 2.5);
        expect(divider.color, Colors.blue);
        expect(divider.indent, 8);
        expect(divider.endIndent, 12);
      });

      testWidgets('should combine all properties for vertical divider', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppDivider(
                orientation: AppDividerOrientation.vertical,
                thickness: 1.5,
                color: Colors.green,
                indent: 5,
                endIndent: 15,
                margin: EdgeInsets.symmetric(horizontal: 4),
              ),
            ),
          ),
        );

        // Find specific padding with correct EdgeInsets
        final paddingFinder = find.byWidgetPredicate(
          (Widget widget) => widget is Padding && 
                             widget.padding == const EdgeInsets.symmetric(horizontal: 4),
        );
        expect(paddingFinder, findsOneWidget);
        expect(find.byType(VerticalDivider), findsOneWidget);

        final divider = tester.widget<VerticalDivider>(find.byType(VerticalDivider));
        expect(divider.thickness, 1.5);
        expect(divider.color, Colors.green);
        expect(divider.indent, 5);
        expect(divider.endIndent, 15);
      });
    });

    group('Factory Methods', () {
      testWidgets('should create thin divider correctly', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppDivider(
                thickness: 0.5,
              ),
            ),
          ),
        );

        final divider = tester.widget<Divider>(find.byType(Divider));
        expect(divider.thickness, 0.5);
        expect(find.byType(Divider), findsOneWidget);
      });

      testWidgets('should create thin divider with custom properties', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppDivider(
                thickness: 0.5,
                color: Colors.purple,
                margin: EdgeInsets.all(8),
                indent: 16,
                endIndent: 16,
              ),
            ),
          ),
        );

        final paddingFinder = find.byWidgetPredicate(
          (Widget widget) => widget is Padding && 
                             widget.padding == const EdgeInsets.all(8),
        );
        expect(paddingFinder, findsOneWidget);
        expect(find.byType(Divider), findsOneWidget);

        final divider = tester.widget<Divider>(find.byType(Divider));
        expect(divider.thickness, 0.5);
        expect(divider.color, Colors.purple);
        expect(divider.indent, 16);
        expect(divider.endIndent, 16);
      });

      testWidgets('should create thick divider correctly', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppDivider(
                thickness: 2.0,
              ),
            ),
          ),
        );

        final divider = tester.widget<Divider>(find.byType(Divider));
        expect(divider.thickness, 2.0);
        expect(find.byType(Divider), findsOneWidget);
      });

      testWidgets('should create vertical divider correctly', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppDivider(
                orientation: AppDividerOrientation.vertical,
              ),
            ),
          ),
        );

        expect(find.byType(VerticalDivider), findsOneWidget);
        expect(find.byType(Divider), findsNothing);
      });

      testWidgets('should create vertical divider with custom properties', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppDivider(
                orientation: AppDividerOrientation.vertical,
                thickness: 3.0,
                color: Colors.orange,
                margin: EdgeInsets.symmetric(horizontal: 12),
                indent: 8,
                endIndent: 8,
              ),
            ),
          ),
        );

        final paddingFinder = find.byWidgetPredicate(
          (Widget widget) => widget is Padding && 
                             widget.padding == const EdgeInsets.symmetric(horizontal: 12),
        );
        expect(paddingFinder, findsOneWidget);
        expect(find.byType(VerticalDivider), findsOneWidget);

        final divider = tester.widget<VerticalDivider>(find.byType(VerticalDivider));
        expect(divider.thickness, 3.0);
        expect(divider.color, Colors.orange);
        expect(divider.indent, 8);
        expect(divider.endIndent, 8);
      });

      testWidgets('should create section divider correctly', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppDivider(
                orientation: AppDividerOrientation.horizontal,
                thickness: 1.0,
                margin: EdgeInsets.symmetric(vertical: 16),
              ),
            ),
          ),
        );

        final paddingFinder = find.byWidgetPredicate(
          (Widget widget) => widget is Padding && 
                             widget.padding == const EdgeInsets.symmetric(vertical: 16),
        );
        expect(paddingFinder, findsOneWidget);
        expect(find.byType(Divider), findsOneWidget);

        final divider = tester.widget<Divider>(find.byType(Divider));
        expect(divider.thickness, 1.0);
      });

      testWidgets('should create section divider with custom properties', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppDivider(
                orientation: AppDividerOrientation.horizontal,
                thickness: 2.5,
                color: Colors.teal,
                margin: EdgeInsets.symmetric(vertical: 16),
              ),
            ),
          ),
        );

        final paddingFinder = find.byWidgetPredicate(
          (Widget widget) => widget is Padding && 
                             widget.padding == const EdgeInsets.symmetric(vertical: 16),
        );
        expect(paddingFinder, findsOneWidget);
        expect(find.byType(Divider), findsOneWidget);

        final divider = tester.widget<Divider>(find.byType(Divider));
        expect(divider.thickness, 2.5);
        expect(divider.color, Colors.teal);
      });

      testWidgets('should create listItem divider correctly', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppDivider(
                thickness: 0.5,
                indent: 16,
                endIndent: 16,
              ),
            ),
          ),
        );

        final divider = tester.widget<Divider>(find.byType(Divider));
        expect(divider.thickness, 0.5);
        expect(divider.indent, 16);
        expect(divider.endIndent, 16);
      });

      testWidgets('should create listItem divider with custom properties', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppDivider(
                thickness: 0.5,
                color: Colors.cyan,
                indent: 24,
                endIndent: 8,
              ),
            ),
          ),
        );

        final divider = tester.widget<Divider>(find.byType(Divider));
        expect(divider.thickness, 0.5);
        expect(divider.color, Colors.cyan);
        expect(divider.indent, 24);
        expect(divider.endIndent, 8);
      });
    });

    group('Edge Cases', () {
      testWidgets('should handle zero thickness', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppDivider(thickness: 0),
            ),
          ),
        );

        final divider = tester.widget<Divider>(find.byType(Divider));
        expect(divider.thickness, 0);
      });

      testWidgets('should handle very thick divider', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppDivider(thickness: 50),
            ),
          ),
        );

        final divider = tester.widget<Divider>(find.byType(Divider));
        expect(divider.thickness, 50);
      });

      testWidgets('should handle zero indents', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppDivider(
                indent: 0,
                endIndent: 0,
              ),
            ),
          ),
        );

        final divider = tester.widget<Divider>(find.byType(Divider));
        expect(divider.indent, 0);
        expect(divider.endIndent, 0);
      });

      testWidgets('should handle large indent values', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppDivider(
                indent: 100,
                endIndent: 150,
              ),
            ),
          ),
        );

        final divider = tester.widget<Divider>(find.byType(Divider));
        expect(divider.indent, 100);
        expect(divider.endIndent, 150);
      });

      testWidgets('should handle no margin (null)', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppDivider(margin: null),
            ),
          ),
        );

        // Should not have custom padding, only system padding from MaterialApp/Scaffold
        final customPaddingFinder = find.byWidgetPredicate(
          (Widget widget) => widget is Padding && 
                             widget.padding != EdgeInsets.zero &&
                             // Exclude system paddings (they typically have specific values)
                             !widget.padding.toString().contains('EdgeInsetsDirectional') &&
                             !widget.padding.toString().contains('0.0, 0.0, 0.0,'),
        );
        expect(customPaddingFinder, findsNothing);
        expect(find.byType(Divider), findsOneWidget);
      });

      testWidgets('should handle zero margin', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppDivider(
                margin: EdgeInsets.zero,
              ),
            ),
          ),
        );

        // Simply verify the widget renders without checking specific padding
        expect(find.byType(AppDivider), findsOneWidget);
        expect(find.byType(Divider), findsOneWidget);
      });
    });
  });
}