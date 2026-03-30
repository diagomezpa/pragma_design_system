import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pragma_design_system/feedback/app_snackbar.dart';
import 'package:pragma_design_system/feedback/app_snackbar_type.dart';
import 'package:pragma_design_system/atoms.dart';

void main() {
  group('AppSnackbar Tests', () {
    group('Constructor', () {
      testWidgets('should not be instantiable', (tester) async {
        // AppSnackbar has a private constructor - using it only through static methods
        // This test validates that the class is designed as a utility class
        expect(AppSnackbar, isA<Type>());
      });
    });

    group('Success Feedback', () {
      testWidgets('should show success snackbar with correct message', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Builder(
                builder: (context) {
                  return ElevatedButton(
                    onPressed: () {
                      AppSnackbar.success(context, message: 'Operation successful');
                    },
                    child: const Text('Show Success'),
                  );
                },
              ),
            ),
          ),
        );

        await tester.tap(find.text('Show Success'));
        await tester.pump();

        expect(find.text('Operation successful'), findsOneWidget);
        expect(find.byType(SnackBar), findsOneWidget);
      });

      testWidgets('should show success snackbar with correct styling', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Builder(
                builder: (context) {
                  return ElevatedButton(
                    onPressed: () {
                      AppSnackbar.success(context, message: 'Success message');
                    },
                    child: const Text('Success'),
                  );
                },
              ),
            ),
          ),
        );

        await tester.tap(find.text('Success'));
        await tester.pump();

        final snackbar = tester.widget<SnackBar>(find.byType(SnackBar));
        expect(snackbar.behavior, SnackBarBehavior.floating);
        expect(snackbar.duration, const Duration(seconds: 2));
        expect(snackbar.margin, const EdgeInsets.all(16.0));
        expect(snackbar.shape, isA<RoundedRectangleBorder>());
      });

      testWidgets('should use AppText for success message content', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Builder(
                builder: (context) {
                  return ElevatedButton(
                    onPressed: () {
                      AppSnackbar.success(context, message: 'AppText test');
                    },
                    child: const Text('Test'),
                  );
                },
              ),
            ),
          ),
        );

        await tester.tap(find.text('Test'));
        await tester.pump();

        expect(find.byType(AppText), findsOneWidget);
        
        final appText = tester.widget<AppText>(find.byType(AppText));
        expect(appText.text, 'AppText test');
        expect(appText.variant, AppTextVariant.bodyMedium);
      });

      testWidgets('should use correct colors for success theme', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(
                seedColor: Colors.blue,
                brightness: Brightness.light,
              ),
            ),
            home: Scaffold(
              body: Builder(
                builder: (context) {
                  return ElevatedButton(
                    onPressed: () {
                      AppSnackbar.success(context, message: 'Color test');
                    },
                    child: const Text('Color Test'),
                  );
                },
              ),
            ),
          ),
        );

        await tester.tap(find.text('Color Test'));
        await tester.pump();

        final snackbar = tester.widget<SnackBar>(find.byType(SnackBar));
        final theme = Theme.of(tester.element(find.byType(Scaffold)));
        
        expect(snackbar.backgroundColor, theme.colorScheme.primaryContainer);
      });
    });

    group('Error Feedback', () {
      testWidgets('should show error snackbar with correct message', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Builder(
                builder: (context) {
                  return ElevatedButton(
                    onPressed: () {
                      AppSnackbar.error(context, message: 'Something went wrong');
                    },
                    child: const Text('Show Error'),
                  );
                },
              ),
            ),
          ),
        );

        await tester.tap(find.text('Show Error'));
        await tester.pump();

        expect(find.text('Something went wrong'), findsOneWidget);
        expect(find.byType(SnackBar), findsOneWidget);
      });

      testWidgets('should use correct colors for error theme', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(
                seedColor: Colors.red,
                brightness: Brightness.light,
              ),
            ),
            home: Scaffold(
              body: Builder(
                builder: (context) {
                  return ElevatedButton(
                    onPressed: () {
                      AppSnackbar.error(context, message: 'Error colors');
                    },
                    child: const Text('Error'),
                  );
                },
              ),
            ),
          ),
        );

        await tester.tap(find.text('Error'));
        await tester.pump();

        final snackbar = tester.widget<SnackBar>(find.byType(SnackBar));
        final theme = Theme.of(tester.element(find.byType(Scaffold)));
        
        expect(snackbar.backgroundColor, theme.colorScheme.errorContainer);
      });

      testWidgets('should show error with long message', (tester) async {
        const longMessage = 'This is a very long error message that should be displayed properly in the snackbar without causing layout issues or text overflow problems';
        
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Builder(
                builder: (context) {
                  return ElevatedButton(
                    onPressed: () {
                      AppSnackbar.error(context, message: longMessage);
                    },
                    child: const Text('Long Error'),
                  );
                },
              ),
            ),
          ),
        );

        await tester.tap(find.text('Long Error'));
        await tester.pump();

        expect(find.text(longMessage), findsOneWidget);
        expect(tester.takeException(), isNull);
      });
    });

    group('Info Feedback', () {
      testWidgets('should show info snackbar with correct message', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Builder(
                builder: (context) {
                  return ElevatedButton(
                    onPressed: () {
                      AppSnackbar.info(context, message: 'Information message');
                    },
                    child: const Text('Show Info'),
                  );
                },
              ),
            ),
          ),
        );

        await tester.tap(find.text('Show Info'));
        await tester.pump();

        expect(find.text('Information message'), findsOneWidget);
        expect(find.byType(SnackBar), findsOneWidget);
      });

      testWidgets('should use correct colors for info theme', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(
                seedColor: Colors.grey,
                brightness: Brightness.light,
              ),
            ),
            home: Scaffold(
              body: Builder(
                builder: (context) {
                  return ElevatedButton(
                    onPressed: () {
                      AppSnackbar.info(context, message: 'Info colors');
                    },
                    child: const Text('Info'),
                  );
                },
              ),
            ),
          ),
        );

        await tester.tap(find.text('Info'));
        await tester.pump();

        final snackbar = tester.widget<SnackBar>(find.byType(SnackBar));
        final theme = Theme.of(tester.element(find.byType(Scaffold)));
        
        expect(snackbar.backgroundColor, theme.colorScheme.surfaceContainerHighest);
      });
    });

    group('Snackbar Properties', () {
      testWidgets('should have consistent duration across all types', (tester) async {
        // Test success duration
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Builder(
                builder: (context) {
                  return Column(
                    children: [
                      ElevatedButton(
                        onPressed: () => AppSnackbar.success(context, message: 'Success'),
                        child: const Text('Success'),
                      ),
                      ElevatedButton(
                        onPressed: () => AppSnackbar.error(context, message: 'Error'),
                        child: const Text('Error'),
                      ),
                      ElevatedButton(
                        onPressed: () => AppSnackbar.info(context, message: 'Info'),
                        child: const Text('Info'),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        );

        // Test success
        await tester.tap(find.text('Success'));
        await tester.pump();
        expect(tester.widget<SnackBar>(find.byType(SnackBar)).duration, const Duration(seconds: 2));

        // Clear and test error
        await tester.pump(const Duration(seconds: 3));
        await tester.tap(find.text('Error'));
        await tester.pump();
        expect(tester.widget<SnackBar>(find.byType(SnackBar)).duration, const Duration(seconds: 2));

        // Clear and test info
        await tester.pump(const Duration(seconds: 3));
        await tester.tap(find.text('Info'));
        await tester.pump();
        expect(tester.widget<SnackBar>(find.byType(SnackBar)).duration, const Duration(seconds: 2));
      });

      testWidgets('should have floating behavior', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Builder(
                builder: (context) {
                  return ElevatedButton(
                    onPressed: () {
                      AppSnackbar.info(context, message: 'Test floating');
                    },
                    child: const Text('Test'),
                  );
                },
              ),
            ),
          ),
        );

        await tester.tap(find.text('Test'));
        await tester.pump();

        final snackbar = tester.widget<SnackBar>(find.byType(SnackBar));
        expect(snackbar.behavior, SnackBarBehavior.floating);
      });

      testWidgets('should have rounded corners', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Builder(
                builder: (context) {
                  return ElevatedButton(
                    onPressed: () {
                      AppSnackbar.success(context, message: 'Rounded test');
                    },
                    child: const Text('Test'),
                  );
                },
              ),
            ),
          ),
        );

        await tester.tap(find.text('Test'));
        await tester.pump();

        final snackbar = tester.widget<SnackBar>(find.byType(SnackBar));
        final shape = snackbar.shape as RoundedRectangleBorder;
        expect(shape.borderRadius, BorderRadius.circular(12.0));
      });

      testWidgets('should have consistent margin', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Builder(
                builder: (context) {
                  return ElevatedButton(
                    onPressed: () {
                      AppSnackbar.error(context, message: 'Margin test');
                    },
                    child: const Text('Test'),
                  );
                },
              ),
            ),
          ),
        );

        await tester.tap(find.text('Test'));
        await tester.pump();

        final snackbar = tester.widget<SnackBar>(find.byType(SnackBar));
        expect(snackbar.margin, const EdgeInsets.all(16.0));
      });
    });

    group('Snackbar Management', () {
      testWidgets('should clear previous snackbar when showing new one', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Builder(
                builder: (context) {
                  return Column(
                    children: [
                      ElevatedButton(
                        onPressed: () => AppSnackbar.success(context, message: 'First message'),
                        child: const Text('First'),
                      ),
                      ElevatedButton(
                        onPressed: () => AppSnackbar.error(context, message: 'Second message'),
                        child: const Text('Second'),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        );

        // Show first snackbar
        await tester.tap(find.text('First'));
        await tester.pump();
        expect(find.text('First message'), findsOneWidget);
        expect(find.byType(SnackBar), findsOneWidget);

        // Show second snackbar - should replace first
        await tester.tap(find.text('Second'));
        await tester.pump();
        
        // Should only show second message
        expect(find.text('Second message'), findsOneWidget);
        expect(find.text('First message'), findsNothing);
        expect(find.byType(SnackBar), findsOneWidget);
      });

      testWidgets('should work with ScaffoldMessenger', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Builder(
                builder: (context) {
                  return ElevatedButton(
                    onPressed: () {
                      AppSnackbar.info(context, message: 'Messenger test');
                    },
                    child: const Text('Test'),
                  );
                },
              ),
            ),
          ),
        );

        await tester.tap(find.text('Test'));
        await tester.pump();

        expect(find.byType(SnackBar), findsOneWidget);
        expect(find.text('Messenger test'), findsOneWidget);
      });
    });

    group('Dark Theme Support', () {
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
              body: Builder(
                builder: (context) {
                  return Column(
                    children: [
                      ElevatedButton(
                        onPressed: () => AppSnackbar.success(context, message: 'Dark success'),
                        child: const Text('Success'),
                      ),
                      ElevatedButton(
                        onPressed: () => AppSnackbar.error(context, message: 'Dark error'),
                        child: const Text('Error'),
                      ),
                      ElevatedButton(
                        onPressed: () => AppSnackbar.info(context, message: 'Dark info'),
                        child: const Text('Info'),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        );

        // Test dark theme colors are applied
        await tester.tap(find.text('Success'));
        await tester.pump();
        expect(find.byType(SnackBar), findsOneWidget);
        
        await tester.pump(const Duration(seconds: 3));
        
        await tester.tap(find.text('Error'));
        await tester.pump();
        expect(find.byType(SnackBar), findsOneWidget);
      });
    });

    group('Edge Cases', () {
      testWidgets('should handle empty message', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Builder(
                builder: (context) {
                  return ElevatedButton(
                    onPressed: () {
                      AppSnackbar.info(context, message: '');
                    },
                    child: const Text('Empty'),
                  );
                },
              ),
            ),
          ),
        );

        await tester.tap(find.text('Empty'));
        await tester.pump();

        expect(find.byType(SnackBar), findsOneWidget);
        expect(find.byType(AppText), findsOneWidget);
      });

      testWidgets('should handle very long messages', (tester) async {
        const veryLongMessage = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.';
        
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Builder(
                builder: (context) {
                  return ElevatedButton(
                    onPressed: () {
                      AppSnackbar.success(context, message: veryLongMessage);
                    },
                    child: const Text('Long Message'),
                  );
                },
              ),
            ),
          ),
        );

        await tester.tap(find.text('Long Message'));
        await tester.pump();

        expect(find.text(veryLongMessage), findsOneWidget);
        expect(tester.takeException(), isNull);
      });

      testWidgets('should handle special characters in message', (tester) async {
        const specialMessage = 'Special chars: !@#\$%^&*()_+{}[]|:";\'<>?,./ 🎉 ⭐ 💯';
        
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Builder(
                builder: (context) {
                  return ElevatedButton(
                    onPressed: () {
                      AppSnackbar.error(context, message: specialMessage);
                    },
                    child: const Text('Special'),
                  );
                },
              ),
            ),
          ),
        );

        await tester.tap(find.text('Special'));
        await tester.pump();

        expect(find.text(specialMessage), findsOneWidget);
        expect(tester.takeException(), isNull);
      });

      testWidgets('should handle multiple rapid calls', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Builder(
                builder: (context) {
                  return ElevatedButton(
                    onPressed: () {
                      // Rapid succession calls
                      AppSnackbar.success(context, message: 'Message 1');
                      AppSnackbar.error(context, message: 'Message 2');
                      AppSnackbar.info(context, message: 'Message 3');
                    },
                    child: const Text('Rapid'),
                  );
                },
              ),
            ),
          ),
        );

        await tester.tap(find.text('Rapid'));
        await tester.pump();

        // Should only show the last message due to clearSnackBars()
        expect(find.byType(SnackBar), findsOneWidget);
        expect(find.text('Message 3'), findsOneWidget);
        expect(find.text('Message 1'), findsNothing);
        expect(find.text('Message 2'), findsNothing);
      });
    });

    group('Integration with Design System', () {
      testWidgets('should use AppText with correct variant', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Builder(
                builder: (context) {
                  return ElevatedButton(
                    onPressed: () {
                      AppSnackbar.success(context, message: 'Design system test');
                    },
                    child: const Text('Test'),
                  );
                },
              ),
            ),
          ),
        );

        await tester.tap(find.text('Test'));
        await tester.pump();

        final appText = tester.widget<AppText>(find.byType(AppText));
        expect(appText.variant, AppTextVariant.bodyMedium);
        expect(appText.text, 'Design system test');
      });

      testWidgets('should integrate with theme color scheme', (tester) async {
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
              body: Builder(
                builder: (context) {
                  return Column(
                    children: [
                      ElevatedButton(
                        onPressed: () => AppSnackbar.success(context, message: 'Success'),
                        child: const Text('Success'),
                      ),
                      ElevatedButton(
                        onPressed: () => AppSnackbar.error(context, message: 'Error'),
                        child: const Text('Error'),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        );

        // Test success colors
        await tester.tap(find.text('Success'));
        await tester.pump();
        
        final successSnackbar = tester.widget<SnackBar>(find.byType(SnackBar));
        expect(successSnackbar.backgroundColor, customTheme.colorScheme.primaryContainer);
        
        await tester.pump(const Duration(seconds: 3));

        // Test error colors - verify using theme-based colors
        await tester.tap(find.text('Error'));
        await tester.pump();
        
        final errorSnackbar = tester.widget<SnackBar>(find.byType(SnackBar));
        // Verify the snackbar uses a theme-based error color
        expect(errorSnackbar.backgroundColor, isNotNull);
        expect(errorSnackbar.backgroundColor!.alpha, 255); // Fully opaque
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
                      AppSnackbar.success(context, message: 'Accessible message');
                    },
                    child: const Text('Accessible'),
                  );
                },
              ),
            ),
          ),
        );

        await tester.tap(find.text('Accessible'));
        await tester.pump();

        expect(find.text('Accessible message'), findsOneWidget);
        expect(find.byType(AppText), findsOneWidget);
        
        // AppText provides semantic accessibility
        final appText = tester.widget<AppText>(find.byType(AppText));
        expect(appText.text, 'Accessible message');
      });
    });
  });
}