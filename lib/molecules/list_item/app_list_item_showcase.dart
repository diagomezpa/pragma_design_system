import 'package:flutter/material.dart';
import 'package:pragma_design_system/pragma_design_system.dart';

/// AppListItemShowcase - Demonstrates various `AppListItem` variants.
///
/// This page showcases different configurations and states of the AppListItem molecule.
/// It demonstrates the flexibility and reusability of the component across
/// different use cases like menus, product lists, and settings screens.
class AppListItemShowcase extends StatefulWidget {
  const AppListItemShowcase({super.key});

  @override
  State<AppListItemShowcase> createState() => _AppListItemShowcaseState();
}

class _AppListItemShowcaseState extends State<AppListItemShowcase> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AppListItem Showcase'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // Section 1: Basic list item (title only)
          const AppText('Basic List Item', variant: AppTextVariant.titleLarge),
          const SizedBox(height: 8),
          // Simple list item with just a title demonstrates the minimal configuration
          const AppListItem(
            title: 'Basic Item',
          ),

          const SizedBox(height: 24),

          // Section 2: List item with subtitle
          const AppText('With Subtitle', variant: AppTextVariant.titleLarge),
          const SizedBox(height: 8),
          // List item with subtitle shows additional information below the title
          const AppListItem(
            title: 'Settings',
            subtitle: 'Configure your app preferences and privacy settings',
          ),

          const SizedBox(height: 24),

          // Section 3: List item with leading icon
          const AppText('With Leading Icon', variant: AppTextVariant.titleLarge),
          const SizedBox(height: 8),
          // Leading icon provides visual context for the list item
          const AppListItem(
            leading: AppIcon(Icons.notifications),
            title: 'Notifications',
            subtitle: 'Manage your notification preferences',
          ),

          const SizedBox(height: 24),

          // Section 4: List item with trailing icon
          const AppText('With Trailing Icon', variant: AppTextVariant.titleLarge),
          const SizedBox(height: 8),
          // Trailing icon typically indicates navigation or action
          const AppListItem(
            title: 'Account Settings',
            subtitle: 'Update your profile and preferences',
            trailing: AppIcon(Icons.arrow_forward_ios),
          ),

          const SizedBox(height: 24),

          // Section 5: List item with leading image (thumbnail)
          const AppText('With Leading Image', variant: AppTextVariant.titleLarge),
          const SizedBox(height: 8),
          // Leading image provides visual representation (product, avatar, etc.)
          AppListItem(
            leading: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.blue.shade100,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const AppIcon(
                Icons.image,
                size: AppIconSize.medium,
              ),
            ),
            title: 'Product Image',
            subtitle: 'Wireless Bluetooth Headphones',
          ),

          const SizedBox(height: 24),

          // Section 6: Disabled list item
          const AppText('Disabled State', variant: AppTextVariant.titleLarge),
          const SizedBox(height: 8),
          // Disabled list item shows reduced opacity and no interaction
          const AppListItem(
            leading: AppIcon(Icons.lock),
            title: 'Premium Feature',
            subtitle: 'Upgrade to unlock this feature',
            trailing: AppIcon(Icons.star),
            isEnabled: false,
          ),

          const SizedBox(height: 24),

          // Section 7: Tappable list item with tap simulation
          const AppText('Interactive List Item', variant: AppTextVariant.titleLarge),
          const SizedBox(height: 8),
          // Interactive list item demonstrates tap behavior
          AppListItem(
            leading: const AppIcon(Icons.touch_app),
            title: 'Tap Me!',
            subtitle: 'This item responds to taps - check the debug console',
            trailing: const AppIcon(Icons.chevron_right),
            onTap: () => debugPrint('List item tapped: Interactive demo'),
          ),

          const SizedBox(height: 24),

          // Section 8: Complete example (all features)
          const AppText('Complete Example', variant: AppTextVariant.titleLarge),
          const SizedBox(height: 8),
          // Complete example showing all features together
          AppListItem(
            leading: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.green.shade100,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const AppIcon(
                Icons.person,
                size: AppIconSize.medium,
              ),
            ),
            title: 'John Doe',
            subtitle: 'Software Engineer • Online now',
            trailing: const AppIcon(Icons.more_vert),
            onTap: () => debugPrint('User profile tapped: John Doe'),
          ),

          const SizedBox(height: 40),

          // Footer note
          const AppText(
            'All variants demonstrate the flexibility of AppListItem molecule',
            variant: AppTextVariant.bodySmall,
          ),
        ],
      ),
    );
  }
}