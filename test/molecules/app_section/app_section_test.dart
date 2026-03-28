import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pragma_design_system/molecules.dart';
import 'package:pragma_design_system/atoms.dart';

void main() {
  group('AppSection Tests', () {
    group('Basic Rendering', () {
      testWidgets('should render with required title and child parameters', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppSection(
                title: 'Test Section',
                child: Text('Section Content'),
              ),
            ),
          ),
        );

        expect(find.byType(AppSection), findsOneWidget);
        expect(find.text('Test Section'), findsOneWidget);
        expect(find.text('Section Content'), findsOneWidget);
        expect(find.byType(AppText), findsOneWidget);
        expect(find.byType(Column), findsOneWidget);
        expect(find.byType(Padding), findsOneWidget);
      });

      testWidgets('should render with title, description and child', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppSection(
                title: 'User Settings',
                description: 'Manage your account preferences',
                child: Icon(Icons.settings),
              ),
            ),
          ),
        );

        expect(find.text('User Settings'), findsOneWidget);
        expect(find.text('Manage your account preferences'), findsOneWidget);
        expect(find.byIcon(Icons.settings), findsOneWidget);
        expect(find.byType(AppText), findsNWidgets(2));
        expect(find.byType(AppSpacer), findsNWidgets(2));
      });

      testWidgets('should render without description when not provided', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppSection(
                title: 'Simple Section',
                child: Container(width: 100, height: 50),
              ),
            ),
          ),
        );

        expect(find.text('Simple Section'), findsOneWidget);
        expect(find.byType(AppText), findsOneWidget); // Only title
        expect(find.byType(Container), findsOneWidget);
        expect(find.byType(AppSpacer), findsOneWidget); // Only medium spacer before content
      });
    });

    group('Title Properties', () {
      testWidgets('should use titleLarge variant for title', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppSection(
                title: 'Title Variant Test',
                child: SizedBox.shrink(),
              ),
            ),
          ),
        );

        final titleWidget = tester.widget<AppText>(find.byType(AppText));
        expect(titleWidget.variant, AppTextVariant.titleLarge);
        expect(titleWidget.text, 'Title Variant Test');
        expect(titleWidget.fontWeight, FontWeight.w600);
      });

      testWidgets('should use onSurface color from theme for title', (tester) async {
        const testColor = Color(0xFF123456);
        
        await tester.pumpWidget(
          MaterialApp(
            theme: ThemeData.light().copyWith(
              colorScheme: ColorScheme.light().copyWith(onSurface: testColor),
            ),
            home: const Scaffold(
              body: AppSection(
                title: 'Themed Title',
                child: SizedBox.shrink(),
              ),
            ),
          ),
        );

        final titleWidget = tester.widget<AppText>(find.byType(AppText));
        expect(titleWidget.color, testColor);
      });
    });

    group('Description Properties', () {
      testWidgets('should use bodySmall variant for description', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppSection(
                title: 'Test Title',
                description: 'Test Description',
                child: SizedBox.shrink(),
              ),
            ),
          ),
        );

        final textWidgets = tester.widgetList<AppText>(find.byType(AppText));
        final descriptionWidget = textWidgets.last;
        
        expect(descriptionWidget.variant, AppTextVariant.bodySmall);
        expect(descriptionWidget.text, 'Test Description');
        expect(descriptionWidget.maxLines, 3);
        expect(descriptionWidget.overflow, TextOverflow.ellipsis);
      });

      testWidgets('should use onSurfaceVariant color for description', (tester) async {
        const testColor = Color(0xFF654321);
        
        await tester.pumpWidget(
          MaterialApp(
            theme: ThemeData.light().copyWith(
              colorScheme: ColorScheme.light().copyWith(onSurfaceVariant: testColor),
            ),
            home: const Scaffold(
              body: AppSection(
                title: 'Test Title',
                description: 'Themed Description',
                child: SizedBox.shrink(),
              ),
            ),
          ),
        );

        final textWidgets = tester.widgetList<AppText>(find.byType(AppText));
        final descriptionWidget = textWidgets.last;
        
        expect(descriptionWidget.color, testColor);
      });

      testWidgets('should handle long description with ellipsis', (tester) async {
        const longDescription = 'This is a very long description that should be truncated with ellipsis after three lines to maintain proper layout and prevent overflow issues in the section component.';
        
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppSection(
                title: 'Long Description Test',
                description: longDescription,
                child: SizedBox.shrink(),
              ),
            ),
          ),
        );

        final textWidgets = tester.widgetList<AppText>(find.byType(AppText));
        final descriptionWidget = textWidgets.last;
        
        expect(descriptionWidget.text, longDescription);
        expect(descriptionWidget.maxLines, 3);
        expect(descriptionWidget.overflow, TextOverflow.ellipsis);
      });
    });

    group('Padding Properties', () {
      testWidgets('should apply default padding of 16.0 on all sides', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppSection(
                title: 'Default Padding',
                child: Text('Content'),
              ),
            ),
          ),
        );

        final padding = tester.widget<Padding>(find.byType(Padding));
        expect(padding.padding, const EdgeInsets.all(16.0));
      });

      testWidgets('should apply custom padding when provided', (tester) async {
        const customPadding = EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0);
        
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppSection(
                title: 'Custom Padding',
                padding: customPadding,
                child: Text('Content'),
              ),
            ),
          ),
        );

        final padding = tester.widget<Padding>(find.byType(Padding));
        expect(padding.padding, customPadding);
      });

      testWidgets('should apply zero padding when specified', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppSection(
                title: 'No Padding',
                padding: EdgeInsets.zero,
                child: Text('Content'),
              ),
            ),
          ),
        );

        final padding = tester.widget<Padding>(find.byType(Padding));
        expect(padding.padding, EdgeInsets.zero);
      });

      testWidgets('should apply asymmetric padding correctly', (tester) async {
        const asymmetricPadding = EdgeInsets.only(
          left: 12.0,
          right: 20.0,
          top: 8.0,
          bottom: 24.0,
        );
        
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppSection(
                title: 'Asymmetric Padding',
                padding: asymmetricPadding,
                child: Text('Content'),
              ),
            ),
          ),
        );

        final padding = tester.widget<Padding>(find.byType(Padding));
        expect(padding.padding, asymmetricPadding);
      });
    });

    group('Spacing and Layout', () {
      testWidgets('should have correct spacing with description', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppSection(
                title: 'Spaced Section',
                description: 'With description',
                child: Text('Content'),
              ),
            ),
          ),
        );

        final spacers = tester.widgetList<AppSpacer>(find.byType(AppSpacer));
        
        // Should have small spacer after title and medium spacer before content
        expect(spacers, hasLength(2));
        expect(spacers.any((s) => s.size == AppSpacerSize.small), isTrue);
        expect(spacers.any((s) => s.size == AppSpacerSize.medium), isTrue);
      });

      testWidgets('should have correct spacing without description', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppSection(
                title: 'Simple Section',
                child: Text('Content'),
              ),
            ),
          ),
        );

        final spacers = tester.widgetList<AppSpacer>(find.byType(AppSpacer));
        
        // Should only have medium spacer before content
        expect(spacers, hasLength(1));
        expect(spacers.first.size, AppSpacerSize.medium);
      });

      testWidgets('should have correct column properties', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppSection(
                title: 'Column Test',
                child: Text('Content'),
              ),
            ),
          ),
        );

        final column = tester.widget<Column>(find.byType(Column));
        expect(column.crossAxisAlignment, CrossAxisAlignment.start);
        expect(column.mainAxisSize, MainAxisSize.min);
      });

      testWidgets('should render child widget in correct position', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppSection(
                title: 'Child Position Test',
                description: 'Test description',
                child: Container(
                  width: 200,
                  height: 100,
                  color: Colors.blue,
                ),
              ),
            ),
          ),
        );

        // Child should be last element in column
        expect(find.byType(Container), findsOneWidget);
        final container = tester.widget<Container>(find.byType(Container));
        expect(container.color, Colors.blue);
        
        // Verify the container maintains its size properties
        final renderBox = tester.renderObject<RenderBox>(find.byType(Container));
        expect(renderBox.size.width, 200.0);
        expect(renderBox.size.height, 100.0);
      });
    });

    group('Child Widget Composition', () {
      testWidgets('should render with design system atoms as children', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppSection(
                title: 'Atom Composition',
                child: Column(
                  children: [
                    AppText('Text Atom', variant: AppTextVariant.bodyMedium),
                    AppIcon(Icons.star, size: AppIconSize.medium),
                    AppSpacer(size: AppSpacerSize.small),
                  ],
                ),
              ),
            ),
          ),
        );

        expect(find.byType(AppSection), findsOneWidget);
        expect(find.text('Atom Composition'), findsOneWidget);
        expect(find.text('Text Atom'), findsOneWidget);
        expect(find.byIcon(Icons.star), findsOneWidget);
        expect(find.byType(AppSpacer), findsAtLeastNWidgets(1));
      });

      testWidgets('should compose well with other molecules', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppSection(
                title: 'Molecule Composition',
                description: 'Testing with AppCard',
                child: AppCard(
                  child: AppEmptyState(
                    title: 'Nested Empty State',
                    icon: Icons.info,
                  ),
                ),
              ),
            ),
          ),
        );

        expect(find.byType(AppSection), findsOneWidget);
        expect(find.byType(AppCard), findsOneWidget);
        expect(find.byType(AppEmptyState), findsOneWidget);
        expect(find.text('Molecule Composition'), findsOneWidget);
        expect(find.text('Testing with AppCard'), findsOneWidget);
        expect(find.text('Nested Empty State'), findsOneWidget);
      });

      testWidgets('should handle complex nested layouts', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppSection(
                title: 'Complex Layout',
                child: Column(
                  children: [
                    Row(
                      children: [
                        Icon(Icons.settings),
                        SizedBox(width: 8),
                        Text('Settings Item'),
                      ],
                    ),
                    Divider(),
                    ListTile(
                      title: Text('List Item'),
                      trailing: Icon(Icons.chevron_right),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );

        expect(find.byType(AppSection), findsOneWidget);
        expect(find.byIcon(Icons.settings), findsOneWidget);
        expect(find.byIcon(Icons.chevron_right), findsOneWidget);
        expect(find.text('Settings Item'), findsOneWidget);
        expect(find.text('List Item'), findsOneWidget);
        expect(find.byType(Divider), findsOneWidget);
        expect(find.byType(ListTile), findsOneWidget);
      });
    });

    group('Theme Integration', () {
      testWidgets('should adapt to dark theme', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            theme: ThemeData.dark(),
            home: const Scaffold(
              body: AppSection(
                title: 'Dark Theme Section',
                description: 'Testing dark mode',
                child: Text('Dark Content'),
              ),
            ),
          ),
        );

        final darkTheme = ThemeData.dark();
        final textWidgets = tester.widgetList<AppText>(find.byType(AppText));
        final titleWidget = textWidgets.first;
        final descriptionWidget = textWidgets.last;
        
        expect(titleWidget.color, darkTheme.colorScheme.onSurface);
        expect(descriptionWidget.color, darkTheme.colorScheme.onSurfaceVariant);
      });

      testWidgets('should respond to theme changes', (tester) async {
        const surfaceColor = Color(0xFF112233);
        const surfaceVariantColor = Color(0xFF445566);
        
        await tester.pumpWidget(
          MaterialApp(
            theme: ThemeData.light().copyWith(
              colorScheme: ColorScheme.light().copyWith(
                onSurface: surfaceColor,
                onSurfaceVariant: surfaceVariantColor,
              ),
            ),
            home: const Scaffold(
              body: AppSection(
                title: 'Custom Theme',
                description: 'Custom colors',
                child: SizedBox.shrink(),
              ),
            ),
          ),
        );

        final textWidgets = tester.widgetList<AppText>(find.byType(AppText));
        final titleWidget = textWidgets.first;
        final descriptionWidget = textWidgets.last;
        
        expect(titleWidget.color, surfaceColor);
        expect(descriptionWidget.color, surfaceVariantColor);
      });
    });

    group('Edge Cases', () {
      testWidgets('should handle empty title gracefully', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppSection(
                title: '',
                child: Text('Empty title test'),
              ),
            ),
          ),
        );

        expect(find.text(''), findsOneWidget);
        expect(find.text('Empty title test'), findsOneWidget);
        expect(find.byType(AppSection), findsOneWidget);
      });

      testWidgets('should handle empty description gracefully', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppSection(
                title: 'Test Title',
                description: '',
                child: Text('Empty description test'),
              ),
            ),
          ),
        );

        expect(find.text('Test Title'), findsOneWidget);
        expect(find.text(''), findsOneWidget);
        expect(find.byType(AppText), findsNWidgets(2)); // Title + empty description
      });

      testWidgets('should handle null description correctly', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppSection(
                title: 'No Description',
                description: null,
                child: Text('Null description test'),
              ),
            ),
          ),
        );

        expect(find.byType(AppText), findsOneWidget); // Only title
        expect(find.text('No Description'), findsOneWidget);
        expect(find.text('Null description test'), findsOneWidget);
      });

      testWidgets('should handle very long title', (tester) async {
        const longTitle = 'This is an extremely long title that might span multiple lines and should be handled gracefully by the AppSection component without causing layout issues';
        
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppSection(
                title: longTitle,
                child: Text('Long title test'),
              ),
            ),
          ),
        );

        expect(find.text(longTitle), findsOneWidget);
        expect(find.byType(AppSection), findsOneWidget);
      });

      testWidgets('should handle SizedBox.shrink as child', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppSection(
                title: 'Shrink Child',
                child: SizedBox.shrink(),
              ),
            ),
          ),
        );

        expect(find.byType(AppSection), findsOneWidget);
        expect(find.text('Shrink Child'), findsOneWidget);
        
        // Find specifically the SizedBox.shrink (not from AppSpacer)
        final shrinkBox = find.byWidgetPredicate((widget) =>
            widget is SizedBox && widget.width == 0.0 && widget.height == 0.0
        );
        expect(shrinkBox, findsOneWidget);
      });
    });

    group('Accessibility', () {
      testWidgets('should maintain proper semantic structure', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppSection(
                title: 'Accessible Section',
                description: 'Accessible description',
                child: Text('Accessible content'),
              ),
            ),
          ),
        );

        // Verify semantic hierarchy through AppText components
        expect(find.byType(AppText), findsNWidgets(2));
        
        final textWidgets = tester.widgetList<AppText>(find.byType(AppText));
        final titleWidget = textWidgets.first;
        final descriptionWidget = textWidgets.last;
        
        expect(titleWidget.variant, AppTextVariant.titleLarge);
        expect(descriptionWidget.variant, AppTextVariant.bodySmall);
      });

      testWidgets('should support semantic labels from child widgets', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppSection(
                title: 'Section with Semantic Child',
                child: Semantics(
                  label: 'Custom semantic label',
                  child: Container(width: 50, height: 50),
                ),
              ),
            ),
          ),
        );

        expect(find.byType(AppSection), findsOneWidget);
        expect(find.byType(Semantics), findsAtLeastNWidgets(1));
        
        // Find the specific semantic widget with our custom label
        final semanticWidget = find.byWidgetPredicate((widget) =>
            widget is Semantics && 
            widget.properties.label == 'Custom semantic label'
        );
        expect(semanticWidget, findsOneWidget);
      });
    });
  });
}