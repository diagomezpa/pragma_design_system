import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pragma_design_system/organisms.dart';
import 'package:pragma_design_system/atoms.dart';

void main() {
  group('AppEmptyStateSection Tests', () {
    group('Constructor and Validation', () {
      testWidgets('should create with required title only', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppEmptyStateSection(
                title: 'Empty State',
              ),
            ),
          ),
        );

        expect(find.byType(AppEmptyStateSection), findsOneWidget);
        expect(find.text('Empty State'), findsOneWidget);
      });

      testWidgets('should have correct default property values', (tester) async {
        const emptyState = AppEmptyStateSection(title: 'Test');

        expect(emptyState.icon, isNull);
        expect(emptyState.imageUrl, isNull);
        expect(emptyState.title, 'Test');
        expect(emptyState.description, isNull);
        expect(emptyState.primaryAction, isNull);
        expect(emptyState.secondaryAction, isNull);
        expect(emptyState.padding, isNull);
        expect(emptyState.textAlign, TextAlign.center);
        expect(emptyState.mainAxisAlignment, MainAxisAlignment.center);
      });

      testWidgets('should accept all optional parameters', (tester) async {
        const customPadding = EdgeInsets.all(16.0);
        final primaryButton = AppButton(text: 'Primary', onPressed: () {});
        final secondaryButton = AppButton(text: 'Secondary', onPressed: () {});

        final emptyState = AppEmptyStateSection(
          icon: Icons.folder,
          title: 'Custom Empty',
          description: 'Custom description',
          primaryAction: primaryButton,
          secondaryAction: secondaryButton,
          padding: customPadding,
          textAlign: TextAlign.left,
          mainAxisAlignment: MainAxisAlignment.start,
        );

        expect(emptyState.icon, Icons.folder);
        expect(emptyState.title, 'Custom Empty');
        expect(emptyState.description, 'Custom description');
        expect(emptyState.primaryAction, primaryButton);
        expect(emptyState.secondaryAction, secondaryButton);
        expect(emptyState.padding, customPadding);
        expect(emptyState.textAlign, TextAlign.left);
        expect(emptyState.mainAxisAlignment, MainAxisAlignment.start);
      });

      testWidgets('should assert when both icon and imageUrl provided', (tester) async {
        expect(
          () => AppEmptyStateSection(
            icon: Icons.error,
            imageUrl: 'https://example.com/image.png',
            title: 'Invalid',
          ),
          throwsAssertionError,
        );
      });

      testWidgets('should allow null icon and imageUrl', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppEmptyStateSection(
                title: 'No Media',
              ),
            ),
          ),
        );

        expect(find.byType(AppEmptyStateSection), findsOneWidget);
        expect(find.byIcon(Icons.error), findsNothing);
        expect(find.byType(AppImage), findsNothing);
      });
    });

    group('Icon Display', () {
      testWidgets('should display icon when provided', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppEmptyStateSection(
                icon: Icons.folder_open,
                title: 'Empty Folder',
              ),
            ),
          ),
        );

        expect(find.byIcon(Icons.folder_open), findsOneWidget);
        
        final iconWidget = tester.widget<Icon>(find.byIcon(Icons.folder_open));
        expect(iconWidget.size, 72.0);
        expect(iconWidget.semanticLabel, 'Empty Folder');
      });

      testWidgets('should apply theme primary color to icon', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(
                seedColor: Colors.purple,
                brightness: Brightness.light,
              ),
            ),
            home: const Scaffold(
              body: AppEmptyStateSection(
                icon: Icons.warning,
                title: 'Warning State',
              ),
            ),
          ),
        );

        final iconWidget = tester.widget<Icon>(find.byIcon(Icons.warning));
        final theme = Theme.of(tester.element(find.byType(Scaffold)));
        expect(iconWidget.color, theme.colorScheme.primary);
      });

      testWidgets('should use title as semantic label for icon', (tester) async {
        const title = 'Accessible Icon Title';
        
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppEmptyStateSection(
                icon: Icons.accessibility,
                title: title,
              ),
            ),
          ),
        );

        final iconWidget = tester.widget<Icon>(find.byIcon(Icons.accessibility));
        expect(iconWidget.semanticLabel, title);
      });

      testWidgets('should accept different icon types', (tester) async {
        const icons = [
          Icons.folder_open,
          Icons.search,
          Icons.error_outline,
          Icons.add_circle_outline,
        ];

        for (final iconData in icons) {
          await tester.pumpWidget(
            MaterialApp(
              home: Scaffold(
                body: AppEmptyStateSection(
                  icon: iconData,
                  title: 'Icon Test',
                ),
              ),
            ),
          );

          expect(find.byIcon(iconData), findsOneWidget);
          
          await tester.pumpWidget(Container()); // Clear for next iteration
        }
      });
    });

    group('Image Display', () {
      testWidgets('should display AppImage when imageUrl provided', (tester) async {
        const imageUrl = 'https://example.com/empty-state.png';
        
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppEmptyStateSection(
                imageUrl: imageUrl,
                title: 'Image State',
              ),
            ),
          ),
        );

        expect(find.byType(AppImage), findsOneWidget);
        
        final appImage = tester.widget<AppImage>(find.byType(AppImage));
        expect(appImage.imageUrl, imageUrl);
        expect(appImage.width, 200.0);
        expect(appImage.height, 160.0);
        expect(appImage.fit, BoxFit.contain);
        expect(appImage.semanticLabel, 'Image State');
      });

      testWidgets('should show placeholder while image loads', (tester) async {
        const imageUrl = 'https://example.com/loading-image.png';
        
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppEmptyStateSection(
                imageUrl: imageUrl,
                title: 'Loading Image',
              ),
            ),
          ),
        );

        final appImage = tester.widget<AppImage>(find.byType(AppImage));
        expect(appImage.placeholder, isA<SizedBox>());
      });

      testWidgets('should use title as semantic label for image', (tester) async {
        const title = 'Accessible Image Title';
        
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppEmptyStateSection(
                imageUrl: 'https://example.com/image.png',
                title: title,
              ),
            ),
          ),
        );

        final appImage = tester.widget<AppImage>(find.byType(AppImage));
        expect(appImage.semanticLabel, title);
      });

      testWidgets('should not display icon when imageUrl is provided', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppEmptyStateSection(
                imageUrl: 'https://example.com/image.png',
                title: 'Image Only',
              ),
            ),
          ),
        );

        expect(find.byType(AppImage), findsOneWidget);
        expect(find.byType(Icon), findsNothing);
      });
    });

    group('Text Content', () {
      testWidgets('should display title with correct styling', (tester) async {
        const title = 'Empty State Title';
        
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppEmptyStateSection(title: title),
            ),
          ),
        );

        expect(find.text(title), findsOneWidget);
        
        final titleWidget = tester.widget<AppText>(
          find.widgetWithText(AppText, title),
        );
        expect(titleWidget.variant, AppTextVariant.titleLarge);
        expect(titleWidget.textAlign, TextAlign.center);
      });

      testWidgets('should apply theme onSurface color to title', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(
                seedColor: Colors.green,
                brightness: Brightness.light,
              ),
            ),
            home: const Scaffold(
              body: AppEmptyStateSection(title: 'Themed Title'),
            ),
          ),
        );

        final titleWidget = tester.widget<AppText>(
          find.widgetWithText(AppText, 'Themed Title'),
        );
        final theme = Theme.of(tester.element(find.byType(Scaffold)));
        expect(titleWidget.color, theme.colorScheme.onSurface);
      });

      testWidgets('should display description when provided', (tester) async {
        const description = 'This is a detailed description of the empty state.';
        
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppEmptyStateSection(
                title: 'With Description',
                description: description,
              ),
            ),
          ),
        );

        expect(find.text(description), findsOneWidget);
        
        final descriptionWidget = tester.widget<AppText>(
          find.widgetWithText(AppText, description),
        );
        expect(descriptionWidget.variant, AppTextVariant.bodyMedium);
        expect(descriptionWidget.textAlign, TextAlign.center);
      });

      testWidgets('should apply theme onSurfaceVariant color to description', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(
                seedColor: Colors.orange,
                brightness: Brightness.light,
              ),
            ),
            home: const Scaffold(
              body: AppEmptyStateSection(
                title: 'Title',
                description: 'Themed description',
              ),
            ),
          ),
        );

        final descriptionWidget = tester.widget<AppText>(
          find.widgetWithText(AppText, 'Themed description'),
        );
        final theme = Theme.of(tester.element(find.byType(Scaffold)));
        expect(descriptionWidget.color, theme.colorScheme.onSurfaceVariant);
      });

      testWidgets('should not display description when null', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppEmptyStateSection(title: 'Title Only'),
            ),
          ),
        );

        expect(find.text('Title Only'), findsOneWidget);
        // Should only find one AppText widget (the title)
        expect(find.byType(AppText), findsOneWidget);
      });

      testWidgets('should apply custom text alignment', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppEmptyStateSection(
                title: 'Left Aligned',
                description: 'Left aligned description',
                textAlign: TextAlign.left,
              ),
            ),
          ),
        );

        final titleWidget = tester.widget<AppText>(
          find.widgetWithText(AppText, 'Left Aligned'),
        );
        final descriptionWidget = tester.widget<AppText>(
          find.widgetWithText(AppText, 'Left aligned description'),
        );
        
        expect(titleWidget.textAlign, TextAlign.left);
        expect(descriptionWidget.textAlign, TextAlign.left);
      });

      testWidgets('should handle long text content', (tester) async {
        const longTitle = 'This is a very long title that might wrap to multiple lines and should be handled gracefully by the empty state component';
        const longDescription = 'This is an extremely long description that contains multiple sentences and should wrap properly across several lines without causing layout issues or text overflow problems in the empty state display.';
        
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppEmptyStateSection(
                title: longTitle,
                description: longDescription,
              ),
            ),
          ),
        );

        expect(find.text(longTitle), findsOneWidget);
        expect(find.text(longDescription), findsOneWidget);
        expect(tester.takeException(), isNull);
      });
    });

    group('Action Buttons', () {
      testWidgets('should display primary action when provided', (tester) async {
        bool primaryPressed = false;
        
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppEmptyStateSection(
                title: 'With Primary',
                primaryAction: AppButton(
                  text: 'Primary Action',
                  onPressed: () => primaryPressed = true,
                ),
              ),
            ),
          ),
        );

        expect(find.text('Primary Action'), findsOneWidget);
        expect(find.byType(AppButton), findsOneWidget);
        
        await tester.tap(find.text('Primary Action'));
        expect(primaryPressed, true);
      });

      testWidgets('should display secondary action when provided', (tester) async {
        bool secondaryPressed = false;
        
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppEmptyStateSection(
                title: 'With Secondary',
                secondaryAction: AppButton(
                  text: 'Secondary Action',
                  variant: AppButtonVariant.text,
                  onPressed: () => secondaryPressed = true,
                ),
              ),
            ),
          ),
        );

        expect(find.text('Secondary Action'), findsOneWidget);
        expect(find.byType(AppButton), findsOneWidget);
        
        await tester.tap(find.text('Secondary Action'));
        expect(secondaryPressed, true);
      });

      testWidgets('should display both primary and secondary actions', (tester) async {
        bool primaryPressed = false;
        bool secondaryPressed = false;
        
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppEmptyStateSection(
                title: 'With Both Actions',
                primaryAction: AppButton(
                  text: 'Primary',
                  onPressed: () => primaryPressed = true,
                ),
                secondaryAction: AppButton(
                  text: 'Secondary',
                  variant: AppButtonVariant.text,
                  onPressed: () => secondaryPressed = true,
                ),
              ),
            ),
          ),
        );

        expect(find.text('Primary'), findsOneWidget);
        expect(find.text('Secondary'), findsOneWidget);
        expect(find.byType(AppButton), findsNWidgets(2));
        
        await tester.tap(find.text('Primary'));
        await tester.tap(find.text('Secondary'));
        
        expect(primaryPressed, true);
        expect(secondaryPressed, true);
      });

      testWidgets('should stack actions vertically with proper spacing', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppEmptyStateSection(
                title: 'Stacked Actions',
                primaryAction: AppButton(
                  text: 'Primary',
                  onPressed: () {},
                ),
                secondaryAction: AppButton(
                  text: 'Secondary',
                  onPressed: () {},
                ),
              ),
            ),
          ),
        );

        final primaryPosition = tester.getCenter(find.text('Primary'));
        final secondaryPosition = tester.getCenter(find.text('Secondary'));
        
        // Secondary should be below primary
        expect(secondaryPosition.dy, greaterThan(primaryPosition.dy));
        
        // Should have spacing between actions
        expect(find.byType(AppSpacer), findsAtLeastNWidgets(1));
      });

      testWidgets('should center-align actions', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppEmptyStateSection(
                title: 'Centered Actions',
                primaryAction: AppButton(
                  text: 'Centered Primary',
                  onPressed: () {},
                ),
                secondaryAction: AppButton(
                  text: 'Centered Secondary',
                  onPressed: () {},
                ),
              ),
            ),
          ),
        );

        // Check that actions are wrapped in Align widgets with center alignment
        final alignWidgets = tester.widgetList<Align>(find.byType(Align));
        for (final align in alignWidgets) {
          expect(align.alignment, Alignment.center);
        }
      });

      testWidgets('should accept custom action widgets', (tester) async {
        final customAction = Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Text('Custom Action'),
        );
        
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppEmptyStateSection(
                title: 'Custom Action Test',
                primaryAction: customAction,
              ),
            ),
          ),
        );

        expect(find.text('Custom Action'), findsOneWidget);
        expect(find.text('Custom Action Test'), findsOneWidget);
        expect(find.byType(Container), findsAtLeastNWidgets(1));
      });

      testWidgets('should not display action area when no actions provided', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppEmptyStateSection(title: 'No Actions'),
            ),
          ),
        );

        expect(find.text('No Actions'), findsOneWidget);
        // Should not have action-related spacing or containers
        final spacers = tester.widgetList<AppSpacer>(find.byType(AppSpacer));
        // Should not have large spacers that appear before actions
        expect(spacers.where((s) => s.size == AppSpacerSize.large).isEmpty, true);
      });
    });

    group('Layout and Responsive Behavior', () {
      testWidgets('should have default padding', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppEmptyStateSection(title: 'Default Padding'),
            ),
          ),
        );

        final padding = tester.widget<Padding>(find.byType(Padding).first);
        expect(padding.padding, const EdgeInsets.symmetric(horizontal: 24, vertical: 32));
      });

      testWidgets('should apply custom padding when provided', (tester) async {
        const customPadding = EdgeInsets.all(16.0);
        
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppEmptyStateSection(
                title: 'Custom Padding',
                padding: customPadding,
              ),
            ),
          ),
        );

        final padding = tester.widget<Padding>(find.byType(Padding).first);
        expect(padding.padding, customPadding);
      });

      testWidgets('should constrain content width on large screens', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppEmptyStateSection(title: 'Constrained'),
            ),
          ),
        );

        expect(find.byType(ConstrainedBox), findsWidgets);
        
        final constrainedBoxes = tester.widgetList<ConstrainedBox>(find.byType(ConstrainedBox));
        final contentConstrainedBox = constrainedBoxes.firstWhere((box) => 
          box.constraints.maxWidth != double.infinity && box.constraints.maxWidth > 0
        );
        expect(contentConstrainedBox.constraints.maxWidth, isNotNull);
      });

      testWidgets('should use LayoutBuilder for responsive behavior', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppEmptyStateSection(title: 'Responsive'),
            ),
          ),
        );

        expect(find.byType(LayoutBuilder), findsOneWidget);
      });

      testWidgets('should center content horizontally', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppEmptyStateSection(title: 'Centered'),
            ),
          ),
        );

        expect(find.byType(Center), findsOneWidget);
      });

      testWidgets('should apply custom main axis alignment', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppEmptyStateSection(
                title: 'Top Aligned',
                mainAxisAlignment: MainAxisAlignment.start,
              ),
            ),
          ),
        );

        final column = tester.widget<Column>(find.byType(Column));
        expect(column.mainAxisAlignment, MainAxisAlignment.start);
      });

      testWidgets('should have correct column properties', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppEmptyStateSection(title: 'Column Props'),
            ),
          ),
        );

        final column = tester.widget<Column>(find.byType(Column));
        expect(column.mainAxisSize, MainAxisSize.min);
        expect(column.crossAxisAlignment, CrossAxisAlignment.center);
      });
    });

    group('Spacing and Visual Hierarchy', () {
      testWidgets('should add appropriate spacing after media', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppEmptyStateSection(
                icon: Icons.folder,
                title: 'With Icon',
              ),
            ),
          ),
        );

        // Should have medium vertical spacing after icon
        final spacers = tester.widgetList<AppSpacer>(find.byType(AppSpacer));
        expect(spacers.where((s) => s.size == AppSpacerSize.medium).isNotEmpty, true);
      });

      testWidgets('should add spacing between title and description', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppEmptyStateSection(
                title: 'Title',
                description: 'Description',
              ),
            ),
          ),
        );

        // Should have small spacing between title and description
        final spacers = tester.widgetList<AppSpacer>(find.byType(AppSpacer));
        expect(spacers.where((s) => s.size == AppSpacerSize.small).isNotEmpty, true);
      });

      testWidgets('should add large spacing before actions', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppEmptyStateSection(
                title: 'With Action',
                primaryAction: AppButton(text: 'Action', onPressed: () {}),
              ),
            ),
          ),
        );

        // Should have large spacing before actions
        final spacers = tester.widgetList<AppSpacer>(find.byType(AppSpacer));
        expect(spacers.where((s) => s.size == AppSpacerSize.large).isNotEmpty, true);
      });

      testWidgets('should add medium spacing between actions', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppEmptyStateSection(
                title: 'Both Actions',
                primaryAction: AppButton(text: 'Primary', onPressed: () {}),
                secondaryAction: AppButton(text: 'Secondary', onPressed: () {}),
              ),
            ),
          ),
        );

        // Should have medium spacing between primary and secondary actions
        final spacers = tester.widgetList<AppSpacer>(find.byType(AppSpacer));
        expect(spacers.where((s) => s.size == AppSpacerSize.medium).length, greaterThanOrEqualTo(1));
      });
    });

    group('Theme Integration', () {
      testWidgets('should adapt to light theme', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(
                seedColor: Colors.blue,
                brightness: Brightness.light,
              ),
            ),
            home: const Scaffold(
              body: AppEmptyStateSection(
                icon: Icons.lightbulb,
                title: 'Light Theme',
                description: 'Light theme description',
              ),
            ),
          ),
        );

        final theme = Theme.of(tester.element(find.byType(Scaffold)));
        
        final iconWidget = tester.widget<Icon>(find.byIcon(Icons.lightbulb));
        expect(iconWidget.color, theme.colorScheme.primary);
        
        final titleWidget = tester.widget<AppText>(
          find.widgetWithText(AppText, 'Light Theme'),
        );
        expect(titleWidget.color, theme.colorScheme.onSurface);
        
        final descriptionWidget = tester.widget<AppText>(
          find.widgetWithText(AppText, 'Light theme description'),
        );
        expect(descriptionWidget.color, theme.colorScheme.onSurfaceVariant);
      });

      testWidgets('should adapt to dark theme', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(
                seedColor: Colors.blue,
                brightness: Brightness.dark,
              ),
            ),
            home: const Scaffold(
              body: AppEmptyStateSection(
                icon: Icons.dark_mode,
                title: 'Dark Theme',
                description: 'Dark theme description',
              ),
            ),
          ),
        );

        final theme = Theme.of(tester.element(find.byType(Scaffold)));
        
        final iconWidget = tester.widget<Icon>(find.byIcon(Icons.dark_mode));
        expect(iconWidget.color, theme.colorScheme.primary);
        
        final titleWidget = tester.widget<AppText>(
          find.widgetWithText(AppText, 'Dark Theme'),
        );
        expect(titleWidget.color, theme.colorScheme.onSurface);
      });
    });

    group('Complete Integration Scenarios', () {
      testWidgets('should display complete empty state with icon', (tester) async {
        bool actionPressed = false;
        
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppEmptyStateSection(
                icon: Icons.folder_open,
                title: 'No Files Found',
                description: 'Your folder is empty. Start by uploading your first file.',
                primaryAction: AppButton(
                  text: 'Upload File',
                  onPressed: () => actionPressed = true,
                ),
                secondaryAction: AppButton(
                  text: 'Learn More',
                  variant: AppButtonVariant.text,
                  onPressed: () {},
                ),
              ),
            ),
          ),
        );

        expect(find.byIcon(Icons.folder_open), findsOneWidget);
        expect(find.text('No Files Found'), findsOneWidget);
        expect(find.text('Your folder is empty. Start by uploading your first file.'), findsOneWidget);
        expect(find.text('Upload File'), findsOneWidget);
        expect(find.text('Learn More'), findsOneWidget);
        
        await tester.tap(find.text('Upload File'));
        expect(actionPressed, true);
      });

      testWidgets('should display complete empty state with image', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppEmptyStateSection(
                imageUrl: 'https://example.com/empty.png',
                title: 'Welcome to App',
                description: 'Get started by exploring our features.',
                padding: EdgeInsets.all(32),
              ),
            ),
          ),
        );

        expect(find.byType(AppImage), findsOneWidget);
        expect(find.text('Welcome to App'), findsOneWidget);
        expect(find.text('Get started by exploring our features.'), findsOneWidget);
        
        final padding = tester.widget<Padding>(find.byType(Padding).first);
        expect(padding.padding, const EdgeInsets.all(32));
      });

      testWidgets('should display minimal empty state', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppEmptyStateSection(title: 'Nothing Here'),
            ),
          ),
        );

        expect(find.text('Nothing Here'), findsOneWidget);
        expect(find.byType(Icon), findsNothing);
        expect(find.byType(AppImage), findsNothing);
        expect(find.byType(AppButton), findsNothing);
      });
    });

    group('Edge Cases', () {
      testWidgets('should handle empty title string', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppEmptyStateSection(title: ''),
            ),
          ),
        );

        expect(find.text(''), findsOneWidget);
        expect(find.byType(AppText), findsOneWidget);
        expect(tester.takeException(), isNull);
      });

      testWidgets('should handle special characters in text', (tester) async {
        const title = 'Special: !@#\$%^&*() 🎉';
        const description = 'Description with émojis: 💯 ⭐ and spëcial chars';
        
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppEmptyStateSection(
                title: title,
                description: description,
              ),
            ),
          ),
        );

        expect(find.text(title), findsOneWidget);
        expect(find.text(description), findsOneWidget);
        expect(tester.takeException(), isNull);
      });

      testWidgets('should handle extreme padding values', (tester) async {
        const largePadding = EdgeInsets.all(100.0);
        
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppEmptyStateSection(
                title: 'Large Padding',
                padding: largePadding,
              ),
            ),
          ),
        );

        final padding = tester.widget<Padding>(find.byType(Padding).first);
        expect(padding.padding, largePadding);
        expect(tester.takeException(), isNull);
      });
    });

    group('Accessibility', () {
      testWidgets('should be semantically accessible', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppEmptyStateSection(
                icon: Icons.accessibility,
                title: 'Accessible Empty State',
                description: 'This empty state is fully accessible.',
                primaryAction: AppButton(
                  text: 'Accessible Action',
                  onPressed: () {},
                ),
              ),
            ),
          ),
        );

        // Icon should have semantic label
        final iconWidget = tester.widget<Icon>(find.byIcon(Icons.accessibility));
        expect(iconWidget.semanticLabel, 'Accessible Empty State');
        
        // Should use accessible text components
        expect(find.byType(AppText), findsNWidgets(2)); // Title + description
        
        // Should use accessible button components
        expect(find.byType(AppButton), findsOneWidget);
      });

      testWidgets('should provide semantic labels for images', (tester) async {
        const title = 'Image Accessibility Test';
        
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppEmptyStateSection(
                imageUrl: 'https://example.com/accessible.png',
                title: title,
              ),
            ),
          ),
        );

        final appImage = tester.widget<AppImage>(find.byType(AppImage));
        expect(appImage.semanticLabel, title);
      });
    });
  });
}