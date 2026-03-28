import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pragma_design_system/molecules.dart';
import 'package:pragma_design_system/atoms.dart';

void main() {
  group('AppLabeledCard Tests', () {
    group('Basic Rendering', () {
      testWidgets('should render with required label and child', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppLabeledCard(
                label: 'Test Label',
                child: AppText('Content'),
              ),
            ),
          ),
        );

        expect(find.byType(AppLabeledCard), findsOneWidget);
        expect(find.byType(AppCard), findsOneWidget);
        expect(find.text('Test Label'), findsOneWidget);
        expect(find.text('Content'), findsOneWidget);
        expect(find.byType(Column), findsOneWidget);
        expect(find.byType(AppSpacer), findsOneWidget);
        expect(find.byType(Center), findsOneWidget);
      });

      testWidgets('should have correct default structure', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppLabeledCard(
                label: 'Default Config',
                child: AppIcon(Icons.star),
              ),
            ),
          ),
        );

        final columns = tester.widgetList<Column>(find.byType(Column));
        final mainColumn = columns.first;
        expect(mainColumn.mainAxisSize, MainAxisSize.min);
        expect(mainColumn.crossAxisAlignment, CrossAxisAlignment.center);
        expect(mainColumn.children, hasLength(3)); // Label + Spacer + Center

        expect(find.byType(Center), findsAtLeastNWidgets(1));
        expect(find.byType(AppIcon), findsOneWidget);
      });

      testWidgets('should render inside AppCard container', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppLabeledCard(
                label: 'Card Test',
                child: SizedBox(width: 50, height: 50),
              ),
            ),
          ),
        );

        final appCard = tester.widget<AppCard>(find.byType(AppCard));
        expect(appCard.child, isA<Column>());
        expect(find.byType(AppCard), findsOneWidget);
      });
    });

    group('Label Properties', () {
      testWidgets('should render label with default bodySmall variant', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppLabeledCard(
                label: 'Default Label',
                child: AppIcon(Icons.home),
              ),
            ),
          ),
        );

        final labelWidgets = tester.widgetList<AppText>(find.byType(AppText));
        final labelText = labelWidgets.first;
        expect(labelText.text, 'Default Label');
        expect(labelText.variant, AppTextVariant.bodySmall);
      });

      testWidgets('should support custom label variant', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppLabeledCard(
                label: 'Large Label',
                labelVariant: AppTextVariant.bodyLarge,
                child: AppIcon(Icons.info),
              ),
            ),
          ),
        );

        final labelWidgets = tester.widgetList<AppText>(find.byType(AppText));
        final labelText = labelWidgets.first;
        expect(labelText.text, 'Large Label');
        expect(labelText.variant, AppTextVariant.bodyLarge);
      });

      testWidgets('should support medium label variant', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppLabeledCard(
                label: 'Medium Label',
                labelVariant: AppTextVariant.bodyMedium,
                child: AppIcon(Icons.settings),
              ),
            ),
          ),
        );

        final labelWidgets = tester.widgetList<AppText>(find.byType(AppText));
        final labelText = labelWidgets.first;
        expect(labelText.text, 'Medium Label');
        expect(labelText.variant, AppTextVariant.bodyMedium);
      });

      testWidgets('should handle empty label string', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppLabeledCard(
                label: '',
                child: AppIcon(Icons.warning),
              ),
            ),
          ),
        );

        expect(find.text(''), findsOneWidget);
        expect(find.byType(AppText), findsOneWidget); // Label still rendered
        expect(find.byType(AppIcon), findsOneWidget); // Child still rendered
      });

      testWidgets('should handle long label text', (tester) async {
        const longLabel = 'This is a very long label text that should be handled properly by the component without breaking the layout or causing overflow issues';
        
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppLabeledCard(
                label: longLabel,
                child: AppIcon(Icons.text_fields),
              ),
            ),
          ),
        );

        expect(find.text(longLabel), findsOneWidget);
        expect(find.byType(AppText), findsOneWidget);
        
        // Verify no overflow
        expect(tester.takeException(), isNull);
      });
    });

    group('Child Content', () {
      testWidgets('should center child content', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppLabeledCard(
                label: 'Centered Content',
                child: AppIcon(Icons.center_focus_strong),
              ),
            ),
          ),
        );

        expect(find.byType(Center), findsAtLeastNWidgets(1));
        expect(find.byIcon(Icons.center_focus_strong), findsOneWidget);
      });

      testWidgets('should support complex child widgets', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppLabeledCard(
                label: 'Complex Child',
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    AppIcon(Icons.star),
                    AppText('Complex'),
                    AppIcon(Icons.favorite),
                  ],
                ),
              ),
            ),
          ),
        );

        expect(find.text('Complex Child'), findsOneWidget);
        expect(find.text('Complex'), findsOneWidget);
        expect(find.byIcon(Icons.star), findsOneWidget);
        expect(find.byIcon(Icons.favorite), findsOneWidget);
        expect(find.byType(Column), findsNWidgets(2)); // Main column + child column
      });

      testWidgets('should support molecular composites as children', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppLabeledCard(
                label: 'Icon Group Example',
                child: AppIconGroup(
                  icons: const [
                    AppIcon(Icons.home),
                    AppIcon(Icons.search),
                    AppIcon(Icons.settings),
                  ],
                  includeVerticalPadding: false,
                ),
              ),
            ),
          ),
        );

        expect(find.text('Icon Group Example'), findsOneWidget);
        expect(find.byType(AppIconGroup), findsOneWidget);
        expect(find.byType(AppIcon), findsNWidgets(3));
      });

      testWidgets('should handle minimal child widgets', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppLabeledCard(
                label: 'Minimal Child',
                child: SizedBox.shrink(),
              ),
            ),
          ),
        );

        expect(find.text('Minimal Child'), findsOneWidget);
        expect(find.byType(SizedBox), findsAtLeastNWidgets(1));
        expect(find.byType(Center), findsOneWidget);
      });
    });

    group('Spacing Configuration', () {
      testWidgets('should use default small spacing', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppLabeledCard(
                label: 'Default Spacing',
                child: AppIcon(Icons.space_bar),
              ),
            ),
          ),
        );

        final spacer = tester.widget<AppSpacer>(find.byType(AppSpacer));
        expect(spacer.size, AppSpacerSize.small);
        expect(spacer.direction, AppSpacerDirection.vertical);
      });

      testWidgets('should support custom spacing sizes', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppLabeledCard(
                label: 'Large Spacing',
                spacing: AppSpacerSize.large,
                child: AppIcon(Icons.format_line_spacing),
              ),
            ),
          ),
        );

        final spacer = tester.widget<AppSpacer>(find.byType(AppSpacer));
        expect(spacer.size, AppSpacerSize.large);
        expect(spacer.direction, AppSpacerDirection.vertical);
      });

      testWidgets('should support extraSmall spacing', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppLabeledCard(
                label: 'Tight Spacing',
                spacing: AppSpacerSize.extraSmall,
                child: AppIcon(Icons.compress),
              ),
            ),
          ),
        );

        final spacer = tester.widget<AppSpacer>(find.byType(AppSpacer));
        expect(spacer.size, AppSpacerSize.extraSmall);
      });

      testWidgets('should support medium spacing', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppLabeledCard(
                label: 'Medium Spacing',
                spacing: AppSpacerSize.medium,
                child: AppIcon(Icons.unfold_more),
              ),
            ),
          ),
        );

        final spacer = tester.widget<AppSpacer>(find.byType(AppSpacer));
        expect(spacer.size, AppSpacerSize.medium);
      });

      testWidgets('should support extraLarge spacing', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppLabeledCard(
                label: 'Extra Large Spacing',
                spacing: AppSpacerSize.extraLarge,
                child: AppIcon(Icons.height),
              ),
            ),
          ),
        );

        final spacer = tester.widget<AppSpacer>(find.byType(AppSpacer));
        expect(spacer.size, AppSpacerSize.extraLarge);
      });
    });

    group('Factory Methods', () {
      testWidgets('should create small configuration with factory', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppLabeledCardFactory.small(
                label: 'Small Factory',
                child: const AppIcon(Icons.star),
              ),
            ),
          ),
        );

        expect(find.text('Small Factory'), findsOneWidget);
        final labelWidgets = tester.widgetList<AppText>(find.byType(AppText));
        final labelText = labelWidgets.first;
        expect(labelText.variant, AppTextVariant.bodySmall);

        final spacer = tester.widget<AppSpacer>(find.byType(AppSpacer));
        expect(spacer.size, AppSpacerSize.small);
      });

      testWidgets('should create medium configuration with factory', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppLabeledCardFactory.medium(
                label: 'Medium Factory',
                child: const AppIcon(Icons.mediation),
              ),
            ),
          ),
        );

        expect(find.text('Medium Factory'), findsOneWidget);
        final labelWidgets = tester.widgetList<AppText>(find.byType(AppText));
        final labelText = labelWidgets.first;
        expect(labelText.variant, AppTextVariant.bodyMedium);

        final spacer = tester.widget<AppSpacer>(find.byType(AppSpacer));
        expect(spacer.size, AppSpacerSize.medium);
      });

      testWidgets('should create emphasized configuration with factory', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppLabeledCardFactory.emphasized(
                label: 'Emphasized Factory',
                child: const AppIcon(Icons.priority_high),
              ),
            ),
          ),
        );

        expect(find.text('Emphasized Factory'), findsOneWidget);
        final labelWidgets = tester.widgetList<AppText>(find.byType(AppText));
        final labelText = labelWidgets.first;
        expect(labelText.variant, AppTextVariant.bodyLarge);

        final spacer = tester.widget<AppSpacer>(find.byType(AppSpacer));
        expect(spacer.size, AppSpacerSize.medium);
      });
    });

    group('Design System Integration', () {
      testWidgets('should use design system atoms properly', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppLabeledCard(
                label: 'Atoms Integration',
                child: AppText('Integrated Content'),
              ),
            ),
          ),
        );

        expect(find.byType(AppCard), findsOneWidget);
        expect(find.byType(AppText), findsNWidgets(2)); // Label + child
        expect(find.byType(AppSpacer), findsOneWidget);
        expect(find.byType(Center), findsOneWidget);
      });

      testWidgets('should compose well with other molecules', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppLabeledCard(
                label: 'Molecule Composition',
                child: AppSection(
                  title: 'Inner Section',
                  child: const AppText('Nested content'),
                ),
              ),
            ),
          ),
        );

        expect(find.text('Molecule Composition'), findsOneWidget);
        expect(find.text('Inner Section'), findsOneWidget);
        expect(find.text('Nested content'), findsOneWidget);
        expect(find.byType(AppLabeledCard), findsOneWidget);
        expect(find.byType(AppSection), findsOneWidget);
      });

      testWidgets('should maintain design system spacing hierarchy', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppLabeledCard(
                label: 'Spacing Hierarchy',
                spacing: AppSpacerSize.huge,
                child: AppText('Large spacing test'),
              ),
            ),
          ),
        );

        final spacer = tester.widget<AppSpacer>(find.byType(AppSpacer));
        expect(spacer.size, AppSpacerSize.huge);
        expect(spacer.direction, AppSpacerDirection.vertical);
      });
    });

    group('Layout Behavior', () {
      testWidgets('should maintain layout with constrained width', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: SizedBox(
                width: 200,
                child: AppLabeledCard(
                  label: 'Constrained Width Test',
                  child: const AppText('Content inside narrow container'),
                ),
              ),
            ),
          ),
        );

        expect(find.text('Constrained Width Test'), findsOneWidget);
        expect(find.text('Content inside narrow container'), findsOneWidget);
        
        // Verify no overflow
        expect(tester.takeException(), isNull);
      });

      testWidgets('should handle varying content heights', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppLabeledCard(
                label: 'Variable Height',
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: List.generate(
                    10,
                    (index) => AppText('Line $index'),
                  ),
                ),
              ),
            ),
          ),
        );

        expect(find.text('Variable Height'), findsOneWidget);
        for (int i = 0; i < 10; i++) {
          expect(find.text('Line $i'), findsOneWidget);
        }
      });

      testWidgets('should center content regardless of child size', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppLabeledCard(
                label: 'Centered Layout',
                child: SizedBox(
                  width: 100,
                  height: 100,
                  child: AppIcon(Icons.crop_square),
                ),
              ),
            ),
          ),
        );

        expect(find.byType(Center), findsAtLeastNWidgets(1));
        final sizedBox = tester.widget<SizedBox>(find.byWidgetPredicate(
          (widget) => widget is SizedBox && widget.width == 100 && widget.height == 100,
        ));
        expect(sizedBox.width, 100);
        expect(sizedBox.height, 100);
      });
    });

    group('Edge Cases', () {
      testWidgets('should handle special characters in label', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppLabeledCard(
                label: 'Special: !@#\$%^&*()_+{}[]|\\:";\'<>?,./`~',
                child: AppIcon(Icons.flag),
              ),
            ),
          ),
        );

        expect(find.text('Special: !@#\$%^&*()_+{}[]|\\:";\'<>?,./`~'), findsOneWidget);
        expect(find.byType(AppIcon), findsOneWidget);
      });

      testWidgets('should handle multiple labeled cards in same parent', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Column(
                children: const [
                  AppLabeledCard(
                    label: 'Card 1',
                    child: AppIcon(Icons.looks_one),
                  ),
                  AppLabeledCard(
                    label: 'Card 2',
                    child: AppIcon(Icons.looks_two),
                  ),
                ],
              ),
            ),
          ),
        );

        expect(find.byType(AppLabeledCard), findsNWidgets(2));
        expect(find.text('Card 1'), findsOneWidget);
        expect(find.text('Card 2'), findsOneWidget);
        expect(find.byIcon(Icons.looks_one), findsOneWidget);
        expect(find.byIcon(Icons.looks_two), findsOneWidget);
      });

      testWidgets('should handle nested labeled cards', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppLabeledCard(
                label: 'Outer Card',
                child: AppLabeledCard(
                  label: 'Inner Card',
                  child: const AppIcon(Icons.layers),
                ),
              ),
            ),
          ),
        );

        expect(find.byType(AppLabeledCard), findsNWidgets(2));
        expect(find.byType(AppCard), findsNWidgets(2));
        expect(find.text('Outer Card'), findsOneWidget);
        expect(find.text('Inner Card'), findsOneWidget);
        expect(find.byIcon(Icons.layers), findsOneWidget);
      });
    });

    group('Accessibility', () {
      testWidgets('should maintain text semantics for label', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppLabeledCard(
                label: 'Accessible Label',
                child: AppIcon(Icons.accessibility),
              ),
            ),
          ),
        );

        expect(find.text('Accessible Label'), findsOneWidget);
        expect(find.byIcon(Icons.accessibility), findsOneWidget);
        
        // Label should be readable by screen readers through AppText
        final labelWidgets = tester.widgetList<AppText>(find.byType(AppText));
        final labelText = labelWidgets.first;
        expect(labelText.text, 'Accessible Label');
      });

      testWidgets('should support semantic child content', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppLabeledCard(
                label: 'Semantic Content',
                child: Semantics(
                  label: 'Custom semantic label',
                  child: const AppIcon(Icons.speaker_notes),
                ),
              ),
            ),
          ),
        );

        expect(find.text('Semantic Content'), findsOneWidget);
        
        final semanticWidget = find.byWidgetPredicate((widget) =>
            widget is Semantics && 
            widget.properties.label == 'Custom semantic label'
        );
        expect(semanticWidget, findsOneWidget);
      });
    });
  });
}