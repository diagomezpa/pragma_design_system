import 'package:flutter/material.dart';
import 'package:pragma_design_system/pragma_design_system.dart';

/// AppCardListShowcase - Demuestra varias variantes de `AppCardList`.
///
/// Esta página muestra diferentes configuraciones y casos de uso del organismo AppCardList.
/// Demuestra cómo puede usarse para mostrar colecciones de tarjetas con distintos
/// diseños, separadores y comportamientos de desplazamiento.
class AppCardListShowcase extends StatelessWidget {
  const AppCardListShowcase({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AppCardList Showcase'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // Section 1: Basic card list
          const AppText(
            'Basic Card List',
            variant: AppTextVariant.titleLarge,
          ),
          const SizedBox(height: 8),
          // Simple card list without title, using default separator
          AppCardList(
            children: [
              AppCard(
                child: ListTile(
                  title: const Text('First Card'),
                  subtitle: const Text('This is the first card in the list'),
                  trailing: const Icon(Icons.arrow_forward_ios),
                ),
              ),
              AppCard(
                child: ListTile(
                  title: const Text('Second Card'),
                  subtitle: const Text('This is the second card in the list'),
                  trailing: const Icon(Icons.arrow_forward_ios),
                ),
              ),
            ],
          ),

          const SizedBox(height: 32),

          // Section 2: Card list with title
          const AppText(
            'Card List with Title',
            variant: AppTextVariant.titleLarge,
          ),
          const SizedBox(height: 8),
          // Card list with a title header for better organization
          AppCardList(
            title: 'Recent Activities',
            children: [
              AppCard(
                child: ListTile(
                  leading: const Icon(Icons.shopping_cart, color: Colors.blue),
                  title: const Text('Order Placed'),
                  subtitle: const Text('Your order #12345 has been confirmed'),
                  trailing: const Text('2 min ago'),
                ),
              ),
              AppCard(
                child: ListTile(
                  leading: const Icon(Icons.payment, color: Colors.green),
                  title: const Text('Payment Received'),
                  subtitle: const Text('Payment of \$299.99 processed successfully'),
                  trailing: const Text('1 hour ago'),
                ),
              ),
              AppCard(
                child: ListTile(
                  leading: const Icon(Icons.local_shipping, color: Colors.orange),
                  title: const Text('Order Shipped'),
                  subtitle: const Text('Your order is on the way'),
                  trailing: const Text('1 day ago'),
                ),
              ),
            ],
          ),

          const SizedBox(height: 32),

          // Section 3: Card list with custom separator
          const AppText(
            'Card List with Custom Separator',
            variant: AppTextVariant.titleLarge,
          ),
          const SizedBox(height: 8),
          // Card list using a custom separator (divider) instead of spacing
          AppCardList(
            title: 'Settings',
            separator: const AppDivider(),
            children: [
              AppCard(
                child: ListTile(
                  leading: const Icon(Icons.account_circle),
                  title: const Text('Account'),
                  subtitle: const Text('Manage your account settings'),
                  trailing: const Icon(Icons.chevron_right),
                ),
              ),
              AppCard(
                child: ListTile(
                  leading: const Icon(Icons.notifications),
                  title: const Text('Notifications'),
                  subtitle: const Text('Configure notification preferences'),
                  trailing: const Icon(Icons.chevron_right),
                ),
              ),
              AppCard(
                child: ListTile(
                  leading: const Icon(Icons.security),
                  title: const Text('Privacy & Security'),
                  subtitle: const Text('Update privacy and security settings'),
                  trailing: const Icon(Icons.chevron_right),
                ),
              ),
            ],
          ),

          const SizedBox(height: 32),

          // Section 4: Non-scrollable card list
          const AppText(
            'Non-Scrollable Card List',
            variant: AppTextVariant.titleLarge,
          ),
          const SizedBox(height: 8),
          // Static card list that doesn't scroll (uses Column internally)
          AppCardList(
            title: 'Quick Actions',
            isScrollable: false,
            children: [
              AppCard(
                onTap: () => debugPrint('Create new item tapped'),
                child: const ListTile(
                  leading: Icon(Icons.add_circle, color: Colors.blue),
                  title: Text('Create New'),
                  subtitle: Text('Start a new project or document'),
                ),
              ),
              AppCard(
                onTap: () => debugPrint('Import data tapped'),
                child: const ListTile(
                  leading: Icon(Icons.upload_file, color: Colors.green),
                  title: Text('Import Data'),
                  subtitle: Text('Upload and import existing data'),
                ),
              ),
            ],
          ),

          const SizedBox(height: 32),

          // Section 5: Scrollable card list demonstration
          const AppText(
            'Scrollable Card List',
            variant: AppTextVariant.titleLarge,
          ),
          const SizedBox(height: 8),
          // Container to limit height and demonstrate scrolling behavior
          Container(
            height: 250,
            decoration: BoxDecoration(
              border: Border.all(color: Theme.of(context).colorScheme.outline),
              borderRadius: BorderRadius.circular(8),
            ),
            child: AppCardList(
              title: 'Product Catalog',
              isScrollable: true,
              shrinkWrap: false,
              padding: const EdgeInsets.all(12),
              children: [
                AppCard(
                  child: ListTile(
                    leading: const Icon(Icons.laptop, color: Colors.blue),
                    title: const Text('MacBook Pro'),
                    subtitle: const Text('13-inch, M2 chip, 8GB RAM'),
                    trailing: const Text('\$1,299'),
                  ),
                ),
                AppCard(
                  child: ListTile(
                    leading: const Icon(Icons.phone_iphone, color: Colors.black),
                    title: const Text('iPhone 15'),
                    subtitle: const Text('128GB, Midnight color'),
                    trailing: const Text('\$799'),
                  ),
                ),
                AppCard(
                  child: ListTile(
                    leading: const Icon(Icons.tablet_mac, color: Colors.grey),
                    title: const Text('iPad Air'),
                    subtitle: const Text('10.9-inch, Wi-Fi, 64GB'),
                    trailing: const Text('\$599'),
                  ),
                ),
                AppCard(
                  child: ListTile(
                    leading: const Icon(Icons.watch, color: Colors.red),
                    title: const Text('Apple Watch'),
                    subtitle: const Text('Series 9, 45mm, GPS'),
                    trailing: const Text('\$429'),
                  ),
                ),
                AppCard(
                  child: ListTile(
                    leading: const Icon(Icons.headphones, color: Colors.purple),
                    title: const Text('AirPods Pro'),
                    subtitle: const Text('2nd generation, USB-C'),
                    trailing: const Text('\$249'),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 32),

          // Section 6: Card list with custom padding
          const AppText(
            'Card List with Custom Padding',
            variant: AppTextVariant.titleLarge,
          ),
          const SizedBox(height: 8),
          // Card list with custom padding around the entire list
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Theme.of(context).colorScheme.outline),
            ),
            child: AppCardList(
              title: 'Featured Items',
              padding: const EdgeInsets.all(20),
              separator: const AppSpacer(size: AppSpacerSize.large),
              children: [
                AppCard(
                  child: ListTile(
                    leading: const Icon(Icons.star, color: Colors.amber),
                    title: const Text('Premium Feature'),
                    subtitle: const Text('Unlock advanced capabilities'),
                    trailing: const Icon(Icons.lock_open),
                  ),
                ),
                AppCard(
                  child: ListTile(
                    leading: const Icon(Icons.trending_up, color: Colors.green),
                    title: const Text('Popular Choice'),
                    subtitle: const Text('Most selected by users'),
                    trailing: const Icon(Icons.thumb_up),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 40),

          // Footer note
          AppText(
            'All examples demonstrate different AppCardList configurations for various layout needs',
            variant: AppTextVariant.bodySmall,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}