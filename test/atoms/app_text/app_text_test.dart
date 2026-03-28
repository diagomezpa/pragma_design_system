import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pragma_design_system/atoms.dart';

void main() {
  group('AppText Widget Tests', () {
    testWidgets('should render AppText with correct text', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppText('Hello World'),
          ),
        ),
      );

      expect(find.text('Hello World'), findsOneWidget);
    });

    testWidgets('should use bodyLarge variant as default', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppText('Default Text'),
          ),
        ),
      );

      final textWidget = tester.widget<Text>(find.byType(Text));
      expect(textWidget.style?.fontSize, 16); // bodyLarge default fontSize
    });

    group('Text Variants', () {
      testWidgets('should render headlineLarge variant correctly', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppText(
                'Headline Large',
                variant: AppTextVariant.headlineLarge,
              ),
            ),
          ),
        );

        expect(find.text('Headline Large'), findsOneWidget);
        final textWidget = tester.widget<Text>(find.byType(Text));
        expect(textWidget.style?.fontSize, 32); // headlineLarge fontSize
      });

      testWidgets('should render headlineMedium variant correctly', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppText(
                'Headline Medium',
                variant: AppTextVariant.headlineMedium,
              ),
            ),
          ),
        );

        expect(find.text('Headline Medium'), findsOneWidget);
        final textWidget = tester.widget<Text>(find.byType(Text));
        expect(textWidget.style?.fontSize, 28); // headlineMedium fontSize
      });

      testWidgets('should render headlineSmall variant correctly', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppText(
                'Headline Small',
                variant: AppTextVariant.headlineSmall,
              ),
            ),
          ),
        );

        expect(find.text('Headline Small'), findsOneWidget);
        final textWidget = tester.widget<Text>(find.byType(Text));
        expect(textWidget.style?.fontSize, 24); // headlineSmall fontSize
      });

      testWidgets('should render titleLarge variant correctly', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppText(
                'Title Large',
                variant: AppTextVariant.titleLarge,
              ),
            ),
          ),
        );

        expect(find.text('Title Large'), findsOneWidget);
        final textWidget = tester.widget<Text>(find.byType(Text));
        expect(textWidget.style?.fontSize, 22); // titleLarge fontSize
      });

      testWidgets('should render titleMedium variant correctly', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppText(
                'Title Medium',
                variant: AppTextVariant.titleMedium,
              ),
            ),
          ),
        );

        expect(find.text('Title Medium'), findsOneWidget);
        final textWidget = tester.widget<Text>(find.byType(Text));
        expect(textWidget.style?.fontSize, 16); // titleMedium fontSize
      });

      testWidgets('should render titleSmall variant correctly', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppText(
                'Title Small',
                variant: AppTextVariant.titleSmall,
              ),
            ),
          ),
        );

        expect(find.text('Title Small'), findsOneWidget);
        final textWidget = tester.widget<Text>(find.byType(Text));
        expect(textWidget.style?.fontSize, 14); // titleSmall fontSize
      });

      testWidgets('should render bodyLarge variant correctly', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppText(
                'Body Large',
                variant: AppTextVariant.bodyLarge,
              ),
            ),
          ),
        );

        expect(find.text('Body Large'), findsOneWidget);
        final textWidget = tester.widget<Text>(find.byType(Text));
        expect(textWidget.style?.fontSize, 16); // bodyLarge fontSize
      });

      testWidgets('should render bodyMedium variant correctly', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppText(
                'Body Medium',
                variant: AppTextVariant.bodyMedium,
              ),
            ),
          ),
        );

        expect(find.text('Body Medium'), findsOneWidget);
        final textWidget = tester.widget<Text>(find.byType(Text));
        expect(textWidget.style?.fontSize, 14); // bodyMedium fontSize
      });

      testWidgets('should render bodySmall variant correctly', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppText(
                'Body Small',
                variant: AppTextVariant.bodySmall,
              ),
            ),
          ),
        );

        expect(find.text('Body Small'), findsOneWidget);
        final textWidget = tester.widget<Text>(find.byType(Text));
        expect(textWidget.style?.fontSize, 12); // bodySmall fontSize
      });

      testWidgets('should render labelLarge variant correctly', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppText(
                'Label Large',
                variant: AppTextVariant.labelLarge,
              ),
            ),
          ),
        );

        expect(find.text('Label Large'), findsOneWidget);
        final textWidget = tester.widget<Text>(find.byType(Text));
        expect(textWidget.style?.fontSize, 14); // labelLarge fontSize
      });
    });

    group('Style Overrides', () {
      testWidgets('should apply custom color override', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppText(
                'Colored Text',
                color: Colors.red,
              ),
            ),
          ),
        );

        final textWidget = tester.widget<Text>(find.byType(Text));
        expect(textWidget.style?.color, Colors.red);
      });

      testWidgets('should apply custom fontWeight override', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppText(
                'Bold Text',
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );

        final textWidget = tester.widget<Text>(find.byType(Text));
        expect(textWidget.style?.fontWeight, FontWeight.bold);
      });

      testWidgets('should apply custom decoration override', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppText(
                'Underlined Text',
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        );

        final textWidget = tester.widget<Text>(find.byType(Text));
        expect(textWidget.style?.decoration, TextDecoration.underline);
      });

      testWidgets('should combine variant with style overrides', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppText(
                'Combined Style',
                variant: AppTextVariant.titleLarge,
                color: Colors.blue,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        );

        final textWidget = tester.widget<Text>(find.byType(Text));
        expect(textWidget.style?.fontSize, 22); // titleLarge fontSize
        expect(textWidget.style?.color, Colors.blue);
        expect(textWidget.style?.fontWeight, FontWeight.w600);
      });
    });

    group('Text Properties', () {
      testWidgets('should apply textAlign property', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppText(
                'Centered Text',
                textAlign: TextAlign.center,
              ),
            ),
          ),
        );

        final textWidget = tester.widget<Text>(find.byType(Text));
        expect(textWidget.textAlign, TextAlign.center);
      });

      testWidgets('should apply maxLines property', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppText(
                'Text with max lines',
                maxLines: 2,
              ),
            ),
          ),
        );

        final textWidget = tester.widget<Text>(find.byType(Text));
        expect(textWidget.maxLines, 2);
      });

      testWidgets('should apply overflow property', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppText(
                'Text with overflow ellipsis',
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        );

        final textWidget = tester.widget<Text>(find.byType(Text));
        expect(textWidget.overflow, TextOverflow.ellipsis);
      });

      testWidgets('should combine all text properties', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppText(
                'Complete properties test',
                variant: AppTextVariant.bodyMedium,
                color: Colors.green,
                textAlign: TextAlign.right,
                maxLines: 3,
                overflow: TextOverflow.fade,
                fontWeight: FontWeight.w500,
                decoration: TextDecoration.lineThrough,
              ),
            ),
          ),
        );

        final textWidget = tester.widget<Text>(find.byType(Text));
        expect(find.text('Complete properties test'), findsOneWidget);
        expect(textWidget.textAlign, TextAlign.right);
        expect(textWidget.maxLines, 3);
        expect(textWidget.overflow, TextOverflow.fade);
        expect(textWidget.style?.color, Colors.green);
        expect(textWidget.style?.fontWeight, FontWeight.w500);
        expect(textWidget.style?.decoration, TextDecoration.lineThrough);
      });
    });

    group('Edge Cases', () {
      testWidgets('should handle empty text string', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppText(''),
            ),
          ),
        );

        expect(find.text(''), findsOneWidget);
        expect(find.byType(Text), findsOneWidget);
      });

      testWidgets('should handle very long text', (tester) async {
        const longText = 'This is a very long text that might wrap to multiple lines depending on the screen size and layout constraints of the widget tree.';
        
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppText(longText),
            ),
          ),
        );

        expect(find.text(longText), findsOneWidget);
        expect(find.byType(Text), findsOneWidget);
      });

      testWidgets('should handle special characters', (tester) async {
        const specialText = 'Special chars: áéíóú ñ ¿? ¡! @#\$%^&*()';
        
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppText(specialText),
            ),
          ),
        );

        expect(find.text(specialText), findsOneWidget);
      });
    });
  });
}