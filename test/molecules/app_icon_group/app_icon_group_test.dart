import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pragma_design_system/molecules.dart';
import 'package:pragma_design_system/atoms.dart';

void main() {
  group('AppIconGroup Tests', () {
    group('Basic Rendering', () {
      testWidgets('should render with required icons parameter', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppIconGroup(
                icons: [
                  AppIcon(Icons.star, size: AppIconSize.medium),
                  AppIcon(Icons.favorite, size: AppIconSize.medium),
                  AppIcon(Icons.home, size: AppIconSize.medium),
                ],
              ),
            ),
          ),
        );

        expect(find.byType(AppIconGroup), findsOneWidget);
        expect(find.byType(AppIcon), findsNWidgets(3));
        expect(find.byIcon(Icons.star), findsOneWidget);
        expect(find.byIcon(Icons.favorite), findsOneWidget);
        expect(find.byIcon(Icons.home), findsOneWidget);
        expect(find.byType(Wrap), findsOneWidget);
      });

      testWidgets('should render single icon correctly', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppIconGroup(
                icons: [
                  AppIcon(Icons.settings, size: AppIconSize.large),
                ],
              ),
            ),
          ),
        );

        expect(find.byType(AppIcon), findsOneWidget);
        expect(find.byIcon(Icons.settings), findsOneWidget);
        expect(find.byType(Wrap), findsOneWidget);
      });

      testWidgets('should render multiple icons with different sizes', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppIconGroup(
                icons: [
                  AppIcon(Icons.star, size: AppIconSize.small),
                  AppIcon(Icons.favorite, size: AppIconSize.medium),
                  AppIcon(Icons.home, size: AppIconSize.large),
                  AppIcon(Icons.accessible, size: AppIconSize.extraLarge),
                ],
              ),
            ),
          ),
        );

        expect(find.byType(AppIcon), findsNWidgets(4));
        
        final iconWidgets = tester.widgetList<AppIcon>(find.byType(AppIcon)).toList();
        expect(iconWidgets[0].size, AppIconSize.small);
        expect(iconWidgets[1].size, AppIconSize.medium);
        expect(iconWidgets[2].size, AppIconSize.large);
        expect(iconWidgets[3].size, AppIconSize.extraLarge);
      });
    });

    group('Empty List Handling', () {
      testWidgets('should render SizedBox.shrink when icons list is empty', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppIconGroup(icons: []),
            ),
          ),
        );

        expect(find.byType(AppIconGroup), findsOneWidget);
        expect(find.byType(SizedBox), findsOneWidget);
        expect(find.byType(AppIcon), findsNothing);
        expect(find.byType(Wrap), findsNothing);
        expect(find.byType(Column), findsNothing);
      });

      testWidgets('should not render padding structure when list is empty', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppIconGroup(
                icons: [],
                includeVerticalPadding: true,
              ),
            ),
          ),
        );

        expect(find.byType(SizedBox), findsOneWidget);
        expect(find.byType(AppSpacer), findsNothing);
        expect(find.byType(Column), findsNothing);
      });
    });

    group('Main Axis Alignment', () {
      testWidgets('should use spaceEvenly alignment by default', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppIconGroup(
                icons: [
                  AppIcon(Icons.first_page),
                  AppIcon(Icons.last_page),
                ],
              ),
            ),
          ),
        );

        final wrap = tester.widget<Wrap>(find.byType(Wrap));
        expect(wrap.alignment, WrapAlignment.spaceEvenly);
      });

      testWidgets('should support center alignment', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppIconGroup(
                icons: [
                  AppIcon(Icons.center_focus_strong),
                  AppIcon(Icons.center_focus_weak),
                ],
                mainAxisAlignment: MainAxisAlignment.center,
              ),
            ),
          ),
        );

        final wrap = tester.widget<Wrap>(find.byType(Wrap));
        expect(wrap.alignment, WrapAlignment.center);
      });

      testWidgets('should support start alignment', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppIconGroup(
                icons: [
                  AppIcon(Icons.arrow_forward),
                  AppIcon(Icons.arrow_back),
                ],
                mainAxisAlignment: MainAxisAlignment.start,
              ),
            ),
          ),
        );

        final wrap = tester.widget<Wrap>(find.byType(Wrap));
        expect(wrap.alignment, WrapAlignment.start);
      });

      testWidgets('should support end alignment', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppIconGroup(
                icons: [
                  AppIcon(Icons.arrow_forward),
                  AppIcon(Icons.arrow_back),
                ],
                mainAxisAlignment: MainAxisAlignment.end,
              ),
            ),
          ),
        );

        final wrap = tester.widget<Wrap>(find.byType(Wrap));
        expect(wrap.alignment, WrapAlignment.end);
      });

      testWidgets('should support spaceBetween alignment', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppIconGroup(
                icons: [
                  AppIcon(Icons.first_page),
                  AppIcon(Icons.last_page),
                ],
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
              ),
            ),
          ),
        );

        final wrap = tester.widget<Wrap>(find.byType(Wrap));
        expect(wrap.alignment, WrapAlignment.spaceBetween);
      });

      testWidgets('should support spaceAround alignment', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppIconGroup(
                icons: [
                  AppIcon(Icons.first_page),
                  AppIcon(Icons.last_page),
                ],
                mainAxisAlignment: MainAxisAlignment.spaceAround,
              ),
            ),
          ),
        );

        final wrap = tester.widget<Wrap>(find.byType(Wrap));
        expect(wrap.alignment, WrapAlignment.spaceAround);
      });
    });

    group('Spacing Configuration', () {
      testWidgets('should use medium spacing by default', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppIconGroup(
                icons: [
                  AppIcon(Icons.star),
                  AppIcon(Icons.favorite),
                ],
              ),
            ),
          ),
        );

        final wrap = tester.widget<Wrap>(find.byType(Wrap));
        expect(wrap.spacing, 16.0); // AppSpacerSize.medium
        expect(wrap.runSpacing, 16.0);
      });

      testWidgets('should support extraSmall spacing', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppIconGroup(
                icons: [
                  AppIcon(Icons.star),
                  AppIcon(Icons.favorite),
                ],
                spacing: AppSpacerSize.extraSmall,
              ),
            ),
          ),
        );

        final wrap = tester.widget<Wrap>(find.byType(Wrap));
        expect(wrap.spacing, 4.0); // AppSpacerSize.extraSmall
        expect(wrap.runSpacing, 4.0);
      });

      testWidgets('should support small spacing', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppIconGroup(
                icons: [
                  AppIcon(Icons.star),
                  AppIcon(Icons.favorite),
                ],
                spacing: AppSpacerSize.small,
              ),
            ),
          ),
        );

        final wrap = tester.widget<Wrap>(find.byType(Wrap));
        expect(wrap.spacing, 8.0); // AppSpacerSize.small
      });

      testWidgets('should support large spacing', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppIconGroup(
                icons: [
                  AppIcon(Icons.star),
                  AppIcon(Icons.favorite),
                ],
                spacing: AppSpacerSize.large,
              ),
            ),
          ),
        );

        final wrap = tester.widget<Wrap>(find.byType(Wrap));
        expect(wrap.spacing, 24.0); // AppSpacerSize.large
      });

      testWidgets('should support extraLarge spacing', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppIconGroup(
                icons: [
                  AppIcon(Icons.star),
                  AppIcon(Icons.favorite),
                ],
                spacing: AppSpacerSize.extraLarge,
              ),
            ),
          ),
        );

        final wrap = tester.widget<Wrap>(find.byType(Wrap));
        expect(wrap.spacing, 32.0); // AppSpacerSize.extraLarge
      });

      testWidgets('should support huge spacing', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppIconGroup(
                icons: [
                  AppIcon(Icons.star),
                  AppIcon(Icons.favorite),
                ],
                spacing: AppSpacerSize.huge,
              ),
            ),
          ),
        );

        final wrap = tester.widget<Wrap>(find.byType(Wrap));
        expect(wrap.spacing, 48.0); // AppSpacerSize.huge
      });
    });

    group('Vertical Padding', () {
      testWidgets('should include vertical padding by default', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppIconGroup(
                icons: [
                  AppIcon(Icons.star),
                  AppIcon(Icons.favorite),
                ],
              ),
            ),
          ),
        );

        expect(find.byType(Column), findsOneWidget);
        expect(find.byType(AppSpacer), findsNWidgets(2)); // Before and after
        
        final spacers = tester.widgetList<AppSpacer>(find.byType(AppSpacer)).toList();
        expect(spacers.every((s) => s.size == AppSpacerSize.medium), isTrue);
        expect(spacers.every((s) => s.direction == AppSpacerDirection.vertical), isTrue);
      });

      testWidgets('should not include vertical padding when disabled', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppIconGroup(
                icons: [
                  AppIcon(Icons.star),
                  AppIcon(Icons.favorite),
                ],
                includeVerticalPadding: false,
              ),
            ),
          ),
        );

        expect(find.byType(Column), findsNothing);
        expect(find.byType(AppSpacer), findsNothing);
        expect(find.byType(Wrap), findsOneWidget); // Direct wrap without column
      });

      testWidgets('should have correct column structure when padding enabled', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppIconGroup(
                icons: [
                  AppIcon(Icons.star),
                ],
                includeVerticalPadding: true,
              ),
            ),
          ),
        );

        final column = tester.widget<Column>(find.byType(Column));
        expect(column.mainAxisSize, MainAxisSize.min);
        expect(column.children, hasLength(3)); // Spacer + Wrap + Spacer
      });
    });

    group('Layout Behavior', () {
      testWidgets('should allow icons to wrap on multiple lines', (tester) async {
        // Create a narrow container to force wrapping
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: SizedBox(
                width: 100, // Very narrow to force wrapping
                child: AppIconGroup(
                  icons: List.generate(
                    10,
                    (index) => AppIcon(Icons.star, size: AppIconSize.large),
                  ),
                  includeVerticalPadding: false,
                ),
              ),
            ),
          ),
        );

        expect(find.byType(Wrap), findsOneWidget);
        expect(find.byType(AppIcon), findsNWidgets(10));
        
        final wrap = tester.widget<Wrap>(find.byType(Wrap));
        expect(wrap.children, hasLength(10));
      });

      testWidgets('should maintain icon properties when wrapped', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppIconGroup(
                icons: [
                  AppIcon(Icons.star, size: AppIconSize.small),
                  AppIcon(Icons.favorite, size: AppIconSize.medium),
                  AppIcon(Icons.home, size: AppIconSize.large),
                ],
                includeVerticalPadding: false,
              ),
            ),
          ),
        );

        final iconWidgets = tester.widgetList<AppIcon>(find.byType(AppIcon)).toList();
        expect(iconWidgets[0].icon, Icons.star);
        expect(iconWidgets[0].size, AppIconSize.small);
        expect(iconWidgets[1].icon, Icons.favorite);
        expect(iconWidgets[1].size, AppIconSize.medium);
        expect(iconWidgets[2].icon, Icons.home);
        expect(iconWidgets[2].size, AppIconSize.large);
      });
    });

    group('Factory Methods', () {
      testWidgets('should create icon group with even spacing using factory', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppIconGroupFactory.even(
                icons: const [
                  AppIcon(Icons.star),
                  AppIcon(Icons.favorite),
                ],
              ),
            ),
          ),
        );

        expect(find.byType(AppIconGroup), findsOneWidget);
        expect(find.byType(AppIcon), findsNWidgets(2));
        
        final wrap = tester.widget<Wrap>(find.byType(Wrap));
        expect(wrap.alignment, WrapAlignment.spaceEvenly);
        expect(wrap.spacing, 16.0); // Default medium spacing
      });

      testWidgets('should create centered icon group using factory', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppIconGroupFactory.center(
                icons: const [
                  AppIcon(Icons.center_focus_strong),
                  AppIcon(Icons.center_focus_weak),
                ],
                spacing: AppSpacerSize.large,
              ),
            ),
          ),
        );

        final wrap = tester.widget<Wrap>(find.byType(Wrap));
        expect(wrap.alignment, WrapAlignment.center);
        expect(wrap.spacing, 24.0); // Large spacing
      });

      testWidgets('should create start-aligned icon group using factory', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppIconGroupFactory.start(
                icons: const [
                  AppIcon(Icons.arrow_forward),
                  AppIcon(Icons.arrow_back),
                ],
                includeVerticalPadding: false,
              ),
            ),
          ),
        );

        final wrap = tester.widget<Wrap>(find.byType(Wrap));
        expect(wrap.alignment, WrapAlignment.start);
        expect(find.byType(AppSpacer), findsNothing); // No vertical padding
      });
    });

    group('Design System Integration', () {
      testWidgets('should use only AppIcon atoms', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppIconGroup(
                icons: [
                  AppIcon(Icons.star, size: AppIconSize.medium),
                  AppIcon(Icons.favorite, size: AppIconSize.medium),
                ],
              ),
            ),
          ),
        );

        expect(find.byType(AppIcon), findsNWidgets(2));
        expect(find.byType(AppIconGroup), findsOneWidget);
        expect(find.byType(AppSpacer), findsNWidgets(2)); // Vertical padding
      });

      testWidgets('should compose well with other molecules', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppCard(
                child: AppSection(
                  title: 'Icon Collection',
                  child: AppIconGroup(
                    icons: const [
                      AppIcon(Icons.star),
                      AppIcon(Icons.favorite),
                      AppIcon(Icons.home),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );

        expect(find.byType(AppCard), findsOneWidget);
        expect(find.byType(AppSection), findsOneWidget);
        expect(find.byType(AppIconGroup), findsOneWidget);
        expect(find.text('Icon Collection'), findsOneWidget);
        expect(find.byType(AppIcon), findsNWidgets(3));
      });
    });

    group('Edge Cases', () {
      testWidgets('should handle very large number of icons', (tester) async {
        final manyIcons = List.generate(
          50,
          (index) => AppIcon(Icons.star, size: AppIconSize.small),
        );

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppIconGroup(icons: manyIcons),
            ),
          ),
        );

        expect(find.byType(AppIcon), findsNWidgets(50));
        expect(find.byType(Wrap), findsOneWidget);
      });

      testWidgets('should handle icons with different interactive states', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppIconGroup(
                icons: [
                  AppIcon.menu(onTap: () {}),
                  AppIcon.close(onTap: () {}),
                  AppIcon(Icons.star), // Non-interactive
                ],
              ),
            ),
          ),
        );

        expect(find.byType(AppIcon), findsNWidgets(3));
        expect(find.byIcon(Icons.menu), findsOneWidget);
        expect(find.byIcon(Icons.close), findsOneWidget);
        expect(find.byIcon(Icons.star), findsOneWidget);
      });

      testWidgets('should handle mixed icon sizes gracefully', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppIconGroup(
                icons: [
                  AppIcon(Icons.star, size: AppIconSize.extraSmall),
                  AppIcon(Icons.favorite, size: AppIconSize.extraLarge),
                  AppIcon(Icons.home, size: AppIconSize.medium),
                ],
                includeVerticalPadding: false,
              ),
            ),
          ),
        );

        expect(find.byType(AppIcon), findsNWidgets(3));
        expect(find.byType(Wrap), findsOneWidget);
        
        final iconWidgets = tester.widgetList<AppIcon>(find.byType(AppIcon)).toList();
        expect(iconWidgets[0].size, AppIconSize.extraSmall);
        expect(iconWidgets[1].size, AppIconSize.extraLarge);
        expect(iconWidgets[2].size, AppIconSize.medium);
      });
    });

    group('Accessibility', () {
      testWidgets('should maintain icon semantics and accessibility', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppIconGroup(
                icons: [
                  AppIcon(Icons.accessibility),
                  AppIcon(Icons.accessible),
                  AppIcon(Icons.account_circle),
                ],
              ),
            ),
          ),
        );

        // Verify that all AppIcon widgets are present and maintain their properties
        final iconWidgets = tester.widgetList<AppIcon>(find.byType(AppIcon));
        expect(iconWidgets, hasLength(3));
        
        // Icons should maintain their accessibility properties
        expect(find.byIcon(Icons.accessibility), findsOneWidget);
        expect(find.byIcon(Icons.accessible), findsOneWidget);
        expect(find.byIcon(Icons.account_circle), findsOneWidget);
      });

      testWidgets('should support semantic grouping', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Semantics(
                label: 'Navigation icons',
                child: const AppIconGroup(
                  icons: [
                    AppIcon(Icons.home),
                    AppIcon(Icons.search),
                    AppIcon(Icons.settings),
                  ],
                ),
              ),
            ),
          ),
        );

        expect(find.byType(AppIconGroup), findsOneWidget);
        
        final semanticWidget = find.byWidgetPredicate((widget) =>
            widget is Semantics && 
            widget.properties.label == 'Navigation icons'
        );
        expect(semanticWidget, findsOneWidget);
      });
    });
  });
}