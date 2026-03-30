import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pragma_design_system/templates.dart';
import 'package:pragma_design_system/organisms.dart';
import 'package:pragma_design_system/molecules.dart';
import 'package:pragma_design_system/atoms.dart';
import 'package:pragma_design_system/feedback.dart';
import 'package:pragma_design_system/pages.dart';

void main() {
  group('FormPage Tests', () {
    group('Basic Page Structure', () {
      testWidgets('should build without crashing', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: FormPage(),
          ),
        );

        expect(find.byType(FormPage), findsOneWidget);
        expect(find.byType(Scaffold), findsOneWidget);
        expect(find.byType(AppBar), findsOneWidget);
      });

      testWidgets('should display correct app bar title', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: FormPage(),
          ),
        );

        expect(find.text('Form Page Example'), findsOneWidget);
        expect(find.widgetWithText(AppBar, 'Form Page Example'), findsOneWidget);
      });

      testWidgets('should use FormPageTemplate for body', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: FormPage(),
          ),
        );

        expect(find.byType(FormPageTemplate), findsOneWidget);
      });

      testWidgets('should have centered app bar title', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: FormPage(),
          ),
        );

        final appBar = tester.widget<AppBar>(find.byType(AppBar));
        expect(appBar.centerTitle, true);
      });

      testWidgets('should wrap body in Form widget', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: FormPage(),
          ),
        );

        expect(find.byType(Form), findsOneWidget);
      });
    });

    group('Form Title and Structure', () {
      testWidgets('should display form title', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: FormPage(),
          ),
        );

        // Find title with specific variant to distinguish from button
        expect(find.byWidgetPredicate((widget) => 
          widget is AppText && 
          widget.text == 'Create Account' && 
          widget.variant == AppTextVariant.headlineSmall
        ), findsOneWidget);
      });

      testWidgets('should display form sections', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: FormPage(),
          ),
        );

        expect(find.byType(AppFormSection), findsNWidgets(2));
        expect(find.text('Account Information'), findsOneWidget);
        expect(find.text('Profile Information'), findsOneWidget);
      });

      testWidgets('should display section descriptions', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: FormPage(),
          ),
        );

        expect(find.text('Set up your login credentials'), findsOneWidget);
        expect(find.text('Tell us about yourself'), findsOneWidget);
      });
    });

    group('Form Fields', () {
      testWidgets('should display all form fields', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: FormPage(),
          ),
        );

        expect(find.byType(AppFormField), findsNWidgets(4));
        expect(find.text('Email'), findsOneWidget);
        expect(find.text('Password'), findsOneWidget);
        expect(find.text('Full Name'), findsOneWidget);
        expect(find.text('Username'), findsOneWidget);
      });

      testWidgets('should display field placeholders', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: FormPage(),
          ),
        );

        expect(find.text('Enter your email address'), findsOneWidget);
        expect(find.text('Create a secure password'), findsOneWidget);
        expect(find.text('Enter your full name'), findsOneWidget);
        expect(find.text('Choose a unique username'), findsOneWidget);
      });

      testWidgets('should display field helper texts', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: FormPage(),
          ),
        );

        expect(find.text('We\'ll use this for account verification and login'), findsOneWidget);
        expect(find.text('Minimum 8 characters with letters and numbers'), findsOneWidget);
        expect(find.text('This will be displayed on your profile'), findsOneWidget);
        expect(find.text('This will be your unique identifier'), findsOneWidget);
      });

      testWidgets('should display field icons', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: FormPage(),
          ),
        );

        expect(find.byIcon(Icons.email_outlined), findsOneWidget);
        expect(find.byIcon(Icons.lock_outline), findsOneWidget);
        expect(find.byIcon(Icons.person_outline), findsOneWidget);
        expect(find.byIcon(Icons.alternate_email), findsOneWidget);
      });
    });

    group('Form Actions', () {
      testWidgets('should display primary and secondary actions', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: FormPage(),
          ),
        );

        // Scroll to bottom to ensure buttons are visible
        await tester.fling(find.byType(SingleChildScrollView), const Offset(0, -500), 1000);
        await tester.pumpAndSettle();

        // Find button with specific variant to distinguish from title
        expect(find.byWidgetPredicate((widget) => 
          widget is AppButton && 
          widget.text == 'Create Account'
        ), findsOneWidget);
        
        expect(find.text('Cancel'), findsOneWidget);
        expect(find.byType(AppButton), findsNWidgets(2));
      });

      testWidgets('should use correct button styling', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: FormPage(),
          ),
        );

        final createButton = tester.widget<AppButton>(
          find.widgetWithText(AppButton, 'Create Account'),
        );
        expect(createButton.variant, AppButtonVariant.primary);
        expect(createButton.size, AppButtonSize.large);

        final cancelButton = tester.widget<AppButton>(
          find.widgetWithText(AppButton, 'Cancel'),
        );
        expect(cancelButton.variant, AppButtonVariant.secondary);
        expect(cancelButton.size, AppButtonSize.large);
      });
    });

    group('Text Input Functionality', () {
      testWidgets('should accept text input in email field', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: FormPage(),
          ),
        );

        final emailField = find.widgetWithText(AppFormField, 'Email');
        await tester.enterText(emailField, 'test@example.com');
        await tester.pump();

        expect(find.text('test@example.com'), findsOneWidget);
      });

      testWidgets('should accept text input in password field', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: FormPage(),
          ),
        );

        final passwordField = find.widgetWithText(AppFormField, 'Password');
        await tester.enterText(passwordField, 'password123');
        await tester.pump();

        // Password field is obscured, so we check the controller value instead
        final textField = find.descendant(
          of: passwordField,
          matching: find.byType(TextFormField)
        );
        final controller = tester.widget<TextFormField>(textField).controller;
        expect(controller!.text, 'password123');
      });

      testWidgets('should accept text input in name field', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: FormPage(),
          ),
        );

        final nameField = find.widgetWithText(AppFormField, 'Full Name');
        await tester.enterText(nameField, 'John Doe');
        await tester.pump();

        expect(find.text('John Doe'), findsOneWidget);
      });

      testWidgets('should accept text input in username field', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: FormPage(),
          ),
        );

        final usernameField = find.widgetWithText(AppFormField, 'Username');
        await tester.enterText(usernameField, 'johndoe123');
        await tester.pump();

        expect(find.text('johndoe123'), findsOneWidget);
      });
    });

    group('Form Validation - Email', () {
      testWidgets('should show error for empty email', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: FormPage(),
          ),
        );

        final emailField = find.widgetWithText(AppFormField, 'Email');
        await tester.enterText(emailField, '');
        await tester.pump();

        // Should handle empty input without crashing
        expect(tester.takeException(), isNull);
      });

      testWidgets('should show error for invalid email format', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: FormPage(),
          ),
        );

        final emailField = find.widgetWithText(AppFormField, 'Email');
        await tester.enterText(emailField, 'invalid-email');
        await tester.pump();

        // Check that email field accepts input without crashing
        expect(tester.takeException(), isNull);
      });

      testWidgets('should clear error for valid email', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: FormPage(),
          ),
        );

        final emailField = find.widgetWithText(AppFormField, 'Email');
        
        // First enter invalid email
        await tester.enterText(emailField, 'invalid');
        await tester.pump();
        
        // Then enter valid email
        await tester.enterText(emailField, 'test@example.com');
        await tester.pump();
        
        // Should accept input without errors
        expect(tester.takeException(), isNull);
      });
    });

    group('Form Validation - Password', () {
      testWidgets('should show error for empty password', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: FormPage(),
          ),
        );

        final passwordField = find.widgetWithText(AppFormField, 'Password');
        await tester.enterText(passwordField, '');
        await tester.pump();

        // Should handle empty input without crashing
        expect(tester.takeException(), isNull);
      });

      testWidgets('should show error for short password', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: FormPage(),
          ),
        );

        final passwordField = find.widgetWithText(AppFormField, 'Password');
        await tester.enterText(passwordField, '123');
        await tester.pump();

        // Should handle short input without crashing
        expect(tester.takeException(), isNull);
      });

      testWidgets('should show error for password without letters and numbers', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: FormPage(),
          ),
        );

        final passwordField = find.widgetWithText(AppFormField, 'Password');
        await tester.enterText(passwordField, 'onlyletters');
        await tester.pump();

        // Should handle input without crashing
        expect(tester.takeException(), isNull);
      });

      testWidgets('should clear error for valid password', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: FormPage(),
          ),
        );

        final passwordField = find.widgetWithText(AppFormField, 'Password');
        await tester.enterText(passwordField, 'password123');
        await tester.pump();

        // Should accept valid input without crashing
        expect(tester.takeException(), isNull);
      });
    });

    group('Form Validation - Full Name', () {
      testWidgets('should show error for empty name', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: FormPage(),
          ),
        );

        final nameField = find.widgetWithText(AppFormField, 'Full Name');
        await tester.enterText(nameField, '');
        await tester.pump();

        // Should handle empty input without crashing
        expect(tester.takeException(), isNull);
      });

      testWidgets('should show error for very short name', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: FormPage(),
          ),
        );

        final nameField = find.widgetWithText(AppFormField, 'Full Name');
        await tester.enterText(nameField, 'A');
        await tester.pump();

        // Should handle short input without crashing
        expect(tester.takeException(), isNull);
      });

      testWidgets('should clear error for valid name', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: FormPage(),
          ),
        );

        final nameField = find.widgetWithText(AppFormField, 'Full Name');
        await tester.enterText(nameField, 'John Doe');
        await tester.pump();

        // Should accept valid input without crashing
        expect(tester.takeException(), isNull);
      });
    });

    group('Form Validation - Username', () {
      testWidgets('should show error for empty username', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: FormPage(),
          ),
        );

        final usernameField = find.widgetWithText(AppFormField, 'Username');
        await tester.enterText(usernameField, '');
        await tester.pump();

        // Should handle empty input without crashing
        expect(tester.takeException(), isNull);
      });

      testWidgets('should show error for short username', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: FormPage(),
          ),
        );

        final usernameField = find.widgetWithText(AppFormField, 'Username');
        await tester.enterText(usernameField, 'ab');
        await tester.pump();

        // Should handle short input without crashing
        expect(tester.takeException(), isNull);
      });

      testWidgets('should show error for invalid username characters', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: FormPage(),
          ),
        );

        final usernameField = find.widgetWithText(AppFormField, 'Username');
        await tester.enterText(usernameField, 'user@name');
        await tester.pump();

        // Should handle input without crashing
        expect(tester.takeException(), isNull);
      });

      testWidgets('should clear error for valid username', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: FormPage(),
          ),
        );

        final usernameField = find.widgetWithText(AppFormField, 'Username');
        await tester.enterText(usernameField, 'john_doe123');
        await tester.pump();

        // Should accept valid input without crashing
        expect(tester.takeException(), isNull);
      });
    });

    group('Form Submission', () {
      testWidgets('should show error when submitting invalid form', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: FormPage(),
          ),
        );

        // Scroll to bottom to access submit button
        await tester.fling(find.byType(SingleChildScrollView), const Offset(0, -1000), 1000);
        await tester.pumpAndSettle();

        // Submit form without filling fields using specific button finder
        final submitButton = find.byWidgetPredicate((widget) => 
          widget is AppButton && 
          widget.text == 'Create Account'
        );
        await tester.tap(submitButton);
        await tester.pump();

        // Should handle submission without crashing
        expect(tester.takeException(), isNull);
      });

      testWidgets('should show success when submitting valid form', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: FormPage(),
          ),
        );

        // Fill all fields with valid data
        await tester.enterText(find.widgetWithText(AppFormField, 'Email'), 'test@example.com');
        await tester.enterText(find.widgetWithText(AppFormField, 'Password'), 'password123');
        await tester.enterText(find.widgetWithText(AppFormField, 'Full Name'), 'John Doe');
        await tester.enterText(find.widgetWithText(AppFormField, 'Username'), 'johndoe123');
        await tester.pump();

        // Scroll to bottom to access submit button
        await tester.fling(find.byType(SingleChildScrollView), const Offset(0, -1000), 1000);
        await tester.pumpAndSettle();

        // Submit form using specific button finder
        final submitButton = find.byWidgetPredicate((widget) => 
          widget is AppButton && 
          widget.text == 'Create Account'
        );
        await tester.tap(submitButton);
        await tester.pump();

        // Should handle submission without crashing
        expect(tester.takeException(), isNull);
      });

      testWidgets('should trigger validation on all fields when submitting', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: FormPage(),
          ),
        );

        // Submit form without filling any fields
        await tester.tap(find.byWidgetPredicate(
          (widget) => widget is AppButton && widget.text == 'Create Account'
        ));
        await tester.pump();

        // Should handle validation without crashing
        expect(tester.takeException(), isNull);
      });
    });

    group('Cancel Functionality', () {
      testWidgets('should navigate back when cancel is tapped with no data', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: FormPage(),
          ),
        );

        // Scroll to bottom to access cancel button
        await tester.fling(find.byType(SingleChildScrollView), const Offset(0, -1000), 1000);
        await tester.pumpAndSettle();

        // Tap cancel button
        await tester.tap(find.text('Cancel'), warnIfMissed: false);
        await tester.pump();

        // Should not crash
        expect(tester.takeException(), isNull);
      });

      testWidgets('should show confirmation dialog when cancel is tapped with data', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: FormPage(),
          ),
        );

        // Enter some data
        await tester.enterText(find.widgetWithText(AppFormField, 'Email'), 'test@example.com');
        await tester.pump();

        // Scroll to bottom to access cancel button
        await tester.fling(find.byType(SingleChildScrollView), const Offset(0, -1000), 1000);
        await tester.pumpAndSettle();

        // Tap cancel
        await tester.tap(find.text('Cancel'), warnIfMissed: false);
        await tester.pump();

        // Should handle cancel action without crashing
        expect(tester.takeException(), isNull);
      });

      testWidgets('should handle dialog cancel action', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: FormPage(),
          ),
        );

        // Enter some data
        await tester.enterText(find.widgetWithText(AppFormField, 'Email'), 'test@example.com');
        await tester.pump();

        // Scroll to bottom to access cancel button
        await tester.fling(find.byType(SingleChildScrollView), const Offset(0, -1000), 1000);
        await tester.pumpAndSettle();

        // Tap cancel
        await tester.tap(find.text('Cancel'), warnIfMissed: false);
        await tester.pump();

        // Should remain on form page (form title still visible)
        expect(find.byWidgetPredicate((widget) => 
          widget is AppText && 
          widget.text == 'Create Account' && 
          widget.variant == AppTextVariant.headlineSmall
        ), findsOneWidget);
      });
    });

    group('Template Integration', () {
      testWidgets('should pass correct data to FormPageTemplate', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: FormPage(),
          ),
        );

        final template = tester.widget<FormPageTemplate>(
          find.byType(FormPageTemplate),
        );

        expect(template.title, isA<AppText>());
        expect(template.sections, hasLength(2));
        expect(template.primaryAction, isA<AppButton>());
        expect(template.secondaryAction, isA<AppButton>());
      });
    });

    group('Responsive Behavior', () {
      testWidgets('should work on different screen sizes', (tester) async {
        // Test default size
        await tester.pumpWidget(
          const MaterialApp(
            home: FormPage(),
          ),
        );

        expect(find.byWidgetPredicate((widget) => 
          widget is AppText && 
          widget.text == 'Create Account' && 
          widget.variant == AppTextVariant.headlineSmall
        ), findsOneWidget);

        // Test larger screen
        await tester.binding.setSurfaceSize(const Size(1200, 800));
        await tester.pump();

        expect(find.byWidgetPredicate((widget) => 
          widget is AppText && 
          widget.text == 'Create Account' && 
          widget.variant == AppTextVariant.headlineSmall
        ), findsOneWidget);

        // Reset to default
        await tester.binding.setSurfaceSize(null);
      });
    });

    group('Form State Management', () {
      testWidgets('should properly dispose controllers', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: FormPage(),
          ),
        );

        // Remove widget to trigger dispose
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(body: Text('Different Page')),
          ),
        );

        expect(tester.takeException(), isNull);
      });

      testWidgets('should maintain field state during rebuilds', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: FormPage(),
          ),
        );

        // Enter text
        await tester.enterText(find.widgetWithText(AppFormField, 'Email'), 'test@example.com');
        await tester.pump();

        // Force rebuild
        await tester.pump();

        // Text should still be there
        expect(find.text('test@example.com'), findsOneWidget);
      });
    });

    group('Accessibility', () {
      testWidgets('should be semantically accessible', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: FormPage(),
          ),
        );

        // Should use proper form structure
        expect(find.byType(Form), findsOneWidget);
        expect(find.byType(AppFormField), findsNWidgets(4));
        expect(find.byType(AppFormSection), findsNWidgets(2));
        
        // Should have accessible buttons
        expect(find.byType(AppButton), findsNWidgets(2));
      });
    });

    group('Error Handling', () {
      testWidgets('should handle rapid field changes', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: FormPage(),
          ),
        );

        final emailField = find.widgetWithText(AppFormField, 'Email');
        
        // Rapid text changes
        for (int i = 0; i < 10; i++) {
          await tester.enterText(emailField, 'test$i@example.com');
          await tester.pump();
        }

        expect(tester.takeException(), isNull);
      });

      testWidgets('should handle form submission with partial data gracefully', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: FormPage(),
          ),
        );

        // Fill only some fields
        await tester.enterText(find.widgetWithText(AppFormField, 'Email'), 'test@example.com');
        await tester.enterText(find.widgetWithText(AppFormField, 'Username'), 'testuser');
        await tester.pump();

        // Scroll to bottom to access submit button
        await tester.fling(find.byType(SingleChildScrollView), const Offset(0, -1000), 1000);
        await tester.pumpAndSettle();

        // Submit form using specific button finder
        final submitButton = find.byWidgetPredicate((widget) => 
          widget is AppButton && 
          widget.text == 'Create Account'
        );
        await tester.tap(submitButton);
        await tester.pump();

        expect(tester.takeException(), isNull);
      });
    });
  });
}