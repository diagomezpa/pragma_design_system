import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pragma_design_system/molecules.dart';
import 'package:pragma_design_system/atoms.dart';

void main() {
  group('AppEmptyState Tests', () {
    group('Basic Rendering', () {
      testWidgets('should render with required title parameter', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppEmptyState(
                title: 'No items found',
              ),
            ),
          ),
        );

        expect(find.byType(AppEmptyState), findsOneWidget);
        expect(find.text('No items found'), findsOneWidget);
        expect(find.byType(AppText), findsOneWidget);
        expect(find.byType(Center), findsOneWidget);
        expect(find.byType(Column), findsOneWidget);
      });

      testWidgets('should render with title and description', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppEmptyState(
                title: 'No items found',
                description: 'Try adjusting your search criteria',
              ),
            ),
          ),
        );

        expect(find.text('No items found'), findsOneWidget);
        expect(find.text('Try adjusting your search criteria'), findsOneWidget);
        expect(find.byType(AppText), findsNWidgets(2));
        expect(find.byType(AppSpacer), findsOneWidget);
      });

      testWidgets('should use correct text variants for title and description', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppEmptyState(
                title: 'Empty Title',
                description: 'Empty Description',
              ),
            ),
          ),
        );

        final titleWidget = tester.widgetList<AppText>(find.byType(AppText)).first;
        final descriptionWidget = tester.widgetList<AppText>(find.byType(AppText)).last;
        
        expect(titleWidget.variant, AppTextVariant.titleLarge);
        expect(titleWidget.text, 'Empty Title');
        expect(descriptionWidget.variant, AppTextVariant.bodyLarge);
        expect(descriptionWidget.text, 'Empty Description');
      });
    });

    group('Visual Elements - Icon vs Image Priority', () {
      testWidgets('should render icon when provided', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppEmptyState(
                title: 'No data',
                icon: Icons.search_off,
              ),
            ),
          ),
        );

        expect(find.byType(AppIcon), findsOneWidget);
        expect(find.byIcon(Icons.search_off), findsOneWidget);
        expect(find.byType(AppImage), findsNothing);
        expect(find.byType(AppSpacer), findsOneWidget); // Spacer after icon
      });

      testWidgets('should use extraLarge size for icon', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppEmptyState(
                title: 'No data',
                icon: Icons.inbox,
              ),
            ),
          ),
        );

        final iconWidget = tester.widget<AppIcon>(find.byType(AppIcon));
        expect(iconWidget.size, AppIconSize.extraLarge);
        expect(iconWidget.icon, Icons.inbox);
      });

      testWidgets('should render image when icon is not provided', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppEmptyState(
                title: 'No results',
                imageUrl: 'https://example.com/empty.png',
              ),
            ),
          ),
        );

        expect(find.byType(AppImage), findsOneWidget);
        expect(find.byType(AppIcon), findsNothing);
        expect(find.byType(AppSpacer), findsOneWidget); // Spacer after image
      });

      testWidgets('should configure image with correct dimensions', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppEmptyState(
                title: 'No content',
                imageUrl: 'https://example.com/illustration.png',
              ),
            ),
          ),
        );

        final imageWidget = tester.widget<AppImage>(find.byType(AppImage));
        expect(imageWidget.imageUrl, 'https://example.com/illustration.png');
        expect(imageWidget.width, 120);
        expect(imageWidget.height, 120);
        expect(imageWidget.fit, BoxFit.contain);
      });

      testWidgets('should prioritize icon over image when both provided', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppEmptyState(
                title: 'Priority test',
                icon: Icons.warning,
                imageUrl: 'https://example.com/ignored.png',
              ),
            ),
          ),
        );

        expect(find.byType(AppIcon), findsOneWidget);
        expect(find.byIcon(Icons.warning), findsOneWidget);
        expect(find.byType(AppImage), findsNothing);
      });

      testWidgets('should render without visual elements when neither icon nor image provided', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppEmptyState(
                title: 'Text only',
                description: 'No visual elements',
              ),
            ),
          ),
        );

        expect(find.byType(AppIcon), findsNothing);
        expect(find.byType(AppImage), findsNothing);
        expect(find.text('Text only'), findsOneWidget);
        expect(find.text('No visual elements'), findsOneWidget);
        // Only spacer between title and description
        expect(find.byType(AppSpacer), findsOneWidget);
      });
    });

    group('Action Button Logic', () {
      testWidgets('should render action button when both label and callback provided', (tester) async {
        bool actionTriggered = false;
        
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppEmptyState(
                title: 'Empty list',
                description: 'Get started by adding items',
                actionLabel: 'Add Item',
                onAction: () => actionTriggered = true,
              ),
            ),
          ),
        );

        expect(find.byType(AppButton), findsOneWidget);
        expect(find.text('Add Item'), findsOneWidget);
        
        // Tap the action button
        await tester.tap(find.byType(AppButton));
        await tester.pump();
        
        expect(actionTriggered, isTrue);
      });

      testWidgets('should not render action button when only label provided', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppEmptyState(
                title: 'No action',
                actionLabel: 'Add Item',
                onAction: null,
              ),
            ),
          ),
        );

        expect(find.byType(AppButton), findsNothing);
        expect(find.text('Add Item'), findsNothing);
      });

      testWidgets('should not render action button when only callback provided', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppEmptyState(
                title: 'No action',
                actionLabel: null,
                onAction: () {},
              ),
            ),
          ),
        );

        expect(find.byType(AppButton), findsNothing);
      });

      testWidgets('should not render action button when neither label nor callback provided', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppEmptyState(
                title: 'No action',
                actionLabel: null,
                onAction: null,
              ),
            ),
          ),
        );

        expect(find.byType(AppButton), findsNothing);
      });

      testWidgets('should have correct spacing before action button', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppEmptyState(
                title: 'With action',
                actionLabel: 'Do Something',
                onAction: () {},
              ),
            ),
          ),
        );

        final spacers = tester.widgetList<AppSpacer>(find.byType(AppSpacer));
        // Should have extraLarge spacer before button
        expect(spacers.any((spacer) => spacer.size == AppSpacerSize.extraLarge), isTrue);
      });
    });

    group('Text Alignment', () {
      testWidgets('should use center alignment by default', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppEmptyState(
                title: 'Centered Title',
                description: 'Centered Description',
              ),
            ),
          ),
        );

        final textWidgets = tester.widgetList<AppText>(find.byType(AppText));
        for (final textWidget in textWidgets) {
          expect(textWidget.textAlign, TextAlign.center);
        }
      });

      testWidgets('should apply custom text alignment', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppEmptyState(
                title: 'Left Title',
                description: 'Left Description',
                alignment: TextAlign.left,
              ),
            ),
          ),
        );

        final textWidgets = tester.widgetList<AppText>(find.byType(AppText));
        for (final textWidget in textWidgets) {
          expect(textWidget.textAlign, TextAlign.left);
        }
      });

      testWidgets('should support right alignment', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppEmptyState(
                title: 'Right Title',
                alignment: TextAlign.right,
              ),
            ),
          ),
        );

        final titleWidget = tester.widget<AppText>(find.byType(AppText));
        expect(titleWidget.textAlign, TextAlign.right);
      });

      testWidgets('should support justify alignment', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppEmptyState(
                title: 'Justified Title',
                description: 'Justified Description',
                alignment: TextAlign.justify,
              ),
            ),
          ),
        );

        final textWidgets = tester.widgetList<AppText>(find.byType(AppText));
        for (final textWidget in textWidgets) {
          expect(textWidget.textAlign, TextAlign.justify);
        }
      });
    });

    group('Spacing and Layout', () {
      testWidgets('should have proper spacing between elements with all components', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppEmptyState(
                title: 'Complete State',
                description: 'With all elements',
                icon: Icons.inbox,
                actionLabel: 'Action',
                onAction: () {},
              ),
            ),
          ),
        );

        final spacers = tester.widgetList<AppSpacer>(find.byType(AppSpacer));
        
        // Should have:
        // - Large spacer after icon
        // - Medium spacer after title
        // - ExtraLarge spacer before action
        expect(spacers, hasLength(3));
        expect(spacers.any((s) => s.size == AppSpacerSize.large), isTrue);
        expect(spacers.any((s) => s.size == AppSpacerSize.medium), isTrue);
        expect(spacers.any((s) => s.size == AppSpacerSize.extraLarge), isTrue);
      });

      testWidgets('should have correct main axis alignment', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppEmptyState(
                title: 'Centered Content',
              ),
            ),
          ),
        );

        final column = tester.widget<Column>(find.byType(Column));
        expect(column.mainAxisAlignment, MainAxisAlignment.center);
        expect(column.mainAxisSize, MainAxisSize.min);
      });

      testWidgets('should be centered in parent', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppEmptyState(
                title: 'Centered Widget',
              ),
            ),
          ),
        );

        expect(find.byType(Center), findsOneWidget);
        final center = tester.widget<Center>(find.byType(Center));
        expect(center.child, isA<Column>());
      });
    });

    group('Design System Composition', () {
      testWidgets('should only use design system atoms', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppEmptyState(
                title: 'System Check',
                description: 'Verifying atoms usage',
                icon: Icons.check,
                actionLabel: 'Confirm',
                onAction: () {},
              ),
            ),
          ),
        );

        // Verify it uses design system atoms properly
        expect(find.byType(AppText), findsNWidgets(2));
        expect(find.byType(AppIcon), findsOneWidget);
        expect(find.byType(AppButton), findsOneWidget);
        expect(find.byType(AppSpacer), findsAtLeastNWidgets(1));
        
        // Verify the AppEmptyState is properly composed
        expect(find.byType(AppEmptyState), findsOneWidget);
        expect(find.byType(Column), findsAtLeastNWidgets(1));
        
        // Verify content is correct
        expect(find.text('System Check'), findsOneWidget);
        expect(find.text('Verifying atoms usage'), findsOneWidget);
        expect(find.text('Confirm'), findsOneWidget);
      });

      testWidgets('should compose well with AppCard', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppCard(
                child: AppEmptyState(
                  title: 'Card Empty State',
                  description: 'Inside a card',
                  icon: Icons.folder_open,
                ),
              ),
            ),
          ),
        );

        expect(find.byType(AppCard), findsOneWidget);
        expect(find.byType(AppEmptyState), findsOneWidget);
        expect(find.text('Card Empty State'), findsOneWidget);
      });
    });

    group('Edge Cases', () {
      testWidgets('should handle empty strings gracefully', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppEmptyState(
                title: '',
                description: '',
              ),
            ),
          ),
        );

        expect(find.text(''), findsNWidgets(2)); // Empty title and description
        expect(find.byType(AppText), findsNWidgets(2));
      });

      testWidgets('should handle very long text content', (tester) async {
        const longTitle = 'This is a very long title that might wrap to multiple lines and should be handled gracefully by the AppEmptyState widget';
        const longDescription = 'This is an extremely long description that contains a lot of text and should also wrap properly without causing any layout issues in the AppEmptyState component. It should maintain proper spacing and alignment.';
        
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppEmptyState(
                title: longTitle,
                description: longDescription,
              ),
            ),
          ),
        );

        expect(find.text(longTitle), findsOneWidget);
        expect(find.text(longDescription), findsOneWidget);
        expect(find.byType(AppText), findsNWidgets(2));
      });

      testWidgets('should handle long action label', (tester) async {
        const longActionLabel = 'This is a very long action label for testing';
        
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppEmptyState(
                title: 'Test',
                actionLabel: longActionLabel,
                onAction: () {},
              ),
            ),
          ),
        );

        expect(find.text(longActionLabel), findsOneWidget);
        expect(find.byType(AppButton), findsOneWidget);
      });

      testWidgets('should handle null description correctly', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppEmptyState(
                title: 'No description',
                description: null,
              ),
            ),
          ),
        );

        expect(find.byType(AppText), findsOneWidget); // Only title
        expect(find.text('No description'), findsOneWidget);
      });
    });

    group('Accessibility', () {
      testWidgets('should maintain accessibility for action button', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppEmptyState(
                title: 'Accessible',
                actionLabel: 'Accessible Action',
                onAction: () {},
              ),
            ),
          ),
        );

        final button = tester.widget<AppButton>(find.byType(AppButton));
        expect(button.text, 'Accessible Action');
        expect(button.onPressed, isNotNull);
      });

      testWidgets('should support semantic properties from atoms', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppEmptyState(
                title: 'Semantic Test',
                description: 'Testing semantics',
                icon: Icons.accessibility,
              ),
            ),
          ),
        );

        // Verify that atoms maintain their semantic properties
        expect(find.byType(AppText), findsNWidgets(2));
        expect(find.byType(AppIcon), findsOneWidget);
        expect(find.byIcon(Icons.accessibility), findsOneWidget);
      });
    });
  });
}