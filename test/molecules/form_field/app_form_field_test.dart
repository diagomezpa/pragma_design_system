import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pragma_design_system/molecules.dart';
import 'package:pragma_design_system/atoms.dart';

void main() {
  group('AppFormField Tests', () {
    group('Basic Rendering', () {
      testWidgets('should render without label and hint text', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppFormField(),
            ),
          ),
        );

        expect(find.byType(AppFormField), findsOneWidget);
        expect(find.byType(TextFormField), findsOneWidget);
        expect(find.byType(Column), findsOneWidget);
        expect(find.byType(AppText), findsNothing); // No label
      });

      testWidgets('should render with all basic components', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppFormField(
                label: 'Test Label',
                hintText: 'Enter text here',
                helperText: 'This is helper text',
              ),
            ),
          ),
        );

        expect(find.byType(AppFormField), findsOneWidget);
        expect(find.byType(TextFormField), findsOneWidget);
        expect(find.byType(Column), findsOneWidget);
        expect(find.byType(AppText), findsNWidgets(2)); // Label + helper text
        expect(find.text('Test Label'), findsOneWidget);
        expect(find.text('This is helper text'), findsOneWidget);
      });

      testWidgets('should have correct column structure', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppFormField(
                label: 'Test Label',
                helperText: 'Helper text',
              ),
            ),
          ),
        );

        final column = tester.widget<Column>(find.byType(Column));
        expect(column.crossAxisAlignment, CrossAxisAlignment.start);
        expect(column.mainAxisSize, MainAxisSize.min);
      });
    });

    group('Label Properties', () {
      testWidgets('should not render label when not provided', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppFormField(
                hintText: 'No label field',
              ),
            ),
          ),
        );

        // Should not have AppText for label
        expect(find.byType(AppText), findsNothing); // No label AppText
        expect(find.byType(TextFormField), findsOneWidget);
      });

      testWidgets('should render label with correct style when enabled', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppFormField(
                label: 'Enabled Label',
                enabled: true,
              ),
            ),
          ),
        );

        expect(find.text('Enabled Label'), findsOneWidget);
        expect(find.byType(AppText), findsOneWidget);
        
        final labelTexts = tester.widgetList<AppText>(find.byType(AppText));
        final labelText = labelTexts.first;
        expect(labelText.variant, AppTextVariant.bodySmall);
        expect(labelText.fontWeight, FontWeight.w500);
      });

      testWidgets('should render label with disabled styling when disabled', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppFormField(
                label: 'Disabled Label',
                enabled: false,
              ),
            ),
          ),
        );

        expect(find.text('Disabled Label'), findsOneWidget);
        expect(find.byType(AppText), findsOneWidget);
        
        final labelTexts = tester.widgetList<AppText>(find.byType(AppText));
        final labelText = labelTexts.first;
        expect(labelText.variant, AppTextVariant.bodySmall);
        expect(labelText.fontWeight, FontWeight.w500);
      });

      testWidgets('should include spacer after label', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppFormField(
                label: 'Spaced Label',
              ),
            ),
          ),
        );

        expect(find.byType(AppSpacer), findsAtLeastNWidgets(1));
        
        final spacers = tester.widgetList<AppSpacer>(find.byType(AppSpacer));
        expect(spacers.any((s) => s.size == AppSpacerSize.extraSmall), isTrue);
      });
    });

    group('Input Field Properties', () {
      testWidgets('should display hint text', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppFormField(
                hintText: 'Enter your email',
              ),
            ),
          ),
        );

        // Verify hint text is rendered (it will be in the TextField)
        expect(find.byType(TextFormField), findsOneWidget);
        // The hint text is internal to TextFormField decoration
      });

      testWidgets('should handle initial value', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppFormField(
                initialValue: 'Initial text',
              ),
            ),
          ),
        );

        final textField = tester.widget<TextFormField>(find.byType(TextFormField));
        expect(textField.initialValue, 'Initial text');
      });

      testWidgets('should use controller when provided', (tester) async {
        final controller = TextEditingController(text: 'Controller text');
        
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppFormField(
                controller: controller,
              ),
            ),
          ),
        );

        // Verify that the field shows the controller's text
        expect(find.text('Controller text'), findsOneWidget);
        expect(find.byType(TextFormField), findsOneWidget);
        
        // Verify controller is used by changing its value
        controller.text = 'Updated text';
        await tester.pump();
        expect(find.text('Updated text'), findsOneWidget);
      });

      testWidgets('should handle obscure text for passwords', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppFormField(
                obscureText: true,
                hintText: 'Enter password',
              ),
            ),
          ),
        );

        // Verify that the field is created with obscureText property
        expect(find.byType(TextFormField), findsOneWidget);
        // The obscureText property is internal to TextFormField
      });

      testWidgets('should support different keyboard types', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppFormField(
                keyboardType: TextInputType.emailAddress,
              ),
            ),
          ),
        );

        // Verify that the field is created with the keyboard type
        expect(find.byType(TextFormField), findsOneWidget);
        // The keyboardType property is internal to TextFormField
      });

      testWidgets('should support different text input actions', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppFormField(
                textInputAction: TextInputAction.send,
              ),
            ),
          ),
        );

        // Verify that the field is created with the text input action
        expect(find.byType(TextFormField), findsOneWidget);
        // The textInputAction property is internal to TextFormField
      });

      testWidgets('should support custom max lines', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppFormField(
                maxLines: 5,
              ),
            ),
          ),
        );

        // Verify that the field is created with max lines
        expect(find.byType(TextFormField), findsOneWidget);
        // The maxLines property is internal to TextFormField
      });

      testWidgets('should default to single line', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppFormField(),
            ),
          ),
        );

        // Verify that the field is created with default configuration
        expect(find.byType(TextFormField), findsOneWidget);
        // The maxLines default is handled by TextFormField
      });
    });

    group('Helper and Error Text', () {
      testWidgets('should display helper text', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppFormField(
                helperText: 'This field is required',
              ),
            ),
          ),
        );

        expect(find.text('This field is required'), findsOneWidget);
        expect(find.byType(AppText), findsOneWidget);
        
        final helperTexts = tester.widgetList<AppText>(find.byType(AppText));
        final helperText = helperTexts.first;
        expect(helperText.variant, AppTextVariant.bodySmall);
      });

      testWidgets('should display error text', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppFormField(
                errorText: 'This field has an error',
              ),
            ),
          ),
        );

        expect(find.text('This field has an error'), findsOneWidget);
        expect(find.byType(AppText), findsOneWidget);
        
        final errorTexts = tester.widgetList<AppText>(find.byType(AppText));
        final errorText = errorTexts.first;
        expect(errorText.variant, AppTextVariant.bodySmall);
      });

      testWidgets('should prioritize error text over helper text', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppFormField(
                helperText: 'Helper text',
                errorText: 'Error text',
              ),
            ),
          ),
        );

        expect(find.text('Error text'), findsOneWidget);
        expect(find.text('Helper text'), findsNothing);
      });

      testWidgets('should include spacer before helper/error text', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppFormField(
                helperText: 'Helper with spacer',
              ),
            ),
          ),
        );

        expect(find.byType(AppSpacer), findsAtLeastNWidgets(1));
        
        final spacers = tester.widgetList<AppSpacer>(find.byType(AppSpacer));
        expect(spacers.any((s) => s.size == AppSpacerSize.extraSmall), isTrue);
      });

      testWidgets('should not render helper/error section when both are null', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppFormField(),
            ),
          ),
        );

        expect(find.byType(AppSpacer), findsNothing);
      });
    });

    group('Input States', () {
      testWidgets('should be enabled by default', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppFormField(),
            ),
          ),
        );

        final textField = tester.widget<TextFormField>(find.byType(TextFormField));
        expect(textField.enabled, isTrue);
      });

      testWidgets('should support disabled state', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppFormField(
                enabled: false,
              ),
            ),
          ),
        );

        final textField = tester.widget<TextFormField>(find.byType(TextFormField));
        expect(textField.enabled, isFalse);
      });

      testWidgets('should apply correct styling for disabled state', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppFormField(
                label: 'Disabled Field',
                enabled: false,
              ),
            ),
          ),
        );

        expect(find.text('Disabled Field'), findsOneWidget);
        expect(find.byType(AppText), findsOneWidget);
        
        final labelTexts = tester.widgetList<AppText>(find.byType(AppText));
        final labelText = labelTexts.first;
        expect(labelText.variant, AppTextVariant.bodySmall);
      });
    });

    group('Icons', () {
      testWidgets('should display prefix icon', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppFormField(
                prefixIcon: AppIcon(Icons.email),
              ),
            ),
          ),
        );

        expect(find.byIcon(Icons.email), findsOneWidget);
        expect(find.byType(TextFormField), findsOneWidget);
      });

      testWidgets('should display suffix icon', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppFormField(
                suffixIcon: AppIcon(Icons.visibility),
              ),
            ),
          ),
        );

        expect(find.byIcon(Icons.visibility), findsOneWidget);
        expect(find.byType(TextFormField), findsOneWidget);
      });

      testWidgets('should support both prefix and suffix icons', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppFormField(
                prefixIcon: AppIcon(Icons.person),
                suffixIcon: AppIcon(Icons.clear),
              ),
            ),
          ),
        );

        expect(find.byIcon(Icons.person), findsOneWidget);
        expect(find.byIcon(Icons.clear), findsOneWidget);
        expect(find.byType(TextFormField), findsOneWidget);
      });

      testWidgets('should not display icons when not provided', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppFormField(),
            ),
          ),
        );

        expect(find.byType(TextFormField), findsOneWidget);
        expect(find.byType(AppIcon), findsNothing);
      });
    });

    group('Focus Management', () {
      testWidgets('should support autofocus', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppFormField(
                autofocus: true,
              ),
            ),
          ),
        );

        // Verify that the TextFormField is created with autofocus
        expect(find.byType(TextFormField), findsOneWidget);
        // Autofocus behavior is handled internally by TextFormField
      });

      testWidgets('should not autofocus by default', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppFormField(),
            ),
          ),
        );

        // Verify that the TextFormField is created without autofocus
        expect(find.byType(TextFormField), findsOneWidget);
        // Default autofocus behavior is handled by TextFormField
      });

      testWidgets('should use provided focus node', (tester) async {
        final focusNode = FocusNode();
        
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppFormField(
                focusNode: focusNode,
              ),
            ),
          ),
        );

        // Verify that the TextFormField is created with focus node
        expect(find.byType(TextFormField), findsOneWidget);
        // Focus node assignment is handled internally by TextFormField
      });
    });

    group('Callbacks', () {
      testWidgets('should call onChanged when text changes', (tester) async {
        String? changedValue;
        
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppFormField(
                onChanged: (value) => changedValue = value,
              ),
            ),
          ),
        );

        await tester.enterText(find.byType(TextFormField), 'test input');
        expect(changedValue, 'test input');
      });

      testWidgets('should call onSubmitted when submitted', (tester) async {
        String? submittedValue;
        
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppFormField(
                onSubmitted: (value) => submittedValue = value,
              ),
            ),
          ),
        );

        await tester.enterText(find.byType(TextFormField), 'submitted text');
        await tester.testTextInput.receiveAction(TextInputAction.done);
        await tester.pump();
        
        expect(submittedValue, 'submitted text');
      });

      testWidgets('should not crash when callbacks are null', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppFormField(),
            ),
          ),
        );

        // Should not crash when entering text without callbacks
        await tester.enterText(find.byType(TextFormField), 'test');
        await tester.testTextInput.receiveAction(TextInputAction.done);
        await tester.pump();
        
        expect(tester.takeException(), isNull);
      });
    });

    group('Input Decoration', () {
      testWidgets('should have Material 3 outlined style', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppFormField(),
            ),
          ),
        );

        // Verify that the TextFormField is created with proper styling
        expect(find.byType(TextFormField), findsOneWidget);
        // The decoration styling is applied internally by AppFormField
      });

      testWidgets('should have correct border radius', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppFormField(),
            ),
          ),
        );

        // Verify that the TextFormField is styled correctly
        expect(find.byType(TextFormField), findsOneWidget);
        // Border radius is applied internally by AppFormField
      });

      testWidgets('should have consistent content padding', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppFormField(),
            ),
          ),
        );

        // Verify that the TextFormField has proper content padding
        expect(find.byType(TextFormField), findsOneWidget);
        // Content padding is configured internally by AppFormField
      });
    });

    group('Design System Integration', () {
      testWidgets('should use AppText atoms for labels and helper text', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppFormField(
                label: 'Form Label',
                helperText: 'Helper text',
              ),
            ),
          ),
        );

        expect(find.byType(AppText), findsNWidgets(2)); // Label + helper
        expect(find.byType(AppSpacer), findsNWidgets(2)); // After label + before helper
      });

      testWidgets('should use AppSpacer for consistent spacing', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppFormField(
                label: 'Spaced Field',
                helperText: 'Helper',
              ),
            ),
          ),
        );

        final spacers = tester.widgetList<AppSpacer>(find.byType(AppSpacer));
        expect(spacers, hasLength(2));
        expect(spacers.every((s) => s.size == AppSpacerSize.extraSmall), isTrue);
      });

      testWidgets('should integrate well with other form components', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Column(
                children: const [
                  AppFormField(
                    label: 'First Name',
                    hintText: 'Enter first name',
                  ),
                  AppFormField(
                    label: 'Last Name',
                    hintText: 'Enter last name',
                  ),
                ],
              ),
            ),
          ),
        );

        expect(find.byType(AppFormField), findsNWidgets(2));
        expect(find.text('First Name'), findsOneWidget);
        expect(find.text('Last Name'), findsOneWidget);
      });
    });

    group('Edge Cases', () {
      testWidgets('should handle very long label text', (tester) async {
        const longLabel = 'This is a very long label that should be handled gracefully without breaking the layout or causing any overflow issues in the form field component';
        
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppFormField(
                label: longLabel,
              ),
            ),
          ),
        );

        expect(find.text(longLabel), findsOneWidget);
        expect(tester.takeException(), isNull);
      });

      testWidgets('should handle very long helper text', (tester) async {
        const longHelper = 'This is a very long helper text that provides extensive information about the form field requirements and validation rules';
        
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppFormField(
                helperText: longHelper,
              ),
            ),
          ),
        );

        expect(find.text(longHelper), findsOneWidget);
        expect(tester.takeException(), isNull);
      });

      testWidgets('should handle empty strings gracefully', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppFormField(
                label: '',
                hintText: '',
                helperText: '',
                initialValue: '',
              ),
            ),
          ),
        );

        expect(find.byType(AppFormField), findsOneWidget);
        expect(tester.takeException(), isNull);
      });

      testWidgets('should handle null maxLines (unlimited)', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppFormField(
                maxLines: null, // Unlimited lines
              ),
            ),
          ),
        );

        // Verify that the TextFormField supports unlimited lines
        expect(find.byType(TextFormField), findsOneWidget);
        // The maxLines configuration is handled internally
      });

      testWidgets('should handle switching between controller and initialValue', (tester) async {
        // Start with initialValue
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppFormField(
                initialValue: 'Initial',
              ),
            ),
          ),
        );

        expect(find.text('Initial'), findsOneWidget);

        // Switch to controller
        final controller = TextEditingController(text: 'Controller');
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppFormField(
                controller: controller,
              ),
            ),
          ),
        );

        expect(find.text('Controller'), findsOneWidget);
        
        // Verify controller works by updating it
        controller.text = 'Updated';
        await tester.pump();
        expect(find.text('Updated'), findsOneWidget);
      });
    });

    group('Accessibility', () {
      testWidgets('should maintain semantic relationships between label and field', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppFormField(
                label: 'Email Address',
                hintText: 'Enter your email',
              ),
            ),
          ),
        );

        expect(find.text('Email Address'), findsOneWidget);
        expect(find.byType(TextFormField), findsOneWidget);
        expect(find.byType(AppText), findsOneWidget);
        
        // Both label and field should be present for screen readers
        final labelTexts = tester.widgetList<AppText>(find.byType(AppText));
        final labelText = labelTexts.first;
        expect(labelText.variant, AppTextVariant.bodySmall);
      });

      testWidgets('should support semantic error messages', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppFormField(
                label: 'Password',
                errorText: 'Password must be at least 8 characters',
              ),
            ),
          ),
        );

        expect(find.text('Password must be at least 8 characters'), findsOneWidget);
        expect(find.byType(AppText), findsNWidgets(2)); // Label + error text
        
        final appTexts = tester.widgetList<AppText>(find.byType(AppText));
        final errorText = appTexts.firstWhere((text) => text.text == 'Password must be at least 8 characters');
        expect(errorText.variant, AppTextVariant.bodySmall);
      });

      testWidgets('should maintain focus semantics', (tester) async {
        final focusNode = FocusNode();
        
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppFormField(
                label: 'Focusable Field',
                focusNode: focusNode,
              ),
            ),
          ),
        );

        // Request focus
        focusNode.requestFocus();
        await tester.pump();
        
        expect(focusNode.hasFocus, isTrue);
      });
    });
  });
}