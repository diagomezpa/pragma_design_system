import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pragma_design_system/atoms.dart';

void main() {
  group('AppSpacer Widget Tests', () {
    testWidgets('should render AppSpacer with default values', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppSpacer(),
          ),
        ),
      );

      final sizedBox = tester.widget<SizedBox>(find.byType(SizedBox));
      expect(sizedBox.height, 16.0); // medium size = 16px
      expect(sizedBox.width, isNull); // vertical direction = no width constraint
    });

    testWidgets('should use medium size as default', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppSpacer(),
          ),
        ),
      );

      final sizedBox = tester.widget<SizedBox>(find.byType(SizedBox));
      expect(sizedBox.height, 16.0); // medium = 16px
    });

    testWidgets('should use vertical direction as default', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppSpacer(),
          ),
        ),
      );

      final sizedBox = tester.widget<SizedBox>(find.byType(SizedBox));
      expect(sizedBox.height, isNotNull);
      expect(sizedBox.width, isNull);
    });

    group('Spacer Sizes - Vertical', () {
      testWidgets('should render extraSmall vertical spacer correctly', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppSpacer(
                size: AppSpacerSize.extraSmall,
                direction: AppSpacerDirection.vertical,
              ),
            ),
          ),
        );

        final sizedBox = tester.widget<SizedBox>(find.byType(SizedBox));
        expect(sizedBox.height, 4.0);
        expect(sizedBox.width, isNull);
      });

      testWidgets('should render small vertical spacer correctly', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppSpacer(
                size: AppSpacerSize.small,
                direction: AppSpacerDirection.vertical,
              ),
            ),
          ),
        );

        final sizedBox = tester.widget<SizedBox>(find.byType(SizedBox));
        expect(sizedBox.height, 8.0);
        expect(sizedBox.width, isNull);
      });

      testWidgets('should render medium vertical spacer correctly', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppSpacer(
                size: AppSpacerSize.medium,
                direction: AppSpacerDirection.vertical,
              ),
            ),
          ),
        );

        final sizedBox = tester.widget<SizedBox>(find.byType(SizedBox));
        expect(sizedBox.height, 16.0);
        expect(sizedBox.width, isNull);
      });

      testWidgets('should render large vertical spacer correctly', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppSpacer(
                size: AppSpacerSize.large,
                direction: AppSpacerDirection.vertical,
              ),
            ),
          ),
        );

        final sizedBox = tester.widget<SizedBox>(find.byType(SizedBox));
        expect(sizedBox.height, 24.0);
        expect(sizedBox.width, isNull);
      });

      testWidgets('should render extraLarge vertical spacer correctly', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppSpacer(
                size: AppSpacerSize.extraLarge,
                direction: AppSpacerDirection.vertical,
              ),
            ),
          ),
        );

        final sizedBox = tester.widget<SizedBox>(find.byType(SizedBox));
        expect(sizedBox.height, 32.0);
        expect(sizedBox.width, isNull);
      });

      testWidgets('should render huge vertical spacer correctly', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppSpacer(
                size: AppSpacerSize.huge,
                direction: AppSpacerDirection.vertical,
              ),
            ),
          ),
        );

        final sizedBox = tester.widget<SizedBox>(find.byType(SizedBox));
        expect(sizedBox.height, 48.0);
        expect(sizedBox.width, isNull);
      });
    });

    group('Spacer Sizes - Horizontal', () {
      testWidgets('should render extraSmall horizontal spacer correctly', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppSpacer(
                size: AppSpacerSize.extraSmall,
                direction: AppSpacerDirection.horizontal,
              ),
            ),
          ),
        );

        final sizedBox = tester.widget<SizedBox>(find.byType(SizedBox));
        expect(sizedBox.width, 4.0);
        expect(sizedBox.height, isNull);
      });

      testWidgets('should render small horizontal spacer correctly', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppSpacer(
                size: AppSpacerSize.small,
                direction: AppSpacerDirection.horizontal,
              ),
            ),
          ),
        );

        final sizedBox = tester.widget<SizedBox>(find.byType(SizedBox));
        expect(sizedBox.width, 8.0);
        expect(sizedBox.height, isNull);
      });

      testWidgets('should render medium horizontal spacer correctly', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppSpacer(
                size: AppSpacerSize.medium,
                direction: AppSpacerDirection.horizontal,
              ),
            ),
          ),
        );

        final sizedBox = tester.widget<SizedBox>(find.byType(SizedBox));
        expect(sizedBox.width, 16.0);
        expect(sizedBox.height, isNull);
      });

      testWidgets('should render large horizontal spacer correctly', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppSpacer(
                size: AppSpacerSize.large,
                direction: AppSpacerDirection.horizontal,
              ),
            ),
          ),
        );

        final sizedBox = tester.widget<SizedBox>(find.byType(SizedBox));
        expect(sizedBox.width, 24.0);
        expect(sizedBox.height, isNull);
      });

      testWidgets('should render extraLarge horizontal spacer correctly', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppSpacer(
                size: AppSpacerSize.extraLarge,
                direction: AppSpacerDirection.horizontal,
              ),
            ),
          ),
        );

        final sizedBox = tester.widget<SizedBox>(find.byType(SizedBox));
        expect(sizedBox.width, 32.0);
        expect(sizedBox.height, isNull);
      });

      testWidgets('should render huge horizontal spacer correctly', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppSpacer(
                size: AppSpacerSize.huge,
                direction: AppSpacerDirection.horizontal,
              ),
            ),
          ),
        );

        final sizedBox = tester.widget<SizedBox>(find.byType(SizedBox));
        expect(sizedBox.width, 48.0);
        expect(sizedBox.height, isNull);
      });
    });

    group('Factory Methods - Vertical', () {
      testWidgets('should create extraSmallVertical spacer correctly', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppSpacerFactory.extraSmallVertical(),
            ),
          ),
        );

        final sizedBox = tester.widget<SizedBox>(find.byType(SizedBox));
        expect(sizedBox.height, 4.0);
        expect(sizedBox.width, isNull);
      });

      testWidgets('should create smallVertical spacer correctly', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppSpacerFactory.smallVertical(),
            ),
          ),
        );

        final sizedBox = tester.widget<SizedBox>(find.byType(SizedBox));
        expect(sizedBox.height, 8.0);
        expect(sizedBox.width, isNull);
      });

      testWidgets('should create mediumVertical spacer correctly', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppSpacerFactory.mediumVertical(),
            ),
          ),
        );

        final sizedBox = tester.widget<SizedBox>(find.byType(SizedBox));
        expect(sizedBox.height, 16.0);
        expect(sizedBox.width, isNull);
      });

      testWidgets('should create largeVertical spacer correctly', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppSpacerFactory.largeVertical(),
            ),
          ),
        );

        final sizedBox = tester.widget<SizedBox>(find.byType(SizedBox));
        expect(sizedBox.height, 24.0);
        expect(sizedBox.width, isNull);
      });

      testWidgets('should create extraLargeVertical spacer correctly', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppSpacerFactory.extraLargeVertical(),
            ),
          ),
        );

        final sizedBox = tester.widget<SizedBox>(find.byType(SizedBox));
        expect(sizedBox.height, 32.0);
        expect(sizedBox.width, isNull);
      });

      testWidgets('should create hugeVertical spacer correctly', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppSpacerFactory.hugeVertical(),
            ),
          ),
        );

        final sizedBox = tester.widget<SizedBox>(find.byType(SizedBox));
        expect(sizedBox.height, 48.0);
        expect(sizedBox.width, isNull);
      });
    });

    group('Factory Methods - Horizontal', () {
      testWidgets('should create extraSmallHorizontal spacer correctly', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppSpacerFactory.extraSmallHorizontal(),
            ),
          ),
        );

        final sizedBox = tester.widget<SizedBox>(find.byType(SizedBox));
        expect(sizedBox.width, 4.0);
        expect(sizedBox.height, isNull);
      });

      testWidgets('should create smallHorizontal spacer correctly', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppSpacerFactory.smallHorizontal(),
            ),
          ),
        );

        final sizedBox = tester.widget<SizedBox>(find.byType(SizedBox));
        expect(sizedBox.width, 8.0);
        expect(sizedBox.height, isNull);
      });

      testWidgets('should create mediumHorizontal spacer correctly', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppSpacerFactory.mediumHorizontal(),
            ),
          ),
        );

        final sizedBox = tester.widget<SizedBox>(find.byType(SizedBox));
        expect(sizedBox.width, 16.0);
        expect(sizedBox.height, isNull);
      });

      testWidgets('should create largeHorizontal spacer correctly', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppSpacerFactory.largeHorizontal(),
            ),
          ),
        );

        final sizedBox = tester.widget<SizedBox>(find.byType(SizedBox));
        expect(sizedBox.width, 24.0);
        expect(sizedBox.height, isNull);
      });

      testWidgets('should create extraLargeHorizontal spacer correctly', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppSpacerFactory.extraLargeHorizontal(),
            ),
          ),
        );

        final sizedBox = tester.widget<SizedBox>(find.byType(SizedBox));
        expect(sizedBox.width, 32.0);
        expect(sizedBox.height, isNull);
      });

      testWidgets('should create hugeHorizontal spacer correctly', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppSpacerFactory.hugeHorizontal(),
            ),
          ),
        );

        final sizedBox = tester.widget<SizedBox>(find.byType(SizedBox));
        expect(sizedBox.width, 48.0);
        expect(sizedBox.height, isNull);
      });
    });

    group('Custom Spacer', () {
      testWidgets('should create custom spacer with width only', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppSpacer.custom(width: 50),
            ),
          ),
        );

        final sizedBox = tester.widget<SizedBox>(find.byType(SizedBox));
        expect(sizedBox.width, 50.0);
        expect(sizedBox.height, isNull);
      });

      testWidgets('should create custom spacer with height only', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppSpacer.custom(height: 30),
            ),
          ),
        );

        final sizedBox = tester.widget<SizedBox>(find.byType(SizedBox));
        expect(sizedBox.height, 30.0);
        expect(sizedBox.width, isNull);
      });

      testWidgets('should create custom spacer with both width and height', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppSpacer.custom(width: 100, height: 75),
            ),
          ),
        );

        final sizedBox = tester.widget<SizedBox>(find.byType(SizedBox));
        expect(sizedBox.width, 100.0);
        expect(sizedBox.height, 75.0);
      });

      testWidgets('should override size and direction when using custom dimensions', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppSpacer(
                size: AppSpacerSize.large,
                direction: AppSpacerDirection.horizontal,
                width: 10,
                height: 20,
              ),
            ),
          ),
        );

        final sizedBox = tester.widget<SizedBox>(find.byType(SizedBox));
        expect(sizedBox.width, 10.0); // Custom overrides size/direction
        expect(sizedBox.height, 20.0);
      });
    });

    group('Flexible Spacer', () {
      testWidgets('should create flexible spacer with default flex', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Column(
                children: [
                  Container(height: 50, color: Colors.red),
                  AppSpacerFactory.flexible(),
                  Container(height: 50, color: Colors.blue),
                ],
              ),
            ),
          ),
        );

        final expanded = tester.widget<Expanded>(find.byType(Expanded));
        expect(expanded.flex, 1);
        expect(find.byType(SizedBox), findsOneWidget);
      });

      testWidgets('should create flexible spacer with custom flex', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Column(
                children: [
                  Container(height: 50, color: Colors.red),
                  AppSpacerFactory.flexible(flex: 3),
                  Container(height: 50, color: Colors.blue),
                ],
              ),
            ),
          ),
        );

        final expanded = tester.widget<Expanded>(find.byType(Expanded));
        expect(expanded.flex, 3);
      });
    });

    group('Edge Cases', () {
      testWidgets('should handle zero custom dimensions', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppSpacer.custom(width: 0, height: 0),
            ),
          ),
        );

        final sizedBox = tester.widget<SizedBox>(find.byType(SizedBox));
        expect(sizedBox.width, 0.0);
        expect(sizedBox.height, 0.0);
      });

      testWidgets('should handle very large custom dimensions', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppSpacer.custom(width: 9999, height: 8888),
            ),
          ),
        );

        final sizedBox = tester.widget<SizedBox>(find.byType(SizedBox));
        expect(sizedBox.width, 9999.0);
        expect(sizedBox.height, 8888.0);
      });
    });
  });
}