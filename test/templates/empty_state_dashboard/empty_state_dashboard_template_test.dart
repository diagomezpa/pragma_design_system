import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pragma_design_system/templates.dart';
import 'package:pragma_design_system/molecules.dart';
import 'package:pragma_design_system/organisms.dart';
import 'package:pragma_design_system/atoms.dart';

void main() {
  group('EmptyStateDashboardTemplate Tests', () {
    Widget createTestEmptyState() {
      return AppEmptyStateSection(
        title: 'Test Empty State',
        description: 'Test description',
      );
    }

    group('Constructor and Properties', () {
      testWidgets('should create with required emptyState parameter', (tester) async {
        final emptyState = createTestEmptyState();
        final template = EmptyStateDashboardTemplate(
          emptyState: emptyState,
        );

        expect(template.emptyState, emptyState);
        expect(template.header, isNull);
        expect(template.footer, isNull);
      });

      testWidgets('should accept all optional parameters', (tester) async {
        final headerWidget = AppText('Header', variant: AppTextVariant.titleLarge);
        final emptyState = createTestEmptyState();
        final footerWidget = AppText('Footer', variant: AppTextVariant.bodySmall);

        final template = EmptyStateDashboardTemplate(
          header: headerWidget,
          emptyState: emptyState,
          footer: footerWidget,
        );

        expect(template.header, headerWidget);
        expect(template.emptyState, emptyState);
        expect(template.footer, footerWidget);
      });
    });

    group('Basic Template Structure', () {
      testWidgets('should display basic template with only empty state', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: EmptyStateDashboardTemplate(
                emptyState: createTestEmptyState(),
              ),
            ),
          ),
        );

        expect(find.byType(AppSection), findsOneWidget);
        expect(find.byType(AppEmptyStateSection), findsOneWidget);
        expect(find.text('Test Empty State'), findsOneWidget);
        expect(find.text('Test description'), findsOneWidget);
      });

      testWidgets('should use AppSection as root container', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: EmptyStateDashboardTemplate(
                emptyState: createTestEmptyState(),
              ),
            ),
          ),
        );

        final appSection = tester.widget<AppSection>(find.byType(AppSection));
        expect(appSection.title, 'Dashboard');
      });

      testWidgets('should have proper column layout properties', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: EmptyStateDashboardTemplate(
                emptyState: createTestEmptyState(),
              ),
            ),
          ),
        );

        final columns = tester.widgetList<Column>(find.byType(Column));
        final templateColumn = columns.firstWhere((col) => col.crossAxisAlignment == CrossAxisAlignment.start);
        expect(templateColumn.crossAxisAlignment, CrossAxisAlignment.start);
        expect(templateColumn.mainAxisSize, MainAxisSize.min);
      });
    });

    group('Header Section', () {
      testWidgets('should not display header when null', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: EmptyStateDashboardTemplate(
                emptyState: createTestEmptyState(),
              ),
            ),
          ),
        );

        // Should not find header content
        expect(find.text('Header Content'), findsNothing);
      });

      testWidgets('should display header when provided', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: EmptyStateDashboardTemplate(
                header: AppText('Dashboard Title', variant: AppTextVariant.titleLarge),
                emptyState: createTestEmptyState(),
              ),
            ),
          ),
        );

        expect(find.text('Dashboard Title'), findsOneWidget);
        final headerWidget = tester.widget<AppText>(
          find.widgetWithText(AppText, 'Dashboard Title'),
        );
        expect(headerWidget.variant, AppTextVariant.titleLarge);
      });

      testWidgets('should add spacing after header', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: EmptyStateDashboardTemplate(
                header: AppText('Header With Spacing', variant: AppTextVariant.titleMedium),
                emptyState: createTestEmptyState(),
              ),
            ),
          ),
        );

        expect(find.text('Header With Spacing'), findsOneWidget);
        expect(find.byType(AppSpacer), findsAtLeastNWidgets(1));
      });

      testWidgets('should support complex header widgets', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: EmptyStateDashboardTemplate(
                header: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText('Home > Analytics', variant: AppTextVariant.bodySmall),
                    AppSpacer(size: AppSpacerSize.small),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppText('Analytics Dashboard', variant: AppTextVariant.titleLarge),
                        AppButton(text: 'Refresh', onPressed: () {}),
                      ],
                    ),
                  ],
                ),
                emptyState: createTestEmptyState(),
              ),
            ),
          ),
        );

        expect(find.text('Home > Analytics'), findsOneWidget);
        expect(find.text('Analytics Dashboard'), findsOneWidget);
        expect(find.text('Refresh'), findsOneWidget);
      });

      testWidgets('should support header with actions', (tester) async {
        bool buttonPressed = false;

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: EmptyStateDashboardTemplate(
                header: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppText('Dashboard', variant: AppTextVariant.titleLarge),
                    AppButton(
                      text: 'Action',
                      onPressed: () => buttonPressed = true,
                    ),
                  ],
                ),
                emptyState: createTestEmptyState(),
              ),
            ),
          ),
        );

        expect(find.text('Dashboard'), findsWidgets);
        expect(find.text('Action'), findsOneWidget);
        
        await tester.tap(find.text('Action'));
        expect(buttonPressed, true);
      });

      testWidgets('should handle long header text', (tester) async {
        const longHeader = 'This is a very long dashboard header that might wrap to multiple lines and should be handled gracefully by the template layout system';
        
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: EmptyStateDashboardTemplate(
                header: AppText(longHeader, variant: AppTextVariant.titleMedium),
                emptyState: createTestEmptyState(),
              ),
            ),
          ),
        );

        expect(find.text(longHeader), findsOneWidget);
        expect(tester.takeException(), isNull);
      });

      testWidgets('should handle empty header text', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: EmptyStateDashboardTemplate(
                header: AppText('', variant: AppTextVariant.titleMedium),
                emptyState: createTestEmptyState(),
              ),
            ),
          ),
        );

        expect(find.text(''), findsOneWidget);
        expect(find.byType(AppText), findsAtLeastNWidgets(1));
      });
    });

    group('Empty State Section', () {
      testWidgets('should always display empty state', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: EmptyStateDashboardTemplate(
                emptyState: AppEmptyStateSection(
                  title: 'No Data Available',
                  description: 'Start by adding some content to see it here.',
                ),
              ),
            ),
          ),
        );

        expect(find.byType(AppEmptyStateSection), findsOneWidget);
        expect(find.text('No Data Available'), findsOneWidget);
        expect(find.text('Start by adding some content to see it here.'), findsOneWidget);
      });

      testWidgets('should support empty state with actions', (tester) async {
        bool actionPressed = false;

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: EmptyStateDashboardTemplate(
                emptyState: AppEmptyStateSection(
                  title: 'No Projects',
                  description: 'Create your first project to get started.',
                ),
              ),
            ),
          ),
        );

        expect(find.text('No Projects'), findsOneWidget);
        expect(find.text('Create your first project to get started.'), findsOneWidget);
      });

      testWidgets('should support empty state with icons', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: EmptyStateDashboardTemplate(
                emptyState: AppEmptyStateSection(
                  icon: Icons.analytics,
                  title: 'No Analytics Data',
                  description: 'Connect your data sources to see analytics.',
                ),
              ),
            ),
          ),
        );

        expect(find.byIcon(Icons.analytics), findsOneWidget);
        expect(find.text('No Analytics Data'), findsOneWidget);
      });

      testWidgets('should support custom empty state widgets', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: EmptyStateDashboardTemplate(
                emptyState: Container(
                  padding: const EdgeInsets.all(32),
                  child: Column(
                    children: [
                      const Icon(Icons.dashboard, size: 64),
                      const SizedBox(height: 16),
                      AppText('Custom Empty State', variant: AppTextVariant.titleMedium),
                      const SizedBox(height: 8),
                      AppText('This is a custom empty state widget.', variant: AppTextVariant.bodyMedium),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );

        expect(find.byIcon(Icons.dashboard), findsOneWidget);
        expect(find.text('Custom Empty State'), findsOneWidget);
        expect(find.text('This is a custom empty state widget.'), findsOneWidget);
      });

      testWidgets('should center empty state content', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: EmptyStateDashboardTemplate(
                emptyState: createTestEmptyState(),
              ),
            ),
          ),
        );

        // Empty state should be present and properly positioned
        expect(find.byType(AppEmptyStateSection), findsOneWidget);
        
        // Should be in a column with proper alignment
        final columns = tester.widgetList<Column>(find.byType(Column));
        final templateColumn = columns.firstWhere((col) => col.crossAxisAlignment == CrossAxisAlignment.start);
        expect(templateColumn.crossAxisAlignment, CrossAxisAlignment.start);
      });
    });

    group('Footer Section', () {
      testWidgets('should not display footer when null', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: EmptyStateDashboardTemplate(
                emptyState: createTestEmptyState(),
              ),
            ),
          ),
        );

        // Should not find footer content
        expect(find.text('Footer Content'), findsNothing);
      });

      testWidgets('should display footer when provided', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: EmptyStateDashboardTemplate(
                emptyState: createTestEmptyState(),
                footer: AppText('Need help? Visit documentation', variant: AppTextVariant.bodySmall),
              ),
            ),
          ),
        );

        expect(find.text('Need help? Visit documentation'), findsOneWidget);
        final footerWidget = tester.widget<AppText>(
          find.widgetWithText(AppText, 'Need help? Visit documentation'),
        );
        expect(footerWidget.variant, AppTextVariant.bodySmall);
      });

      testWidgets('should add spacing before footer', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: EmptyStateDashboardTemplate(
                emptyState: createTestEmptyState(),
                footer: AppText('Footer with spacing', variant: AppTextVariant.bodySmall),
              ),
            ),
          ),
        );

        expect(find.text('Footer with spacing'), findsOneWidget);
        expect(find.byType(AppSpacer), findsAtLeastNWidgets(1));
      });

      testWidgets('should support complex footer widgets', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: EmptyStateDashboardTemplate(
                emptyState: createTestEmptyState(),
                footer: Wrap(
                  spacing: 16,
                  children: [
                    AppButton(text: 'Documentation', variant: AppButtonVariant.text, onPressed: () {}),
                    AppButton(text: 'Support', variant: AppButtonVariant.text, onPressed: () {}),
                    AppButton(text: 'Video Tutorial', variant: AppButtonVariant.text, onPressed: () {}),
                  ],
                ),
              ),
            ),
          ),
        );

        expect(find.text('Documentation'), findsOneWidget);
        expect(find.text('Support'), findsOneWidget);
        expect(find.text('Video Tutorial'), findsOneWidget);
        expect(find.byType(Wrap), findsOneWidget);
      });

      testWidgets('should support footer with multiple lines', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: EmptyStateDashboardTemplate(
                emptyState: createTestEmptyState(),
                footer: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText('Need help getting started?', variant: AppTextVariant.bodySmall),
                    AppSpacer(size: AppSpacerSize.extraSmall),
                    AppText('Visit our documentation or contact support.', variant: AppTextVariant.bodySmall),
                  ],
                ),
              ),
            ),
          ),
        );

        expect(find.text('Need help getting started?'), findsOneWidget);
        expect(find.text('Visit our documentation or contact support.'), findsOneWidget);
      });

      testWidgets('should handle interactive footer elements', (tester) async {
        bool docPressed = false;
        bool supportPressed = false;

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: EmptyStateDashboardTemplate(
                emptyState: createTestEmptyState(),
                footer: Row(
                  children: [
                    AppButton(
                      text: 'Docs',
                      variant: AppButtonVariant.text,
                      onPressed: () => docPressed = true,
                    ),
                    const SizedBox(width: 16),
                    AppButton(
                      text: 'Support',
                      variant: AppButtonVariant.text,
                      onPressed: () => supportPressed = true,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );

        await tester.tap(find.text('Docs'));
        expect(docPressed, true);

        await tester.tap(find.text('Support'));
        expect(supportPressed, true);
      });
    });

    group('Complete Template Scenarios', () {
      testWidgets('should display complete template with all sections', (tester) async {
        bool refreshPressed = false;
        bool createPressed = false;
        bool helpPressed = false;

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: EmptyStateDashboardTemplate(
                header: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText('Home > Analytics', variant: AppTextVariant.bodySmall),
                        AppSpacer(size: AppSpacerSize.extraSmall),
                        AppText('Sales Dashboard', variant: AppTextVariant.titleLarge),
                      ],
                    ),
                    AppButton(
                      text: 'Refresh',
                      onPressed: () => refreshPressed = true,
                    ),
                  ],
                ),
                emptyState: AppEmptyStateSection(
                  icon: Icons.analytics,
                  title: 'No Sales Data',
                  description: 'Start tracking sales to see analytics and insights here.',
                ),
                footer: Row(
                  children: [
                    AppText(
                      'Need help setting up analytics?',
                      variant: AppTextVariant.bodySmall,
                    ),
                    const SizedBox(width: 8),
                    AppButton(
                      text: 'Help Center',
                      variant: AppButtonVariant.text,
                      onPressed: () => helpPressed = true,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );

        // Verify all sections are displayed
        expect(find.text('Home > Analytics'), findsOneWidget);
        expect(find.text('Sales Dashboard'), findsOneWidget);
        expect(find.text('Refresh'), findsOneWidget);
        expect(find.text('No Sales Data'), findsOneWidget);
        expect(find.text('Start tracking sales to see analytics and insights here.'), findsOneWidget);
        expect(find.text('Need help setting up analytics?'), findsOneWidget);
        expect(find.text('Help Center'), findsOneWidget);

        // Test interactions
        await tester.tap(find.text('Refresh'));
        expect(refreshPressed, true);

        await tester.tap(find.text('Help Center'));
        expect(helpPressed, true);
      });

      testWidgets('should display minimal template with only empty state', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: EmptyStateDashboardTemplate(
                emptyState: AppEmptyStateSection(
                  title: 'Getting Started',
                  description: 'Welcome to your new dashboard.',
                ),
              ),
            ),
          ),
        );

        expect(find.text('Getting Started'), findsOneWidget);
        expect(find.text('Welcome to your new dashboard.'), findsOneWidget);
        expect(find.byType(AppSection), findsOneWidget);
        
        // Should not have header or footer content beyond section title
        final appTexts = tester.widgetList<AppText>(find.byType(AppText));
        expect(appTexts.length, 3); // Section title + empty state title + description
      });

      testWidgets('should handle template with header but no footer', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: EmptyStateDashboardTemplate(
                header: AppText('Analytics Overview', variant: AppTextVariant.titleLarge),
                emptyState: AppEmptyStateSection(
                  title: 'No Analytics',
                  description: 'Configure your analytics to see data here.',
                ),
              ),
            ),
          ),
        );

        expect(find.text('Analytics Overview'), findsOneWidget);
        expect(find.text('No Analytics'), findsOneWidget);
        expect(find.text('Configure your analytics to see data here.'), findsOneWidget);
      });

      testWidgets('should handle template with footer but no header', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: EmptyStateDashboardTemplate(
                emptyState: AppEmptyStateSection(
                  title: 'Welcome',
                  description: 'Start exploring the dashboard.',
                ),
                footer: AppText('Version 1.0.0 - Documentation available', variant: AppTextVariant.bodySmall),
              ),
            ),
          ),
        );

        expect(find.text('Welcome'), findsOneWidget);
        expect(find.text('Start exploring the dashboard.'), findsOneWidget);
        expect(find.text('Version 1.0.0 - Documentation available'), findsOneWidget);
      });
    });

    group('Design System Integration', () {
      testWidgets('should use AppSection molecule correctly', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: EmptyStateDashboardTemplate(
                emptyState: createTestEmptyState(),
              ),
            ),
          ),
        );

        final appSection = tester.widget<AppSection>(find.byType(AppSection));
        expect(appSection.title, 'Dashboard');
        expect(appSection.child, isA<Column>());
      });

      testWidgets('should use AppSpacer atoms for spacing', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: EmptyStateDashboardTemplate(
                header: AppText('Header', variant: AppTextVariant.titleMedium),
                emptyState: createTestEmptyState(),
                footer: AppText('Footer', variant: AppTextVariant.bodySmall),
              ),
            ),
          ),
        );

        expect(find.byType(AppSpacer), findsAtLeastNWidgets(2)); // After header and before footer
      });

      testWidgets('should integrate with AppEmptyStateSection organism', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: EmptyStateDashboardTemplate(
                emptyState: AppEmptyStateSection(
                  icon: Icons.dashboard,
                  title: 'Empty Dashboard',
                  description: 'Add widgets to customize your dashboard.',
                ),
              ),
            ),
          ),
        );

        expect(find.byType(AppEmptyStateSection), findsOneWidget);
        expect(find.byIcon(Icons.dashboard), findsOneWidget);
        expect(find.text('Empty Dashboard'), findsOneWidget);
      });

      testWidgets('should work with various AppText variants', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: EmptyStateDashboardTemplate(
                header: Column(
                  children: [
                    AppText('Large Title', variant: AppTextVariant.titleLarge),
                    AppText('Medium subtitle', variant: AppTextVariant.titleMedium),
                  ],
                ),
                emptyState: createTestEmptyState(),
                footer: AppText('Small help text', variant: AppTextVariant.bodySmall),
              ),
            ),
          ),
        );

        final titleLarge = tester.widget<AppText>(find.widgetWithText(AppText, 'Large Title'));
        expect(titleLarge.variant, AppTextVariant.titleLarge);

        final titleMedium = tester.widget<AppText>(find.widgetWithText(AppText, 'Medium subtitle'));
        expect(titleMedium.variant, AppTextVariant.titleMedium);

        final bodySmall = tester.widget<AppText>(find.widgetWithText(AppText, 'Small help text'));
        expect(bodySmall.variant, AppTextVariant.bodySmall);
      });
    });

    group('Spacing and Layout', () {
      testWidgets('should have proper spacing between header and empty state', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: EmptyStateDashboardTemplate(
                header: AppText('Header', variant: AppTextVariant.titleLarge),
                emptyState: createTestEmptyState(),
              ),
            ),
          ),
        );

        // Should have spacer after header
        final spacers = tester.widgetList<AppSpacer>(find.byType(AppSpacer));
        expect(spacers.where((s) => s.size == AppSpacerSize.large).isNotEmpty, true);
      });

      testWidgets('should have proper spacing between empty state and footer', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: EmptyStateDashboardTemplate(
                emptyState: createTestEmptyState(),
                footer: AppText('Footer', variant: AppTextVariant.bodySmall),
              ),
            ),
          ),
        );

        // Should have spacer before footer
        final spacers = tester.widgetList<AppSpacer>(find.byType(AppSpacer));
        expect(spacers.where((s) => s.size == AppSpacerSize.large).isNotEmpty, true);
      });

      testWidgets('should have consistent vertical spacing', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: EmptyStateDashboardTemplate(
                header: AppText('Header', variant: AppTextVariant.titleLarge),
                emptyState: createTestEmptyState(),
                footer: AppText('Footer', variant: AppTextVariant.bodySmall),
              ),
            ),
          ),
        );

        // Should have large spacers for section separation
        final spacers = tester.widgetList<AppSpacer>(find.byType(AppSpacer));
        final largeSpacer = spacers.where((s) => s.size == AppSpacerSize.large);
        expect(largeSpacer.length, greaterThanOrEqualTo(2)); // After header and before footer
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
              body: EmptyStateDashboardTemplate(
                header: AppText('Light Theme', variant: AppTextVariant.titleLarge),
                emptyState: createTestEmptyState(),
                footer: AppText('Light footer', variant: AppTextVariant.bodySmall),
              ),
            ),
          ),
        );

        expect(find.text('Light Theme'), findsOneWidget);
        expect(find.text('Light footer'), findsOneWidget);
        expect(find.byType(AppSection), findsOneWidget);
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
              body: EmptyStateDashboardTemplate(
                header: AppText('Dark Theme', variant: AppTextVariant.titleLarge),
                emptyState: createTestEmptyState(),
                footer: AppText('Dark footer', variant: AppTextVariant.bodySmall),
              ),
            ),
          ),
        );

        expect(find.text('Dark Theme'), findsOneWidget);
        expect(find.text('Dark footer'), findsOneWidget);
        expect(find.byType(AppSection), findsOneWidget);
      });
    });

    group('Edge Cases', () {
      testWidgets('should handle extremely long text content', (tester) async {
        const longTitle = 'This is an extremely long dashboard title that should handle text wrapping and layout constraints gracefully without breaking the template structure';
        const longDescription = 'This is a very long description for the empty state that provides extensive details about what users should do and how to get started with comprehensive guidance and instructions for optimal user experience';
        
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: EmptyStateDashboardTemplate(
                header: AppText(longTitle, variant: AppTextVariant.titleMedium),
                emptyState: AppEmptyStateSection(
                  title: 'Long Content Test',
                  description: longDescription,
                ),
              ),
            ),
          ),
        );

        expect(find.text(longTitle), findsOneWidget);
        expect(find.text(longDescription), findsOneWidget);
        expect(tester.takeException(), isNull);
      });

      testWidgets('should handle special characters', (tester) async {
        const specialHeader = 'Dashboard: !@#\$%^&*() 📊 Analytics';
        const specialFooter = 'Help & Support: 🆘 Contact us';
        
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: EmptyStateDashboardTemplate(
                header: AppText(specialHeader, variant: AppTextVariant.titleLarge),
                emptyState: createTestEmptyState(),
                footer: AppText(specialFooter, variant: AppTextVariant.bodySmall),
              ),
            ),
          ),
        );

        expect(find.text(specialHeader), findsOneWidget);
        expect(find.text(specialFooter), findsOneWidget);
        expect(tester.takeException(), isNull);
      });

      testWidgets('should handle empty string content', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: EmptyStateDashboardTemplate(
                header: AppText('', variant: AppTextVariant.titleLarge),
                emptyState: createTestEmptyState(),
                footer: AppText('', variant: AppTextVariant.bodySmall),
              ),
            ),
          ),
        );

        expect(find.text(''), findsNWidgets(2)); // Header and footer
        expect(tester.takeException(), isNull);
      });

      testWidgets('should handle complex nested widgets', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: SingleChildScrollView(
                child: EmptyStateDashboardTemplate(
                  header: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      children: [
                        AppText('Complex Header', variant: AppTextVariant.titleLarge),
                        const SizedBox(height: 8),
                        LinearProgressIndicator(value: 0.3),
                      ],
                    ),
                  ),
                  emptyState: createTestEmptyState(),
                  footer: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          AppText('Complex Footer', variant: AppTextVariant.bodySmall),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Icon(Icons.info),
                              const SizedBox(width: 8),
                              Expanded(
                                child: AppText('Additional info', variant: AppTextVariant.bodySmall),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );

        expect(find.text('Complex Header'), findsOneWidget);
        expect(find.text('Complex Footer'), findsOneWidget);
        expect(find.byType(LinearProgressIndicator), findsOneWidget);
        expect(find.byType(Card), findsOneWidget);
        expect(find.byIcon(Icons.info), findsOneWidget);
        expect(tester.takeException(), isNull);
      });
    });

    group('Accessibility', () {
      testWidgets('should be semantically accessible', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: EmptyStateDashboardTemplate(
                header: AppText('Accessible Dashboard', variant: AppTextVariant.titleLarge),
                emptyState: AppEmptyStateSection(
                  title: 'Accessible Empty State',
                  description: 'This dashboard is fully accessible.',
                ),
                footer: AppText('Accessible footer text', variant: AppTextVariant.bodySmall),
              ),
            ),
          ),
        );

        // Should use AppSection for proper semantic structure
        expect(find.byType(AppSection), findsOneWidget);
        
        // Should use AppText atoms for proper text semantics
        expect(find.byType(AppText), findsAtLeastNWidgets(3));
        
        // Should use AppEmptyStateSection for accessible empty state
        expect(find.byType(AppEmptyStateSection), findsOneWidget);
      });

      testWidgets('should provide proper section labeling', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: EmptyStateDashboardTemplate(
                emptyState: createTestEmptyState(),
              ),
            ),
          ),
        );

        final appSection = tester.widget<AppSection>(find.byType(AppSection));
        expect(appSection.title, 'Dashboard'); // Provides semantic context
      });
    });
  });
}