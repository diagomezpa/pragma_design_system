import 'package:flutter/material.dart';

import '../../atoms/app_button/app_button.dart';
import '../../atoms/app_spacer/app_spacer.dart';
import '../../atoms/app_text/app_text.dart';
import '../../organisms/app_empty_state_section/app_empty_state_section.dart';
import '../../organisms/app_product_list_item/app_product_list_item.dart';
import 'product_list_template.dart';

/// ProductListTemplateShowcase
///
/// A comprehensive showcase demonstrating how to use the ProductListTemplate
/// in different real-world scenarios. This serves as both documentation and
/// a testing ground for the template's behavior with various input combinations.
///
/// The showcase demonstrates:
/// - How the template handles populated product lists
/// - How the template adapts to empty states
/// - Proper usage of header widgets
/// - Integration with design system organisms and atoms
class ProductListTemplateShowcase extends StatelessWidget {
  const ProductListTemplateShowcase({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AppText(
          'ProductListTemplate Showcase',
          variant: AppTextVariant.titleLarge,
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Scenario 1: Product list with multiple items
          _buildShowcaseSection(
            context,
            title: '1. Product List with Items',
            description: 'Template with header and multiple products using AppProductListItem',
            child: ProductListTemplate(
              header: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const AppText(
                    'Featured Products',
                    variant: AppTextVariant.titleLarge,
                  ),
                  AppSpacerFactory.extraSmallVertical(),
                  const AppText(
                    'Discover our top-rated items',
                    variant: AppTextVariant.bodySmall,
                  ),
                ],
              ),
              products: [
                // Mock product 1: Premium item
                AppProductListItem(
                  imageUrl: 'https://via.placeholder.com/80x80/4CAF50/FFFFFF?text=P1',
                  title: 'Premium Wireless Headphones',
                  subtitle: 'High-quality audio with noise cancellation',
                  price: '\$299.99',
                  onTap: () => debugPrint('Tapped Premium Headphones'),
                ),

                // Mock product 2: Regular item
                AppProductListItem(
                  imageUrl: 'https://via.placeholder.com/80x80/2196F3/FFFFFF?text=P2',
                  title: 'Smartphone Stand',
                  subtitle: 'Adjustable aluminum stand for all devices',
                  price: '\$24.99',
                  onTap: () => debugPrint('Tapped Smartphone Stand'),
                ),

                // Mock product 3: Sale item
                AppProductListItem(
                  imageUrl: 'https://via.placeholder.com/80x80/FF9800/FFFFFF?text=P3',
                  title: 'Bluetooth Speaker',
                  subtitle: 'Portable speaker with 12-hour battery',
                  price: '\$79.99',
                  onTap: () => debugPrint('Tapped Bluetooth Speaker'),
                ),

                // Mock product 4: Out of stock
                AppProductListItem(
                  imageUrl: 'https://via.placeholder.com/80x80/9E9E9E/FFFFFF?text=P4',
                  title: 'USB-C Cable',
                  subtitle: 'Currently out of stock',
                  price: '\$12.99',
                  onTap: () => debugPrint('Tapped USB-C Cable'),
                ),
              ],
            ),
          ),

          AppSpacerFactory.hugeVertical(),

          // Scenario 2: Empty state
          _buildShowcaseSection(
            context,
            title: '2. Empty Product List',
            description: 'Template with empty products list showing AppEmptyStateSection',
            child: ProductListTemplate(
              header: const AppText(
                'Search Results',
                variant: AppTextVariant.titleLarge,
              ),
              products: const [], // Empty list to trigger empty state
              emptyState: AppEmptyStateSection(
                icon: Icons.search_off,
                title: 'No products found',
                description: 'We couldn\'t find any products matching your search criteria. Try adjusting your filters or search terms.',
                primaryAction: AppButton(
                  text: 'Clear Filters',
                  onPressed: () => debugPrint('Clear filters tapped'),
                  variant: AppButtonVariant.primary,
                ),
                secondaryAction: AppButton(
                  text: 'Browse All Products',
                  onPressed: () => debugPrint('Browse all tapped'),
                  variant: AppButtonVariant.outline,
                ),
              ),
            ),
          ),

          AppSpacerFactory.hugeVertical(),

          // Scenario 3: Minimal template usage
          _buildShowcaseSection(
            context,
            title: '3. Minimal Template Usage',
            description: 'Template without header, simple product list',
            child: ProductListTemplate(
              products: [
                AppProductListItem(
                  imageUrl: 'https://via.placeholder.com/80x80/E91E63/FFFFFF?text=M1',
                  title: 'Desk Lamp',
                  subtitle: 'LED desk lamp with adjustable brightness',
                  price: '\$45.00',
                  onTap: () => debugPrint('Tapped Desk Lamp'),
                ),
                AppProductListItem(
                  imageUrl: 'https://via.placeholder.com/80x80/9C27B0/FFFFFF?text=M2',
                  title: 'Notebook Set',
                  subtitle: 'Pack of 3 premium notebooks',
                  price: '\$18.99',
                  onTap: () => debugPrint('Tapped Notebook Set'),
                ),
              ],
            ),
          ),

          // Extra spacing at bottom
          AppSpacerFactory.extraLargeVertical(),
        ],
      ),
    );
  }

  /// Builds a labeled showcase section with consistent styling and explanations
  Widget _buildShowcaseSection(
    BuildContext context, {
    required String title,
    required String description,
    required Widget child,
  }) {
    final theme = Theme.of(context);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section title
        AppText(
          title,
          variant: AppTextVariant.titleMedium,
          color: theme.colorScheme.primary,
        ),
        
        AppSpacerFactory.extraSmallVertical(),
        
        // Section description explaining what this demonstrates
        AppText(
          description,
          variant: AppTextVariant.bodySmall,
          color: theme.colorScheme.onSurfaceVariant,
        ),
        
        AppSpacerFactory.mediumVertical(),
        
        // Template showcase wrapped in a visual container
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(
              color: theme.colorScheme.outline.withOpacity(0.2),
            ),
            borderRadius: BorderRadius.circular(12),
            color: theme.colorScheme.surface.withOpacity(0.5),
          ),
          padding: const EdgeInsets.all(16),
          child: child,
        ),
      ],
    );
  }
}