import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pragma_design_system/molecules.dart';
import 'package:pragma_design_system/atoms.dart';

void main() {
  group('AppListItem Tests', () {
    group('Basic Rendering', () {
      testWidgets('should render with required title only', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppListItem(
                title: 'Basic Item',
              ),
            ),
          ),
        );

        expect(find.byType(AppListItem), findsOneWidget);
        expect(find.text('Basic Item'), findsOneWidget);
        expect(find.byType(Material), findsAtLeastNWidgets(1));
        expect(find.byType(InkWell), findsOneWidget);
        expect(find.byType(Row), findsOneWidget);
        expect(find.byType(Column), findsOneWidget);
        expect(find.byType(AppText), findsOneWidget);
      });

      testWidgets('should render with all components', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppListItem(
                leading: const AppIcon(Icons.person),
                title: 'Complete Item',
                subtitle: 'With all components',
                trailing: const AppIcon(Icons.arrow_forward),
                onTap: () {},
              ),
            ),
          ),
        );

        expect(find.byType(AppListItem), findsOneWidget);
        expect(find.text('Complete Item'), findsOneWidget);
        expect(find.text('With all components'), findsOneWidget);
        expect(find.byIcon(Icons.person), findsOneWidget);
        expect(find.byIcon(Icons.arrow_forward), findsOneWidget);
        expect(find.byType(AppIcon), findsNWidgets(2));
        expect(find.byType(AppText), findsNWidgets(2)); // Title + subtitle
        expect(find.byType(AppSpacer), findsAtLeastNWidgets(1));
      });

      testWidgets('should have correct material structure', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppListItem(
                title: 'Material Test',
              ),
            ),
          ),
        );

        final materials = tester.widgetList<Material>(find.byType(Material));
        expect(materials.any((m) => m.color == Colors.transparent), isTrue);

        final inkWell = tester.widget<InkWell>(find.byType(InkWell));
        expect(inkWell.borderRadius, BorderRadius.circular(8.0));
      });

      testWidgets('should have proper container padding', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppListItem(
                title: 'Padding Test',
              ),
            ),
          ),
        );

        final container = tester.widget<Container>(find.byType(Container).first);
        expect(container.padding, const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0));
      });
    });

    group('Leading Widget', () {
      testWidgets('should not render leading when not provided', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppListItem(
                title: 'No Leading',
              ),
            ),
          ),
        );

        expect(find.byType(SizedBox), findsNothing); // No leading size box
        final row = tester.widget<Row>(find.byType(Row));
        expect(row.children.length, 1); // Only expanded content
      });

      testWidgets('should render leading icon correctly', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppListItem(
                leading: AppIcon(Icons.account_circle),
                title: 'With Leading Icon',
              ),
            ),
          ),
        );

        expect(find.byIcon(Icons.account_circle), findsOneWidget);
        expect(find.byType(SizedBox), findsAtLeastNWidgets(1));

        final sizedBoxes = tester.widgetList<SizedBox>(find.byType(SizedBox));
        final leadingBox = sizedBoxes.firstWhere((box) => box.width == 40.0 && box.height == 40.0);
        expect(leadingBox.width, 40.0);
        expect(leadingBox.height, 40.0);
      });

      testWidgets('should render leading avatar correctly', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppListItem(
                leading: CircleAvatar(
                  child: Text('A'),
                ),
                title: 'With Avatar',
              ),
            ),
          ),
        );

        expect(find.byType(CircleAvatar), findsOneWidget);
        expect(find.text('A'), findsOneWidget);
        expect(find.byType(SizedBox), findsAtLeastNWidgets(1));
      });

      testWidgets('should align leading widget to center left', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppListItem(
                leading: AppIcon(Icons.star),
                title: 'Aligned Leading',
              ),
            ),
          ),
        );

        final sizedBoxes = tester.widgetList<SizedBox>(find.byType(SizedBox));
        final leadingBox = sizedBoxes.firstWhere((box) => box.width == 40.0);
        final align = tester.widget<Align>(find.ancestor(of: find.byIcon(Icons.star), matching: find.byType(Align)));
        expect(align.alignment, Alignment.centerLeft);
      });

      testWidgets('should include spacer after leading', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppListItem(
                leading: AppIcon(Icons.notification_important),
                title: 'Spaced Leading',
              ),
            ),
          ),
        );

        expect(find.byType(AppSpacer), findsAtLeastNWidgets(1));
        
        final spacers = tester.widgetList<AppSpacer>(find.byType(AppSpacer));
        expect(spacers.any((spacer) => 
            spacer.size == AppSpacerSize.medium && 
            spacer.direction == AppSpacerDirection.horizontal
        ), isTrue);
      });
    });

    group('Title Properties', () {
      testWidgets('should render title with correct style', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppListItem(
                title: 'Styled Title',
              ),
            ),
          ),
        );

        expect(find.text('Styled Title'), findsOneWidget);
        
        final titleTexts = tester.widgetList<AppText>(find.byType(AppText));
        final titleText = titleTexts.first;
        expect(titleText.text, 'Styled Title');
        expect(titleText.variant, AppTextVariant.bodyLarge);
        expect(titleText.fontWeight, FontWeight.w500);
        expect(titleText.maxLines, 1);
        expect(titleText.overflow, TextOverflow.ellipsis);
      });

      testWidgets('should handle long title text with ellipsis', (tester) async {
        const longTitle = 'This is a very long title that should be truncated with ellipsis when it exceeds the available space';
        
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: SizedBox(
                width: 200,
                child: AppListItem(
                  title: longTitle,
                ),
              ),
            ),
          ),
        );

        expect(find.text(longTitle), findsOneWidget);
        
        final titleTexts = tester.widgetList<AppText>(find.byType(AppText));
        final titleText = titleTexts.first;
        expect(titleText.maxLines, 1);
        expect(titleText.overflow, TextOverflow.ellipsis);
      });

      testWidgets('should handle empty title string', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppListItem(
                title: '',
              ),
            ),
          ),
        );

        expect(find.text(''), findsOneWidget);
        expect(find.byType(AppText), findsOneWidget);
      });

      testWidgets('should apply enabled title styling when enabled', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppListItem(
                title: 'Enabled Title',
                isEnabled: true,
              ),
            ),
          ),
        );

        final titleTexts = tester.widgetList<AppText>(find.byType(AppText));
        final titleText = titleTexts.first;
        expect(titleText.text, 'Enabled Title');
        expect(titleText.variant, AppTextVariant.bodyLarge);
      });

      testWidgets('should apply disabled title styling when disabled', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppListItem(
                title: 'Disabled Title',
                isEnabled: false,
              ),
            ),
          ),
        );

        final opacity = tester.widget<Opacity>(find.byType(Opacity));
        expect(opacity.opacity, 0.38);

        final titleTexts = tester.widgetList<AppText>(find.byType(AppText));
        final titleText = titleTexts.first;
        expect(titleText.variant, AppTextVariant.bodyLarge);
      });
    });

    group('Subtitle Properties', () {
      testWidgets('should not render subtitle when not provided', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppListItem(
                title: 'Title Only',
              ),
            ),
          ),
        );

        expect(find.byType(AppText), findsOneWidget); // Only title
        final column = tester.widget<Column>(find.byType(Column));
        expect(column.children.length, 1); // Only title in column
      });

      testWidgets('should render subtitle with correct style', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppListItem(
                title: 'Main Title',
                subtitle: 'Subtitle Text',
              ),
            ),
          ),
        );

        expect(find.text('Subtitle Text'), findsOneWidget);
        expect(find.byType(AppText), findsNWidgets(2)); // Title + subtitle
        
        final appTexts = tester.widgetList<AppText>(find.byType(AppText));
        final subtitleText = appTexts.firstWhere((text) => text.text == 'Subtitle Text');
        expect(subtitleText.variant, AppTextVariant.bodySmall);
        expect(subtitleText.maxLines, 2);
        expect(subtitleText.overflow, TextOverflow.ellipsis);
      });

      testWidgets('should include spacer between title and subtitle', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppListItem(
                title: 'Title',
                subtitle: 'Subtitle',
              ),
            ),
          ),
        );

        expect(find.byType(AppSpacer), findsAtLeastNWidgets(1));
        
        final spacers = tester.widgetList<AppSpacer>(find.byType(AppSpacer));
        expect(spacers.any((spacer) => spacer.size == AppSpacerSize.extraSmall), isTrue);

        final column = tester.widget<Column>(find.byType(Column));
        expect(column.children.length, 3); // Title + spacer + subtitle
      });

      testWidgets('should handle long subtitle text', (tester) async {
        const longSubtitle = 'This is a very long subtitle that might wrap to multiple lines but should be limited to two lines maximum with ellipsis overflow';
        
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: SizedBox(
                width: 200,
                child: AppListItem(
                  title: 'Title',
                  subtitle: longSubtitle,
                ),
              ),
            ),
          ),
        );

        expect(find.text(longSubtitle), findsOneWidget);
        
        final appTexts = tester.widgetList<AppText>(find.byType(AppText));
        final subtitleText = appTexts.firstWhere((text) => text.text == longSubtitle);
        expect(subtitleText.maxLines, 2);
        expect(subtitleText.overflow, TextOverflow.ellipsis);
      });

      testWidgets('should handle empty subtitle string', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppListItem(
                title: 'Title',
                subtitle: '',
              ),
            ),
          ),
        );

        expect(find.text('Title'), findsOneWidget);
        expect(find.byType(AppText), findsNWidgets(2)); // Title + subtitle rendered
      });

      testWidgets('should apply correct subtitle color when enabled/disabled', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppListItem(
                title: 'Test Title',
                subtitle: 'Test Subtitle',
                isEnabled: false,
              ),
            ),
          ),
        );

        final opacity = tester.widget<Opacity>(find.byType(Opacity));
        expect(opacity.opacity, 0.38);

        final appTexts = tester.widgetList<AppText>(find.byType(AppText));
        final subtitleText = appTexts.firstWhere((text) => text.text == 'Test Subtitle');
        expect(subtitleText.variant, AppTextVariant.bodySmall);
      });
    });

    group('Trailing Widget', () {
      testWidgets('should not render trailing when not provided', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppListItem(
                title: 'No Trailing',
              ),
            ),
          ),
        );

        final row = tester.widget<Row>(find.byType(Row));
        expect(row.children.length, 1); // Only expanded content, no trailing
      });

      testWidgets('should render trailing icon correctly', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppListItem(
                title: 'With Trailing',
                trailing: AppIcon(Icons.chevron_right),
              ),
            ),
          ),
        );

        expect(find.byIcon(Icons.chevron_right), findsOneWidget);
        
        final row = tester.widget<Row>(find.byType(Row));
        expect(row.children.length, 3); // Expanded content + spacer + flexible trailing
      });

      testWidgets('should render trailing button correctly', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppListItem(
                title: 'With Action',
                trailing: IconButton(
                  icon: const Icon(Icons.more_vert),
                  onPressed: () {},
                ),
              ),
            ),
          ),
        );

        expect(find.byType(IconButton), findsOneWidget);
        expect(find.byIcon(Icons.more_vert), findsOneWidget);
      });

      testWidgets('should include spacer before trailing', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppListItem(
                title: 'Spaced Trailing',
                trailing: AppIcon(Icons.bookmark),
              ),
            ),
          ),
        );

        expect(find.byType(AppSpacer), findsAtLeastNWidgets(1));
        
        final spacers = tester.widgetList<AppSpacer>(find.byType(AppSpacer));
        expect(spacers.any((spacer) => 
            spacer.size == AppSpacerSize.medium && 
            spacer.direction == AppSpacerDirection.horizontal
        ), isTrue);
      });

      testWidgets('should wrap trailing in flexible widget', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppListItem(
                title: 'Flexible Trailing',
                trailing: AppIcon(Icons.info),
              ),
            ),
          ),
        );

        expect(find.byType(Flexible), findsOneWidget);
        
        final flexible = tester.widget<Flexible>(find.byType(Flexible));
        expect(flexible.child, isA<AppIcon>());
      });
    });

    group('Tap Interaction', () {
      testWidgets('should call onTap when tapped and enabled', (tester) async {
        bool tapped = false;
        
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppListItem(
                title: 'Tappable Item',
                onTap: () => tapped = true,
              ),
            ),
          ),
        );

        await tester.tap(find.byType(AppListItem));
        await tester.pump();
        
        expect(tapped, isTrue);
      });

      testWidgets('should not call onTap when tapped and disabled', (tester) async {
        bool tapped = false;
        
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppListItem(
                title: 'Disabled Item',
                isEnabled: false,
                onTap: () => tapped = true,
              ),
            ),
          ),
        );

        await tester.tap(find.byType(AppListItem));
        await tester.pump();
        
        expect(tapped, isFalse);

        final inkWell = tester.widget<InkWell>(find.byType(InkWell));
        expect(inkWell.onTap, isNull); // Should be null when disabled
      });

      testWidgets('should handle null onTap callback', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppListItem(
                title: 'Non-interactive Item',
              ),
            ),
          ),
        );

        // Should not crash when tapping without callback
        await tester.tap(find.byType(AppListItem));
        await tester.pump();
        
        expect(tester.takeException(), isNull);

        final inkWell = tester.widget<InkWell>(find.byType(InkWell));
        expect(inkWell.onTap, isNull);
      });

      testWidgets('should show ripple effect on tap', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppListItem(
                title: 'Ripple Test',
                onTap: () {},
              ),
            ),
          ),
        );

        final inkWell = tester.widget<InkWell>(find.byType(InkWell));
        expect(inkWell.borderRadius, BorderRadius.circular(8.0));
      });
    });

    group('Enabled/Disabled State', () {
      testWidgets('should be enabled by default', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppListItem(
                title: 'Default State',
              ),
            ),
          ),
        );

        final opacity = tester.widget<Opacity>(find.byType(Opacity));
        expect(opacity.opacity, 1.0);
      });

      testWidgets('should apply disabled opacity when disabled', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppListItem(
                title: 'Disabled Item',
                isEnabled: false,
              ),
            ),
          ),
        );

        final opacity = tester.widget<Opacity>(find.byType(Opacity));
        expect(opacity.opacity, 0.38);
      });

      testWidgets('should disable interaction when disabled', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppListItem(
                title: 'Disabled Interactive',
                isEnabled: false,
                onTap: () {},
              ),
            ),
          ),
        );

        final inkWell = tester.widget<InkWell>(find.byType(InkWell));
        expect(inkWell.onTap, isNull); // Should be null when disabled
      });

      testWidgets('should maintain visual structure when disabled', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppListItem(
                leading: AppIcon(Icons.account_box),
                title: 'Disabled Complete',
                subtitle: 'All components',
                trailing: AppIcon(Icons.arrow_forward_ios),
                isEnabled: false,
              ),
            ),
          ),
        );

        expect(find.byType(AppIcon), findsNWidgets(2));
        expect(find.byType(AppText), findsNWidgets(2));
        expect(find.text('Disabled Complete'), findsOneWidget);
        expect(find.text('All components'), findsOneWidget);

        final opacity = tester.widget<Opacity>(find.byType(Opacity));
        expect(opacity.opacity, 0.38);
      });
    });

    group('Layout and Spacing', () {
      testWidgets('should have proper row alignment', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppListItem(
                leading: AppIcon(Icons.star),
                title: 'Alignment Test',
                trailing: AppIcon(Icons.chevron_right),
              ),
            ),
          ),
        );

        final row = tester.widget<Row>(find.byType(Row));
        expect(row.crossAxisAlignment, CrossAxisAlignment.center);
      });

      testWidgets('should have proper column alignment for content', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppListItem(
                title: 'Column Test',
                subtitle: 'Content alignment',
              ),
            ),
          ),
        );

        final column = tester.widget<Column>(find.byType(Column));
        expect(column.crossAxisAlignment, CrossAxisAlignment.start);
        expect(column.mainAxisSize, MainAxisSize.min);
      });

      testWidgets('should expand content area correctly', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppListItem(
                leading: AppIcon(Icons.person),
                title: 'Expanded Content',
                trailing: AppIcon(Icons.more_horiz),
              ),
            ),
          ),
        );

        expect(find.byType(Expanded), findsOneWidget);
        
        final expanded = tester.widget<Expanded>(find.byType(Expanded));
        expect(expanded.child, isA<Column>());
      });

      testWidgets('should maintain consistent spacing with multiple components', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: Column(
                children: [
                  AppListItem(
                    leading: AppIcon(Icons.home),
                    title: 'Home',
                    trailing: AppIcon(Icons.arrow_forward),
                  ),
                  AppListItem(
                    leading: AppIcon(Icons.settings),
                    title: 'Settings',
                    subtitle: 'Configure preferences',
                    trailing: AppIcon(Icons.arrow_forward),
                  ),
                  AppListItem(
                    title: 'Simple Item',
                  ),
                ],
              ),
            ),
          ),
        );

        expect(find.byType(AppListItem), findsNWidgets(3));
        expect(find.byType(AppSpacer), findsAtLeastNWidgets(3)); // Multiple spacers across items
      });
    });

    group('Design System Integration', () {
      testWidgets('should use design system atoms correctly', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppListItem(
                leading: AppIcon(Icons.notifications),
                title: 'System Integration',
                subtitle: 'Using AppText and AppIcon atoms',
                trailing: AppIcon(Icons.keyboard_arrow_right),
              ),
            ),
          ),
        );

        expect(find.byType(AppIcon), findsNWidgets(2)); // Leading + trailing
        expect(find.byType(AppText), findsNWidgets(2)); // Title + subtitle
        expect(find.byType(AppSpacer), findsAtLeastNWidgets(2)); // Various spacers
      });

      testWidgets('should compose well with other molecules', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppCard(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    AppListItem(
                      leading: AppIcon(Icons.person),
                      title: 'John Doe',
                      subtitle: 'Software Developer',
                    ),
                    AppListItem(
                      leading: AppIcon(Icons.email),
                      title: 'john@example.com',
                    ),
                  ],
                ),
              ),
            ),
          ),
        );

        expect(find.byType(AppCard), findsOneWidget);
        expect(find.byType(AppListItem), findsNWidgets(2));
        expect(find.text('John Doe'), findsOneWidget);
        expect(find.text('john@example.com'), findsOneWidget);
      });

      testWidgets('should integrate well in list contexts', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: ListView(
                children: const [
                  AppListItem(
                    leading: AppIcon(Icons.inbox),
                    title: 'Inbox',
                    subtitle: '5 new messages',
                    trailing: AppIcon(Icons.arrow_forward),
                  ),
                  AppListItem(
                    leading: AppIcon(Icons.send),
                    title: 'Sent',
                    trailing: AppIcon(Icons.arrow_forward),
                  ),
                  AppListItem(
                    leading: AppIcon(Icons.drafts),
                    title: 'Drafts',
                    subtitle: '2 unsent drafts',
                    trailing: AppIcon(Icons.arrow_forward),
                  ),
                ],
              ),
            ),
          ),
        );

        expect(find.byType(AppListItem), findsNWidgets(3));
        expect(find.text('5 new messages'), findsOneWidget);
        expect(find.text('2 unsent drafts'), findsOneWidget);
        expect(find.byIcon(Icons.inbox), findsOneWidget);
      });
    });

    group('Edge Cases', () {
      testWidgets('should handle very long title and subtitle gracefully', (tester) async {
        const veryLongTitle = 'This is an extremely long title that will definitely exceed the normal width constraints and should be handled gracefully with ellipsis';
        const veryLongSubtitle = 'This is also a very long subtitle text that should wrap to multiple lines but be constrained to maximum two lines with ellipsis overflow behavior for consistent layout';
        
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: SizedBox(
                width: 250,
                child: AppListItem(
                  title: veryLongTitle,
                  subtitle: veryLongSubtitle,
                ),
              ),
            ),
          ),
        );

        expect(find.text(veryLongTitle), findsOneWidget);
        expect(find.text(veryLongSubtitle), findsOneWidget);
        expect(tester.takeException(), isNull);
      });

      testWidgets('should handle special characters in text', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppListItem(
                title: 'Special chars: !@#\$%^&*()_+{}[]|:";\'<>?,./',
                subtitle: 'Unicode: 🦄 🎉 ⭐ 💯 🚀',
              ),
            ),
          ),
        );

        expect(find.text('Special chars: !@#\$%^&*()_+{}[]|:";\'<>?,./'), findsOneWidget);
        expect(find.text('Unicode: 🦄 🎉 ⭐ 💯 🚀'), findsOneWidget);
        expect(tester.takeException(), isNull);
      });

      testWidgets('should handle complex leading/trailing widgets', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppListItem(
                leading: Stack(
                  children: const [
                    AppIcon(Icons.account_circle, size: AppIconSize.large),
                    Positioned(
                      top: 0,
                      right: 0,
                      child: AppIcon(Icons.circle, size: AppIconSize.extraSmall),
                    ),
                  ],
                ),
                title: 'Complex Widgets',
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    AppIcon(Icons.star),
                    AppIcon(Icons.favorite),
                  ],
                ),
              ),
            ),
          ),
        );

        expect(find.byType(Stack), findsAtLeastNWidgets(1));
        expect(find.byIcon(Icons.account_circle), findsOneWidget);
        expect(find.byIcon(Icons.circle), findsOneWidget);
        expect(find.byIcon(Icons.star), findsOneWidget);
        expect(find.byIcon(Icons.favorite), findsOneWidget);
      });

      testWidgets('should handle multiple list items with different configurations', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: ListView(
                children: [
                  const AppListItem(title: 'Simple'),
                  const AppListItem(
                    leading: AppIcon(Icons.star),
                    title: 'With leading',
                  ),
                  const AppListItem(
                    title: 'With subtitle',
                    subtitle: 'Additional info',
                  ),
                  AppListItem(
                    leading: const AppIcon(Icons.settings),
                    title: 'Complete item',
                    subtitle: 'All components',
                    trailing: const AppIcon(Icons.arrow_forward),
                    onTap: () {},
                  ),
                  const AppListItem(
                    title: 'Disabled item',
                    isEnabled: false,
                  ),
                ],
              ),
            ),
          ),
        );

        expect(find.byType(AppListItem), findsNWidgets(5));
        expect(find.text('Simple'), findsOneWidget);
        expect(find.text('Complete item'), findsOneWidget);
        expect(find.text('Disabled item'), findsOneWidget);
      });
    });

    group('Accessibility', () {
      testWidgets('should maintain semantic structure for screen readers', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppListItem(
                leading: AppIcon(Icons.message),
                title: 'Important Message',
                subtitle: 'Tap to read details',
              ),
            ),
          ),
        );

        expect(find.text('Important Message'), findsOneWidget);
        expect(find.text('Tap to read details'), findsOneWidget);
        
        // Title and subtitle should be accessible through AppText widgets
        final appTexts = tester.widgetList<AppText>(find.byType(AppText)).toList();
        expect(appTexts, hasLength(2));
        expect(appTexts[0].text, 'Important Message');
        expect(appTexts[1].text, 'Tap to read details');
      });

      testWidgets('should support semantic gestures', (tester) async {
        bool tapped = false;
        
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppListItem(
                title: 'Accessible Item',
                subtitle: 'Can be activated',
                onTap: () => tapped = true,
              ),
            ),
          ),
        );

        // Semantic tap should work
        expect(find.byType(InkWell), findsOneWidget);
        
        await tester.tap(find.byType(AppListItem));
        await tester.pump();
        expect(tapped, isTrue);
      });

      testWidgets('should provide proper contrast for disabled state', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppListItem(
                title: 'Disabled for accessibility',
                subtitle: 'Reduced opacity but still readable',
                isEnabled: false,
              ),
            ),
          ),
        );

        final opacity = tester.widget<Opacity>(find.byType(Opacity));
        expect(opacity.opacity, 0.38); // Standard disabled opacity
        
        expect(find.text('Disabled for accessibility'), findsOneWidget);
        expect(find.text('Reduced opacity but still readable'), findsOneWidget);
      });

      testWidgets('should maintain focus behavior', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Column(
                children: [
                  AppListItem(
                    title: 'First item',
                    onTap: () {},
                  ),
                  AppListItem(
                    title: 'Second item',
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ),
        );

        // Both items should be focusable
        expect(find.byType(InkWell), findsNWidgets(2));
        expect(find.text('First item'), findsOneWidget);
        expect(find.text('Second item'), findsOneWidget);
      });
    });
  });
}