import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pragma_design_system/organisms.dart';
import 'package:pragma_design_system/atoms.dart';

void main() {
  group('AppProductListItem Tests', () {
    group('Constructor and Properties', () {
      testWidgets('should create with required title only', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppProductListItem(title: 'Product Name'),
            ),
          ),
        );

        expect(find.byType(AppProductListItem), findsOneWidget);
        expect(find.text('Product Name'), findsOneWidget);
      });

      testWidgets('should have correct default property values', (tester) async {
        const productItem = AppProductListItem(title: 'Test Product');

        expect(productItem.title, 'Test Product');
        expect(productItem.subtitle, isNull);
        expect(productItem.imageUrl, isNull);
        expect(productItem.price, isNull);
        expect(productItem.trailingAction, isNull);
        expect(productItem.onTap, isNull);
        expect(productItem.isEnabled, true);
      });

      testWidgets('should accept all optional parameters', (tester) async {
        bool tapCalled = false;
        final trailingWidget = Icon(Icons.arrow_forward);

        final productItem = AppProductListItem(
          title: 'Complete Product',
          subtitle: 'Product description',
          imageUrl: 'https://example.com/image.png',
          price: '\$99.99',
          trailingAction: trailingWidget,
          onTap: () => tapCalled = true,
          isEnabled: false,
        );

        expect(productItem.title, 'Complete Product');
        expect(productItem.subtitle, 'Product description');
        expect(productItem.imageUrl, 'https://example.com/image.png');
        expect(productItem.price, '\$99.99');
        expect(productItem.trailingAction, trailingWidget);
        expect(productItem.isEnabled, false);
      });
    });

    group('Title Display', () {
      testWidgets('should display title with correct styling', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppProductListItem(title: 'Product Title'),
            ),
          ),
        );

        expect(find.text('Product Title'), findsOneWidget);
        
        final titleWidget = tester.widget<AppText>(
          find.widgetWithText(AppText, 'Product Title'),
        );
        expect(titleWidget.variant, AppTextVariant.bodyLarge);
        expect(titleWidget.fontWeight, FontWeight.w500);
        expect(titleWidget.maxLines, 1);
        expect(titleWidget.overflow, TextOverflow.ellipsis);
      });

      testWidgets('should apply theme onSurface color to title when enabled', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(
                seedColor: Colors.blue,
                brightness: Brightness.light,
              ),
            ),
            home: Scaffold(
              body: AppProductListItem(
                title: 'Enabled Product',
                isEnabled: true,
              ),
            ),
          ),
        );

        final titleWidget = tester.widget<AppText>(
          find.widgetWithText(AppText, 'Enabled Product'),
        );
        final theme = Theme.of(tester.element(find.byType(Scaffold)));
        expect(titleWidget.color, theme.colorScheme.onSurface);
      });

      testWidgets('should apply dimmed color to title when disabled', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppProductListItem(
                title: 'Disabled Product',
                isEnabled: false,
              ),
            ),
          ),
        );

        final titleWidget = tester.widget<AppText>(
          find.widgetWithText(AppText, 'Disabled Product'),
        );
        final theme = Theme.of(tester.element(find.byType(Scaffold)));
        final expectedColor = theme.colorScheme.onSurface.withOpacity(0.38);
        expect(titleWidget.color, expectedColor);
      });

      testWidgets('should handle long title with ellipsis', (tester) async {
        const longTitle = 'This is a very long product title that should be truncated with ellipsis to prevent layout overflow';
        
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppProductListItem(title: longTitle),
            ),
          ),
        );

        expect(find.text(longTitle), findsOneWidget);
        
        final titleWidget = tester.widget<AppText>(
          find.widgetWithText(AppText, longTitle),
        );
        expect(titleWidget.maxLines, 1);
        expect(titleWidget.overflow, TextOverflow.ellipsis);
      });

      testWidgets('should handle empty title string', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppProductListItem(title: ''),
            ),
          ),
        );

        expect(find.text(''), findsOneWidget);
        expect(find.byType(AppText), findsOneWidget);
        expect(tester.takeException(), isNull);
      });

      testWidgets('should handle special characters in title', (tester) async {
        const specialTitle = 'Special Product: !@#\$%^&*() 🎁';
        
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppProductListItem(title: specialTitle),
            ),
          ),
        );

        expect(find.text(specialTitle), findsOneWidget);
        expect(tester.takeException(), isNull);
      });
    });

    group('Subtitle Display', () {
      testWidgets('should not display subtitle when null', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppProductListItem(title: 'Title Only'),
            ),
          ),
        );

        expect(find.text('Title Only'), findsOneWidget);
        // Should only find one AppText widget (the title)
        expect(find.byType(AppText), findsOneWidget);
      });

      testWidgets('should display subtitle when provided', (tester) async {
        const subtitle = 'High-quality product with excellent features';
        
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppProductListItem(
                title: 'Product',
                subtitle: subtitle,
              ),
            ),
          ),
        );

        expect(find.text(subtitle), findsOneWidget);
        
        final subtitleWidget = tester.widget<AppText>(
          find.widgetWithText(AppText, subtitle),
        );
        expect(subtitleWidget.variant, AppTextVariant.bodyMedium);
        expect(subtitleWidget.maxLines, 2);
        expect(subtitleWidget.overflow, TextOverflow.ellipsis);
      });

      testWidgets('should apply theme onSurfaceVariant color to subtitle when enabled', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(
                seedColor: Colors.green,
                brightness: Brightness.light,
              ),
            ),
            home: Scaffold(
              body: AppProductListItem(
                title: 'Product',
                subtitle: 'Enabled subtitle',
                isEnabled: true,
              ),
            ),
          ),
        );

        final subtitleWidget = tester.widget<AppText>(
          find.widgetWithText(AppText, 'Enabled subtitle'),
        );
        final theme = Theme.of(tester.element(find.byType(Scaffold)));
        expect(subtitleWidget.color, theme.colorScheme.onSurfaceVariant);
      });

      testWidgets('should apply dimmed color to subtitle when disabled', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppProductListItem(
                title: 'Product',
                subtitle: 'Disabled subtitle',
                isEnabled: false,
              ),
            ),
          ),
        );

        final subtitleWidget = tester.widget<AppText>(
          find.widgetWithText(AppText, 'Disabled subtitle'),
        );
        final theme = Theme.of(tester.element(find.byType(Scaffold)));
        final expectedColor = theme.colorScheme.onSurface.withOpacity(0.38);
        expect(subtitleWidget.color, expectedColor);
      });

      testWidgets('should handle long subtitle with ellipsis', (tester) async {
        const longSubtitle = 'This is a very long product description that should be truncated after two lines to prevent the layout from becoming too tall and maintain visual hierarchy in the list item display';
        
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppProductListItem(
                title: 'Product',
                subtitle: longSubtitle,
              ),
            ),
          ),
        );

        expect(find.text(longSubtitle), findsOneWidget);
        
        final subtitleWidget = tester.widget<AppText>(
          find.widgetWithText(AppText, longSubtitle),
        );
        expect(subtitleWidget.maxLines, 2);
        expect(subtitleWidget.overflow, TextOverflow.ellipsis);
      });

      testWidgets('should add spacing between title and subtitle', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppProductListItem(
                title: 'Product Name',
                subtitle: 'Product description',
              ),
            ),
          ),
        );

        // Should have extra small spacer between title and subtitle
        final spacers = tester.widgetList<AppSpacer>(find.byType(AppSpacer));
        expect(spacers.where((s) => s.size == AppSpacerSize.extraSmall).isNotEmpty, true);
      });
    });

    group('Price Display', () {
      testWidgets('should not display price when null', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppProductListItem(
                title: 'Product',
                subtitle: 'Subtitle',
              ),
            ),
          ),
        );

        // Should only find two AppText widgets (title + subtitle)
        expect(find.byType(AppText), findsNWidgets(2));
      });

      testWidgets('should display price when provided', (tester) async {
        const price = '\$29.99';
        
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppProductListItem(
                title: 'Product',
                price: price,
              ),
            ),
          ),
        );

        expect(find.text(price), findsOneWidget);
        
        final priceWidget = tester.widget<AppText>(
          find.widgetWithText(AppText, price),
        );
        expect(priceWidget.variant, AppTextVariant.titleMedium);
        expect(priceWidget.fontWeight, FontWeight.w600);
      });

      testWidgets('should apply theme primary color to price when enabled', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(
                seedColor: Colors.purple,
                brightness: Brightness.light,
              ),
            ),
            home: Scaffold(
              body: AppProductListItem(
                title: 'Product',
                price: '\$49.99',
                isEnabled: true,
              ),
            ),
          ),
        );

        final priceWidget = tester.widget<AppText>(
          find.widgetWithText(AppText, '\$49.99'),
        );
        final theme = Theme.of(tester.element(find.byType(Scaffold)));
        expect(priceWidget.color, theme.colorScheme.primary);
      });

      testWidgets('should apply dimmed primary color to price when disabled', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppProductListItem(
                title: 'Product',
                price: '\$19.99',
                isEnabled: false,
              ),
            ),
          ),
        );

        final priceWidget = tester.widget<AppText>(
          find.widgetWithText(AppText, '\$19.99'),
        );
        final theme = Theme.of(tester.element(find.byType(Scaffold)));
        final expectedColor = theme.colorScheme.primary.withOpacity(0.38);
        expect(priceWidget.color, expectedColor);
      });

      testWidgets('should add spacing before price', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppProductListItem(
                title: 'Product',
                subtitle: 'Description',
                price: '\$39.99',
              ),
            ),
          ),
        );

        // Should have extra small spacers: title-subtitle and subtitle-price
        final spacers = tester.widgetList<AppSpacer>(find.byType(AppSpacer));
        expect(spacers.where((s) => s.size == AppSpacerSize.extraSmall).length, 2);
      });

      testWidgets('should handle different price formats', (tester) async {
        final priceFormats = [
          '\$99.99',
          '€49.50',
          '¥1,200',
          'FREE',
          '29.99 USD',
          '\$0.99',
        ];

        for (final priceFormat in priceFormats) {
          await tester.pumpWidget(
            MaterialApp(
              home: Scaffold(
                body: AppProductListItem(
                  title: 'Product',
                  price: priceFormat,
                ),
              ),
            ),
          );

          expect(find.text(priceFormat), findsOneWidget);
          
          await tester.pumpWidget(Container()); // Clear for next iteration
        }
      });
    });

    group('Image Display', () {
      testWidgets('should not display image when imageUrl is null', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppProductListItem(title: 'No Image Product'),
            ),
          ),
        );

        expect(find.byType(AppImage), findsNothing);
        expect(find.byType(ClipRRect), findsNothing);
      });

      testWidgets('should display image when imageUrl is provided', (tester) async {
        const imageUrl = 'https://example.com/product.jpg';
        
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppProductListItem(
                title: 'Product with Image',
                imageUrl: imageUrl,
              ),
            ),
          ),
        );

        expect(find.byType(AppImage), findsOneWidget);
        
        final appImage = tester.widget<AppImage>(find.byType(AppImage));
        expect(appImage.imageUrl, imageUrl);
        expect(appImage.fit, BoxFit.cover);
      });

      testWidgets('should have correct image size and styling', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppProductListItem(
                title: 'Product',
                imageUrl: 'https://example.com/image.png',
              ),
            ),
          ),
        );

        final imageContainer = tester.widget<SizedBox>(
          find.ancestor(
            of: find.byType(ClipRRect),
            matching: find.byType(SizedBox),
          ).first,
        );
        expect(imageContainer.width, 56.0);
        expect(imageContainer.height, 56.0);

        final clipRRect = tester.widget<ClipRRect>(find.byType(ClipRRect));
        expect(clipRRect.borderRadius, BorderRadius.circular(8.0));
      });

      testWidgets('should add spacing after image', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppProductListItem(
                title: 'Product with Image',
                imageUrl: 'https://example.com/image.png',
              ),
            ),
          ),
        );

        // Should have medium horizontal spacer after image
        final spacers = tester.widgetList<AppSpacer>(find.byType(AppSpacer));
        final horizontalSpacers = spacers.where(
          (s) => s.direction == AppSpacerDirection.horizontal && s.size == AppSpacerSize.medium,
        );
        expect(horizontalSpacers.isNotEmpty, true);
      });
    });

    group('Trailing Action Display', () {
      testWidgets('should not display trailing action when null', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppProductListItem(title: 'No Action Product'),
            ),
          ),
        );

        // Should not find any additional widgets beyond the basic structure
        expect(find.byIcon(Icons.arrow_forward), findsNothing);
      });

      testWidgets('should display trailing action when provided', (tester) async {
        final trailingAction = Icon(Icons.favorite, color: Colors.red);
        
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppProductListItem(
                title: 'Product with Action',
                trailingAction: trailingAction,
              ),
            ),
          ),
        );

        expect(find.byIcon(Icons.favorite), findsOneWidget);
      });

      testWidgets('should constrain trailing action size', (tester) async {
        final trailingAction = Container(
          width: 100,
          height: 100,
          color: Colors.blue,
          child: Icon(Icons.more_vert),
        );
        
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppProductListItem(
                title: 'Product',
                trailingAction: trailingAction,
              ),
            ),
          ),
        );

        // Should find the constraining SizedBox
        final constrainingBox = tester.widget<SizedBox>(
          find.ancestor(
            of: find.byType(Align),
            matching: find.byType(SizedBox),
          ).last,
        );
        expect(constrainingBox.width, 40.0);
        expect(constrainingBox.height, 40.0);
      });

      testWidgets('should align trailing action to center right', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppProductListItem(
                title: 'Product',
                trailingAction: Icon(Icons.arrow_forward),
              ),
            ),
          ),
        );

        final align = tester.widget<Align>(find.byType(Align));
        expect(align.alignment, Alignment.centerRight);
      });

      testWidgets('should add spacing before trailing action', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppProductListItem(
                title: 'Product',
                trailingAction: Icon(Icons.arrow_forward),
              ),
            ),
          ),
        );

        // Should have medium horizontal spacer before trailing action
        final spacers = tester.widgetList<AppSpacer>(find.byType(AppSpacer));
        final horizontalSpacers = spacers.where(
          (s) => s.direction == AppSpacerDirection.horizontal && s.size == AppSpacerSize.medium,
        );
        expect(horizontalSpacers.isNotEmpty, true);
      });

      testWidgets('should accept different trailing action widgets', (tester) async {
        final actionWidgets = [
          Icon(Icons.favorite),
          Icon(Icons.shopping_cart),
          AppButton(text: 'Buy', onPressed: () {}),
          Container(width: 20, height: 20, color: Colors.red),
        ];

        for (final actionWidget in actionWidgets) {
          await tester.pumpWidget(
            MaterialApp(
              home: Scaffold(
                body: AppProductListItem(
                  title: 'Product',
                  trailingAction: actionWidget,
                ),
              ),
            ),
          );

          // Should not throw exceptions
          expect(tester.takeException(), isNull);
          
          await tester.pumpWidget(Container()); // Clear for next iteration
        }
      });
    });

    group('Interaction Behavior', () {
      testWidgets('should handle tap when enabled and onTap provided', (tester) async {
        bool tapped = false;
        
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppProductListItem(
                title: 'Tappable Product',
                onTap: () => tapped = true,
                isEnabled: true,
              ),
            ),
          ),
        );

        await tester.tap(find.byType(AppProductListItem));
        expect(tapped, true);
      });

      testWidgets('should not handle tap when disabled', (tester) async {
        bool tapped = false;
        
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppProductListItem(
                title: 'Disabled Product',
                onTap: () => tapped = true,
                isEnabled: false,
              ),
            ),
          ),
        );

        await tester.tap(find.byType(AppProductListItem));
        expect(tapped, false);
      });

      testWidgets('should not handle tap when onTap is null', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppProductListItem(
                title: 'Non-tappable Product',
                isEnabled: true,
              ),
            ),
          ),
        );

        // Should not throw errors when tapping
        await tester.tap(find.byType(AppProductListItem));
        expect(tester.takeException(), isNull);
      });

      testWidgets('should have proper InkWell properties', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppProductListItem(
                title: 'Product',
                onTap: () {},
              ),
            ),
          ),
        );

        final inkWell = tester.widget<InkWell>(find.byType(InkWell));
        expect(inkWell.borderRadius, BorderRadius.circular(8.0));
        expect(inkWell.onTap, isNotNull);
      });

      testWidgets('should disable InkWell when isEnabled is false', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppProductListItem(
                title: 'Disabled Product',
                onTap: () {},
                isEnabled: false,
              ),
            ),
          ),
        );

        final inkWell = tester.widget<InkWell>(find.byType(InkWell));
        expect(inkWell.onTap, isNull);
      });
    });

    group('Enabled/Disabled State', () {
      testWidgets('should have full opacity when enabled', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppProductListItem(
                title: 'Enabled Product',
                isEnabled: true,
              ),
            ),
          ),
        );

        final opacity = tester.widget<Opacity>(find.byType(Opacity));
        expect(opacity.opacity, 1.0);
      });

      testWidgets('should have reduced opacity when disabled', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppProductListItem(
                title: 'Disabled Product',
                isEnabled: false,
              ),
            ),
          ),
        );

        final opacity = tester.widget<Opacity>(find.byType(Opacity));
        expect(opacity.opacity, 0.38);
      });

      testWidgets('should apply disabled colors to all text elements', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppProductListItem(
                title: 'Disabled Product',
                subtitle: 'Disabled subtitle',
                price: '\$19.99',
                isEnabled: false,
              ),
            ),
          ),
        );

        final theme = Theme.of(tester.element(find.byType(Scaffold)));
        
        final titleWidget = tester.widget<AppText>(
          find.widgetWithText(AppText, 'Disabled Product'),
        );
        expect(titleWidget.color, theme.colorScheme.onSurface.withOpacity(0.38));
        
        final subtitleWidget = tester.widget<AppText>(
          find.widgetWithText(AppText, 'Disabled subtitle'),
        );
        expect(subtitleWidget.color, theme.colorScheme.onSurface.withOpacity(0.38));
        
        final priceWidget = tester.widget<AppText>(
          find.widgetWithText(AppText, '\$19.99'),
        );
        expect(priceWidget.color, theme.colorScheme.primary.withOpacity(0.38));
      });
    });

    group('Layout and Structure', () {
      testWidgets('should have proper container padding', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppProductListItem(title: 'Product'),
            ),
          ),
        );

        final container = tester.widget<Container>(find.byType(Container));
        expect(container.padding, const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0));
      });

      testWidgets('should use Row layout with proper cross axis alignment', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppProductListItem(title: 'Product'),
            ),
          ),
        );

        final row = tester.widget<Row>(find.byType(Row));
        expect(row.crossAxisAlignment, CrossAxisAlignment.center);
      });

      testWidgets('should expand content area properly', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppProductListItem(
                title: 'Product',
                imageUrl: 'https://example.com/image.png',
                trailingAction: Icon(Icons.arrow_forward),
              ),
            ),
          ),
        );

        // Should have Expanded widget around content
        expect(find.byType(Expanded), findsOneWidget);
      });

      testWidgets('should have proper content column layout', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppProductListItem(
                title: 'Product',
                subtitle: 'Description',
              ),
            ),
          ),
        );

        final column = tester.widget<Column>(
          find.descendant(
            of: find.byType(Expanded),
            matching: find.byType(Column),
          ),
        );
        expect(column.crossAxisAlignment, CrossAxisAlignment.start);
        expect(column.mainAxisSize, MainAxisSize.min);
      });
    });

    group('Complete Product Item Scenarios', () {
      testWidgets('should display complete product item with all elements', (tester) async {
        bool actionTapped = false;
        
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppProductListItem(
                title: 'Premium Wireless Headphones',
                subtitle: 'High-quality sound with noise cancellation',
                imageUrl: 'https://example.com/headphones.jpg',
                price: '\$299.99',
                trailingAction: Icon(Icons.add_shopping_cart),
                onTap: () => actionTapped = true,
                isEnabled: true,
              ),
            ),
          ),
        );

        expect(find.text('Premium Wireless Headphones'), findsOneWidget);
        expect(find.text('High-quality sound with noise cancellation'), findsOneWidget);
        expect(find.text('\$299.99'), findsOneWidget);
        expect(find.byType(AppImage), findsOneWidget);
        expect(find.byIcon(Icons.add_shopping_cart), findsOneWidget);
        
        await tester.tap(find.byType(AppProductListItem));
        expect(actionTapped, true);
      });

      testWidgets('should display minimal product item', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppProductListItem(title: 'Simple Product'),
            ),
          ),
        );

        expect(find.text('Simple Product'), findsOneWidget);
        expect(find.byType(AppImage), findsNothing);
        expect(find.byType(Icon), findsNothing);
        // Should only have title AppText
        expect(find.byType(AppText), findsOneWidget);
      });

      testWidgets('should display product with image only', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppProductListItem(
                title: 'Visual Product',
                imageUrl: 'https://example.com/product.png',
              ),
            ),
          ),
        );

        expect(find.text('Visual Product'), findsOneWidget);
        expect(find.byType(AppImage), findsOneWidget);
        expect(find.byType(AppText), findsOneWidget);
      });

      testWidgets('should display product with price only', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppProductListItem(
                title: 'Priced Product',
                price: 'FREE',
              ),
            ),
          ),
        );

        expect(find.text('Priced Product'), findsOneWidget);
        expect(find.text('FREE'), findsOneWidget);
        expect(find.byType(AppText), findsNWidgets(2));
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
              body: AppProductListItem(
                title: 'Light Theme Product',
                subtitle: 'Light description',
                price: '\$49.99',
              ),
            ),
          ),
        );

        final theme = Theme.of(tester.element(find.byType(Scaffold)));
        
        final titleWidget = tester.widget<AppText>(
          find.widgetWithText(AppText, 'Light Theme Product'),
        );
        expect(titleWidget.color, theme.colorScheme.onSurface);
        
        final subtitleWidget = tester.widget<AppText>(
          find.widgetWithText(AppText, 'Light description'),
        );
        expect(subtitleWidget.color, theme.colorScheme.onSurfaceVariant);
        
        final priceWidget = tester.widget<AppText>(
          find.widgetWithText(AppText, '\$49.99'),
        );
        expect(priceWidget.color, theme.colorScheme.primary);
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
              body: AppProductListItem(
                title: 'Dark Theme Product',
                subtitle: 'Dark description',
                price: '\$29.99',
              ),
            ),
          ),
        );

        final theme = Theme.of(tester.element(find.byType(Scaffold)));
        
        final titleWidget = tester.widget<AppText>(
          find.widgetWithText(AppText, 'Dark Theme Product'),
        );
        expect(titleWidget.color, theme.colorScheme.onSurface);
      });
    });

    group('Edge Cases', () {
      testWidgets('should handle very long content', (tester) async {
        const longTitle = 'This is an extremely long product title that should be truncated properly to prevent layout issues and maintain visual hierarchy in the list';
        const longSubtitle = 'This is an extremely long product description with multiple sentences that should wrap properly and be truncated after two lines to maintain consistent item heights in product lists throughout the application interface design';
        
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppProductListItem(
                title: longTitle,
                subtitle: longSubtitle,
                price: '\$999,999.99',
              ),
            ),
          ),
        );

        expect(find.text(longTitle), findsOneWidget);
        expect(find.text(longSubtitle), findsOneWidget);
        expect(tester.takeException(), isNull);
      });

      testWidgets('should handle special characters in all fields', (tester) async {
        const specialTitle = 'Special Product: !@#\$%^&*() 🎁';
        const specialSubtitle = 'Description with émojis: 💯 ⭐ and spëcial chars';
        const specialPrice = '€49,99 + 19% MwSt.';
        
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppProductListItem(
                title: specialTitle,
                subtitle: specialSubtitle,
                price: specialPrice,
              ),
            ),
          ),
        );

        expect(find.text(specialTitle), findsOneWidget);
        expect(find.text(specialSubtitle), findsOneWidget);
        expect(find.text(specialPrice), findsOneWidget);
        expect(tester.takeException(), isNull);
      });

      testWidgets('should handle rapid state changes', (tester) async {
        final ValueNotifier<bool> isEnabledNotifier = ValueNotifier(true);
        
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: ValueListenableBuilder<bool>(
                valueListenable: isEnabledNotifier,
                builder: (context, isEnabled, child) {
                  return AppProductListItem(
                    title: 'Dynamic Product',
                    isEnabled: isEnabled,
                  );
                },
              ),
            ),
          ),
        );

        // Start enabled
        expect((tester.widget<Opacity>(find.byType(Opacity))).opacity, 1.0);
        
        // Change to disabled
        isEnabledNotifier.value = false;
        await tester.pump();
        expect((tester.widget<Opacity>(find.byType(Opacity))).opacity, 0.38);
        
        // Change back to enabled
        isEnabledNotifier.value = true;
        await tester.pump();
        expect((tester.widget<Opacity>(find.byType(Opacity))).opacity, 1.0);
        
        expect(tester.takeException(), isNull);
      });
    });

    group('Accessibility', () {
      testWidgets('should be semantically accessible', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppProductListItem(
                title: 'Accessible Product',
                subtitle: 'This product is fully accessible',
                price: '\$19.99',
                trailingAction: Icon(Icons.add_shopping_cart),
                onTap: () {},
              ),
            ),
          ),
        );

        // Should use accessible text components
        expect(find.byType(AppText), findsNWidgets(3)); // Title + subtitle + price
        
        // Should provide tap interaction
        expect(find.byType(InkWell), findsOneWidget);
        
        // Should be focusable for accessibility
        expect(find.text('Accessible Product'), findsOneWidget);
        expect(find.text('This product is fully accessible'), findsOneWidget);
        expect(find.text('\$19.99'), findsOneWidget);
      });

      testWidgets('should handle disabled state accessibly', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppProductListItem(
                title: 'Disabled Product',
                subtitle: 'This product is disabled',
                onTap: () {},
                isEnabled: false,
              ),
            ),
          ),
        );

        // Should disable tap interaction when disabled
        final inkWell = tester.widget<InkWell>(find.byType(InkWell));
        expect(inkWell.onTap, isNull);
        
        // Should have reduced opacity to indicate disabled state
        final opacity = tester.widget<Opacity>(find.byType(Opacity));
        expect(opacity.opacity, 0.38);
      });
    });
  });
}