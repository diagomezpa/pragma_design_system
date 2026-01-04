import 'package:flutter/material.dart';
import 'package:pragma_design_system/pragma_design_system.dart';

/// AppPriceShowcase - Demonstrates various `AppPrice` variants.
///
/// This page showcases different configurations and use cases of the AppPrice molecule.
/// It demonstrates pricing display for e-commerce applications including regular prices,
/// discounts, and highlighted pricing scenarios.
class AppPriceShowcase extends StatelessWidget {
  const AppPriceShowcase({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AppPrice Showcase'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // Example 1: Normal price
          AppSection(
            title: 'Normal Price',
            description: 'Standard price display for products',
            child: Container(
              padding: const EdgeInsets.all(24.0),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Theme.of(context).colorScheme.outline,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText('Product Name', variant: AppTextVariant.titleMedium),
                  SizedBox(height: 8),
                  AppPrice(value: 299000),
                ],
              ),
            ),
          ),

          const AppSpacer(size: AppSpacerSize.extraLarge),

          // Example 2: Highlighted price
          AppSection(
            title: 'Highlighted Price',
            description: 'Emphasized pricing for featured products or special offers',
            child: Container(
              padding: const EdgeInsets.all(24.0),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Theme.of(context).colorScheme.outline,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText('Featured Product', variant: AppTextVariant.titleMedium),
                  SizedBox(height: 8),
                  AppPrice(
                    value: 499000,
                    highlight: true,
                  ),
                ],
              ),
            ),
          ),

          const AppSpacer(size: AppSpacerSize.extraLarge),

          // Example 3: Discounted price
          AppSection(
            title: 'Discounted Price',
            description: 'Price with discount showing original and sale price',
            child: Container(
              padding: const EdgeInsets.all(24.0),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Theme.of(context).colorScheme.outline,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText('Sale Item', variant: AppTextVariant.titleMedium),
                  SizedBox(height: 8),
                  AppPrice(
                    value: 399000,
                    discountedValue: 299000,
                  ),
                ],
              ),
            ),
          ),

          const AppSpacer(size: AppSpacerSize.extraLarge),

          // Example 4: Highlighted discounted price
          AppSection(
            title: 'Highlighted Discounted Price',
            description: 'Featured sale item with emphasized discount pricing',
            child: Container(
              padding: const EdgeInsets.all(24.0),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Theme.of(context).colorScheme.outline,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText('Premium Sale', variant: AppTextVariant.titleMedium),
                  SizedBox(height: 8),
                  AppPrice(
                    value: 899000,
                    discountedValue: 599000,
                    highlight: true,
                  ),
                ],
              ),
            ),
          ),

          const AppSpacer(size: AppSpacerSize.extraLarge),

          // Example 5: Different alignments
          AppSection(
            title: 'Price Alignment',
            description: 'Different text alignments for various layout needs',
            child: Container(
              padding: const EdgeInsets.all(24.0),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Theme.of(context).colorScheme.outline,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            AppText('Left Aligned', variant: AppTextVariant.bodySmall),
                            SizedBox(height: 4),
                            AppPrice(
                              value: 150000,
                              alignment: TextAlign.left,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            AppText('Center Aligned', variant: AppTextVariant.bodySmall),
                            SizedBox(height: 4),
                            AppPrice(
                              value: 250000,
                              alignment: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            AppText('Right Aligned', variant: AppTextVariant.bodySmall),
                            SizedBox(height: 4),
                            AppPrice(
                              value: 350000,
                              alignment: TextAlign.right,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          const AppSpacer(size: AppSpacerSize.large),

          // Footer note
          AppText(
            'All examples demonstrate different AppPrice configurations for e-commerce use cases',
            variant: AppTextVariant.bodySmall,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}