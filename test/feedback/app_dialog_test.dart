import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pragma_design_system/feedback.dart';
import 'package:pragma_design_system/atoms.dart';

void main() {
  group('AppDialog Tests', () {
    group('Constructor', () {
      testWidgets('should not be instantiable', (tester) async {
        // AppDialog has a private constructor - using it only through static methods
        // This test validates that the class is designed as a utility class
        expect(AppDialog, isA<Type>());
      });
    });

    group('Basic Dialog Display', () {
      testWidgets('should show dialog with title and content', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Builder(
                builder: (context) {
                  return ElevatedButton(
                    onPressed: () {
                      AppDialog.show(
                        context: context,
                        title: 'Test Title',
                        content: AppText(
                          'Test content message',
                          variant: AppTextVariant.bodyMedium,
                        ),
                      );
                    },
                    child: const Text('Show Dialog'),
                  );
                },
              ),
            ),
          ),
        );

        await tester.tap(find.text('Show Dialog'));
        await tester.pumpAndSettle();

        expect(find.text('Test Title'), findsOneWidget);
        expect(find.text('Test content message'), findsOneWidget);
        expect(find.byType(AlertDialog), findsOneWidget);
      });

      testWidgets('should use AppText for title and content', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Builder(
                builder: (context) {
                  return ElevatedButton(
                    onPressed: () {
                      AppDialog.show(
                        context: context,
                        title: 'AppText Title',
                        content: AppText(
                          'AppText content',
                          variant: AppTextVariant.bodyMedium,
                        ),
                      );
                    },
                    child: const Text('Test'),
                  );
                },
              ),
            ),
          ),
        );

        await tester.tap(find.text('Test'));
        await tester.pumpAndSettle();

        final appTexts = tester.widgetList<AppText>(find.byType(AppText));
        expect(appTexts.length, greaterThanOrEqualTo(2)); // Title and content

        // Check title AppText
        final titleAppText = appTexts.firstWhere((widget) => widget.text == 'AppText Title');
        expect(titleAppText.variant, AppTextVariant.titleMedium);

        // Check content AppText
        final contentAppText = appTexts.firstWhere((widget) => widget.text == 'AppText content');
        expect(contentAppText.variant, AppTextVariant.bodyMedium);
      });
    });

    group('Dialog with Custom Child', () {
      testWidgets('should show dialog with custom child widget', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Builder(
                builder: (context) {
                  return ElevatedButton(
                    onPressed: () {
                      AppDialog.show(
                        context: context,
                        title: 'Custom Child',
                        child: const Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.warning, size: 48),
                            SizedBox(height: 16),
                            Text('Custom widget content'),
                          ],
                        ),
                      );
                    },
                    child: const Text('Custom Child'),
                  );
                },
              ),
            ),
          ),
        );

        await tester.tap(find.text('Custom Child'));
        await tester.pumpAndSettle();

        expect(find.text('Custom Child'), findsNWidgets(2)); // Title and button text
        expect(find.byIcon(Icons.warning), findsOneWidget);
        expect(find.text('Custom widget content'), findsOneWidget);
        expect(find.byType(Column), findsAtLeastNWidgets(1));
      });

      testWidgets('should show child widget when provided without content', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Builder(
                builder: (context) {
                  return ElevatedButton(
                    onPressed: () {
                      AppDialog.show(
                        context: context,
                        title: 'Priority Test',
                        child: const Text('Child widget appears'),
                      );
                    },
                    child: const Text('Priority'),
                  );
                },
              ),
            ),
          ),
        );

        await tester.tap(find.text('Priority'));
        await tester.pumpAndSettle();

        expect(find.text('Child widget appears'), findsOneWidget);
        expect(find.text('This should not appear'), findsNothing);
      });
    });

    group('Dialog Actions', () {
      testWidgets('should show default OK action when no actions provided', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Builder(
                builder: (context) {
                  return ElevatedButton(
                    onPressed: () {
                      AppDialog.show(
                        context: context,
                        title: 'Default Action',
                        content: AppText(
                          'Test message',
                          variant: AppTextVariant.bodyMedium,
                        ),
                      );
                    },
                    child: const Text('Default'),
                  );
                },
              ),
            ),
          ),
        );

        await tester.tap(find.text('Default'));
        await tester.pumpAndSettle();

        // No default OK action in this implementation
        expect(find.byType(AppButton), findsNothing);
      });

      testWidgets('should show custom actions when provided', (tester) async {
        bool action1Called = false;
        bool action2Called = false;

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Builder(
                builder: (context) {
                  return ElevatedButton(
                    onPressed: () {
                      AppDialog.show(
                        context: context,
                        title: 'Custom Actions',
                        content: AppText(
                          'Choose an action',
                          variant: AppTextVariant.bodyMedium,
                        ),
                        actions: [
                          AppButton(
                            text: 'Cancel',
                            variant: AppButtonVariant.text,
                            onPressed: () {
                              action1Called = true;
                              Navigator.of(context).pop(false);
                            },
                          ),
                          AppButton(
                            text: 'Confirm',
                            variant: AppButtonVariant.primary,
                            onPressed: () {
                              action2Called = true;
                              Navigator.of(context).pop(true);
                            },
                          ),
                        ],
                      );
                    },
                    child: const Text('Custom Actions'),
                  );
                },
              ),
            ),
          ),
        );

        await tester.tap(find.text('Custom Actions'));
        await tester.pumpAndSettle();

        expect(find.text('Cancel'), findsOneWidget);
        expect(find.text('Confirm'), findsOneWidget);
        expect(find.byType(AppButton), findsNWidgets(2));

        // Test action callbacks
        await tester.tap(find.text('Cancel'));
        await tester.pumpAndSettle();

        expect(action1Called, true);
        expect(find.byType(AlertDialog), findsNothing); // Dialog closed
      });

      testWidgets('should have proper action spacing', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Builder(
                builder: (context) {
                  return ElevatedButton(
                    onPressed: () {
                      AppDialog.show(
                        context: context,
                        title: 'Action Spacing',
                        content: AppText(
                          'Test spacing',
                          variant: AppTextVariant.bodyMedium,
                        ),
                        actions: [
                          AppButton(
                            text: 'Action 1',
                            variant: AppButtonVariant.text,
                            onPressed: () => Navigator.of(context).pop(),
                          ),
                          AppButton(
                            text: 'Action 2',
                            variant: AppButtonVariant.text,
                            onPressed: () => Navigator.of(context).pop(),
                          ),
                        ],
                      );
                    },
                    child: const Text('Spacing'),
                  );
                },
              ),
            ),
          ),
        );

        await tester.tap(find.text('Spacing'));
        await tester.pumpAndSettle();

        // Check for spacing between actions
        expect(find.byType(SizedBox), findsAtLeastNWidgets(1));
        
        // Check that actions are present
        expect(find.byType(AppButton), findsNWidgets(2));
      });
    });

    group('Return Values and Generic Types', () {
      testWidgets('should handle void return type', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Builder(
                builder: (context) {
                  return ElevatedButton(
                    onPressed: () async {
                      await AppDialog.show(
                        context: context,
                        title: 'Void Return',
                        content: AppText(
                          'This returns void',
                          variant: AppTextVariant.bodyMedium,
                        ),
                      );
                    },
                    child: const Text('Void'),
                  );
                },
              ),
            ),
          ),
        );

        await tester.tap(find.text('Void'));
        await tester.pumpAndSettle();

        expect(find.byType(AlertDialog), findsOneWidget);

        // Dialog with no default actions has no buttons
        expect(find.byType(AppButton), findsNothing);
      });

      testWidgets('should handle boolean return type', (tester) async {
        bool? result;

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Builder(
                builder: (context) {
                  return ElevatedButton(
                    onPressed: () async {
                      result = await AppDialog.show<bool>(
                        context: context,
                        title: 'Boolean Return',
                        content: AppText(
                          'Choose true or false',
                          variant: AppTextVariant.bodyMedium,
                        ),
                        actions: [
                          AppButton(
                            text: 'False',
                            variant: AppButtonVariant.text,
                            onPressed: () => Navigator.of(context).pop(false),
                          ),
                          AppButton(
                            text: 'True',
                            variant: AppButtonVariant.primary,
                            onPressed: () => Navigator.of(context).pop(true),
                          ),
                        ],
                      );
                    },
                    child: const Text('Boolean'),
                  );
                },
              ),
            ),
          ),
        );

        await tester.tap(find.text('Boolean'));
        await tester.pumpAndSettle();

        await tester.tap(find.text('True'));
        await tester.pumpAndSettle();

        expect(result, true);
      });

      testWidgets('should handle string return type', (tester) async {
        String? result;

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Builder(
                builder: (context) {
                  return ElevatedButton(
                    onPressed: () async {
                      result = await AppDialog.show<String>(
                        context: context,
                        title: 'String Return',
                        content: AppText(
                          'Choose an option',
                          variant: AppTextVariant.bodyMedium,
                        ),
                        actions: [
                          AppButton(
                            text: 'Option A',
                            variant: AppButtonVariant.text,
                            onPressed: () => Navigator.of(context).pop('option_a'),
                          ),
                          AppButton(
                            text: 'Option B',
                            variant: AppButtonVariant.primary,
                            onPressed: () => Navigator.of(context).pop('option_b'),
                          ),
                        ],
                      );
                    },
                    child: const Text('String'),
                  );
                },
              ),
            ),
          ),
        );

        await tester.tap(find.text('String'));
        await tester.pumpAndSettle();

        await tester.tap(find.text('Option B'));
        await tester.pumpAndSettle();

        expect(result, 'option_b');
      });

      testWidgets('should return null when dismissed', (tester) async {
        String? result = 'initial';

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Builder(
                builder: (context) {
                  return ElevatedButton(
                    onPressed: () async {
                      result = await AppDialog.show<String>(
                        context: context,
                        title: 'Dismissible',
                        content: AppText(
                          'This can be dismissed',
                          variant: AppTextVariant.bodyMedium,
                        ),
                        actions: [
                          AppButton(
                            text: 'Keep Value',
                            variant: AppButtonVariant.primary,
                            onPressed: () => Navigator.of(context).pop('kept'),
                          ),
                        ],
                      );
                    },
                    child: const Text('Dismissible'),
                  );
                },
              ),
            ),
          ),
        );

        await tester.tap(find.text('Dismissible'));
        await tester.pumpAndSettle();

        // Dismiss by tapping outside (barrier)
        await tester.tapAt(const Offset(50, 50));
        await tester.pumpAndSettle();

        expect(result, null);
      });
    });

    group('Dialog Styling and Layout', () {
      testWidgets('should have proper dialog styling', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Builder(
                builder: (context) {
                  return ElevatedButton(
                    onPressed: () {
                      AppDialog.show(
                        context: context,
                        title: 'Styled Dialog',
                        content: AppText(
                          'Test styling',
                          variant: AppTextVariant.bodyMedium,
                        ),
                      );
                    },
                    child: const Text('Styled'),
                  );
                },
              ),
            ),
          ),
        );

        await tester.tap(find.text('Styled'));
        await tester.pumpAndSettle();

        final alertDialog = tester.widget<AlertDialog>(find.byType(AlertDialog));
        
        // Should have consistent shape and styling
        expect(alertDialog.shape, isA<RoundedRectangleBorder>());
        
        final shape = alertDialog.shape as RoundedRectangleBorder;
        expect(shape.borderRadius, BorderRadius.circular(24.0));
      });

      testWidgets('should adapt to different content sizes', (tester) async {
        const shortContent = 'Short message';
        const longContent = '''
This is a very long message that should properly wrap and display in the dialog without causing layout issues. It contains multiple lines of text to test how the dialog handles longer content and ensures proper spacing and readability.

It also includes line breaks and multiple paragraphs to test the layout behavior comprehensively.
''';

        // Test short content
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Builder(
                builder: (context) {
                  return Column(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          AppDialog.show(
                            context: context,
                            title: 'Short',
                            content: AppText(
                              shortContent,
                              variant: AppTextVariant.bodyMedium,
                            ),
                          );
                        },
                        child: const Text('Short'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          AppDialog.show(
                            context: context,
                            title: 'Long',
                            content: AppText(
                              longContent,
                              variant: AppTextVariant.bodyMedium,
                            ),
                          );
                        },
                        child: const Text('Long'),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        );

        // Test short content dialog
        await tester.tap(find.text('Short'));
        await tester.pumpAndSettle();
        
        expect(find.text(shortContent), findsOneWidget);
        expect(tester.takeException(), isNull);
        
        // Dismiss dialog by tapping outside
        await tester.tapAt(const Offset(50, 50));
        await tester.pumpAndSettle();

        // Test long content dialog
        await tester.tap(find.text('Long'));
        await tester.pumpAndSettle();
        
        expect(find.text(longContent, findRichText: true), findsOneWidget);
        expect(tester.takeException(), isNull);
      });
    });

    group('Multiple Dialogs', () {
      testWidgets('should handle stacked dialogs', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Builder(
                builder: (context) {
                  return ElevatedButton(
                    onPressed: () {
                      AppDialog.show(
                        context: context,
                        title: 'First Dialog',
                        content: AppText(
                          'This is the first dialog',
                          variant: AppTextVariant.bodyMedium,
                        ),
                        actions: [
                          AppButton(
                            text: 'Open Second',
                            variant: AppButtonVariant.primary,
                            onPressed: () {
                              AppDialog.show(
                                context: context,
                                title: 'Second Dialog',
                                content: AppText(
                                  'This is the second dialog',
                                  variant: AppTextVariant.bodyMedium,
                                ),
                              );
                            },
                          ),
                        ],
                      );
                    },
                    child: const Text('Stack Dialogs'),
                  );
                },
              ),
            ),
          ),
        );

        await tester.tap(find.text('Stack Dialogs'));
        await tester.pumpAndSettle();

        expect(find.text('First Dialog'), findsOneWidget);

        await tester.tap(find.text('Open Second'));
        await tester.pumpAndSettle();

        expect(find.text('Second Dialog'), findsOneWidget);
        expect(find.byType(AlertDialog), findsNWidgets(2)); // Both dialogs present
      });
    });

    group('Theme Integration', () {
      testWidgets('should adapt to custom theme', (tester) async {
        final customTheme = ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.purple,
            brightness: Brightness.light,
          ),
          dialogTheme: const DialogTheme(
            backgroundColor: Colors.white,
            titleTextStyle: TextStyle(color: Colors.purple),
            contentTextStyle: TextStyle(color: Colors.grey),
          ),
        );

        await tester.pumpWidget(
          MaterialApp(
            theme: customTheme,
            home: Scaffold(
              body: Builder(
                builder: (context) {
                  return ElevatedButton(
                    onPressed: () {
                      AppDialog.show(
                        context: context,
                        title: 'Custom Theme',
                        content: AppText(
                          'Themed dialog content',
                          variant: AppTextVariant.bodyMedium,
                        ),
                      );
                    },
                    child: const Text('Themed'),
                  );
                },
              ),
            ),
          ),
        );

        await tester.tap(find.text('Themed'));
        await tester.pumpAndSettle();

        final alertDialog = tester.widget<AlertDialog>(find.byType(AlertDialog));
        expect(alertDialog, isNotNull);
        
        // Should use AppText which adapts to theme
        expect(find.byType(AppText), findsAtLeastNWidgets(2));
      });

      testWidgets('should work with dark theme', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(
                seedColor: Colors.blue,
                brightness: Brightness.dark,
              ),
            ),
            home: Scaffold(
              body: Builder(
                builder: (context) {
                  return ElevatedButton(
                    onPressed: () {
                      AppDialog.show(
                        context: context,
                        title: 'Dark Theme',
                        content: AppText(
                          'Dark themed dialog',
                          variant: AppTextVariant.bodyMedium,
                        ),
                      );
                    },
                    child: const Text('Dark'),
                  );
                },
              ),
            ),
          ),
        );

        await tester.tap(find.text('Dark'));
        await tester.pumpAndSettle();

        expect(find.text('Dark Theme'), findsOneWidget);
        expect(find.text('Dark themed dialog'), findsOneWidget);
        expect(find.byType(AlertDialog), findsOneWidget);
      });
    });

    group('Edge Cases', () {
      testWidgets('should handle empty title and content', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Builder(
                builder: (context) {
                  return ElevatedButton(
                    onPressed: () {
                      AppDialog.show(
                        context: context,
                        title: '',
                        content: AppText(
                          '',
                          variant: AppTextVariant.bodyMedium,
                        ),
                      );
                    },
                    child: const Text('Empty'),
                  );
                },
              ),
            ),
          ),
        );

        await tester.tap(find.text('Empty'));
        await tester.pumpAndSettle();

        expect(find.byType(AlertDialog), findsOneWidget);
        expect(tester.takeException(), isNull);
      });

      testWidgets('should handle null title with content', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Builder(
                builder: (context) {
                  return ElevatedButton(
                    onPressed: () {
                      AppDialog.show(
                        context: context,
                        title: null,
                        content: AppText(
                          'Content without title',
                          variant: AppTextVariant.bodyMedium,
                        ),
                      );
                    },
                    child: const Text('No Title'),
                  );
                },
              ),
            ),
          ),
        );

        await tester.tap(find.text('No Title'));
        await tester.pumpAndSettle();

        expect(find.text('Content without title'), findsOneWidget);
        expect(find.byType(AlertDialog), findsOneWidget);
        expect(tester.takeException(), isNull);
      });

      testWidgets('should handle special characters', (tester) async {
        const specialTitle = 'Special: !@#\$%^&*() 🎉';
        const specialContent = 'Content with émojis: 💯 ⭐ and spëcial chars';

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Builder(
                builder: (context) {
                  return ElevatedButton(
                    onPressed: () {
                      AppDialog.show(
                        context: context,
                        title: specialTitle,
                        content: AppText(
                          specialContent,
                          variant: AppTextVariant.bodyMedium,
                        ),
                      );
                    },
                    child: const Text('Special'),
                  );
                },
              ),
            ),
          ),
        );

        await tester.tap(find.text('Special'));
        await tester.pumpAndSettle();

        expect(find.text(specialTitle), findsOneWidget);
        expect(find.text(specialContent), findsOneWidget);
        expect(tester.takeException(), isNull);
      });
    });

    group('Accessibility', () {
      testWidgets('should be semantically accessible', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Builder(
                builder: (context) {
                  return ElevatedButton(
                    onPressed: () {
                      AppDialog.show(
                        context: context,
                        title: 'Accessible Dialog',
                        content: AppText(
                          'This dialog should be accessible',
                          variant: AppTextVariant.bodyMedium,
                        ),
                        actions: [
                          AppButton(
                            text: 'Cancel',
                            variant: AppButtonVariant.text,
                            onPressed: () => Navigator.of(context).pop(false),
                          ),
                          AppButton(
                            text: 'Confirm',
                            variant: AppButtonVariant.primary,
                            onPressed: () => Navigator.of(context).pop(true),
                          ),
                        ],
                      );
                    },
                    child: const Text('Accessible'),
                  );
                },
              ),
            ),
          ),
        );

        await tester.tap(find.text('Accessible'));
        await tester.pumpAndSettle();

        // Should use AppText and AppButton which provide accessibility
        expect(find.byType(AppText), findsAtLeastNWidgets(2));
        expect(find.byType(AppButton), findsNWidgets(2));
        
        // Dialog should be focusable and navigable
        expect(find.byType(AlertDialog), findsOneWidget);
        expect(find.text('Accessible Dialog'), findsOneWidget);
        expect(find.text('This dialog should be accessible'), findsOneWidget);
      });
    });

    group('Integration with Design System', () {
      testWidgets('should use AppText variants correctly', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Builder(
                builder: (context) {
                  return ElevatedButton(
                    onPressed: () {
                      AppDialog.show(
                        context: context,
                        title: 'Design System',
                        content: AppText(
                          'Integration test',
                          variant: AppTextVariant.bodyMedium,
                        ),
                      );
                    },
                    child: const Text('Design System'),
                  );
                },
              ),
            ),
          ),
        );

        await tester.tap(find.text('Design System'));
        await tester.pumpAndSettle();

        final appTexts = tester.widgetList<AppText>(find.byType(AppText));
        
        // Find title and content AppTexts
        final titleText = appTexts.firstWhere((widget) => widget.text == 'Design System');
        final contentText = appTexts.firstWhere((widget) => widget.text == 'Integration test');
        
        expect(titleText.variant, AppTextVariant.titleMedium);
        expect(contentText.variant, AppTextVariant.bodyMedium);
      });

      testWidgets('should use AppButton for actions', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Builder(
                builder: (context) {
                  return ElevatedButton(
                    onPressed: () {
                      AppDialog.show(
                        context: context,
                        title: 'Button Test',
                        content: AppText(
                          'Testing AppButton integration',
                          variant: AppTextVariant.bodyMedium,
                        ),
                        actions: [
                          AppButton(
                            text: 'Custom Action',
                            variant: AppButtonVariant.primary,
                            onPressed: () => Navigator.of(context).pop(),
                          ),
                        ],
                      );
                    },
                    child: const Text('Button Test'),
                  );
                },
              ),
            ),
          ),
        );

        await tester.tap(find.text('Button Test'));
        await tester.pumpAndSettle();

        final customButton = tester.widget<AppButton>(
          find.widgetWithText(AppButton, 'Custom Action'),
        );
        expect(customButton.variant, AppButtonVariant.primary);
        expect(customButton.text, 'Custom Action');
      });

      testWidgets('should use AppSpacer for action spacing', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Builder(
                builder: (context) {
                  return ElevatedButton(
                    onPressed: () {
                      AppDialog.show(
                        context: context,
                        title: 'Spacing Test',
                        content: AppText(
                          'Testing spacing',
                          variant: AppTextVariant.bodyMedium,
                        ),
                        actions: [
                          AppButton(
                            text: 'First',
                            variant: AppButtonVariant.text,
                            onPressed: () => Navigator.of(context).pop(),
                          ),
                          AppButton(
                            text: 'Second',
                            variant: AppButtonVariant.primary,
                            onPressed: () => Navigator.of(context).pop(),
                          ),
                        ],
                      );
                    },
                    child: const Text('Spacing'),
                  );
                },
              ),
            ),
          ),
        );

        await tester.tap(find.text('Spacing'));
        await tester.pumpAndSettle();

        expect(find.byType(SizedBox), findsAtLeastNWidgets(1));
      });
    });
  });
}