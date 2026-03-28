import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pragma_design_system/atoms.dart';

void main() {
  group('AppButton Widget Tests', () {
    bool wasPressed = false;
    void onPressed() {
      wasPressed = true;
    }

    setUp(() {
      wasPressed = false;
    });

    testWidgets('should render AppButton with correct text', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppButton(
              text: 'Click Me',
              onPressed: onPressed,
            ),
          ),
        ),
      );

      expect(find.text('Click Me'), findsOneWidget);
      expect(find.byType(ElevatedButton), findsOneWidget);
    });

    testWidgets('should call onPressed when tapped', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppButton(
              text: 'Press Me',
              onPressed: onPressed,
            ),
          ),
        ),
      );

      await tester.tap(find.byType(AppButton));
      expect(wasPressed, true);
    });

    testWidgets('should use primary variant as default', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppButton(
              text: 'Primary Button',
              onPressed: onPressed,
            ),
          ),
        ),
      );

      final elevatedButton = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
      expect(elevatedButton.style?.backgroundColor?.resolve({}), isNotNull);
      expect(find.text('Primary Button'), findsOneWidget);
    });

    testWidgets('should use medium size as default', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppButton(
              text: 'Medium Button',
              onPressed: onPressed,
            ),
          ),
        ),
      );

      expect(find.text('Medium Button'), findsOneWidget);
      expect(find.byType(ElevatedButton), findsOneWidget);
    });

    group('Button Variants', () {
      testWidgets('should render primary variant correctly', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppButton(
                text: 'Primary',
                variant: AppButtonVariant.primary,
                onPressed: onPressed,
              ),
            ),
          ),
        );

        expect(find.text('Primary'), findsOneWidget);
        expect(find.byType(ElevatedButton), findsOneWidget);
        expect(find.byType(OutlinedButton), findsNothing);
        expect(find.byType(TextButton), findsNothing);
      });

      testWidgets('should render secondary variant correctly', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppButton(
                text: 'Secondary',
                variant: AppButtonVariant.secondary,
                onPressed: onPressed,
              ),
            ),
          ),
        );

        expect(find.text('Secondary'), findsOneWidget);
        expect(find.byType(ElevatedButton), findsOneWidget);
      });

      testWidgets('should render outline variant correctly', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppButton(
                text: 'Outline',
                variant: AppButtonVariant.outline,
                onPressed: onPressed,
              ),
            ),
          ),
        );

        expect(find.text('Outline'), findsOneWidget);
        expect(find.byType(ElevatedButton), findsOneWidget);
      });

      testWidgets('should render text variant correctly', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppButton(
                text: 'Text Button',
                variant: AppButtonVariant.text,
                onPressed: onPressed,
              ),
            ),
          ),
        );

        expect(find.text('Text Button'), findsOneWidget);
        expect(find.byType(ElevatedButton), findsOneWidget);
      });
    });

    group('Button Sizes', () {
      testWidgets('should render extraSmall size correctly', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppButton(
                text: 'Extra Small',
                size: AppButtonSize.extraSmall,
                onPressed: onPressed,
              ),
            ),
          ),
        );

        expect(find.text('Extra Small'), findsOneWidget);
        final text = tester.widget<Text>(find.text('Extra Small'));
        expect(text.style?.fontSize, 10);
      });

      testWidgets('should render small size correctly', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppButton(
                text: 'Small',
                size: AppButtonSize.small,
                onPressed: onPressed,
              ),
            ),
          ),
        );

        expect(find.text('Small'), findsOneWidget);
        final text = tester.widget<Text>(find.text('Small'));
        expect(text.style?.fontSize, 12);
      });

      testWidgets('should render medium size correctly', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppButton(
                text: 'Medium',
                size: AppButtonSize.medium,
                onPressed: onPressed,
              ),
            ),
          ),
        );

        expect(find.text('Medium'), findsOneWidget);
        final text = tester.widget<Text>(find.text('Medium'));
        expect(text.style?.fontSize, 14);
      });

      testWidgets('should render large size correctly', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppButton(
                text: 'Large',
                size: AppButtonSize.large,
                onPressed: onPressed,
              ),
            ),
          ),
        );

        expect(find.text('Large'), findsOneWidget);
        final text = tester.widget<Text>(find.text('Large'));
        expect(text.style?.fontSize, 16);
      });
    });

    group('Variant and Size Combinations', () {
      testWidgets('should handle primary + large combination', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppButton(
                text: 'Primary Large',
                variant: AppButtonVariant.primary,
                size: AppButtonSize.large,
                onPressed: onPressed,
              ),
            ),
          ),
        );

        expect(find.text('Primary Large'), findsOneWidget);
        expect(find.byType(ElevatedButton), findsOneWidget);
        final text = tester.widget<Text>(find.text('Primary Large'));
        expect(text.style?.fontSize, 16);
      });

      testWidgets('should handle outline + small combination', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppButton(
                text: 'Outline Small',
                variant: AppButtonVariant.outline,
                size: AppButtonSize.small,
                onPressed: onPressed,
              ),
            ),
          ),
        );

        expect(find.text('Outline Small'), findsOneWidget);
        final text = tester.widget<Text>(find.text('Outline Small'));
        expect(text.style?.fontSize, 12);
      });

      testWidgets('should handle text + extraSmall combination', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppButton(
                text: 'Text XS',
                variant: AppButtonVariant.text,
                size: AppButtonSize.extraSmall,
                onPressed: onPressed,
              ),
            ),
          ),
        );

        expect(find.text('Text XS'), findsOneWidget);
        final text = tester.widget<Text>(find.text('Text XS'));
        expect(text.style?.fontSize, 10);
      });
    });

    group('Button States', () {
      testWidgets('should be disabled when onPressed is null', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppButton(
                text: 'Disabled',
                onPressed: null,
              ),
            ),
          ),
        );

        final elevatedButton = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
        expect(elevatedButton.onPressed, null);
        expect(find.text('Disabled'), findsOneWidget);
      });

      testWidgets('should be disabled when isEnabled is false', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppButton(
                text: 'Disabled',
                onPressed: onPressed,
                isEnabled: false,
              ),
            ),
          ),
        );

        final elevatedButton = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
        expect(elevatedButton.onPressed, null);
        
        // Should not call onPressed when tapped while disabled
        await tester.tap(find.byType(AppButton));
        expect(wasPressed, false);
      });

      testWidgets('should show loading spinner when isLoading is true', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppButton(
                text: 'Loading',
                onPressed: onPressed,
                isLoading: true,
              ),
            ),
          ),
        );

        expect(find.byType(CircularProgressIndicator), findsOneWidget);
        expect(find.text('Loading'), findsNothing);

        // Button should be disabled when loading
        final elevatedButton = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
        expect(elevatedButton.onPressed, null);
      });

      testWidgets('should be disabled and show spinner when loading', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppButton(
                text: 'Loading Button',
                onPressed: onPressed,
                isLoading: true,
              ),
            ),
          ),
        );

        expect(find.byType(CircularProgressIndicator), findsOneWidget);
        
        // Should not call onPressed when loading
        await tester.tap(find.byType(AppButton));
        expect(wasPressed, false);
      });
    });

    group('Button with Icon', () {
      testWidgets('should render text with icon correctly', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppButton(
                text: 'Save',
                icon: Icons.save,
                onPressed: onPressed,
              ),
            ),
          ),
        );

        expect(find.text('Save'), findsOneWidget);
        expect(find.byIcon(Icons.save), findsOneWidget);
        expect(find.byType(Row), findsOneWidget);
      });

      testWidgets('should render only icon for extraSmall size', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppButton(
                text: 'Icon Only',
                icon: Icons.add,
                size: AppButtonSize.extraSmall,
                onPressed: onPressed,
              ),
            ),
          ),
        );

        expect(find.byIcon(Icons.add), findsOneWidget);
        expect(find.text('Icon Only'), findsNothing);
      });

      testWidgets('should render icon with different sizes', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Column(
                children: [
                  AppButton(
                    text: 'Small',
                    icon: Icons.star,
                    size: AppButtonSize.small,
                    onPressed: onPressed,
                  ),
                  AppButton(
                    text: 'Large',
                    icon: Icons.star,
                    size: AppButtonSize.large,
                    onPressed: onPressed,
                  ),
                ],
              ),
            ),
          ),
        );

        expect(find.byIcon(Icons.star), findsNWidgets(2));
        expect(find.text('Small'), findsOneWidget);
        expect(find.text('Large'), findsOneWidget);
      });

      testWidgets('should show loading spinner instead of icon when loading', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppButton(
                text: 'Save',
                icon: Icons.save,
                isLoading: true,
                onPressed: onPressed,
              ),
            ),
          ),
        );

        expect(find.byType(CircularProgressIndicator), findsOneWidget);
        expect(find.byIcon(Icons.save), findsNothing);
        expect(find.text('Save'), findsNothing);
      });
    });

    group('Edge Cases', () {
      testWidgets('should handle empty text string', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppButton(
                text: '',
                onPressed: onPressed,
              ),
            ),
          ),
        );

        expect(find.text(''), findsOneWidget);
        expect(find.byType(ElevatedButton), findsOneWidget);
      });

      testWidgets('should handle very long text', (tester) async {
        const longText = 'This is a very long button text that might overflow';
        
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppButton(
                text: longText,
                onPressed: onPressed,
              ),
            ),
          ),
        );

        expect(find.text(longText), findsOneWidget);
      });

      testWidgets('should handle all combinations of disabled states', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppButton(
                text: 'Multi Disabled',
                onPressed: null, // null onPressed
                isEnabled: false, // explicitly disabled
                isLoading: true, // also loading
              ),
            ),
          ),
        );

        expect(find.byType(CircularProgressIndicator), findsOneWidget);
        final elevatedButton = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
        expect(elevatedButton.onPressed, null);
      });

      testWidgets('should handle enabled button with all features', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppButton(
                text: 'Complete Button',
                variant: AppButtonVariant.secondary,
                size: AppButtonSize.large,
                icon: Icons.check,
                isEnabled: true,
                isLoading: false,
                onPressed: onPressed,
              ),
            ),
          ),
        );

        expect(find.text('Complete Button'), findsOneWidget);
        expect(find.byIcon(Icons.check), findsOneWidget);
        expect(find.byType(Row), findsOneWidget);
        
        await tester.tap(find.byType(AppButton));
        expect(wasPressed, true);
      });
    });
  });
}