import 'package:flutter/material.dart';

import '../../atoms/app_button/app_button.dart';
import '../../atoms/app_spacer/app_spacer.dart';
import '../../atoms/app_text/app_text.dart';
import 'app_empty_state_section.dart';

/// AppEmptyStateSectionShowcase
///
/// Un showcase completo que demuestra diferentes configuraciones y casos de uso
/// del organismo AppEmptyStateSection. Sirve tanto como documentación visual
/// como campo de pruebas para los distintos estados y propiedades del componente.
class AppEmptyStateSectionShowcase extends StatelessWidget {
  const AppEmptyStateSectionShowcase({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AppText(
          'AppEmptyStateSection Showcase',
          variant: AppTextVariant.titleLarge,
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Section 1: Basic empty state with icon, title, and description
          _buildShowcaseSection(
            context,
            title: 'Basic Empty State',
            description: 'Simple configuration with icon, title, and description',
            child: const AppEmptyStateSection(
              icon: Icons.folder_open,
              title: 'No files found',
              description: 'This folder is empty. Files you add will appear here.',
            ),
          ),

          // Section 2: Empty state with primary action
          _buildShowcaseSection(
            context,
            title: 'With Primary Action',
            description: 'Includes a primary call-to-action button',
            child: AppEmptyStateSection(
              icon: Icons.add_circle_outline,
              title: 'No items yet',
              description: 'Get started by creating your first item.',
              primaryAction: AppButton(
                text: 'Create Item',
                onPressed: () => debugPrint('Create item tapped'),
                variant: AppButtonVariant.primary,
              ),
            ),
          ),

          // Section 3: Empty state with primary and secondary actions
          _buildShowcaseSection(
            context,
            title: 'With Primary + Secondary Actions',
            description: 'Shows visual hierarchy with both action types',
            child: AppEmptyStateSection(
              icon: Icons.shopping_cart_outlined,
              title: 'Your cart is empty',
              description: 'Browse our products and add items to your cart.',
              primaryAction: AppButton(
                text: 'Browse Products',
                onPressed: () => debugPrint('Browse products tapped'),
                variant: AppButtonVariant.primary,
              ),
              secondaryAction: AppButton(
                text: 'View Wishlist',
                onPressed: () => debugPrint('View wishlist tapped'),
                variant: AppButtonVariant.outline,
              ),
            ),
          ),

          // Section 4: Empty state using imageUrl instead of icon
          _buildShowcaseSection(
            context,
            title: 'With Image URL',
            description: 'Uses a network image instead of an icon',
            child: AppEmptyStateSection(
              imageUrl: 'https://via.placeholder.com/200x160/E0E0E0/757575?text=No+Data',
              title: 'No data available',
              description: 'We couldn\'t find any data to display at this time.',
              primaryAction: AppButton(
                text: 'Refresh',
                onPressed: () => debugPrint('Refresh tapped'),
                variant: AppButtonVariant.secondary,
              ),
            ),
          ),

          // Section 5: Minimal empty state with title only
          _buildShowcaseSection(
            context,
            title: 'Minimal Configuration',
            description: 'Title only - no icon, image, or actions',
            child: const AppEmptyStateSection(
              title: 'Nothing to see here',
            ),
          ),

          // Section 6: Empty state with left-aligned text
          _buildShowcaseSection(
            context,
            title: 'Left-Aligned Text',
            description: 'Custom text alignment for specific layout needs',
            child: const AppEmptyStateSection(
              icon: Icons.search_off,
              title: 'No search results',
              description: 'We couldn\'t find anything matching your search criteria. Try adjusting your filters or search terms.',
              textAlign: TextAlign.left,
            ),
          ),

          // Add extra spacing at the bottom
          AppSpacerFactory.extraLargeVertical(),
        ],
      ),
    );
  }

  /// Builds a labeled showcase section with consistent styling
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
        
        // Section description
        AppText(
          description,
          variant: AppTextVariant.bodySmall,
          color: theme.colorScheme.onSurfaceVariant,
        ),
        
        AppSpacerFactory.mediumVertical(),
        
        // Showcase container with subtle border
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(
              color: theme.colorScheme.outline.withOpacity(0.2),
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: child,
        ),
        
        // Spacing between sections
        AppSpacerFactory.extraLargeVertical(),
      ],
    );
  }
}