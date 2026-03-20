import 'package:flutter/material.dart';
import 'package:pragma_design_system/pragma_design_system.dart';

/// AppTextShowcase - demonstrates AppText atom component
class AppTextShowcase extends StatelessWidget {
  const AppTextShowcase({super.key});

  @override
  Widget build(BuildContext context) {
    return AppPage(
      title: 'AppText',
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AppText(
            'Welcome to Our Store',
            variant: AppTextVariant.headlineLarge,
          ),
          
          AppSpacerFactory.mediumVertical(),
          
          const AppText(
            'Featured Products',
            variant: AppTextVariant.headlineMedium,
          ),
          
          AppSpacerFactory.mediumVertical(),
          
          const AppText(
            'New Arrivals',
            variant: AppTextVariant.headlineSmall,
          ),
          
          AppSpacerFactory.mediumVertical(),
          
          const AppText(
            'Product Details',
            variant: AppTextVariant.titleLarge,
          ),
          
          AppSpacerFactory.mediumVertical(),
          
          const AppText(
            'Customer Reviews',
            variant: AppTextVariant.titleMedium,
          ),
          
          AppSpacerFactory.mediumVertical(),
          
          const AppText(
            'Shipping Information',
            variant: AppTextVariant.titleSmall,
          ),
          
          AppSpacerFactory.mediumVertical(),
          
          const AppText(
            'This product offers exceptional quality and value for everyday use.',
            variant: AppTextVariant.bodyLarge,
          ),
          
          AppSpacerFactory.mediumVertical(),
          
          const AppText(
            'Available in multiple colors and sizes to suit your preferences.',
            variant: AppTextVariant.bodyMedium,
          ),
          
          AppSpacerFactory.mediumVertical(),
          
          const AppText(
            'Free shipping on orders over \$50.',
            variant: AppTextVariant.bodySmall,
          ),
          
          AppSpacerFactory.mediumVertical(),
          
          const AppText(
            'Add to Cart',
            variant: AppTextVariant.labelLarge,
          ),
        ],
      ),
    );
  }
}