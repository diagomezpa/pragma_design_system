import 'package:flutter/material.dart';
import 'package:pragma_design_system/pragma_design_system.dart';

/// AppCardShowcase - Demonstrates various `AppCard` variants.
///
/// This page showcases different configurations and use cases of the AppCard molecule.
/// It demonstrates the flexibility and reusability of the component as a surface
/// container for grouping content, from simple text cards to complex interactive layouts.
class AppCardShowcase extends StatelessWidget {
  const AppCardShowcase({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AppCard Showcase'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // Section 1: Basic card with text only
          const AppText('Basic Card', variant: AppTextVariant.title),
          const SizedBox(height: 8),
          // Simple card with basic text content demonstrates minimal configuration
          const AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  'Welcome Message',
                  variant: AppTextVariant.subtitle,
                ),
                SizedBox(height: 8),
                AppText(
                  'This is a basic card containing simple text content. Perfect for notifications, announcements, or any grouped information.',
                  variant: AppTextVariant.body,
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Section 2: Card wrapping an AppSection
          const AppText('Card with AppSection', variant: AppTextVariant.title),
          const SizedBox(height: 8),
          // Card containing an AppSection demonstrates composition with other molecules
          const AppCard(
            padding: EdgeInsets.zero,
            child: AppSection(
              title: 'User Preferences',
              description: 'Manage your account settings and privacy options',
              child: Column(
                children: [
                  SizedBox(height: 8),
                  AppListItem(
                    leading: AppIcon(Icons.notifications),
                    title: 'Notifications',
                    trailing: AppIcon(Icons.chevron_right),
                  ),
                  AppListItem(
                    leading: AppIcon(Icons.security),
                    title: 'Privacy & Security',
                    trailing: AppIcon(Icons.chevron_right),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 24),

          // Section 3: Card containing multiple AppListItem
          const AppText('Card with Multiple List Items', variant: AppTextVariant.title),
          const SizedBox(height: 8),
          // Card as a container for list items demonstrates menu/navigation grouping
          AppCard(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const AppListItem(
                  leading: AppIcon(Icons.home),
                  title: 'Dashboard',
                  subtitle: 'Overview and statistics',
                ),
                const Divider(height: 1),
                const AppListItem(
                  leading: AppIcon(Icons.analytics),
                  title: 'Analytics',
                  subtitle: 'Performance metrics',
                ),
                const Divider(height: 1),
                AppListItem(
                  leading: const AppIcon(Icons.settings),
                  title: 'Settings',
                  subtitle: 'App configuration',
                  onTap: () => debugPrint('Settings tapped from card'),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Section 4: Tappable card (onTap → debugPrint)
          const AppText('Interactive Card', variant: AppTextVariant.title),
          const SizedBox(height: 8),
          // Tappable card demonstrates interactive behavior with ripple effect
          AppCard(
            onTap: () => debugPrint('Interactive card tapped - Add to favorites'),
            child: const Row(
              children: [
                AppIcon(
                  Icons.favorite_border,
                  size: AppIconSize.large,
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText(
                        'Add to Favorites',
                        variant: AppTextVariant.subtitle,
                      ),
                      SizedBox(height: 4),
                      AppText(
                        'Tap this card to add the item to your favorites list',
                        variant: AppTextVariant.body,
                      ),
                    ],
                  ),
                ),
                AppIcon(Icons.chevron_right),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Section 5: Card used as a profile/product summary
          const AppText('Product Summary Card', variant: AppTextVariant.title),
          const SizedBox(height: 8),
          // Product card demonstrates real-world usage for e-commerce or catalog display
          AppCard(
            onTap: () => debugPrint('Product card tapped - Wireless Headphones'),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Product image placeholder
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: Colors.blue.shade50,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.blue.shade200),
                      ),
                      child: const AppIcon(
                        Icons.headphones,
                        size: AppIconSize.large,
                      ),
                    ),
                    const SizedBox(width: 16),
                    // Product details
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const AppText(
                            'Premium Wireless Headphones',
                            variant: AppTextVariant.subtitle,
                          ),
                          const SizedBox(height: 4),
                          AppText(
                            'High-quality sound with noise cancellation',
                            variant: AppTextVariant.body,
                            color: Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              AppText(
                                '\$199.99',
                                variant: AppTextVariant.subtitle,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              const SizedBox(width: 8),
                              AppText(
                                '\$249.99',
                                variant: AppTextVariant.body,
                                decoration: TextDecoration.lineThrough,
                                color: Theme.of(context).colorScheme.onSurfaceVariant,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                // Rating and actions row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          size: 16,
                          color: Colors.amber.shade600,
                        ),
                        const SizedBox(width: 4),
                        AppText(
                          '4.8 (124 reviews)',
                          variant: AppTextVariant.caption,
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ],
                    ),
                    const AppIcon(
                      Icons.add_shopping_cart,
                      size: AppIconSize.medium,
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Section 6: Custom padding example
          const AppText('Custom Padding Card', variant: AppTextVariant.title),
          const SizedBox(height: 8),
          // Demonstrates custom padding configuration
          const AppCard(
            padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
            child: Column(
              children: [
                AppIcon(
                  Icons.info_outline,
                  size: AppIconSize.large,
                ),
                SizedBox(height: 12),
                AppText(
                  'Custom Spacing',
                  variant: AppTextVariant.subtitle,
                ),
                SizedBox(height: 8),
                AppText(
                  'This card uses custom padding (24x20) instead of the default 16px all around.',
                  variant: AppTextVariant.body,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),

          const SizedBox(height: 40),

          // Footer note
          const AppText(
            'All variants demonstrate the versatility of AppCard as a surface container',
            variant: AppTextVariant.caption,
          ),
        ],
      ),
    );
  }
}