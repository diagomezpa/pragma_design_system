import 'package:flutter_test/flutter_test.dart';
import 'package:pragma_design_system/feedback/app_snackbar_type.dart';

void main() {
  group('AppSnackbarType Tests', () {
    group('Enum Values', () {
      testWidgets('should have success type', (tester) async {
        expect(AppSnackbarType.success, isA<AppSnackbarType>());
        expect(AppSnackbarType.success.name, 'success');
      });

      testWidgets('should have error type', (tester) async {
        expect(AppSnackbarType.error, isA<AppSnackbarType>());
        expect(AppSnackbarType.error.name, 'error');
      });

      testWidgets('should have info type', (tester) async {
        expect(AppSnackbarType.info, isA<AppSnackbarType>());
        expect(AppSnackbarType.info.name, 'info');
      });
    });

    group('Enum Properties', () {
      testWidgets('should have exactly three types', (tester) async {
        expect(AppSnackbarType.values, hasLength(3));
        expect(AppSnackbarType.values, contains(AppSnackbarType.success));
        expect(AppSnackbarType.values, contains(AppSnackbarType.error));
        expect(AppSnackbarType.values, contains(AppSnackbarType.info));
      });

      testWidgets('should have different values for each type', (tester) async {
        expect(AppSnackbarType.success, isNot(equals(AppSnackbarType.error)));
        expect(AppSnackbarType.success, isNot(equals(AppSnackbarType.info)));
        expect(AppSnackbarType.error, isNot(equals(AppSnackbarType.info)));
      });

      testWidgets('should support equality comparison', (tester) async {
        expect(AppSnackbarType.success, equals(AppSnackbarType.success));
        expect(AppSnackbarType.error, equals(AppSnackbarType.error));
        expect(AppSnackbarType.info, equals(AppSnackbarType.info));
      });

      testWidgets('should support toString conversion', (tester) async {
        expect(AppSnackbarType.success.toString(), 'AppSnackbarType.success');
        expect(AppSnackbarType.error.toString(), 'AppSnackbarType.error');
        expect(AppSnackbarType.info.toString(), 'AppSnackbarType.info');
      });
    });

    group('Enum Index Properties', () {
      testWidgets('should have correct index values', (tester) async {
        expect(AppSnackbarType.success.index, 0);
        expect(AppSnackbarType.error.index, 1);
        expect(AppSnackbarType.info.index, 2);
      });

      testWidgets('should maintain index order', (tester) async {
        final types = AppSnackbarType.values;
        expect(types[0], AppSnackbarType.success);
        expect(types[1], AppSnackbarType.error);
        expect(types[2], AppSnackbarType.info);
      });
    });

    group('Practical Usage', () {
      testWidgets('should work in switch statements', (tester) async {
        String getTypeDescription(AppSnackbarType type) {
          return switch (type) {
            AppSnackbarType.success => 'Positive feedback',
            AppSnackbarType.error => 'Critical feedback',
            AppSnackbarType.info => 'Neutral feedback',
          };
        }

        expect(getTypeDescription(AppSnackbarType.success), 'Positive feedback');
        expect(getTypeDescription(AppSnackbarType.error), 'Critical feedback');
        expect(getTypeDescription(AppSnackbarType.info), 'Neutral feedback');
      });

      testWidgets('should work in collections', (tester) async {
        final typeSet = {AppSnackbarType.success, AppSnackbarType.error, AppSnackbarType.info};
        expect(typeSet, hasLength(3));
        expect(typeSet.contains(AppSnackbarType.success), isTrue);
        expect(typeSet.contains(AppSnackbarType.error), isTrue);
        expect(typeSet.contains(AppSnackbarType.info), isTrue);
      });

      testWidgets('should work as map keys', (tester) async {
        final typeMap = {
          AppSnackbarType.success: 'success-color',
          AppSnackbarType.error: 'error-color',
          AppSnackbarType.info: 'info-color',
        };

        expect(typeMap[AppSnackbarType.success], 'success-color');
        expect(typeMap[AppSnackbarType.error], 'error-color');
        expect(typeMap[AppSnackbarType.info], 'info-color');
      });

      testWidgets('should support iteration', (tester) async {
        final typeNames = <String>[];
        for (final type in AppSnackbarType.values) {
          typeNames.add(type.name);
        }

        expect(typeNames, ['success', 'error', 'info']);
      });
    });

    group('Type Safety', () {
      testWidgets('should be strongly typed', (tester) async {
        AppSnackbarType type = AppSnackbarType.success;
        expect(type, isA<AppSnackbarType>());
        expect(type.runtimeType.toString(), 'AppSnackbarType');
      });

      testWidgets('should not be null', (tester) async {
        expect(AppSnackbarType.success, isNotNull);
        expect(AppSnackbarType.error, isNotNull);
        expect(AppSnackbarType.info, isNotNull);
      });

      testWidgets('should be immutable', (tester) async {
        final type = AppSnackbarType.success;
        expect(() => type, returnsNormally);
        
        // Enum values are constants and immutable by nature
        expect(identical(AppSnackbarType.success, AppSnackbarType.success), isTrue);
      });
    });

    group('Design System Semantics', () {
      testWidgets('should represent correct semantic meanings', (tester) async {
        // Success represents positive feedback
        expect(AppSnackbarType.success.name, contains('success'));
        
        // Error represents critical feedback
        expect(AppSnackbarType.error.name, contains('error'));
        
        // Info represents neutral feedback
        expect(AppSnackbarType.info.name, contains('info'));
      });

      testWidgets('should be usable for theme color selection', (tester) async {
        String getThemeColorForType(AppSnackbarType type) {
          return switch (type) {
            AppSnackbarType.success => 'primaryContainer',
            AppSnackbarType.error => 'errorContainer', 
            AppSnackbarType.info => 'surfaceContainerHighest',
          };
        }

        expect(getThemeColorForType(AppSnackbarType.success), 'primaryContainer');
        expect(getThemeColorForType(AppSnackbarType.error), 'errorContainer');
        expect(getThemeColorForType(AppSnackbarType.info), 'surfaceContainerHighest');
      });

      testWidgets('should support semantic grouping', (tester) async {
        final positiveTypes = [AppSnackbarType.success];
        final negativeTypes = [AppSnackbarType.error];
        final neutralTypes = [AppSnackbarType.info];

        expect(positiveTypes, contains(AppSnackbarType.success));
        expect(negativeTypes, contains(AppSnackbarType.error));
        expect(neutralTypes, contains(AppSnackbarType.info));
      });
    });
  });
}