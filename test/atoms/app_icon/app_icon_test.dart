import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pragma_design_system/atoms.dart';

void main() {
  group('AppIcon Widget Tests', () {
    bool wasTapped = false;
    void onTap() {
      wasTapped = true;
    }

    setUp(() {
      wasTapped = false;
    });

    testWidgets('should render AppIcon with correct icon', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppIcon(Icons.home),
          ),
        ),
      );

      expect(find.byIcon(Icons.home), findsOneWidget);
    });

    testWidgets('should use medium size as default', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppIcon(Icons.star),
          ),
        ),
      );

      final icon = tester.widget<Icon>(find.byType(Icon));
      expect(icon.size, 24); // medium = 24px
    });

    testWidgets('should render non-interactive icon when onTap is null', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppIcon(Icons.info),
          ),
        ),
      );

      expect(find.byType(InkWell), findsNothing);
      expect(find.byType(Container), findsNothing);
      expect(find.byIcon(Icons.info), findsOneWidget);
    });

    testWidgets('should render interactive icon when onTap is provided', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppIcon(
              Icons.settings,
              onTap: onTap,
            ),
          ),
        ),
      );

      expect(find.byType(InkWell), findsOneWidget);
      expect(find.byType(Container), findsOneWidget);
      expect(find.byIcon(Icons.settings), findsOneWidget);
    });

    testWidgets('should call onTap when tapped', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppIcon(
              Icons.add,
              onTap: onTap,
            ),
          ),
        ),
      );

      await tester.tap(find.byType(InkWell));
      expect(wasTapped, true);
    });

    group('Icon Sizes', () {
      testWidgets('should render extraSmall size correctly', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppIcon(
                Icons.check,
                size: AppIconSize.extraSmall,
              ),
            ),
          ),
        );

        final icon = tester.widget<Icon>(find.byType(Icon));
        expect(icon.size, 12);
      });

      testWidgets('should render small size correctly', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppIcon(
                Icons.check,
                size: AppIconSize.small,
              ),
            ),
          ),
        );

        final icon = tester.widget<Icon>(find.byType(Icon));
        expect(icon.size, 16);
      });

      testWidgets('should render medium size correctly', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppIcon(
                Icons.check,
                size: AppIconSize.medium,
              ),
            ),
          ),
        );

        final icon = tester.widget<Icon>(find.byType(Icon));
        expect(icon.size, 24);
      });

      testWidgets('should render large size correctly', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppIcon(
                Icons.check,
                size: AppIconSize.large,
              ),
            ),
          ),
        );

        final icon = tester.widget<Icon>(find.byType(Icon));
        expect(icon.size, 32);
      });

      testWidgets('should render extraLarge size correctly', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppIcon(
                Icons.check,
                size: AppIconSize.extraLarge,
              ),
            ),
          ),
        );

        final icon = tester.widget<Icon>(find.byType(Icon));
        expect(icon.size, 48);
      });
    });

    group('Icon Properties', () {
      testWidgets('should apply custom color', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppIcon(
                Icons.favorite,
                color: Colors.red,
              ),
            ),
          ),
        );

        final icon = tester.widget<Icon>(find.byType(Icon));
        expect(icon.color, Colors.red);
      });

      testWidgets('should apply semantic label', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppIcon(
                Icons.help,
                semanticLabel: 'Help',
              ),
            ),
          ),
        );

        final icon = tester.widget<Icon>(find.byType(Icon));
        expect(icon.semanticLabel, 'Help');
      });

      testWidgets('should combine size, color, and semantic label', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppIcon(
                Icons.warning,
                size: AppIconSize.large,
                color: Colors.orange,
                semanticLabel: 'Warning',
              ),
            ),
          ),
        );

        final icon = tester.widget<Icon>(find.byType(Icon));
        expect(icon.size, 32);
        expect(icon.color, Colors.orange);
        expect(icon.semanticLabel, 'Warning');
      });
    });

    group('Interactive Icon Properties', () {
      testWidgets('should apply proper padding for extraSmall interactive icon', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppIcon(
                Icons.add,
                size: AppIconSize.extraSmall,
                onTap: onTap,
              ),
            ),
          ),
        );

        final container = tester.widget<Container>(find.byType(Container));
        expect(container.padding, const EdgeInsets.all(4));
      });

      testWidgets('should apply proper padding for small interactive icon', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppIcon(
                Icons.edit,
                size: AppIconSize.small,
                onTap: onTap,
              ),
            ),
          ),
        );

        final container = tester.widget<Container>(find.byType(Container));
        expect(container.padding, const EdgeInsets.all(6));
      });

      testWidgets('should apply proper padding for medium interactive icon', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppIcon(
                Icons.delete,
                size: AppIconSize.medium,
                onTap: onTap,
              ),
            ),
          ),
        );

        final container = tester.widget<Container>(find.byType(Container));
        expect(container.padding, const EdgeInsets.all(8));
      });

      testWidgets('should apply proper padding for large interactive icon', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppIcon(
                Icons.share,
                size: AppIconSize.large,
                onTap: onTap,
              ),
            ),
          ),
        );

        final container = tester.widget<Container>(find.byType(Container));
        expect(container.padding, const EdgeInsets.all(10));
      });

      testWidgets('should apply proper padding for extraLarge interactive icon', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppIcon(
                Icons.save,
                size: AppIconSize.extraLarge,
                onTap: onTap,
              ),
            ),
          ),
        );

        final container = tester.widget<Container>(find.byType(Container));
        expect(container.padding, const EdgeInsets.all(12));
      });

      testWidgets('should have rounded border radius for interactive icon', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppIcon(
                Icons.print,
                size: AppIconSize.medium,
                onTap: onTap,
              ),
            ),
          ),
        );

        final inkWell = tester.widget<InkWell>(find.byType(InkWell));
        expect(inkWell.borderRadius, BorderRadius.circular(12)); // 24/2 = 12 for medium
      });
    });

    group('Named Constructors', () {
      testWidgets('should create close icon with correct properties', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppIcon.close(),
            ),
          ),
        );

        final icon = tester.widget<Icon>(find.byType(Icon));
        expect(icon.icon, Icons.close);
        expect(icon.semanticLabel, 'Close');
        expect(icon.size, 24); // default medium
      });

      testWidgets('should create back icon with correct properties', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppIcon.back(),
            ),
          ),
        );

        final icon = tester.widget<Icon>(find.byType(Icon));
        expect(icon.icon, Icons.arrow_back);
        expect(icon.semanticLabel, 'Back');
        expect(icon.size, 24); // default medium
      });

      testWidgets('should create menu icon with correct properties', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppIcon.menu(),
            ),
          ),
        );

        final icon = tester.widget<Icon>(find.byType(Icon));
        expect(icon.icon, Icons.menu);
        expect(icon.semanticLabel, 'Menu');
        expect(icon.size, 24); // default medium
      });

      testWidgets('should create search icon with correct properties', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppIcon.search(),
            ),
          ),
        );

        final icon = tester.widget<Icon>(find.byType(Icon));
        expect(icon.icon, Icons.search);
        expect(icon.semanticLabel, 'Search');
        expect(icon.size, 24); // default medium
      });

      testWidgets('should create close icon with custom properties', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppIcon.close(
                size: AppIconSize.large,
                color: Colors.red,
                onTap: onTap,
              ),
            ),
          ),
        );

        final icon = tester.widget<Icon>(find.byType(Icon));
        expect(icon.icon, Icons.close);
        expect(icon.semanticLabel, 'Close');
        expect(icon.size, 32);
        expect(icon.color, Colors.red);
        expect(find.byType(InkWell), findsOneWidget);

        await tester.tap(find.byType(InkWell));
        expect(wasTapped, true);
      });

      testWidgets('should create back icon with custom properties', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppIcon.back(
                size: AppIconSize.small,
                color: Colors.blue,
                onTap: onTap,
              ),
            ),
          ),
        );

        final icon = tester.widget<Icon>(find.byType(Icon));
        expect(icon.icon, Icons.arrow_back);
        expect(icon.semanticLabel, 'Back');
        expect(icon.size, 16);
        expect(icon.color, Colors.blue);
        expect(find.byType(InkWell), findsOneWidget);
      });
    });

    group('Factory Methods', () {
      testWidgets('should create close icon via factory', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppIconFactory.close(),
            ),
          ),
        );

        final icon = tester.widget<Icon>(find.byType(Icon));
        expect(icon.icon, Icons.close);
        expect(icon.semanticLabel, 'Close');
      });

      testWidgets('should create back icon via factory', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppIconFactory.back(),
            ),
          ),
        );

        final icon = tester.widget<Icon>(find.byType(Icon));
        expect(icon.icon, Icons.arrow_back);
        expect(icon.semanticLabel, 'Back');
      });

      testWidgets('should create menu icon via factory', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppIconFactory.menu(),
            ),
          ),
        );

        final icon = tester.widget<Icon>(find.byType(Icon));
        expect(icon.icon, Icons.menu);
        expect(icon.semanticLabel, 'Menu');
      });

      testWidgets('should create search icon via factory', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppIconFactory.search(),
            ),
          ),
        );

        final icon = tester.widget<Icon>(find.byType(Icon));
        expect(icon.icon, Icons.search);
        expect(icon.semanticLabel, 'Search');
      });

      testWidgets('should create factory icon with custom properties', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppIconFactory.search(
                size: AppIconSize.extraLarge,
                color: Colors.green,
                onTap: onTap,
              ),
            ),
          ),
        );

        final icon = tester.widget<Icon>(find.byType(Icon));
        expect(icon.icon, Icons.search);
        expect(icon.semanticLabel, 'Search');
        expect(icon.size, 48);
        expect(icon.color, Colors.green);
        expect(find.byType(InkWell), findsOneWidget);

        await tester.tap(find.byType(InkWell));
        expect(wasTapped, true);
      });
    });

    group('Edge Cases', () {
      testWidgets('should handle all icon sizes with interactivity', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Column(
                children: [
                  AppIcon(Icons.star, size: AppIconSize.extraSmall, onTap: onTap),
                  AppIcon(Icons.star, size: AppIconSize.small, onTap: onTap),
                  AppIcon(Icons.star, size: AppIconSize.medium, onTap: onTap),
                  AppIcon(Icons.star, size: AppIconSize.large, onTap: onTap),
                  AppIcon(Icons.star, size: AppIconSize.extraLarge, onTap: onTap),
                ],
              ),
            ),
          ),
        );

        expect(find.byIcon(Icons.star), findsNWidgets(5));
        expect(find.byType(InkWell), findsNWidgets(5));
        expect(find.byType(Container), findsNWidgets(5));
      });

      testWidgets('should handle combination of all properties', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppIcon(
                Icons.favorite,
                size: AppIconSize.large,
                color: Colors.pink,
                onTap: onTap,
                semanticLabel: 'Favorite Item',
              ),
            ),
          ),
        );

        final icon = tester.widget<Icon>(find.byType(Icon));
        expect(icon.icon, Icons.favorite);
        expect(icon.size, 32);
        expect(icon.color, Colors.pink);
        expect(icon.semanticLabel, 'Favorite Item');
        expect(find.byType(InkWell), findsOneWidget);

        await tester.tap(find.byType(InkWell));
        expect(wasTapped, true);
      });

      testWidgets('should handle null color (uses theme default)', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppIcon(
                Icons.home,
                color: null,
              ),
            ),
          ),
        );

        final icon = tester.widget<Icon>(find.byType(Icon));
        expect(icon.color, isNotNull); // Should use theme color
      });

      testWidgets('should handle null semantic label', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppIcon(
                Icons.settings,
                semanticLabel: null,
              ),
            ),
          ),
        );

        final icon = tester.widget<Icon>(find.byType(Icon));
        expect(icon.semanticLabel, null);
      });
    });
  });
}