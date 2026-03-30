import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pragma_design_system/organisms.dart';
import 'package:pragma_design_system/molecules.dart';
import 'package:pragma_design_system/atoms.dart';

void main() {
  group('AppFormSection Tests', () {
    group('Constructor and Properties', () {
      testWidgets('should create with required parameters', (tester) async {
        final formFields = [
          AppFormField(
            label: 'Name',
            onChanged: (_) {},
          ),
        ];

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppFormSection(
                title: 'Personal Information',
                children: formFields,
              ),
            ),
          ),
        );

        expect(find.byType(AppFormSection), findsOneWidget);
        expect(find.text('Personal Information'), findsOneWidget);
      });

      testWidgets('should have correct default property values', (tester) async {
        const formSection = AppFormSection(
          title: 'Test Section',
          children: [],
        );

        expect(formSection.title, 'Test Section');
        expect(formSection.description, isNull);
        expect(formSection.children, isEmpty);
        expect(formSection.showDivider, false);
        expect(formSection.padding, isNull);
      });

      testWidgets('should accept all optional parameters', (tester) async {
        const customPadding = EdgeInsets.all(16.0);
        final testChildren = [
          AppFormField(label: 'Test', onChanged: (_) {}),
        ];

        const formSection = AppFormSection(
          title: 'Custom Section',
          description: 'Custom description',
          children: [],
          showDivider: true,
          padding: customPadding,
        );

        expect(formSection.title, 'Custom Section');
        expect(formSection.description, 'Custom description');
        expect(formSection.children, isEmpty);
        expect(formSection.showDivider, true);
        expect(formSection.padding, customPadding);
      });
    });

    group('Title Display', () {
      testWidgets('should display title with correct styling', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppFormSection(
                title: 'Section Title',
                children: const [SizedBox()],
              ),
            ),
          ),
        );

        expect(find.text('Section Title'), findsOneWidget);
        
        final titleWidget = tester.widget<AppText>(
          find.widgetWithText(AppText, 'Section Title'),
        );
        expect(titleWidget.variant, AppTextVariant.titleLarge);
      });

      testWidgets('should apply theme onSurface color to title', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(
                seedColor: Colors.purple,
                brightness: Brightness.light,
              ),
            ),
            home: Scaffold(
              body: AppFormSection(
                title: 'Themed Title',
                children: const [SizedBox()],
              ),
            ),
          ),
        );

        final titleWidget = tester.widget<AppText>(
          find.widgetWithText(AppText, 'Themed Title'),
        );
        final theme = Theme.of(tester.element(find.byType(Scaffold)));
        expect(titleWidget.color, theme.colorScheme.onSurface);
      });

      testWidgets('should handle long title text', (tester) async {
        const longTitle = 'This is a very long section title that might wrap to multiple lines and should be handled gracefully';
        
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppFormSection(
                title: longTitle,
                children: const [SizedBox()],
              ),
            ),
          ),
        );

        expect(find.text(longTitle), findsOneWidget);
        expect(tester.takeException(), isNull);
      });

      testWidgets('should handle empty title string', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppFormSection(
                title: '',
                children: const [SizedBox()],
              ),
            ),
          ),
        );

        expect(find.text(''), findsOneWidget);
        expect(find.byType(AppText), findsOneWidget);
      });

      testWidgets('should handle special characters in title', (tester) async {
        const specialTitle = 'Special: !@#\$%^&*() 🎉 Section';
        
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppFormSection(
                title: specialTitle,
                children: const [SizedBox()],
              ),
            ),
          ),
        );

        expect(find.text(specialTitle), findsOneWidget);
        expect(tester.takeException(), isNull);
      });
    });

    group('Description Display', () {
      testWidgets('should not display description when null', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppFormSection(
                title: 'Title Only',
                children: const [SizedBox()],
              ),
            ),
          ),
        );

        expect(find.text('Title Only'), findsOneWidget);
        // Should only find one AppText widget (the title)
        expect(find.byType(AppText), findsOneWidget);
      });

      testWidgets('should display description when provided', (tester) async {
        const description = 'Please fill out your personal information below.';
        
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppFormSection(
                title: 'Personal Info',
                description: description,
                children: const [SizedBox()],
              ),
            ),
          ),
        );

        expect(find.text(description), findsOneWidget);
        
        final descriptionWidget = tester.widget<AppText>(
          find.widgetWithText(AppText, description),
        );
        expect(descriptionWidget.variant, AppTextVariant.bodySmall);
      });

      testWidgets('should apply theme onSurfaceVariant color to description', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(
                seedColor: Colors.green,
                brightness: Brightness.light,
              ),
            ),
            home: Scaffold(
              body: AppFormSection(
                title: 'Form',
                description: 'Themed description',
                children: const [SizedBox()],
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

      testWidgets('should add spacing between title and description', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppFormSection(
                title: 'With Description',
                description: 'Some description',
                children: const [SizedBox()],
              ),
            ),
          ),
        );

        // Should have small spacer between title and description
        final spacers = tester.widgetList<AppSpacer>(find.byType(AppSpacer));
        expect(spacers.where((s) => s.size == AppSpacerSize.small).isNotEmpty, true);
      });

      testWidgets('should handle empty description string', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppFormSection(
                title: 'Title',
                description: '',
                children: const [SizedBox()],
              ),
            ),
          ),
        );

        expect(find.text(''), findsOneWidget); // Empty description
        expect(find.byType(AppText), findsNWidgets(2)); // Title + empty description
      });

      testWidgets('should handle long description text', (tester) async {
        const longDescription = 'This is a very long section description that provides detailed instructions about what the user should fill out in this form section and might wrap to multiple lines.';
        
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppFormSection(
                title: 'Title',
                description: longDescription,
                children: const [SizedBox()],
              ),
            ),
          ),
        );

        expect(find.text(longDescription), findsOneWidget);
        expect(tester.takeException(), isNull);
      });
    });

    group('Form Fields Display', () {
      testWidgets('should display form field children', (tester) async {
        final formFields = [
          AppFormField(
            label: 'First Name',
            onChanged: (_) {},
          ),
          AppFormField(
            label: 'Last Name',
            onChanged: (_) {},
          ),
        ];

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppFormSection(
                title: 'Personal Information',
                children: formFields,
              ),
            ),
          ),
        );

        expect(find.text('First Name'), findsOneWidget);
        expect(find.text('Last Name'), findsOneWidget);
        expect(find.byType(AppFormField), findsNWidgets(2));
      });

      testWidgets('should handle empty children list', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppFormSection(
                title: 'Empty Section',
                children: const [],
              ),
            ),
          ),
        );

        expect(find.text('Empty Section'), findsOneWidget);
        expect(find.byType(AppFormField), findsNothing);
        expect(tester.takeException(), isNull);
      });

      testWidgets('should handle single child', (tester) async {
        final singleField = AppFormField(
          label: 'Email',
          onChanged: (_) {},
        );

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppFormSection(
                title: 'Contact',
                children: [singleField],
              ),
            ),
          ),
        );

        expect(find.text('Email'), findsOneWidget);
        expect(find.byType(AppFormField), findsOneWidget);
      });

      testWidgets('should accept mixed widget types as children', (tester) async {
        final mixedChildren = [
          AppFormField(label: 'Name', onChanged: (_) {}),
          const Text('Custom instruction text'),
          Container(
            padding: const EdgeInsets.all(8),
            child: const Text('Custom container'),
          ),
          AppFormField(label: 'Email', onChanged: (_) {}),
        ];

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppFormSection(
                title: 'Mixed Content',
                children: mixedChildren,
              ),
            ),
          ),
        );

        expect(find.text('Name'), findsOneWidget);
        expect(find.text('Custom instruction text'), findsOneWidget);
        expect(find.text('Custom container'), findsOneWidget);
        expect(find.text('Email'), findsOneWidget);
        expect(find.byType(AppFormField), findsNWidgets(2));
        expect(find.byType(Container), findsAtLeastNWidgets(1));
      });

      testWidgets('should handle many form fields', (tester) async {
        final manyFields = List.generate(
          10,
          (index) => AppFormField(
            label: 'Field ${index + 1}',
            onChanged: (_) {},
          ),
        );

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: SingleChildScrollView(
                child: AppFormSection(
                  title: 'Many Fields',
                  children: manyFields,
                ),
              ),
            ),
          ),
        );

        expect(find.text('Field 1'), findsOneWidget);
        expect(find.text('Field 10'), findsOneWidget);
        expect(find.byType(AppFormField), findsNWidgets(10));
        expect(tester.takeException(), isNull);
      });
    });

    group('Divider Display', () {
      testWidgets('should not show divider by default', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppFormSection(
                title: 'No Divider',
                children: const [SizedBox()],
              ),
            ),
          ),
        );

        expect(find.byType(AppDivider), findsNothing);
      });

      testWidgets('should show divider when showDivider is true', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppFormSection(
                title: 'With Divider',
                children: const [SizedBox()],
                showDivider: true,
              ),
            ),
          ),
        );

        expect(find.byType(AppDivider), findsOneWidget);
      });

      testWidgets('should add spacing before divider', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppFormSection(
                title: 'Spaced Divider',
                children: const [SizedBox()],
                showDivider: true,
              ),
            ),
          ),
        );

        final spacers = tester.widgetList<AppSpacer>(find.byType(AppSpacer));
        // Should have medium spacer before divider (in addition to spacer after title/description)
        expect(spacers.where((s) => s.size == AppSpacerSize.medium).length, greaterThanOrEqualTo(1));
      });

      testWidgets('should show divider with different content configurations', (tester) async {
        // Test divider with title only
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppFormSection(
                title: 'Title Only',
                children: const [Text('Content')],
                showDivider: true,
              ),
            ),
          ),
        );

        expect(find.byType(AppDivider), findsOneWidget);

        // Test divider with title and description
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppFormSection(
                title: 'Title',
                description: 'Description',
                children: const [Text('Content')],
                showDivider: true,
              ),
            ),
          ),
        );

        expect(find.byType(AppDivider), findsOneWidget);
      });
    });

    group('Padding and Layout', () {
      testWidgets('should have no padding by default', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppFormSection(
                title: 'No Padding',
                children: const [SizedBox()],
              ),
            ),
          ),
        );

        final container = tester.widget<Container>(find.byType(Container));
        expect(container.padding, isNull);
      });

      testWidgets('should apply custom padding when provided', (tester) async {
        const customPadding = EdgeInsets.all(24.0);
        
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppFormSection(
                title: 'Custom Padding',
                children: const [SizedBox()],
                padding: customPadding,
              ),
            ),
          ),
        );

        final container = tester.widget<Container>(find.byType(Container));
        expect(container.padding, customPadding);
      });

      testWidgets('should apply asymmetric padding correctly', (tester) async {
        const asymmetricPadding = EdgeInsets.fromLTRB(8, 16, 32, 24);
        
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppFormSection(
                title: 'Asymmetric Padding',
                children: const [SizedBox()],
                padding: asymmetricPadding,
              ),
            ),
          ),
        );

        final container = tester.widget<Container>(find.byType(Container));
        expect(container.padding, asymmetricPadding);
      });

      testWidgets('should have proper column layout properties', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppFormSection(
                title: 'Layout Test',
                children: const [SizedBox()],
              ),
            ),
          ),
        );

        final column = tester.widget<Column>(find.byType(Column));
        expect(column.crossAxisAlignment, CrossAxisAlignment.start);
        expect(column.mainAxisSize, MainAxisSize.min);
      });
    });

    group('Spacing Between Elements', () {
      testWidgets('should add medium spacing before content', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppFormSection(
                title: 'Spacing Test',
                children: const [Text('Content')],
              ),
            ),
          ),
        );

        // Should have medium spacing between title and content
        final spacers = tester.widgetList<AppSpacer>(find.byType(AppSpacer));
        expect(spacers.where((s) => s.size == AppSpacerSize.medium).isNotEmpty, true);
      });

      testWidgets('should add small spacing between title and description', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppFormSection(
                title: 'Title',
                description: 'Description',
                children: const [Text('Content')],
              ),
            ),
          ),
        );

        final spacers = tester.widgetList<AppSpacer>(find.byType(AppSpacer));
        expect(spacers.where((s) => s.size == AppSpacerSize.small).isNotEmpty, true);
        expect(spacers.where((s) => s.size == AppSpacerSize.medium).isNotEmpty, true);
      });

      testWidgets('should add medium spacing before divider', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppFormSection(
                title: 'With Divider',
                children: const [Text('Content')],
                showDivider: true,
              ),
            ),
          ),
        );

        final spacers = tester.widgetList<AppSpacer>(find.byType(AppSpacer));
        // Should have at least 2 medium spacers: one after title, one before divider
        expect(spacers.where((s) => s.size == AppSpacerSize.medium).length, greaterThanOrEqualTo(2));
      });

      testWidgets('should maintain consistent spacing with all elements', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppFormSection(
                title: 'Complete Section',
                description: 'Complete description',
                children: const [
                  Text('First content'),
                  Text('Second content'),
                ],
                showDivider: true,
              ),
            ),
          ),
        );

        final spacers = tester.widgetList<AppSpacer>(find.byType(AppSpacer));
        expect(spacers.where((s) => s.size == AppSpacerSize.small).length, 1); // Title-description
        expect(spacers.where((s) => s.size == AppSpacerSize.medium).length, 2); // Description-content, content-divider
      });
    });

    group('Integration with Design System', () {
      testWidgets('should use AppText atoms correctly', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppFormSection(
                title: 'Design System',
                description: 'Integration test',
                children: const [SizedBox()],
              ),
            ),
          ),
        );

        final appTexts = tester.widgetList<AppText>(find.byType(AppText));
        expect(appTexts.length, 2);

        final titleText = tester.widget<AppText>(
          find.widgetWithText(AppText, 'Design System'),
        );
        expect(titleText.variant, AppTextVariant.titleLarge);

        final descriptionText = tester.widget<AppText>(
          find.widgetWithText(AppText, 'Integration test'),
        );
        expect(descriptionText.variant, AppTextVariant.bodySmall);
      });

      testWidgets('should use AppSpacer atoms for spacing', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppFormSection(
                title: 'Spacing',
                description: 'Test spacing',
                children: const [Text('Content')],
                showDivider: true,
              ),
            ),
          ),
        );

        expect(find.byType(AppSpacer), findsAtLeastNWidgets(2));
        
        final spacers = tester.widgetList<AppSpacer>(find.byType(AppSpacer));
        expect(spacers.where((s) => s.size == AppSpacerSize.small).length, 1);
        expect(spacers.where((s) => s.size == AppSpacerSize.medium).length, 2);
      });

      testWidgets('should use AppDivider atoms correctly', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppFormSection(
                title: 'With Divider',
                children: const [Text('Content')],
                showDivider: true,
              ),
            ),
          ),
        );

        expect(find.byType(AppDivider), findsOneWidget);
      });

      testWidgets('should integrate with AppFormField molecules', (tester) async {
        final formFields = [
          AppFormField(
            label: 'Text Field',
            onChanged: (_) {},
          ),
          AppFormField(
            label: 'Email Field',
            keyboardType: TextInputType.emailAddress,
            onChanged: (_) {},
          ),
        ];

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppFormSection(
                title: 'Form Integration',
                children: formFields,
              ),
            ),
          ),
        );

        expect(find.byType(AppFormField), findsNWidgets(2));
        expect(find.text('Text Field'), findsOneWidget);
        expect(find.text('Email Field'), findsOneWidget);
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
            home: Scaffold(
              body: AppFormSection(
                title: 'Light Theme',
                description: 'Light description',
                children: const [Text('Content')],
              ),
            ),
          ),
        );

        final theme = Theme.of(tester.element(find.byType(Scaffold)));
        
        final titleWidget = tester.widget<AppText>(
          find.widgetWithText(AppText, 'Light Theme'),
        );
        expect(titleWidget.color, theme.colorScheme.onSurface);
        
        final descriptionWidget = tester.widget<AppText>(
          find.widgetWithText(AppText, 'Light description'),
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
            home: Scaffold(
              body: AppFormSection(
                title: 'Dark Theme',
                description: 'Dark description',
                children: const [Text('Content')],
              ),
            ),
          ),
        );

        final theme = Theme.of(tester.element(find.byType(Scaffold)));
        
        final titleWidget = tester.widget<AppText>(
          find.widgetWithText(AppText, 'Dark Theme'),
        );
        expect(titleWidget.color, theme.colorScheme.onSurface);
      });

      testWidgets('should work with custom color scheme', (tester) async {
        final customTheme = ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.purple,
            brightness: Brightness.light,
          ),
        );

        await tester.pumpWidget(
          MaterialApp(
            theme: customTheme,
            home: Scaffold(
              body: AppFormSection(
                title: 'Custom Colors',
                description: 'Custom description',
                children: const [Text('Content')],
              ),
            ),
          ),
        );

        final titleWidget = tester.widget<AppText>(
          find.widgetWithText(AppText, 'Custom Colors'),
        );
        expect(titleWidget.color, customTheme.colorScheme.onSurface);
        
        final descriptionWidget = tester.widget<AppText>(
          find.widgetWithText(AppText, 'Custom description'),
        );
        expect(descriptionWidget.color, customTheme.colorScheme.onSurfaceVariant);
      });
    });

    group('Complete Form Section Scenarios', () {
      testWidgets('should display complete form section with all elements', (tester) async {
        final formFields = [
          AppFormField(
            label: 'First Name',
            onChanged: (_) {},
          ),
          AppFormField(
            label: 'Last Name',
            onChanged: (_) {},
          ),
          AppFormField(
            label: 'Email',
            keyboardType: TextInputType.emailAddress,
            onChanged: (_) {},
          ),
        ];

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppFormSection(
                title: 'Personal Information',
                description: 'Please provide your basic contact information.',
                children: formFields,
                showDivider: true,
                padding: const EdgeInsets.all(16),
              ),
            ),
          ),
        );

        expect(find.text('Personal Information'), findsOneWidget);
        expect(find.text('Please provide your basic contact information.'), findsOneWidget);
        expect(find.text('First Name'), findsOneWidget);
        expect(find.text('Last Name'), findsOneWidget);
        expect(find.text('Email'), findsOneWidget);
        expect(find.byType(AppDivider), findsOneWidget);
        expect(find.byType(AppFormField), findsNWidgets(3));
        
        final containers = tester.widgetList<Container>(find.byType(Container));
        final appFormContainer = containers.firstWhere((container) => container.padding == const EdgeInsets.all(16));
        expect(appFormContainer.padding, const EdgeInsets.all(16));
      });

      testWidgets('should display minimal form section', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppFormSection(
                title: 'Simple Section',
                children: const [Text('Simple content')],
              ),
            ),
          ),
        );

        expect(find.text('Simple Section'), findsOneWidget);
        expect(find.text('Simple content'), findsOneWidget);
        expect(find.byType(AppDivider), findsNothing);
      });

      testWidgets('should handle multiple form sections together', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Column(
                children: [
                  AppFormSection(
                    title: 'Section 1',
                    children: [
                      AppFormField(label: 'Field 1', onChanged: (_) {}),
                    ],
                    showDivider: true,
                  ),
                  AppFormSection(
                    title: 'Section 2',
                    children: [
                      AppFormField(label: 'Field 2', onChanged: (_) {}),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );

        expect(find.text('Section 1'), findsOneWidget);
        expect(find.text('Section 2'), findsOneWidget);
        expect(find.text('Field 1'), findsOneWidget);
        expect(find.text('Field 2'), findsOneWidget);
        expect(find.byType(AppFormSection), findsNWidgets(2));
        expect(find.byType(AppDivider), findsOneWidget); // Only first section has divider
      });
    });

    group('Edge Cases', () {
      testWidgets('should handle extreme padding values', (tester) async {
        const largePadding = EdgeInsets.all(100.0);
        
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppFormSection(
                title: 'Large Padding',
                children: const [Text('Content')],
                padding: largePadding,
              ),
            ),
          ),
        );

        final container = tester.widget<Container>(find.byType(Container));
        expect(container.padding, largePadding);
        expect(tester.takeException(), isNull);
      });

      testWidgets('should handle special characters in text', (tester) async {
        const specialTitle = 'Special: !@#\$%^&*() 🎉';
        const specialDescription = 'Description with émojis: 💯 ⭐ and spëcial chars';
        
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppFormSection(
                title: specialTitle,
                description: specialDescription,
                children: const [Text('Content')],
              ),
            ),
          ),
        );

        expect(find.text(specialTitle), findsOneWidget);
        expect(find.text(specialDescription), findsOneWidget);
        expect(tester.takeException(), isNull);
      });

      testWidgets('should handle very long content lists', (tester) async {
        final manyWidgets = List.generate(
          50,
          (index) => Container(
            height: 20,
            child: Text('Widget $index'),
          ),
        );

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: SingleChildScrollView(
                child: AppFormSection(
                  title: 'Many Widgets',
                  children: manyWidgets,
                ),
              ),
            ),
          ),
        );

        expect(find.text('Many Widgets'), findsOneWidget);
        expect(tester.takeException(), isNull);
      });
    });

    group('Accessibility', () {
      testWidgets('should be semantically accessible', (tester) async {
        final accessibleFields = [
          AppFormField(
            label: 'Accessible Field',
            onChanged: (_) {},
          ),
        ];

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppFormSection(
                title: 'Accessible Form Section',
                description: 'This section is fully accessible.',
                children: accessibleFields,
              ),
            ),
          ),
        );

        // Should use accessible text components
        expect(find.byType(AppText), findsNWidgets(3)); // Title + description + field label
        
        // Should use accessible form field components
        expect(find.byType(AppFormField), findsOneWidget);
        
        expect(find.text('Accessible Form Section'), findsOneWidget);
        expect(find.text('This section is fully accessible.'), findsOneWidget);
        expect(find.text('Accessible Field'), findsOneWidget);
      });

      testWidgets('should group related form fields semantically', (tester) async {
        final relatedFields = [
          AppFormField(label: 'First Name', onChanged: (_) {}),
          AppFormField(label: 'Last Name', onChanged: (_) {}),
        ];

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppFormSection(
                title: 'Name Information',
                description: 'Enter your full name',
                children: relatedFields,
              ),
            ),
          ),
        );

        // Form section groups related fields with descriptive title
        expect(find.text('Name Information'), findsOneWidget);
        expect(find.text('Enter your full name'), findsOneWidget);
        expect(find.byType(AppFormField), findsNWidgets(2));
      });
    });
  });
}