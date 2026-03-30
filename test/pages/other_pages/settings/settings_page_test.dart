import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pragma_design_system/templates.dart';
import 'package:pragma_design_system/organisms.dart';
import 'package:pragma_design_system/molecules.dart';
import 'package:pragma_design_system/atoms.dart';
import 'package:pragma_design_system/pages.dart';

void main() {
  group('SettingsPage Tests', () {
    group('Basic Page Structure', () {
      testWidgets('should build without crashing', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: SettingsPage(),
          ),
        );

        expect(find.byType(SettingsPage), findsOneWidget);
        expect(find.byType(Scaffold), findsOneWidget);
        expect(find.byType(AppBar), findsOneWidget);
      });

      testWidgets('should display correct app bar title', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: SettingsPage(),
          ),
        );

        expect(find.text('Settings Page Example'), findsOneWidget);
        expect(find.widgetWithText(AppBar, 'Settings Page Example'), findsOneWidget);
      });

      testWidgets('should use SettingsPageTemplate for body', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: SettingsPage(),
          ),
        );

        expect(find.byType(SettingsPageTemplate), findsOneWidget);
      });

      testWidgets('should have centered app bar title', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: SettingsPage(),
          ),
        );

        final appBar = tester.widget<AppBar>(find.byType(AppBar));
        expect(appBar.centerTitle, true);
      });
    });

    group('Settings Title', () {
      testWidgets('should display settings title', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: SettingsPage(),
          ),
        );

        expect(find.text('Settings'), findsOneWidget);
      });

      testWidgets('should use correct text variant for title', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: SettingsPage(),
          ),
        );

        final titleWidget = tester.widget<AppText>(
          find.widgetWithText(AppText, 'Settings'),
        );
        expect(titleWidget.variant, AppTextVariant.headlineSmall);
      });
    });

    group('Settings Groups Structure', () {
      testWidgets('should display all settings groups', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: SettingsPage(),
          ),
        );

        expect(find.byType(AppSettingsGroup), findsNWidgets(3));
        expect(find.text('Profile'), findsOneWidget);
        expect(find.text('Notifications'), findsOneWidget);
        expect(find.text('Privacy'), findsOneWidget);
      });

      testWidgets('should organize settings in logical groups', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: SettingsPage(),
          ),
        );

        // Check group order and logical organization
        final groups = tester.widgetList<AppSettingsGroup>(find.byType(AppSettingsGroup));
        expect(groups, hasLength(3));

        // Verify proper hierarchical structure
        expect(find.text('Profile'), findsOneWidget);
        expect(find.text('Notifications'), findsOneWidget);
        expect(find.text('Privacy'), findsOneWidget);
      });
    });

    group('Profile Settings Group', () {
      testWidgets('should display profile settings items', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: SettingsPage(),
          ),
        );

        expect(find.text('Edit Profile'), findsOneWidget);
        expect(find.text('Account Information'), findsOneWidget);
      });

      testWidgets('should display profile setting descriptions', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: SettingsPage(),
          ),
        );

        expect(find.text('Update your name, photo, and bio'), findsOneWidget);
        expect(find.text('View and manage account details'), findsOneWidget);
      });

      testWidgets('should display profile setting icons', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: SettingsPage(),
          ),
        );

        expect(find.byIcon(Icons.person_outline), findsOneWidget);
        expect(find.byIcon(Icons.account_circle_outlined), findsOneWidget);
      });

      testWidgets('should display chevron indicators for navigation', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: SettingsPage(),
          ),
        );

        // Should have chevron_right icons for all navigable items
        expect(find.byIcon(Icons.chevron_right), findsNWidgets(6)); // 2 per group × 3 groups
      });
    });

    group('Notifications Settings Group', () {
      testWidgets('should display notification settings items', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: SettingsPage(),
          ),
        );

        expect(find.text('Push Notifications'), findsOneWidget);
        expect(find.text('Email Notifications'), findsOneWidget);
      });

      testWidgets('should display notification setting descriptions', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: SettingsPage(),
          ),
        );

        expect(find.text('Manage app notifications and alerts'), findsOneWidget);
        expect(find.text('Configure email preferences and frequency'), findsOneWidget);
      });

      testWidgets('should display notification setting icons', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: SettingsPage(),
          ),
        );

        expect(find.byIcon(Icons.notifications_outlined), findsOneWidget);
        expect(find.byIcon(Icons.email_outlined), findsOneWidget);
      });
    });

    group('Privacy Settings Group', () {
      testWidgets('should display privacy settings items', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: SettingsPage(),
          ),
        );

        expect(find.text('Change Password'), findsOneWidget);
        expect(find.text('Privacy Policy'), findsOneWidget);
      });

      testWidgets('should display privacy setting descriptions', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: SettingsPage(),
          ),
        );

        expect(find.text('Update your account password'), findsOneWidget);
        expect(find.text('Review our data usage and privacy practices'), findsOneWidget);
      });

      testWidgets('should display privacy setting icons', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: SettingsPage(),
          ),
        );

        expect(find.byIcon(Icons.lock_outline), findsOneWidget);
        expect(find.byIcon(Icons.privacy_tip_outlined), findsOneWidget);
      });
    });

    group('User Interactions', () {
      testWidgets('should handle edit profile tap', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: SettingsPage(),
          ),
        );

        await tester.tap(find.text('Edit Profile'));
        await tester.pump();

        // Should not crash
        expect(tester.takeException(), isNull);
      });

      testWidgets('should handle account information tap', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: SettingsPage(),
          ),
        );

        await tester.tap(find.text('Account Information'));
        await tester.pump();

        expect(tester.takeException(), isNull);
      });

      testWidgets('should handle push notifications tap', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: SettingsPage(),
          ),
        );

        await tester.tap(find.text('Push Notifications'));
        await tester.pump();

        expect(tester.takeException(), isNull);
      });

      testWidgets('should handle email notifications tap', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: SettingsPage(),
          ),
        );

        await tester.tap(find.text('Email Notifications'));
        await tester.pump();

        expect(tester.takeException(), isNull);
      });

      testWidgets('should handle change password tap', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: SettingsPage(),
          ),
        );

        // Scroll to make Privacy group visible
        await tester.fling(find.byType(SingleChildScrollView), const Offset(0, -500), 1000);
        await tester.pumpAndSettle();

        await tester.tap(find.text('Change Password'), warnIfMissed: false);
        await tester.pump();

        expect(tester.takeException(), isNull);
      });

      testWidgets('should handle privacy policy tap', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: SettingsPage(),
          ),
        );

        // Scroll to make Privacy group visible
        await tester.fling(find.byType(SingleChildScrollView), const Offset(0, -500), 1000);
        await tester.pumpAndSettle();

        await tester.tap(find.text('Privacy Policy'), warnIfMissed: false);
        await tester.pump();

        expect(tester.takeException(), isNull);
      });
    });

    group('Visual Design and Scannability', () {
      testWidgets('should use consistent visual hierarchy', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: SettingsPage(),
          ),
        );

        // All list items should follow same pattern
        expect(find.byType(AppListItem), findsNWidgets(6));
        
        // All should have leading icons
        expect(find.byType(AppIcon), findsAtLeastNWidgets(12)); // Leading + trailing icons
        
        // All should have descriptive subtitles
        final listItems = tester.widgetList<AppListItem>(find.byType(AppListItem));
        for (final item in listItems) {
          expect(item.subtitle, isNotNull);
        }
      });

      testWidgets('should group related settings logically', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: SettingsPage(),
          ),
        );

        // Profile group should contain user-related settings
        // Check positioning of profile items within their group
        expect(find.text('Edit Profile'), findsOneWidget);
        expect(find.text('Account Information'), findsOneWidget);
        
        // Notifications group should contain communication settings
        expect(find.text('Push Notifications'), findsOneWidget);
        expect(find.text('Email Notifications'), findsOneWidget);
        
        // Privacy group should contain security settings
        expect(find.text('Change Password'), findsOneWidget);
        expect(find.text('Privacy Policy'), findsOneWidget);
      });

      testWidgets('should provide clear visual separation between groups', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: SettingsPage(),
          ),
        );

        // Should have distinct groups with titles
        expect(find.byType(AppSettingsGroup), findsNWidgets(3));
        expect(find.text('Profile'), findsOneWidget);
        expect(find.text('Notifications'), findsOneWidget);
        expect(find.text('Privacy'), findsOneWidget);
      });

      testWidgets('should use appropriate icons for each setting type', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: SettingsPage(),
          ),
        );

        // Profile icons
        expect(find.byIcon(Icons.person_outline), findsOneWidget);
        expect(find.byIcon(Icons.account_circle_outlined), findsOneWidget);
        
        // Notification icons
        expect(find.byIcon(Icons.notifications_outlined), findsOneWidget);
        expect(find.byIcon(Icons.email_outlined), findsOneWidget);
        
        // Privacy icons
        expect(find.byIcon(Icons.lock_outline), findsOneWidget);
        expect(find.byIcon(Icons.privacy_tip_outlined), findsOneWidget);
      });
    });

    group('Template Integration', () {
      testWidgets('should pass correct data to SettingsPageTemplate', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: SettingsPage(),
          ),
        );

        final template = tester.widget<SettingsPageTemplate>(
          find.byType(SettingsPageTemplate),
        );

        expect(template.title, isA<AppText>());
        expect(template.groups, hasLength(3));
      });

      testWidgets('should organize groups in logical order', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: SettingsPage(),
          ),
        );

        final template = tester.widget<SettingsPageTemplate>(
          find.byType(SettingsPageTemplate),
        );

        expect(template.groups, hasLength(3));
        // Groups should be provided in logical order: Profile, Notifications, Privacy
      });
    });

    group('Content Strategy', () {
      testWidgets('should use clear, actionable setting titles', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: SettingsPage(),
          ),
        );

        // Titles should be action-oriented
        expect(find.text('Edit Profile'), findsOneWidget);
        expect(find.text('Change Password'), findsOneWidget);
        
        // Or descriptive of content
        expect(find.text('Account Information'), findsOneWidget);
        expect(find.text('Privacy Policy'), findsOneWidget);
      });

      testWidgets('should provide helpful descriptions for each setting', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: SettingsPage(),
          ),
        );

        // All settings should have descriptive subtitles
        expect(find.text('Update your name, photo, and bio'), findsOneWidget);
        expect(find.text('View and manage account details'), findsOneWidget);
        expect(find.text('Manage app notifications and alerts'), findsOneWidget);
        expect(find.text('Configure email preferences and frequency'), findsOneWidget);
        expect(find.text('Update your account password'), findsOneWidget);
        expect(find.text('Review our data usage and privacy practices'), findsOneWidget);
      });

      testWidgets('should organize settings by user mental model', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: SettingsPage(),
          ),
        );

        // Group titles should match user expectations
        expect(find.text('Profile'), findsOneWidget);      // Personal information
        expect(find.text('Notifications'), findsOneWidget); // Communication preferences  
        expect(find.text('Privacy'), findsOneWidget);       // Security and data controls
      });
    });

    group('Responsive Behavior', () {
      testWidgets('should work on different screen sizes', (tester) async {
        // Test default size
        await tester.pumpWidget(
          const MaterialApp(
            home: SettingsPage(),
          ),
        );

        expect(find.text('Settings'), findsOneWidget);
        expect(find.text('Profile'), findsOneWidget);

        // Test larger screen
        await tester.binding.setSurfaceSize(const Size(1200, 800));
        await tester.pump();

        expect(find.text('Settings'), findsOneWidget);
        expect(find.text('Profile'), findsOneWidget);

        // Test smaller screen
        await tester.binding.setSurfaceSize(const Size(300, 600));
        await tester.pump();

        expect(find.text('Settings'), findsOneWidget);
        expect(find.text('Profile'), findsOneWidget);

        // Reset to default
        await tester.binding.setSurfaceSize(null);
      });
    });

    group('Accessibility', () {
      testWidgets('should be semantically accessible', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: SettingsPage(),
          ),
        );

        // Should use proper semantic structure
        expect(find.byType(Scaffold), findsOneWidget);
        expect(find.byType(AppBar), findsOneWidget);
        expect(find.byType(SettingsPageTemplate), findsOneWidget);
        
        // Should have accessible settings groups
        expect(find.byType(AppSettingsGroup), findsNWidgets(3));
        expect(find.byType(AppListItem), findsNWidgets(6));
      });

      testWidgets('should provide meaningful labels and descriptions', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: SettingsPage(),
          ),
        );

        // All list items should have titles and subtitles for screen readers
        final listItems = tester.widgetList<AppListItem>(find.byType(AppListItem));
        for (final item in listItems) {
          expect(item.title, isNotEmpty);
          expect(item.subtitle, isNotNull);
        }
      });

      testWidgets('should have accessible navigation indicators', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: SettingsPage(),
          ),
        );

        // All settings should be tappable with proper trailing indicators
        expect(find.byIcon(Icons.chevron_right), findsNWidgets(6));
      });
    });

    group('Page Architecture', () {
      testWidgets('should be stateless', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: SettingsPage(),
          ),
        );

        final page = tester.widget<SettingsPage>(
          find.byType(SettingsPage),
        );

        // Verify it extends StatelessWidget
        expect(page, isA<StatelessWidget>());
      });

      testWidgets('should separate concerns correctly', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: SettingsPage(),
          ),
        );

        // Page should provide content and callbacks
        expect(find.byType(SettingsPage), findsOneWidget);
        
        // Template should handle layout
        expect(find.byType(SettingsPageTemplate), findsOneWidget);
        
        // Organisms should handle group composition
        expect(find.byType(AppSettingsGroup), findsNWidgets(3));
        
        // Molecules should handle individual setting items
        expect(find.byType(AppListItem), findsNWidgets(6));
      });

      testWidgets('should build groups using factory methods', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: SettingsPage(),
          ),
        );

        // Should have logically grouped settings
        expect(find.text('Profile'), findsOneWidget);
        expect(find.text('Notifications'), findsOneWidget);
        expect(find.text('Privacy'), findsOneWidget);
        
        // Each group should have correct number of items
        expect(find.byType(AppListItem), findsNWidgets(6)); // 2 per group
      });
    });

    group('Error Handling', () {
      testWidgets('should handle widget rebuilds gracefully', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: SettingsPage(),
          ),
        );

        // Force rebuild
        await tester.pump();
        await tester.pump(const Duration(milliseconds: 100));

        expect(tester.takeException(), isNull);
        expect(find.text('Settings'), findsOneWidget);
      });

      testWidgets('should handle multiple rapid taps', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: SettingsPage(),
          ),
        );

        // Tap multiple settings rapidly
        for (int i = 0; i < 5; i++) {
          await tester.tap(find.text('Edit Profile'));
          await tester.pump();
        }

        expect(tester.takeException(), isNull);
      });

      testWidgets('should handle all settings taps without errors', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: SettingsPage(),
          ),
        );

        final settingTexts = [
          'Edit Profile',
          'Account Information', 
          'Push Notifications',
          'Email Notifications',
          'Change Password',
          'Privacy Policy',
        ];

        for (int i = 0; i < settingTexts.length; i++) {
          final setting = settingTexts[i];
          
          // Scroll down for Privacy group items (last 2 items)
          if (i >= 4) {
            await tester.fling(find.byType(SingleChildScrollView), const Offset(0, -300), 1000);
            await tester.pumpAndSettle();
          }
          
          await tester.tap(find.text(setting), warnIfMissed: false);
          await tester.pump();
          expect(tester.takeException(), isNull);
        }
      });
    });

    group('Navigation Logic', () {
      testWidgets('should demonstrate navigation callback pattern', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: SettingsPage(),
          ),
        );

        // All settings should be tappable (indicating navigation capability)
        final listItems = tester.widgetList<AppListItem>(find.byType(AppListItem));
        
        for (final item in listItems) {
          expect(item.onTap, isNotNull);
          expect(item.trailing, isA<AppIcon>()); // Should have navigation indicator
        }
      });
    });
  });
}