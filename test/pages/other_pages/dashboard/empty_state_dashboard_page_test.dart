import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pragma_design_system/templates.dart';
import 'package:pragma_design_system/organisms.dart';
import 'package:pragma_design_system/atoms.dart';
import 'package:pragma_design_system/pages.dart';

void main() {
  group('EmptyStateDashboardPage Tests', () {
    group('Basic Page Structure', () {
      testWidgets('should build without crashing', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: EmptyStateDashboardPage(),
          ),
        );

        expect(find.byType(EmptyStateDashboardPage), findsOneWidget);
        expect(find.byType(Scaffold), findsOneWidget);
        expect(find.byType(AppBar), findsOneWidget);
      });

      testWidgets('should display correct app bar title', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: EmptyStateDashboardPage(),
          ),
        );

        expect(find.text('Empty State Dashboard'), findsOneWidget);
        expect(find.widgetWithText(AppBar, 'Empty State Dashboard'), findsOneWidget);
      });

      testWidgets('should use EmptyStateDashboardTemplate for body', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: EmptyStateDashboardPage(),
          ),
        );

        expect(find.byType(EmptyStateDashboardTemplate), findsOneWidget);
      });

      testWidgets('should have centered app bar title', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: EmptyStateDashboardPage(),
          ),
        );

        final appBar = tester.widget<AppBar>(find.byType(AppBar));
        expect(appBar.centerTitle, true);
      });
    });

    group('Empty State Content', () {
      testWidgets('should display empty state section', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: EmptyStateDashboardPage(),
          ),
        );

        expect(find.byType(AppEmptyStateSection), findsOneWidget);
      });

      testWidgets('should display welcome title', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: EmptyStateDashboardPage(),
          ),
        );

        expect(find.text('Welcome to your dashboard'), findsOneWidget);
      });

      testWidgets('should display descriptive content', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: EmptyStateDashboardPage(),
          ),
        );

        const expectedDescription = 'Your dashboard is where you\'ll track progress, view insights, and manage your most important items. Once you create your first item, you\'ll see it come to life here.';
        expect(find.text(expectedDescription), findsOneWidget);
      });

      testWidgets('should display dashboard icon', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: EmptyStateDashboardPage(),
          ),
        );

        expect(find.byIcon(Icons.dashboard_outlined), findsOneWidget);
      });
    });

    group('Call-to-Action Button', () {
      testWidgets('should display primary action button', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: EmptyStateDashboardPage(),
          ),
        );

        expect(find.text('Create your first item'), findsOneWidget);
        expect(find.byType(AppButton), findsOneWidget);
      });

      testWidgets('should use correct button styling', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: EmptyStateDashboardPage(),
          ),
        );

        final button = tester.widget<AppButton>(
          find.widgetWithText(AppButton, 'Create your first item'),
        );

        expect(button.variant, AppButtonVariant.primary);
        expect(button.size, AppButtonSize.large);
      });

      testWidgets('should handle button tap interaction', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: EmptyStateDashboardPage(),
          ),
        );

        // Tap the create button
        await tester.tap(find.text('Create your first item'));
        await tester.pump();

        // Should not crash or throw exceptions
        expect(tester.takeException(), isNull);
      });

      testWidgets('should be tappable', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: EmptyStateDashboardPage(),
          ),
        );

        final button = find.text('Create your first item');
        
        // Verify button is enabled and tappable
        await tester.ensureVisible(button);
        await tester.tap(button);
        await tester.pump();

        expect(tester.takeException(), isNull);
      });
    });

    group('Template Integration', () {
      testWidgets('should pass empty state to template', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: EmptyStateDashboardPage(),
          ),
        );

        final template = tester.widget<EmptyStateDashboardTemplate>(
          find.byType(EmptyStateDashboardTemplate),
        );

        expect(template.emptyState, isA<AppEmptyStateSection>());
        expect(template.header, isNull);
        expect(template.footer, isNull);
      });

      testWidgets('should create template with minimal configuration', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: EmptyStateDashboardPage(),
          ),
        );

        final template = tester.widget<EmptyStateDashboardTemplate>(
          find.byType(EmptyStateDashboardTemplate),
        );

        // Should only have empty state, no header or footer
        expect(template.header, isNull);
        expect(template.footer, isNull);
        expect(template.emptyState, isNotNull);
      });
    });

    group('Content Strategy', () {
      testWidgets('should use welcoming and motivational language', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: EmptyStateDashboardPage(),
          ),
        );

        // Welcoming tone
        expect(find.textContaining('Welcome'), findsOneWidget);
        
        // Personal ownership language
        expect(find.textContaining('your dashboard'), findsOneWidget);
        
        // Motivational action text
        expect(find.textContaining('Create your first'), findsOneWidget);
      });

      testWidgets('should explain dashboard value proposition', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: EmptyStateDashboardPage(),
          ),
        );

        // Should explain what the dashboard will provide
        expect(find.textContaining('track progress'), findsOneWidget);
        expect(find.textContaining('view insights'), findsOneWidget);
        expect(find.textContaining('manage your most important items'), findsOneWidget);
      });

      testWidgets('should provide clear next steps', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: EmptyStateDashboardPage(),
          ),
        );

        // Should tell users what will happen after they act
        expect(find.textContaining('Once you create your first item'), findsOneWidget);
        expect(find.textContaining('come to life here'), findsOneWidget);
      });
    });

    group('User Experience Flow', () {
      testWidgets('should represent critical conversion moment', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: EmptyStateDashboardPage(),
          ),
        );

        // Should have obvious, prominent call-to-action
        final createButton = find.text('Create your first item');
        expect(createButton, findsOneWidget);
        
        // Button should be visually prominent (primary variant, large size)
        final button = tester.widget<AppButton>(
          find.widgetWithText(AppButton, 'Create your first item'),
        );
        expect(button.variant, AppButtonVariant.primary);
        expect(button.size, AppButtonSize.large);
      });

      testWidgets('should focus on first-time user guidance', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: EmptyStateDashboardPage(),
          ),
        );

        // Language should be focused on first-time experience
        expect(find.textContaining('first item'), findsWidgets);
        expect(find.textContaining('Welcome'), findsOneWidget);
        expect(find.textContaining('your dashboard'), findsOneWidget);
      });
    });

    group('Visual Hierarchy', () {
      testWidgets('should use appropriate icon for context', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: EmptyStateDashboardPage(),
          ),
        );

        // Should use dashboard-related icon
        expect(find.byIcon(Icons.dashboard_outlined), findsOneWidget);
      });

      testWidgets('should structure content for scannability', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: EmptyStateDashboardPage(),
          ),
        );

        // Should have clear hierarchy: icon -> title -> description -> action
        expect(find.byType(AppEmptyStateSection), findsOneWidget);
        expect(find.byIcon(Icons.dashboard_outlined), findsOneWidget);
        expect(find.text('Welcome to your dashboard'), findsOneWidget);
        expect(find.text('Create your first item'), findsOneWidget);
      });
    });

    group('Responsive Behavior', () {
      testWidgets('should work on different screen sizes', (tester) async {
        // Test default size
        await tester.pumpWidget(
          const MaterialApp(
            home: EmptyStateDashboardPage(),
          ),
        );

        expect(find.text('Welcome to your dashboard'), findsOneWidget);

        // Test larger screen
        await tester.binding.setSurfaceSize(const Size(1200, 800));
        await tester.pump();

        expect(find.text('Welcome to your dashboard'), findsOneWidget);
        expect(find.text('Create your first item'), findsOneWidget);

        // Test smaller screen (use a more reasonable size to avoid overflow)
        await tester.binding.setSurfaceSize(const Size(400, 800));
        await tester.pump();

        // Should still display content on smaller screen
        expect(find.text('Welcome to your dashboard'), findsOneWidget);
        expect(find.text('Create your first item'), findsOneWidget);

        // Reset to default
        await tester.binding.setSurfaceSize(null);
      });
    });

    group('Accessibility', () {
      testWidgets('should be semantically accessible', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: EmptyStateDashboardPage(),
          ),
        );

        // Should use proper semantic structure
        expect(find.byType(Scaffold), findsOneWidget);
        expect(find.byType(AppBar), findsOneWidget);
        expect(find.byType(AppEmptyStateSection), findsOneWidget);
        
        // Should have accessible interactive elements
        expect(find.byType(AppButton), findsOneWidget);
      });

      testWidgets('should provide meaningful content for screen readers', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: EmptyStateDashboardPage(),
          ),
        );

        // Should have descriptive text that provides context
        expect(find.text('Welcome to your dashboard'), findsOneWidget);
        expect(find.textContaining('track progress, view insights'), findsOneWidget);
        expect(find.text('Create your first item'), findsOneWidget);
      });
    });

    group('Error Handling', () {
      testWidgets('should handle widget rebuilds gracefully', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: EmptyStateDashboardPage(),
          ),
        );

        // Force rebuild
        await tester.pump();
        await tester.pump(const Duration(milliseconds: 100));

        expect(tester.takeException(), isNull);
        expect(find.text('Welcome to your dashboard'), findsOneWidget);
      });

      testWidgets('should handle multiple button taps', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: EmptyStateDashboardPage(),
          ),
        );

        // Tap button multiple times rapidly
        for (int i = 0; i < 5; i++) {
          await tester.tap(find.text('Create your first item'));
          await tester.pump();
        }

        expect(tester.takeException(), isNull);
      });
    });

    group('Page Architecture', () {
      testWidgets('should be stateless', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: EmptyStateDashboardPage(),
          ),
        );

        final page = tester.widget<EmptyStateDashboardPage>(
          find.byType(EmptyStateDashboardPage),
        );

        // Verify it extends StatelessWidget
        expect(page, isA<StatelessWidget>());
      });

      testWidgets('should separate concerns correctly', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: EmptyStateDashboardPage(),
          ),
        );

        // Page should provide content and callbacks
        expect(find.byType(EmptyStateDashboardPage), findsOneWidget);
        
        // Template should handle layout
        expect(find.byType(EmptyStateDashboardTemplate), findsOneWidget);
        
        // Organism should handle component composition
        expect(find.byType(AppEmptyStateSection), findsOneWidget);
      });
    });
  });
}