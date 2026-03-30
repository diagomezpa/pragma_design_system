import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pragma_design_system/organisms.dart';
import 'package:pragma_design_system/molecules.dart';
import 'package:pragma_design_system/atoms.dart';

void main() {
  group('AppCardList Tests', () {
    group('Constructor and Properties', () {
      testWidgets('should create with required children parameter', (tester) async {
        final testCards = [
          const AppCard(child: Text('Card 1')),
          const AppCard(child: Text('Card 2')),
        ];

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppCardList(children: testCards),
            ),
          ),
        );

        expect(find.byType(AppCardList), findsOneWidget);
        expect(find.text('Card 1'), findsOneWidget);
        expect(find.text('Card 2'), findsOneWidget);
      });

      testWidgets('should have correct default property values', (tester) async {
        const cardList = AppCardList(children: []);

        expect(cardList.title, isNull);
        expect(cardList.children, isEmpty);
        expect(cardList.separator, isNull);
        expect(cardList.padding, isNull);
        expect(cardList.isScrollable, false);
        expect(cardList.scrollPhysics, isNull);
        expect(cardList.shrinkWrap, true);
      });

      testWidgets('should accept all optional parameters', (tester) async {
        final customSeparator = Container(height: 8, color: Colors.red);
        const customPadding = EdgeInsets.all(16.0);

        final cardList = AppCardList(
          title: 'Custom Title',
          children: const [],
          separator: customSeparator,
          padding: customPadding,
          isScrollable: true,
          scrollPhysics: const BouncingScrollPhysics(),
          shrinkWrap: false,
        );

        expect(cardList.title, 'Custom Title');
        expect(cardList.separator, customSeparator);
        expect(cardList.padding, customPadding);
        expect(cardList.isScrollable, true);
        expect(cardList.scrollPhysics, isA<BouncingScrollPhysics>());
        expect(cardList.shrinkWrap, false);
      });
    });

    group('Static List Layout (isScrollable: false)', () {
      testWidgets('should display cards in column layout by default', (tester) async {
        final testCards = [
          const AppCard(child: Text('Card 1')),
          const AppCard(child: Text('Card 2')),
          const AppCard(child: Text('Card 3')),
        ];

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppCardList(children: testCards),
            ),
          ),
        );

        expect(find.byType(Column), findsAtLeastNWidgets(1));
        expect(find.text('Card 1'), findsOneWidget);
        expect(find.text('Card 2'), findsOneWidget);
        expect(find.text('Card 3'), findsOneWidget);
        expect(find.byType(ListView), findsNothing);
      });

      testWidgets('should add default separators between cards', (tester) async {
        final testCards = [
          const AppCard(child: Text('Card 1')),
          const AppCard(child: Text('Card 2')),
          const AppCard(child: Text('Card 3')),
        ];

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppCardList(children: testCards),
            ),
          ),
        );

        // Should have AppSpacer separators between cards
        final spacers = tester.widgetList<AppSpacer>(find.byType(AppSpacer));
        // 2 separators for 3 cards (between card1-card2 and card2-card3)
        expect(spacers.where((spacer) => spacer.size == AppSpacerSize.medium).length, 2);
      });

      testWidgets('should use custom separator when provided', (tester) async {
        final customSeparator = Container(
          height: 16,
          color: Colors.red,
          child: const Text('Custom Separator'),
        );

        final testCards = [
          const AppCard(child: Text('Card 1')),
          const AppCard(child: Text('Card 2')),
        ];

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppCardList(
                children: testCards,
                separator: customSeparator,
              ),
            ),
          ),
        );

        expect(find.text('Custom Separator'), findsOneWidget);
        expect(find.byType(Container), findsAtLeastNWidgets(1));
      });

      testWidgets('should handle empty children list gracefully', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppCardList(children: []),
            ),
          ),
        );

        expect(find.byType(AppCardList), findsOneWidget);
        expect(find.byType(SizedBox), findsOneWidget); // Empty state widget from SizedBox.shrink()
      });

      testWidgets('should handle single card without separator', (tester) async {
        final singleCard = [const AppCard(child: Text('Single Card'))];

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppCardList(children: singleCard),
            ),
          ),
        );

        expect(find.text('Single Card'), findsOneWidget);
        // No separators should be added for single card
        final spacers = tester.widgetList<AppSpacer>(find.byType(AppSpacer));
        expect(spacers.where((spacer) => spacer.size == AppSpacerSize.medium).length, 0);
      });
    });

    group('Scrollable List Layout (isScrollable: true)', () {
      testWidgets('should display cards in ListView when scrollable', (tester) async {
        final testCards = [
          const AppCard(child: Text('Card 1')),
          const AppCard(child: Text('Card 2')),
          const AppCard(child: Text('Card 3')),
        ];

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: SizedBox(
                height: 400,
                child: AppCardList(
                  children: testCards,
                  isScrollable: true,
                ),
              ),
            ),
          ),
        );

        expect(find.byType(ListView), findsOneWidget);
        expect(find.text('Card 1'), findsOneWidget);
        expect(find.text('Card 2'), findsOneWidget);
        expect(find.text('Card 3'), findsOneWidget);
      });

      testWidgets('should apply custom scroll physics when provided', (tester) async {
        final testCards = [
          const AppCard(child: Text('Card 1')),
          const AppCard(child: Text('Card 2')),
        ];

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: SizedBox(
                height: 400,
                child: AppCardList(
                  children: testCards,
                  isScrollable: true,
                  scrollPhysics: const BouncingScrollPhysics(),
                ),
              ),
            ),
          ),
        );

        final listView = tester.widget<ListView>(find.byType(ListView));
        expect(listView.physics, isA<BouncingScrollPhysics>());
      });

      testWidgets('should apply shrinkWrap property correctly', (tester) async {
        final testCards = [
          const AppCard(child: Text('Card 1')),
          const AppCard(child: Text('Card 2')),
        ];

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: SizedBox(
                height: 400,
                child: AppCardList(
                  children: testCards,
                  isScrollable: true,
                  shrinkWrap: false,
                ),
              ),
            ),
          ),
        );

        final listView = tester.widget<ListView>(find.byType(ListView));
        expect(listView.shrinkWrap, false);
      });

      testWidgets('should use ListView.separated with default separators', (tester) async {
        final testCards = [
          const AppCard(child: Text('Card 1')),
          const AppCard(child: Text('Card 2')),
          const AppCard(child: Text('Card 3')),
        ];

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: SizedBox(
                height: 400,
                child: AppCardList(
                  children: testCards,
                  isScrollable: true,
                ),
              ),
            ),
          ),
        );

        final listView = tester.widget<ListView>(find.byType(ListView));
        expect(listView.itemExtent, isNull); // ListView.separated doesn't use itemExtent
        expect(find.byType(AppSpacer), findsAtLeastNWidgets(2)); // Separators between cards
      });

      testWidgets('should handle large lists efficiently', (tester) async {
        final largeCardList = List.generate(
          100,
          (index) => AppCard(child: Text('Card ${index + 1}')),
        );

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: SizedBox(
                height: 600,
                child: AppCardList(
                  children: largeCardList,
                  isScrollable: true,
                  shrinkWrap: false, // Use Expanded to fill available space
                ),
              ),
            ),
          ),
        );

        expect(find.byType(ListView), findsOneWidget);
        expect(find.text('Card 1'), findsOneWidget);
        // Test scroll behavior with smaller scroll offset
        await tester.drag(find.byType(ListView), const Offset(0, -100));
        await tester.pumpAndSettle();
        
        // Should be able to scroll without issues
        expect(tester.takeException(), isNull);
      });
    });

    group('Title Display', () {
      testWidgets('should not show title when null', (tester) async {
        final testCards = [const AppCard(child: Text('Card 1'))];

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppCardList(children: testCards),
            ),
          ),
        );

        // Check that no AppText with titleLarge variant exists for title
        final titleTexts = tester.widgetList<AppText>(find.byType(AppText));
        final titleLargeTexts = titleTexts.where(
          (text) => text.variant == AppTextVariant.titleLarge,
        );
        expect(titleLargeTexts.length, 0);
      });

      testWidgets('should display title when provided', (tester) async {
        final testCards = [const AppCard(child: Text('Card 1'))];

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppCardList(
                title: 'My Card List',
                children: testCards,
              ),
            ),
          ),
        );

        expect(find.text('My Card List'), findsOneWidget);
        
        final titleWidget = tester.widget<AppText>(
          find.widgetWithText(AppText, 'My Card List'),
        );
        expect(titleWidget.variant, AppTextVariant.titleLarge);
      });

      testWidgets('should apply theme colors to title', (tester) async {
        final testCards = [const AppCard(child: Text('Card 1'))];

        await tester.pumpWidget(
          MaterialApp(
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(
                seedColor: Colors.purple,
                brightness: Brightness.light,
              ),
            ),
            home: Scaffold(
              body: AppCardList(
                title: 'Themed Title',
                children: testCards,
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

      testWidgets('should add spacing after title', (tester) async {
        final testCards = [const AppCard(child: Text('Card 1'))];

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppCardList(
                title: 'Spaced Title',
                children: testCards,
              ),
            ),
          ),
        );

        // Should have AppSpacer after title
        final spacers = tester.widgetList<AppSpacer>(find.byType(AppSpacer));
        final largeSpacer = spacers.firstWhere(
          (spacer) => spacer.size == AppSpacerSize.large,
          orElse: () => throw Exception('Large spacer not found after title'),
        );
        expect(largeSpacer.size, AppSpacerSize.large);
      });

      testWidgets('should handle empty title string', (tester) async {
        final testCards = [const AppCard(child: Text('Card 1'))];

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppCardList(
                title: '',
                children: testCards,
              ),
            ),
          ),
        );

        expect(find.text(''), findsOneWidget);
        expect(find.byType(AppText), findsOneWidget);
      });

      testWidgets('should handle long title text', (tester) async {
        const longTitle = 'This is a very long title that might wrap to multiple lines and should be handled gracefully by the card list component';
        final testCards = [const AppCard(child: Text('Card 1'))];

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppCardList(
                title: longTitle,
                children: testCards,
              ),
            ),
          ),
        );

        expect(find.text(longTitle), findsOneWidget);
        expect(tester.takeException(), isNull);
      });
    });

    group('Padding and Container Properties', () {
      testWidgets('should apply custom padding when provided', (tester) async {
        const customPadding = EdgeInsets.all(24.0);
        final testCards = [const AppCard(child: Text('Card 1'))];

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppCardList(
                children: testCards,
                padding: customPadding,
              ),
            ),
          ),
        );

        final containers = tester.widgetList<Container>(find.byType(Container));
        final appCardListContainer = containers.firstWhere((container) => container.padding == customPadding);
        expect(appCardListContainer.padding, customPadding);
      });

      testWidgets('should have no padding by default', (tester) async {
        final testCards = [const AppCard(child: Text('Card 1'))];

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppCardList(children: testCards),
            ),
          ),
        );

        final containers = tester.widgetList<Container>(find.byType(Container));
        final appCardListContainer = containers.firstWhere((container) => container.padding == null);
        expect(appCardListContainer.padding, isNull);
      });

      testWidgets('should apply asymmetric padding correctly', (tester) async {
        const asymmetricPadding = EdgeInsets.fromLTRB(10, 20, 30, 40);
        final testCards = [const AppCard(child: Text('Card 1'))];

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppCardList(
                children: testCards,
                padding: asymmetricPadding,
              ),
            ),
          ),
        );

        final containers = tester.widgetList<Container>(find.byType(Container));
        final appCardListContainer = containers.firstWhere((container) => container.padding == asymmetricPadding);
        expect(appCardListContainer.padding, asymmetricPadding);
      });
    });

    group('Integration with Design System', () {
      testWidgets('should use AppCard molecules correctly', (tester) async {
        final testCards = <Widget>[
          const AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Card Title', style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Text('Card Content'),
                SizedBox(height: 8),
                Text('Card Child'),
              ],
            ),
          ),
        ];

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppCardList(children: testCards),
            ),
          ),
        );

        expect(find.byType(AppCard), findsOneWidget);
        expect(find.text('Card Title'), findsOneWidget);
        expect(find.text('Card Content'), findsOneWidget);
        expect(find.text('Card Child'), findsOneWidget);
      });

      testWidgets('should use AppText atoms correctly', (tester) async {
        final testCards = [const AppCard(child: Text('Test Card'))];

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppCardList(
                title: 'System Integration',
                children: testCards,
              ),
            ),
          ),
        );

        final titleText = tester.widget<AppText>(
          find.widgetWithText(AppText, 'System Integration'),
        );
        expect(titleText.variant, AppTextVariant.titleLarge);
      });

      testWidgets('should use AppSpacer atoms for spacing', (tester) async {
        final testCards = [
          const AppCard(child: Text('Card 1')),
          const AppCard(child: Text('Card 2')),
        ];

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppCardList(
                title: 'Spaced Cards',
                children: testCards,
              ),
            ),
          ),
        );

        final spacers = tester.widgetList<AppSpacer>(find.byType(AppSpacer));
        // One large spacer after title, medium spacers between cards
        expect(spacers.where((s) => s.size == AppSpacerSize.large).length, 1);
        expect(spacers.where((s) => s.size == AppSpacerSize.medium).length, 1);
      });

      testWidgets('should integrate with mixed card types', (tester) async {
        final mixedCards = <Widget>[
          const AppCard(child: Text('Basic Card')),
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Titled Card', style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Container(height: 50, color: Colors.blue),
              ],
            ),
          ),
          const AppCard(
            child: Text('Content-only Card'),
          ),
        ];

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppCardList(children: mixedCards),
            ),
          ),
        );

        expect(find.text('Basic Card'), findsOneWidget);
        expect(find.text('Titled Card'), findsOneWidget);
        expect(find.text('Content-only Card'), findsOneWidget);
        expect(find.byType(AppCard), findsNWidgets(3));
      });
    });

    group('CustomWidget Integration', () {
      testWidgets('should accept non-AppCard widgets as children', (tester) async {
        final mixedChildren = [
          const AppCard(child: Text('Card Widget')),
          Container(
            padding: const EdgeInsets.all(16),
            child: const Text('Custom Container'),
          ),
          const ListTile(
            title: Text('List Tile Widget'),
            subtitle: Text('Custom widget'),
          ),
        ];

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppCardList(children: mixedChildren),
            ),
          ),
        );

        expect(find.text('Card Widget'), findsOneWidget);
        expect(find.text('Custom Container'), findsOneWidget);
        expect(find.text('List Tile Widget'), findsOneWidget);
        expect(find.byType(AppCard), findsOneWidget);
        expect(find.byType(Container), findsAtLeastNWidgets(1));
        expect(find.byType(ListTile), findsOneWidget);
      });
    });

    group('Theme Integration', () {
      testWidgets('should adapt to light theme', (tester) async {
        final testCards = [const AppCard(child: Text('Light Theme'))];

        await tester.pumpWidget(
          MaterialApp(
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(
                seedColor: Colors.blue,
                brightness: Brightness.light,
              ),
            ),
            home: Scaffold(
              body: AppCardList(
                title: 'Light Theme Title',
                children: testCards,
              ),
            ),
          ),
        );

        final titleWidget = tester.widget<AppText>(
          find.widgetWithText(AppText, 'Light Theme Title'),
        );
        final theme = Theme.of(tester.element(find.byType(Scaffold)));
        expect(titleWidget.color, theme.colorScheme.onSurface);
      });

      testWidgets('should adapt to dark theme', (tester) async {
        final testCards = [const AppCard(child: Text('Dark Theme'))];

        await tester.pumpWidget(
          MaterialApp(
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(
                seedColor: Colors.blue,
                brightness: Brightness.dark,
              ),
            ),
            home: Scaffold(
              body: AppCardList(
                title: 'Dark Theme Title',
                children: testCards,
              ),
            ),
          ),
        );

        final titleWidget = tester.widget<AppText>(
          find.widgetWithText(AppText, 'Dark Theme Title'),
        );
        final theme = Theme.of(tester.element(find.byType(Scaffold)));
        expect(titleWidget.color, theme.colorScheme.onSurface);
      });

      testWidgets('should work with custom color scheme', (tester) async {
        final testCards = [const AppCard(child: Text('Custom Colors'))];

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
              body: AppCardList(
                title: 'Custom Theme',
                children: testCards,
              ),
            ),
          ),
        );

        final titleWidget = tester.widget<AppText>(
          find.widgetWithText(AppText, 'Custom Theme'),
        );
        expect(titleWidget.color, customTheme.colorScheme.onSurface);
      });
    });

    group('Layout Behavior', () {
      testWidgets('should have proper column cross-axis alignment', (tester) async {
        final testCards = [const AppCard(child: Text('Aligned Card'))];

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppCardList(children: testCards),
            ),
          ),
        );

        final column = tester.widget<Column>(
          find.byType(Column).first, // Get the main Column
        );
        expect(column.crossAxisAlignment, CrossAxisAlignment.start);
        expect(column.mainAxisSize, MainAxisSize.min);
      });

      testWidgets('should handle different card heights gracefully', (tester) async {
        final varyingHeightCards = [
          AppCard(child: Container(height: 50, child: const Text('Short Card'))),
          AppCard(child: Container(height: 150, child: const Text('Tall Card'))),
          AppCard(child: Container(height: 100, child: const Text('Medium Card'))),
        ];

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppCardList(children: varyingHeightCards),
            ),
          ),
        );

        expect(find.text('Short Card'), findsOneWidget);
        expect(find.text('Tall Card'), findsOneWidget);
        expect(find.text('Medium Card'), findsOneWidget);
        expect(tester.takeException(), isNull);
      });

      testWidgets('should maintain layout consistency with many cards', (tester) async {
        final manyCards = List.generate(
          20,
          (index) => AppCard(child: Text('Card ${index + 1}')),
        );

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: SingleChildScrollView(
                child: AppCardList(children: manyCards),
              ),
            ),
          ),
        );

        // Check that first and last few cards are rendered correctly
        expect(find.text('Card 1'), findsOneWidget);
        expect(find.text('Card 2'), findsOneWidget);
        expect(tester.takeException(), isNull);
        
        // Cards should be arranged consistently
        final cardPositions = [
          tester.getTopLeft(find.text('Card 1')),
          tester.getTopLeft(find.text('Card 2')),
        ];
        
        // Second card should be below first card
        expect(cardPositions[1].dy, greaterThan(cardPositions[0].dy));
      });
    });

    group('Edge Cases', () {
      testWidgets('should handle null separator gracefully', (tester) async {
        final testCards = [
          const AppCard(child: Text('Card 1')),
          const AppCard(child: Text('Card 2')),
        ];

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppCardList(
                children: testCards,
                separator: null, // Explicit null
              ),
            ),
          ),
        );

        expect(find.text('Card 1'), findsOneWidget);
        expect(find.text('Card 2'), findsOneWidget);
        // Should use default AppSpacer.medium
        final spacers = tester.widgetList<AppSpacer>(find.byType(AppSpacer));
        expect(spacers.where((s) => s.size == AppSpacerSize.medium).length, 1);
      });

      testWidgets('should handle very large separators', (tester) async {
        final largeSeparator = Container(height: 200, color: Colors.orange);
        final testCards = [
          const AppCard(child: Text('Card 1')),
          const AppCard(child: Text('Card 2')),
        ];

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppCardList(
                children: testCards,
                separator: largeSeparator,
              ),
            ),
          ),
        );

        expect(find.byType(Container), findsAtLeastNWidgets(2)); // App container + custom separator
        expect(tester.takeException(), isNull);
      });

      testWidgets('should handle zero-height separators', (tester) async {
        final zeroSeparator = Container(height: 0);
        final testCards = [
          const AppCard(child: Text('Card 1')),
          const AppCard(child: Text('Card 2')),
        ];

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppCardList(
                children: testCards,
                separator: zeroSeparator,
              ),
            ),
          ),
        );

        expect(find.text('Card 1'), findsOneWidget);
        expect(find.text('Card 2'), findsOneWidget);
        expect(tester.takeException(), isNull);
      });
    });

    group('Accessibility', () {
      testWidgets('should be semantically accessible', (tester) async {
        final testCards = [
          const AppCard(child: Text('Accessible Card 1')),
          const AppCard(child: Text('Accessible Card 2')),
        ];

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppCardList(
                title: 'Accessible Card List',
                children: testCards,
              ),
            ),
          ),
        );

        // Should use accessible components (AppText, AppCard)
        expect(find.byType(AppText), findsAtLeastNWidgets(1)); // Title uses AppText
        expect(find.byType(AppCard), findsNWidgets(2));
        expect(find.text('Accessible Card List'), findsOneWidget);
        expect(find.text('Accessible Card 1'), findsOneWidget);
        expect(find.text('Accessible Card 2'), findsOneWidget);
      });

      testWidgets('should maintain semantic order in scrollable list', (tester) async {
        final accessibleCards = List.generate(
          5, // Reduce number of cards to fit in available space
          (index) => AppCard(child: Text('Accessible Item ${index + 1}')),
        );

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: SizedBox(
                height: 450, // Increase height to accommodate title and cards
                child: AppCardList(
                  title: 'Scrollable Accessible List',
                  children: accessibleCards,
                  isScrollable: true,
                ),
              ),
            ),
          ),
        );

        // ListView should maintain semantic order
        expect(find.byType(ListView), findsOneWidget);
        expect(find.text('Scrollable Accessible List'), findsOneWidget);
        expect(find.text('Accessible Item 1'), findsOneWidget);
      });
    });

    group('Performance', () {
      testWidgets('should not cause unnecessary rebuilds', (tester) async {
        int buildCount = 0;

        final testCards = [
          AppCard(
            child: Builder(
              builder: (context) {
                buildCount++;
                return const Text('Build Counter Card');
              },
            ),
          ),
        ];

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppCardList(children: testCards),
            ),
          ),
        );

        final initialBuildCount = buildCount;
        
        // Trigger a rebuild by adding/removing some content
        await tester.pump();
        
        // Build count should not increase unnecessarily
        expect(buildCount, initialBuildCount);
      });

      testWidgets('should handle rapid layout changes efficiently', (tester) async {
        final testCards = [const AppCard(child: Text('Stable Card'))];

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppCardList(children: testCards),
            ),
          ),
        );

        // Multiple pumps should not cause issues
        for (int i = 0; i < 5; i++) {
          await tester.pump(const Duration(milliseconds: 100));
        }

        expect(find.text('Stable Card'), findsOneWidget);
        expect(tester.takeException(), isNull);
      });
    });
  });
}