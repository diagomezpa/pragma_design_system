import 'package:flutter/material.dart';
import 'package:pragma_design_system/pragma_design_system.dart';

/// AppEmptyStateShowcase - Demonstrates various `AppEmptyState` variants.
///
/// This page showcases different configurations and use cases of the AppEmptyState molecule.
/// It demonstrates the flexibility of the component for different empty state scenarios
/// like search results, onboarding, errors, and action prompts.
class AppEmptyStateShowcase extends StatelessWidget {
  const AppEmptyStateShowcase({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AppEmptyState Showcase'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // Example 1: Empty state with icon only
          AppSection(
            title: 'Icon Only',
            description: 'Basic empty state with just an icon and title',
            child: Container(
              height: 200,
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Theme.of(context).colorScheme.outline,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const AppEmptyState(
                title: 'No notifications',
                icon: Icons.notifications_off_outlined,
              ),
            ),
          ),

          const AppSpacer(size: AppSpacerSize.extraLarge),

          // Example 2: Empty state with icon + description
          AppSection(
            title: 'Icon with Description',
            description: 'Empty state with icon, title, and descriptive text',
            child: Container(
              height: 250,
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Theme.of(context).colorScheme.outline,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const AppEmptyState(
                title: 'No search results',
                description: 'We couldn\'t find any items matching your search criteria. Try adjusting your filters or search terms.',
                icon: Icons.search_off,
              ),
            ),
          ),

          const AppSpacer(size: AppSpacerSize.extraLarge),

          // Example 3: Empty state with image
          AppSection(
            title: 'With Image',
            description: 'Empty state using an image instead of icon for visual appeal',
            child: Container(
              height: 300,
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Theme.of(context).colorScheme.outline,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const AppEmptyState(
                title: 'Welcome to our app',
                description: 'Discover amazing features and get started with your journey.',
                imageUrl: 'https://via.placeholder.com/120x120/42A5F5/FFFFFF?text=Welcome',
              ),
            ),
          ),

          const AppSpacer(size: AppSpacerSize.extraLarge),

          // Example 4: Empty state with action button
          AppSection(
            title: 'With Action Button',
            description: 'Complete empty state with call-to-action button',
            child: Container(
              height: 300,
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Theme.of(context).colorScheme.outline,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: AppEmptyState(
                title: 'No items in cart',
                description: 'Your shopping cart is empty. Browse our products and add items you like.',
                icon: Icons.shopping_cart_outlined,
                actionLabel: 'Start Shopping',
                onAction: () => debugPrint('Start shopping button tapped'),
              ),
            ),
          ),

          const AppSpacer(size: AppSpacerSize.extraLarge),

          // Example 5: Bonus - Empty state with different text alignment
          AppSection(
            title: 'Left Aligned Text',
            description: 'Empty state with left-aligned text for specific layouts',
            child: Container(
              height: 250,
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Theme.of(context).colorScheme.outline,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const AppEmptyState(
                title: 'No messages',
                description: 'Start a conversation by sending your first message.',
                icon: Icons.chat_bubble_outline,
                alignment: TextAlign.left,
              ),
            ),
          ),

          const AppSpacer(size: AppSpacerSize.large),

          // Footer note
          AppText(
            'All examples demonstrate different configurations of AppEmptyState molecule',
            variant: AppTextVariant.bodySmall,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}