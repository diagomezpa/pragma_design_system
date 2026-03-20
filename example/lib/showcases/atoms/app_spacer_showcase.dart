import 'package:flutter/material.dart';
import 'package:pragma_design_system/pragma_design_system.dart';

/// AppSpacerShowcase - demonstrates AppSpacer atom component
class AppSpacerShowcase extends StatelessWidget {
  const AppSpacerShowcase({super.key});

  @override
  Widget build(BuildContext context) {
    return AppPage(
      title: 'AppSpacer',
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          const AppText(
            'Vertical Spacing',
            variant: AppTextVariant.titleMedium,
          ),
          
          const AppText('Item 1'),
          AppSpacerFactory.extraSmallVertical(),
          const AppText('Item 2 (extraSmall)'),
          AppSpacerFactory.smallVertical(),
          const AppText('Item 3 (small)'),
          AppSpacerFactory.mediumVertical(),
          const AppText('Item 4 (medium)'),
          AppSpacerFactory.largeVertical(),
          const AppText('Item 5 (large)'),
          AppSpacerFactory.extraLargeVertical(),
          const AppText('Item 6 (extraLarge)'),
          
          AppSpacerFactory.largeVertical(),
          
          const AppText(
            'Horizontal Spacing',
            variant: AppTextVariant.titleMedium,
          ),
          
          AppSpacerFactory.mediumVertical(),
          
          Row(
            children: [
              const AppText('A'),
              AppSpacerFactory.extraSmallHorizontal(),
              const AppText('B'),
              AppSpacerFactory.smallHorizontal(),
              const AppText('C'),
              AppSpacerFactory.mediumHorizontal(),
              const AppText('D'),
              AppSpacerFactory.largeHorizontal(),
              const AppText('E'),
            ],
          ),
          
          AppSpacerFactory.largeVertical(),
          
          const AppText(
            'Custom Spacing',
            variant: AppTextVariant.titleMedium,
          ),
          
          AppSpacerFactory.mediumVertical(),
          
          const AppText('Before custom space'),
          const AppSpacer.custom(height: 40),
          const AppText('After 40px custom space'),
          
          AppSpacerFactory.largeVertical(),
          
          const AppText(
            'Flexible Space',
            variant: AppTextVariant.titleMedium,
          ),
          
          AppSpacerFactory.mediumVertical(),
          
          Row(
            children: [
              const AppText('Start'),
              AppSpacerFactory.flexible(),
              const AppText('End'),
            ],
          ),
        ],
      ),
    ),
  );
}}