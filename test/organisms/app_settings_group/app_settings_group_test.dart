import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pragma_design_system/organisms.dart';
import 'package:pragma_design_system/molecules.dart';
import 'package:pragma_design_system/atoms.dart';

void main() {
  group('AppSettingsGroup Tests', () {
    group('Constructor and Properties', () {
      testWidgets('should create with required children parameter', (tester) async {
        final settingsItems = [
          AppListItem(title: 'Setting 1', onTap: () {}),
          AppListItem(title: 'Setting 2', onTap: () {}),
        ];

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppSettingsGroup(children: settingsItems),
            ),
          ),
        );

        expect(find.byType(AppSettingsGroup), findsOneWidget);
        expect(find.text('Setting 1'), findsOneWidget);
        expect(find.text('Setting 2'), findsOneWidget);
      });

      testWidgets('should have correct default property values', (tester) async {
        const settingsGroup = AppSettingsGroup(children: []);

        expect(settingsGroup.title, isNull);
        expect(settingsGroup.description, isNull);
        expect(settingsGroup.children, isEmpty);
        expect(settingsGroup.showDividers, true);
        expect(settingsGroup.isCard, false);
        expect(settingsGroup.padding, isNull);
      });

      testWidgets('should accept all optional parameters', (tester) async {
        const customPadding = EdgeInsets.all(24.0);
        final testChildren = [
          AppListItem(title: 'Test', onTap: () {}),
        ];

        const settingsGroup = AppSettingsGroup(
          title: 'Custom Group',
          description: 'Custom description',
          children: [],
          showDividers: false,
          isCard: true,
          padding: customPadding,
        );

        expect(settingsGroup.title, 'Custom Group');
        expect(settingsGroup.description, 'Custom description');
        expect(settingsGroup.children, isEmpty);
        expect(settingsGroup.showDividers, false);
        expect(settingsGroup.isCard, true);
        expect(settingsGroup.padding, customPadding);
      });
    });

    group('Title Display', () {
      testWidgets('should not display title when null', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppSettingsGroup(
                children: [AppListItem(title: 'Setting', onTap: () {})],
              ),
            ),
          ),
        );

        // Should not find any AppText with titleMedium variant
        final titleTexts = tester.widgetList<AppText>(find.byType(AppText));
        final titleMediumTexts = titleTexts.where(
          (text) => text.variant == AppTextVariant.titleMedium,
        );
        expect(titleMediumTexts.isEmpty, true);
      });

      testWidgets('should display title when provided', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppSettingsGroup(
                title: 'Account Settings',
                children: [AppListItem(title: 'Setting', onTap: () {})],
              ),
            ),
          ),
        );

        expect(find.text('Account Settings'), findsOneWidget);
        
        final titleWidget = tester.widget<AppText>(
          find.widgetWithText(AppText, 'Account Settings'),
        );
        expect(titleWidget.variant, AppTextVariant.titleMedium);
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
              body: AppSettingsGroup(
                title: 'Themed Title',
                children: [AppListItem(title: 'Setting', onTap: () {})],
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
        const longTitle = 'This is a very long settings group title that might wrap to multiple lines and should be handled gracefully';
        
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppSettingsGroup(
                title: longTitle,
                children: [AppListItem(title: 'Setting', onTap: () {})],
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
              body: AppSettingsGroup(
                title: '',
                children: [AppListItem(title: 'Setting', onTap: () {})],
              ),
            ),
          ),
        );

        expect(find.text(''), findsOneWidget);
        expect(find.byType(AppText), findsAtLeastNWidgets(1));
      });

      testWidgets('should handle special characters in title', (tester) async {
        const specialTitle = 'Settings: !@#\$%^&*() 🔧 Configuration';
        
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppSettingsGroup(
                title: specialTitle,
                children: [AppListItem(title: 'Setting', onTap: () {})],
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
              body: AppSettingsGroup(
                title: 'Settings',
                children: [AppListItem(title: 'Setting', onTap: () {})],
              ),
            ),
          ),
        );

        // Should not find any AppText with bodySmall variant for description
        final descriptionTexts = tester.widgetList<AppText>(find.byType(AppText));
        final bodySmallTexts = descriptionTexts.where(
          (text) => text.variant == AppTextVariant.bodySmall,
        );
        expect(bodySmallTexts.isEmpty, true);
      });

      testWidgets('should display description when provided', (tester) async {
        const description = 'Configure your account preferences and settings.';
        
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppSettingsGroup(
                title: 'Account',
                description: description,
                children: [AppListItem(title: 'Setting', onTap: () {})],
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
                seedColor: Colors.blue,
                brightness: Brightness.light,
              ),
            ),
            home: Scaffold(
              body: AppSettingsGroup(
                title: 'Settings',
                description: 'Themed description',
                children: [AppListItem(title: 'Setting', onTap: () {})],
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

      testWidgets('should display description without title', (tester) async {
        const description = 'Standalone description without title.';
        
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppSettingsGroup(
                description: description,
                children: [AppListItem(title: 'Setting', onTap: () {})],
              ),
            ),
          ),
        );

        expect(find.text(description), findsOneWidget);
        
        // Should not have title
        final titleTexts = tester.widgetList<AppText>(find.byType(AppText));
        final titleMediumTexts = titleTexts.where(
          (text) => text.variant == AppTextVariant.titleMedium,
        );
        expect(titleMediumTexts.isEmpty, true);
      });

      testWidgets('should handle long description text', (tester) async {
        const longDescription = 'This is a very long settings group description that provides detailed information about what this settings section contains and how users can interact with the various configuration options available in this particular group of related settings.';
        
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppSettingsGroup(
                title: 'Settings',
                description: longDescription,
                children: [AppListItem(title: 'Setting', onTap: () {})],
              ),
            ),
          ),
        );

        expect(find.text(longDescription), findsOneWidget);
        expect(tester.takeException(), isNull);
      });
    });

    group('Children Display', () {
      testWidgets('should display settings items as children', (tester) async {
        final settingsItems = [
          AppListItem(title: 'Notification Settings', onTap: () {}),
          AppListItem(title: 'Privacy Settings', onTap: () {}),
          AppListItem(title: 'Security Settings', onTap: () {}),
        ];

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppSettingsGroup(
                title: 'Preferences',
                children: settingsItems,
              ),
            ),
          ),
        );

        expect(find.text('Notification Settings'), findsOneWidget);
        expect(find.text('Privacy Settings'), findsOneWidget);
        expect(find.text('Security Settings'), findsOneWidget);
        expect(find.byType(AppListItem), findsNWidgets(3));
      });

      testWidgets('should handle empty children list', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppSettingsGroup(
                title: 'Empty Group',
                children: const [],
              ),
            ),
          ),
        );

        expect(find.text('Empty Group'), findsOneWidget);
        expect(find.byType(AppListItem), findsNothing);
        expect(tester.takeException(), isNull);
      });

      testWidgets('should handle single child', (tester) async {
        final singleItem = AppListItem(
          title: 'Single Setting',
          subtitle: 'Only setting in this group',
          onTap: () {},
        );

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppSettingsGroup(
                title: 'Single Item',
                children: [singleItem],
              ),
            ),
          ),
        );

        expect(find.text('Single Setting'), findsOneWidget);
        expect(find.text('Only setting in this group'), findsOneWidget);
        expect(find.byType(AppListItem), findsOneWidget);
      });

      testWidgets('should accept mixed widget types as children', (tester) async {
        final mixedChildren = [
          AppListItem(title: 'List Item', onTap: () {}),
          const Text('Custom text widget'),
          Container(
            padding: const EdgeInsets.all(8),
            child: const Text('Custom container'),
          ),
          Switch(value: true, onChanged: (_) {}),
        ];

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppSettingsGroup(
                title: 'Mixed Content',
                children: mixedChildren,
              ),
            ),
          ),
        );

        expect(find.text('List Item'), findsOneWidget);
        expect(find.text('Custom text widget'), findsOneWidget);
        expect(find.text('Custom container'), findsOneWidget);
        expect(find.byType(Switch), findsOneWidget);
        expect(find.byType(AppListItem), findsOneWidget);
        expect(find.byType(Container), findsAtLeastNWidgets(1));
      });

      testWidgets('should handle many children', (tester) async {
        final manyItems = List.generate(
          15,
          (index) => AppListItem(
            title: 'Setting ${index + 1}',
            onTap: () {},
          ),
        );

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: SingleChildScrollView(
                child: AppSettingsGroup(
                  title: 'Many Settings',
                  children: manyItems,
                ),
              ),
            ),
          ),
        );

        expect(find.text('Setting 1'), findsOneWidget);
        expect(find.text('Setting 15'), findsOneWidget);
        expect(find.byType(AppListItem), findsNWidgets(15));
        expect(tester.takeException(), isNull);
      });
    });

    group('Dividers Display', () {
      testWidgets('should show dividers between items by default', (tester) async {
        final settingsItems = [
          AppListItem(title: 'Setting 1', onTap: () {}),
          AppListItem(title: 'Setting 2', onTap: () {}),
          AppListItem(title: 'Setting 3', onTap: () {}),
        ];

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppSettingsGroup(
                title: 'With Dividers',
                children: settingsItems,
              ),
            ),
          ),
        );

        expect(find.byType(AppDivider), findsNWidgets(2)); // 2 dividers for 3 items
      });

      testWidgets('should not show dividers when showDividers is false', (tester) async {
        final settingsItems = [
          AppListItem(title: 'Setting 1', onTap: () {}),
          AppListItem(title: 'Setting 2', onTap: () {}),
          AppListItem(title: 'Setting 3', onTap: () {}),
        ];

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppSettingsGroup(
                title: 'No Dividers',
                children: settingsItems,
                showDividers: false,
              ),
            ),
          ),
        );

        expect(find.byType(AppDivider), findsNothing);
      });

      testWidgets('should not show divider after last item', (tester) async {
        final settingsItems = [
          AppListItem(title: 'First', onTap: () {}),
          AppListItem(title: 'Second', onTap: () {}),
          AppListItem(title: 'Last', onTap: () {}),
        ];

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppSettingsGroup(
                title: 'Divider Test',
                children: settingsItems,
                showDividers: true,
              ),
            ),
          ),
        );

        // Should have exactly 2 dividers (between first-second and second-last)
        expect(find.byType(AppDivider), findsNWidgets(2));
      });

      testWidgets('should not show dividers for single item', (tester) async {
        final singleItem = [
          AppListItem(title: 'Single Item', onTap: () {}),
        ];

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppSettingsGroup(
                title: 'Single Item',
                children: singleItem,
                showDividers: true,
              ),
            ),
          ),
        );

        expect(find.byType(AppDivider), findsNothing);
      });

      testWidgets('should not show dividers for empty children', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppSettingsGroup(
                title: 'Empty',
                children: const [],
                showDividers: true,
              ),
            ),
          ),
        );

        expect(find.byType(AppDivider), findsNothing);
      });
    });

    group('Card Styling', () {
      testWidgets('should not apply card styling by default', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppSettingsGroup(
                title: 'Default Style',
                children: [AppListItem(title: 'Setting', onTap: () {})],
              ),
            ),
          ),
        );

        expect(find.byType(Card), findsNothing);
      });

      testWidgets('should apply card styling when isCard is true', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppSettingsGroup(
                title: 'Card Style',
                children: [AppListItem(title: 'Setting', onTap: () {})],
                isCard: true,
              ),
            ),
          ),
        );

        expect(find.byType(Card), findsOneWidget);
        
        final card = tester.widget<Card>(find.byType(Card));
        expect(card.elevation, 1.0);
        
        final shape = card.shape as RoundedRectangleBorder;
        expect(shape.borderRadius, BorderRadius.circular(12));
      });

      testWidgets('should apply theme surface color to card', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(
                seedColor: Colors.green,
                brightness: Brightness.light,
              ),
            ),
            home: Scaffold(
              body: AppSettingsGroup(
                title: 'Themed Card',
                children: [AppListItem(title: 'Setting', onTap: () {})],
                isCard: true,
              ),
            ),
          ),
        );

        final card = tester.widget<Card>(find.byType(Card));
        final theme = Theme.of(tester.element(find.byType(Scaffold)));
        expect(card.color, theme.colorScheme.surface);
      });

      testWidgets('should work with card style and no dividers', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppSettingsGroup(
                title: 'Card No Dividers',
                children: [
                  AppListItem(title: 'Setting 1', onTap: () {}),
                  AppListItem(title: 'Setting 2', onTap: () {}),
                ],
                isCard: true,
                showDividers: false,
              ),
            ),
          ),
        );

        expect(find.byType(Card), findsOneWidget);
        expect(find.byType(AppDivider), findsNothing);
      });
    });

    group('Padding and Layout', () {
      testWidgets('should apply default padding', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppSettingsGroup(
                title: 'Default Padding',
                children: [AppListItem(title: 'Setting', onTap: () {})],
              ),
            ),
          ),
        );

        final paddings = tester.widgetList<Padding>(find.byType(Padding));
        final appSettingsPadding = paddings.firstWhere((p) => p.padding == const EdgeInsets.all(16));
        expect(appSettingsPadding.padding, const EdgeInsets.all(16));
      });

      testWidgets('should apply custom padding when provided', (tester) async {
        const customPadding = EdgeInsets.symmetric(horizontal: 32, vertical: 24);
        
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppSettingsGroup(
                title: 'Custom Padding',
                children: [AppListItem(title: 'Setting', onTap: () {})],
                padding: customPadding,
              ),
            ),
          ),
        );

        final paddings = tester.widgetList<Padding>(find.byType(Padding));
        final appSettingsPadding = paddings.firstWhere((p) => p.padding == customPadding);
        expect(appSettingsPadding.padding, customPadding);
      });

      testWidgets('should apply custom padding to card style', (tester) async {
        const customPadding = EdgeInsets.all(48);
        
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppSettingsGroup(
                title: 'Card Custom Padding',
                children: [AppListItem(title: 'Setting', onTap: () {})],
                isCard: true,
                padding: customPadding,
              ),
            ),
          ),
        );

        final paddings = tester.widgetList<Padding>(find.byType(Padding));
        final appSettingsPadding = paddings.firstWhere((p) => p.padding == customPadding);
        expect(appSettingsPadding.padding, customPadding);
        expect(find.byType(Card), findsOneWidget);
      });

      testWidgets('should have proper column layout properties', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppSettingsGroup(
                title: 'Layout Test',
                children: [AppListItem(title: 'Setting', onTap: () {})],
              ),
            ),
          ),
        );

        final columns = tester.widgetList<Column>(find.byType(Column));
        final appSettingsColumn = columns.firstWhere((c) => 
          c.crossAxisAlignment == CrossAxisAlignment.start && 
          c.mainAxisSize == MainAxisSize.min
        );
        expect(appSettingsColumn.crossAxisAlignment, CrossAxisAlignment.start);
        expect(appSettingsColumn.mainAxisSize, MainAxisSize.min);
      });
    });

    group('Spacing Between Elements', () {
      testWidgets('should add spacing between title and description', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppSettingsGroup(
                title: 'Title',
                description: 'Description',
                children: [AppListItem(title: 'Setting', onTap: () {})],
              ),
            ),
          ),
        );

        final spacers = tester.widgetList<AppSpacer>(find.byType(AppSpacer));
        expect(spacers.where((s) => s.size == AppSpacerSize.extraSmall).isNotEmpty, true);
      });

      testWidgets('should add spacing after header before content', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppSettingsGroup(
                title: 'Header',
                children: [AppListItem(title: 'Content', onTap: () {})],
              ),
            ),
          ),
        );

        final spacers = tester.widgetList<AppSpacer>(find.byType(AppSpacer));
        expect(spacers.where((s) => s.size == AppSpacerSize.medium).isNotEmpty, true);
      });

      testWidgets('should add spacing around dividers', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppSettingsGroup(
                title: 'With Dividers',
                children: [
                  AppListItem(title: 'Item 1', onTap: () {}),
                  AppListItem(title: 'Item 2', onTap: () {}),
                ],
                showDividers: true,
              ),
            ),
          ),
        );

        final spacers = tester.widgetList<AppSpacer>(find.byType(AppSpacer));
        expect(spacers.where((s) => s.size == AppSpacerSize.small).length, greaterThanOrEqualTo(2));
      });
    });

    group('Integration with Design System', () {
      testWidgets('should use AppText atoms correctly', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppSettingsGroup(
                title: 'Design System',
                description: 'Integration test',
                children: [AppListItem(title: 'Setting', onTap: () {})],
              ),
            ),
          ),
        );

        final titleText = tester.widget<AppText>(
          find.widgetWithText(AppText, 'Design System'),
        );
        expect(titleText.variant, AppTextVariant.titleMedium);

        final descriptionText = tester.widget<AppText>(
          find.widgetWithText(AppText, 'Integration test'),
        );
        expect(descriptionText.variant, AppTextVariant.bodySmall);
      });

      testWidgets('should use AppSpacer atoms for spacing', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppSettingsGroup(
                title: 'Spacing',
                description: 'Test spacing',
                children: [
                  AppListItem(title: 'Item 1', onTap: () {}),
                  AppListItem(title: 'Item 2', onTap: () {}),
                ],
              ),
            ),
          ),
        );

        expect(find.byType(AppSpacer), findsAtLeastNWidgets(2));
      });

      testWidgets('should use AppDivider atoms correctly', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppSettingsGroup(
                title: 'With Dividers',
                children: [
                  AppListItem(title: 'Item 1', onTap: () {}),
                  AppListItem(title: 'Item 2', onTap: () {}),
                ],
                showDividers: true,
              ),
            ),
          ),
        );

        expect(find.byType(AppDivider), findsOneWidget);
      });

      testWidgets('should integrate with AppListItem molecules', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppSettingsGroup(
                title: 'List Integration',
                children: [
                  AppListItem(
                    title: 'Notifications',
                    subtitle: 'Manage notification settings',
                    leading: const Icon(Icons.notifications),
                    trailing: Switch(value: true, onChanged: (_) {}),
                    onTap: () {},
                  ),
                  AppListItem(
                    title: 'Privacy',
                    leading: const Icon(Icons.privacy_tip),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ),
        );

        expect(find.byType(AppListItem), findsNWidgets(2));
        expect(find.text('Notifications'), findsOneWidget);
        expect(find.text('Privacy'), findsOneWidget);
        expect(find.byType(Switch), findsOneWidget);
        expect(find.byIcon(Icons.chevron_right), findsOneWidget);
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
              body: AppSettingsGroup(
                title: 'Light Theme',
                description: 'Light description',
                children: [AppListItem(title: 'Setting', onTap: () {})],
                isCard: true,
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
        
        final card = tester.widget<Card>(find.byType(Card));
        expect(card.color, theme.colorScheme.surface);
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
              body: AppSettingsGroup(
                title: 'Dark Theme',
                description: 'Dark description',
                children: [AppListItem(title: 'Setting', onTap: () {})],
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
    });

    group('Complete Settings Group Scenarios', () {
      testWidgets('should display complete settings group with all elements', (tester) async {
        bool setting1Toggled = false;
        bool setting2Tapped = false;
        
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppSettingsGroup(
                title: 'Privacy & Security',
                description: 'Manage your privacy settings and account security.',
                children: [
                  AppListItem(
                    title: 'Two-Factor Authentication',
                    subtitle: 'Add an extra layer of security',
                    leading: const Icon(Icons.security),
                    trailing: Switch(
                      value: setting1Toggled,
                      onChanged: (value) => setting1Toggled = value,
                    ),
                  ),
                  AppListItem(
                    title: 'Data Export',
                    subtitle: 'Download your personal data',
                    leading: const Icon(Icons.download),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () => setting2Tapped = true,
                  ),
                  AppListItem(
                    title: 'Delete Account',
                    subtitle: 'Permanently remove your account',
                    leading: const Icon(Icons.delete_forever, color: Colors.red),
                    onTap: () {},
                  ),
                ],
                isCard: true,
                showDividers: true,
              ),
            ),
          ),
        );

        expect(find.text('Privacy & Security'), findsOneWidget);
        expect(find.text('Manage your privacy settings and account security.'), findsOneWidget);
        expect(find.text('Two-Factor Authentication'), findsOneWidget);
        expect(find.text('Data Export'), findsOneWidget);
        expect(find.text('Delete Account'), findsOneWidget);
        expect(find.byType(Switch), findsOneWidget);
        expect(find.byType(Card), findsOneWidget);
        expect(find.byType(AppDivider), findsNWidgets(2));
        
        await tester.tap(find.text('Data Export'));
        expect(setting2Tapped, true);
      });

      testWidgets('should display minimal settings group', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppSettingsGroup(
                children: [AppListItem(title: 'Single Setting', onTap: () {})],
              ),
            ),
          ),
        );

        expect(find.text('Single Setting'), findsOneWidget);
        expect(find.byType(AppDivider), findsNothing);
        expect(find.byType(Card), findsNothing);
      });

      testWidgets('should handle multiple settings groups', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Column(
                children: [
                  AppSettingsGroup(
                    title: 'Account Settings',
                    children: [
                      AppListItem(title: 'Profile', onTap: () {}),
                      AppListItem(title: 'Email', onTap: () {}),
                    ],
                  ),
                  AppSettingsGroup(
                    title: 'Notification Settings',
                    children: [
                      AppListItem(title: 'Push Notifications', onTap: () {}),
                      AppListItem(title: 'Email Notifications', onTap: () {}),
                    ],
                    isCard: true,
                  ),
                ],
              ),
            ),
          ),
        );

        expect(find.text('Account Settings'), findsOneWidget);
        expect(find.text('Notification Settings'), findsOneWidget);
        expect(find.byType(AppSettingsGroup), findsNWidgets(2));
        expect(find.byType(Card), findsOneWidget); // Only second group has card
      });
    });

    group('Edge Cases', () {
      testWidgets('should handle extreme padding values', (tester) async {
        const largePadding = EdgeInsets.all(100.0);
        
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppSettingsGroup(
                title: 'Large Padding',
                children: [AppListItem(title: 'Setting', onTap: () {})],
                padding: largePadding,
              ),
            ),
          ),
        );

        final paddings = tester.widgetList<Padding>(find.byType(Padding));
        final appSettingsPadding = paddings.firstWhere((p) => p.padding == largePadding);
        expect(appSettingsPadding.padding, largePadding);
        expect(tester.takeException(), isNull);
      });

      testWidgets('should handle special characters in text', (tester) async {
        const specialTitle = 'Special: !@#\$%^&*() 🔧 Settings';
        const specialDescription = 'Description with émojis: 💯 ⭐ and spëcial chars';
        
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppSettingsGroup(
                title: specialTitle,
                description: specialDescription,
                children: [AppListItem(title: 'Setting', onTap: () {})],
              ),
            ),
          ),
        );

        expect(find.text(specialTitle), findsOneWidget);
        expect(find.text(specialDescription), findsOneWidget);
        expect(tester.takeException(), isNull);
      });

      testWidgets('should handle very large number of children', (tester) async {
        final manyChildren = List.generate(
          100,
          (index) => Container(
            height: 40,
            child: Text('Child $index'),
          ),
        );

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: SingleChildScrollView(
                child: AppSettingsGroup(
                  title: 'Many Children',
                  children: manyChildren,
                ),
              ),
            ),
          ),
        );

        expect(find.text('Many Children'), findsOneWidget);
        expect(tester.takeException(), isNull);
      });
    });

    group('Accessibility', () {
      testWidgets('should be semantically accessible', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppSettingsGroup(
                title: 'Accessible Settings Group',
                description: 'This settings group is fully accessible.',
                children: [
                  AppListItem(
                    title: 'Accessible Setting',
                    subtitle: 'This setting has proper accessibility',
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ),
        );

        // Should use accessible text components
        expect(find.byType(AppText), findsNWidgets(4)); // Title + description + list item texts
        
        // Should use accessible list item components
        expect(find.byType(AppListItem), findsOneWidget);
        
        expect(find.text('Accessible Settings Group'), findsOneWidget);
        expect(find.text('This settings group is fully accessible.'), findsOneWidget);
      });

      testWidgets('should group related settings semantically', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppSettingsGroup(
                title: 'Notification Preferences',
                description: 'Configure how you receive notifications',
                children: [
                  AppListItem(title: 'Email Notifications', onTap: () {}),
                  AppListItem(title: 'Push Notifications', onTap: () {}),
                ],
              ),
            ),
          ),
        );

        // Settings group logically groups related settings with descriptive title
        expect(find.text('Notification Preferences'), findsOneWidget);
        expect(find.text('Configure how you receive notifications'), findsOneWidget);
        expect(find.byType(AppListItem), findsNWidgets(2));
      });
    });
  });
}