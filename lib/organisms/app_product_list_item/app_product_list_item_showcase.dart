import 'package:flutter/material.dart';
import 'package:pragma_design_system/pragma_design_system.dart';

/// AppProductListItemShowcase - Demuestra varias variantes de `AppProductListItem`.
///
/// Esta página muestra diferentes configuraciones y casos de uso del organismo AppProductListItem.
/// Demuestra cómo puede usarse en escenarios reales de comercio electrónico con distintas
/// combinaciones de información de producto y acciones.
class AppProductListItemShowcase extends StatelessWidget {
  const AppProductListItemShowcase({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AppProductListItem Showcase'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // Section 1: Basic product (title only)
          const AppText(
            'Basic Product',
            variant: AppTextVariant.titleLarge,
          ),
          const SizedBox(height: 8),
          // Minimal product display with just a title - useful for simple lists
          AppProductListItem(
            title: 'Basic Product Item',
            onTap: () => debugPrint('Basic product tapped'),
          ),

          const SizedBox(height: 24),

          // Section 2: Product with image
          const AppText(
            'Product with Image',
            variant: AppTextVariant.titleLarge,
          ),
          const SizedBox(height: 8),
          // Product with visual representation using placeholder image
          AppProductListItem(
            title: 'Wireless Headphones',
            imageUrl: 'https://via.placeholder.com/56x56/42A5F5/FFFFFF?text=🎧',
            onTap: () => debugPrint('Headphones tapped'),
          ),

          const SizedBox(height: 24),

          // Section 3: Product with subtitle and price
          const AppText(
            'Product with Subtitle and Price',
            variant: AppTextVariant.titleLarge,
          ),
          const SizedBox(height: 8),
          // Complete product information without image - good for text-heavy lists
          AppProductListItem(
            title: 'Premium Coffee Beans',
            subtitle: 'Organic, fair-trade, medium roast coffee from Colombia',
            price: '\$ 25.000',
            onTap: () => debugPrint('Coffee tapped'),
          ),

          const SizedBox(height: 24),

          // Section 4: Product with trailing action button
          const AppText(
            'Product with Trailing Action',
            variant: AppTextVariant.titleLarge,
          ),
          const SizedBox(height: 8),
          // Product with add-to-cart action - common e-commerce pattern
          AppProductListItem(
            title: 'Smartphone Case',
            subtitle: 'Protective case with wireless charging support',
            trailingAction: Icon(
              Icons.add_shopping_cart,
              color: Theme.of(context).colorScheme.primary,
            ),
            onTap: () => debugPrint('Phone case tapped'),
          ),

          const SizedBox(height: 24),

          // Section 5: Disabled product
          const AppText(
            'Disabled Product',
            variant: AppTextVariant.titleLarge,
          ),
          const SizedBox(height: 8),
          // Disabled state for out-of-stock or unavailable products
          AppProductListItem(
            title: 'Out of Stock Item',
            subtitle: 'This product is currently unavailable',
            price: '\$ 15.000',
            imageUrl: 'https://via.placeholder.com/56x56/BDBDBD/FFFFFF?text=📦',
            isEnabled: false,
            onTap: () => debugPrint('Disabled product tapped'),
          ),

          const SizedBox(height: 24),

          // Section 6: Complete product example
          const AppText(
            'Complete Product Example',
            variant: AppTextVariant.titleLarge,
          ),
          const SizedBox(height: 8),
          // Full-featured product item with all elements - typical e-commerce display
          AppProductListItem(
            title: 'Premium Wireless Speaker',
            subtitle: 'High-quality Bluetooth speaker with 360° sound and 12-hour battery life',
            price: '\$ 199.000',
            imageUrl: 'https://via.placeholder.com/56x56/4CAF50/FFFFFF?text=🔊',
            trailingAction: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                Icons.add,
                color: Theme.of(context).colorScheme.onPrimary,
                size: 16,
              ),
            ),
            onTap: () => debugPrint('Premium speaker tapped'),
          ),

          const SizedBox(height: 24),

          // Section 7: Product with favorite action
          const AppText(
            'Product with Favorite Action',
            variant: AppTextVariant.titleLarge,
          ),
          const SizedBox(height: 8),
          // Product with favorite/wishlist action - another common pattern
          AppProductListItem(
            title: 'Fitness Tracker',
            subtitle: 'Advanced health monitoring with GPS and heart rate tracking',
            price: '\$ 129.000',
            imageUrl: 'https://via.placeholder.com/56x56/FF9800/FFFFFF?text=⌚',
            trailingAction: const Icon(Icons.favorite_border),
            onTap: () => debugPrint('Fitness tracker tapped'),
          ),

          const SizedBox(height: 24),

          // Section 8: Product with long text
          const AppText(
            'Product with Long Text',
            variant: AppTextVariant.titleLarge,
          ),
          const SizedBox(height: 8),
          // Demonstrates text overflow handling for long product names and descriptions
          AppProductListItem(
            title: 'Professional DSLR Camera with Advanced Image Processing and Multiple Lens Compatibility',
            subtitle: 'This is a very long product description that demonstrates how the organism handles text overflow and maintains proper layout even with extensive product information that might exceed the available space.',
            price: '\$ 1.299.000',
            imageUrl: 'https://via.placeholder.com/56x56/9C27B0/FFFFFF?text=📷',
            trailingAction: const Icon(Icons.more_vert),
            onTap: () => debugPrint('Camera tapped'),
          ),

          const SizedBox(height: 40),

          // Footer note
          AppText(
            'All variants demonstrate real-world e-commerce scenarios using AppProductListItem',
            variant: AppTextVariant.bodySmall,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}