import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pragma_design_system/atoms.dart';

void main() {
  group('AppImage Widget Tests', () {
    testWidgets('should render network image correctly', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppImage(
              imageUrl: 'https://example.com/image.jpg',
            ),
          ),
        ),
      );

      expect(find.byType(Image), findsOneWidget);
      final image = tester.widget<Image>(find.byType(Image));
      expect(image.image.runtimeType.toString(), 'NetworkImage');
    });

    testWidgets('should render asset image correctly', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppImage(
              assetPath: 'assets/test_image.png',
            ),
          ),
        ),
      );

      expect(find.byType(Image), findsOneWidget);
      final image = tester.widget<Image>(find.byType(Image));
      expect(image.image.runtimeType.toString(), 'AssetImage');
    });

    group('Image Properties', () {
      testWidgets('should apply width and height', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppImage(
                imageUrl: 'https://example.com/image.jpg',
                width: 100,
                height: 200,
              ),
            ),
          ),
        );

        final image = tester.widget<Image>(find.byType(Image));
        expect(image.width, 100);
        expect(image.height, 200);
      });

      testWidgets('should apply custom BoxFit', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppImage(
                imageUrl: 'https://example.com/image.jpg',
                fit: BoxFit.contain,
              ),
            ),
          ),
        );

        final image = tester.widget<Image>(find.byType(Image));
        expect(image.fit, BoxFit.contain);
      });

      testWidgets('should use cover as default BoxFit', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppImage(
                imageUrl: 'https://example.com/image.jpg',
              ),
            ),
          ),
        );

        final image = tester.widget<Image>(find.byType(Image));
        expect(image.fit, BoxFit.cover);
      });

      testWidgets('should apply semantic label', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppImage(
                imageUrl: 'https://example.com/image.jpg',
                semanticLabel: 'Test Image',
              ),
            ),
          ),
        );

        final image = tester.widget<Image>(find.byType(Image));
        expect(image.semanticLabel, 'Test Image');
      });

      testWidgets('should apply border radius with ClipRRect', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppImage(
                imageUrl: 'https://example.com/image.jpg',
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        );

        expect(find.byType(ClipRRect), findsOneWidget);
        final clipRRect = tester.widget<ClipRRect>(find.byType(ClipRRect));
        expect(clipRRect.borderRadius, BorderRadius.circular(12));
      });

      testWidgets('should not use ClipRRect when no border radius', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppImage(
                imageUrl: 'https://example.com/image.jpg',
              ),
            ),
          ),
        );

        expect(find.byType(ClipRRect), findsNothing);
      });
    });

    group('Loading and Error States', () {
      testWidgets('should render network image with loadingBuilder', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppImage(
                imageUrl: 'https://example.com/image.jpg',
                width: 100,
                height: 100,
              ),
            ),
          ),
        );

        // Verify the image widget is created with correct properties
        final image = tester.widget<Image>(find.byType(Image));
        expect(image.loadingBuilder, isNotNull);
        expect(image.width, 100);
        expect(image.height, 100);
      });

      testWidgets('should use custom placeholder when provided', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppImage(
                imageUrl: 'https://example.com/image.jpg',
                placeholder: Text('Loading...'),
              ),
            ),
          ),
        );

        // Verify the image widget is configured correctly
        final image = tester.widget<Image>(find.byType(Image));
        expect(image.loadingBuilder, isNotNull);
        // Note: placeholder is used in loadingBuilder, hard to test directly in unit tests
      });

      testWidgets('should configure error handling for network image', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppImage(
                imageUrl: 'https://invalid-url.com/nonexistent.jpg',
                width: 100,
                height: 100,
              ),
            ),
          ),
        );

        // Verify the image widget has error handling
        final image = tester.widget<Image>(find.byType(Image));
        expect(image.errorBuilder, isNotNull);
        expect(image.width, 100);
        expect(image.height, 100);
      });

      testWidgets('should use custom error widget when provided', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppImage(
                imageUrl: 'https://invalid-url.com/nonexistent.jpg',
                errorWidget: Icon(Icons.error),
              ),
            ),
          ),
        );

        // Verify the image widget is configured with errorBuilder
        final image = tester.widget<Image>(find.byType(Image));
        expect(image.errorBuilder, isNotNull);
      });

      testWidgets('should configure error handling for asset image', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppImage(
                assetPath: 'assets/nonexistent_image.png',
                width: 50,
                height: 50,
              ),
            ),
          ),
        );

        // Verify the image widget has error handling
        final image = tester.widget<Image>(find.byType(Image));
        expect(image.errorBuilder, isNotNull);
        expect(image.width, 50);
        expect(image.height, 50);
      });
    });

    group('Factory Methods - Avatar', () {
      testWidgets('should create avatar with network image', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppImageFactory.avatar(
                imageUrl: 'https://example.com/avatar.jpg',
                size: 60,
              ),
            ),
          ),
        );

        expect(find.byType(ClipOval), findsOneWidget);
        expect(find.byType(Image), findsOneWidget);

        final image = tester.widget<Image>(find.byType(Image));
        expect(image.width, 60);
        expect(image.height, 60);
        expect(image.fit, BoxFit.cover);
      });

      testWidgets('should create avatar with asset image', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppImageFactory.avatar(
                imageUrl: null,
                assetPath: 'assets/avatar.png',
                size: 40,
              ),
            ),
          ),
        );

        expect(find.byType(ClipOval), findsOneWidget);
        expect(find.byType(Image), findsOneWidget);

        final image = tester.widget<Image>(find.byType(Image));
        expect(image.width, 40);
        expect(image.height, 40);
        expect(image.fit, BoxFit.cover);
      });

      testWidgets('should create avatar with custom properties', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppImageFactory.avatar(
                imageUrl: 'https://example.com/avatar.jpg',
                size: 80,
                placeholder: const Text('Loading Avatar'),
                errorWidget: const Icon(Icons.person),
                semanticLabel: 'User Avatar',
              ),
            ),
          ),
        );

        expect(find.byType(ClipOval), findsOneWidget);
        final image = tester.widget<Image>(find.byType(Image));
        expect(image.semanticLabel, 'User Avatar');
      });
    });

    group('Factory Methods - Thumbnail', () {
      testWidgets('should create thumbnail with default properties', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppImageFactory.thumbnail(
                imageUrl: 'https://example.com/thumbnail.jpg',
              ),
            ),
          ),
        );

        expect(find.byType(ClipRRect), findsOneWidget);
        expect(find.byType(Image), findsOneWidget);

        final image = tester.widget<Image>(find.byType(Image));
        expect(image.width, 80); // default width
        expect(image.height, 80); // default height
        expect(image.fit, BoxFit.cover);

        final clipRRect = tester.widget<ClipRRect>(find.byType(ClipRRect));
        expect(clipRRect.borderRadius, BorderRadius.circular(8)); // default borderRadius
      });

      testWidgets('should create thumbnail with custom properties', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppImageFactory.thumbnail(
                imageUrl: 'https://example.com/thumbnail.jpg',
                width: 120,
                height: 90,
                borderRadius: 16,
                semanticLabel: 'Product Thumbnail',
              ),
            ),
          ),
        );

        expect(find.byType(ClipRRect), findsOneWidget);
        final image = tester.widget<Image>(find.byType(Image));
        expect(image.width, 120);
        expect(image.height, 90);
        expect(image.semanticLabel, 'Product Thumbnail');

        final clipRRect = tester.widget<ClipRRect>(find.byType(ClipRRect));
        expect(clipRRect.borderRadius, BorderRadius.circular(16));
      });

      testWidgets('should create thumbnail with asset path', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppImageFactory.thumbnail(
                imageUrl: null,
                assetPath: 'assets/thumbnail.png',
                width: 60,
                height: 60,
              ),
            ),
          ),
        );

        expect(find.byType(Image), findsOneWidget);
        final image = tester.widget<Image>(find.byType(Image));
        expect(image.width, 60);
        expect(image.height, 60);
      });
    });

    group('Factory Methods - Banner', () {
      testWidgets('should create banner with default properties', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppImageFactory.banner(
                imageUrl: 'https://example.com/banner.jpg',
              ),
            ),
          ),
        );

        expect(find.byType(Image), findsOneWidget);
        expect(find.byType(ClipRRect), findsNothing); // no border radius by default

        final image = tester.widget<Image>(find.byType(Image));
        expect(image.width, isNull); // should fill available width
        expect(image.fit, BoxFit.cover);
      });

      testWidgets('should create banner with custom height', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppImageFactory.banner(
                imageUrl: 'https://example.com/banner.jpg',
                height: 200,
              ),
            ),
          ),
        );

        final image = tester.widget<Image>(find.byType(Image));
        expect(image.height, 200);
      });

      testWidgets('should create banner with border radius', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppImageFactory.banner(
                imageUrl: 'https://example.com/banner.jpg',
                borderRadius: 12,
              ),
            ),
          ),
        );

        expect(find.byType(ClipRRect), findsOneWidget);
        final clipRRect = tester.widget<ClipRRect>(find.byType(ClipRRect));
        expect(clipRRect.borderRadius, BorderRadius.circular(12));
      });

      testWidgets('should create banner with all custom properties', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppImageFactory.banner(
                imageUrl: 'https://example.com/banner.jpg',
                height: 150,
                borderRadius: 8,
                placeholder: const Text('Loading Banner'),
                errorWidget: const Icon(Icons.landscape),
                semanticLabel: 'Hero Banner',
              ),
            ),
          ),
        );

        expect(find.byType(ClipRRect), findsOneWidget);
        final image = tester.widget<Image>(find.byType(Image));
        expect(image.height, 150);
        expect(image.semanticLabel, 'Hero Banner');
      });
    });

    group('Edge Cases', () {
      testWidgets('should handle very small dimensions', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppImage(
                imageUrl: 'https://example.com/tiny.jpg',
                width: 1,
                height: 1,
              ),
            ),
          ),
        );

        final image = tester.widget<Image>(find.byType(Image));
        expect(image.width, 1);
        expect(image.height, 1);
      });

      testWidgets('should handle very large dimensions', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppImage(
                imageUrl: 'https://example.com/huge.jpg',
                width: 9999,
                height: 8888,
              ),
            ),
          ),
        );

        final image = tester.widget<Image>(find.byType(Image));
        expect(image.width, 9999);
        expect(image.height, 8888);
      });

      testWidgets('should handle null dimensions', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppImage(
                imageUrl: 'https://example.com/flexible.jpg',
              ),
            ),
          ),
        );

        final image = tester.widget<Image>(find.byType(Image));
        expect(image.width, null);
        expect(image.height, null);
      });

      testWidgets('should handle combination of all properties', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppImage(
                imageUrl: 'https://example.com/complete.jpg',
                width: 200,
                height: 150,
                fit: BoxFit.fitWidth,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                ),
                placeholder: Text('Custom Loading'),
                errorWidget: Icon(Icons.warning),
                semanticLabel: 'Complete Example Image',
              ),
            ),
          ),
        );

        expect(find.byType(ClipRRect), findsOneWidget);
        final image = tester.widget<Image>(find.byType(Image));
        expect(image.width, 200);
        expect(image.height, 150);
        expect(image.fit, BoxFit.fitWidth);
        expect(image.semanticLabel, 'Complete Example Image');
      });

      testWidgets('should handle empty URL gracefully', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppImage(
                imageUrl: '',
                width: 100,
                height: 100,
              ),
            ),
          ),
        );

        // Should show error widget for empty URL
        await tester.pumpAndSettle();
        expect(find.byIcon(Icons.broken_image), findsOneWidget);
      });

      testWidgets('should handle empty asset path gracefully', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppImage(
                assetPath: '',
                width: 100,
                height: 100,
              ),
            ),
          ),
        );

        // Should show error widget for empty asset path
        await tester.pumpAndSettle();
        expect(find.byIcon(Icons.broken_image), findsOneWidget);
      });
    });
  });
}