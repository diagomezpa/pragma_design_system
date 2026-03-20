 import 'package:flutter/material.dart';
import 'package:pragma_design_system/pragma_design_system.dart';

/// AppDividerShowcase
///
/// Design System Documentation for the AppDivider atom component.
/// This showcase demonstrates all available orientations, thickness variations,
/// factory methods, and customization options of the AppDivider in a clean,
/// minimal format suitable for design system documentation.
/// 
/// This showcase is built entirely using design system components,
/// serving as an example of how to create pages using the design system.
class AppDividerShowcase extends StatelessWidget {
  const AppDividerShowcase({super.key});

  @override
  Widget build(BuildContext context) {
    return AppPage(
      title: 'AppDivider',
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          // Header Section
          AppSection(
            title: 'AppDivider',
            description: 'Visual separation component for content organization',
            child: AppSpacerFactory.extraSmallVertical(),
          ),
          
          AppSpacerFactory.largeVertical(),

          // Orientations Section
          AppSection(
            title: 'Orientations',
            child: Column(
              children: [
                _buildShowcaseItem(
                  'Horizontal',
                  AppCard(
                    child: Column(
                      children: [
                        const AppText(
                          'Content above',
                          variant: AppTextVariant.bodyMedium,
                        ),
                        AppSpacerFactory.smallVertical(),
                        AppDivider(
                          orientation: AppDividerOrientation.horizontal,
                          thickness: 2.0,
                          color: Theme.of(context).colorScheme.outline,
                        ),
                        AppSpacerFactory.smallVertical(),
                        const AppText(
                          'Content below',
                          variant: AppTextVariant.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                ),
                AppSpacerFactory.mediumVertical(),
                _buildShowcaseItem(
                  'Vertical',
                  AppCard(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const AppText(
                          'Left',
                          variant: AppTextVariant.bodyMedium,
                        ),
                        AppSpacerFactory.smallHorizontal(),
                        AppDivider(
                          orientation: AppDividerOrientation.vertical,
                          thickness: 2.0,
                          color: Theme.of(context).colorScheme.outline,
                        ),
                        AppSpacerFactory.smallHorizontal(),
                        const AppText(
                          'Right',
                          variant: AppTextVariant.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          AppSpacerFactory.largeVertical(),

          // Thickness Variations Section
          AppSection(
            title: 'Thickness Variations',
            child: Column(
              children: [
                _buildShowcaseItem(
                  'Thin (0.5px)',
                  AppCard(
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          const AppText('Above', variant: AppTextVariant.bodySmall),
                          const SizedBox(height: 8),
                          Container(
                            width: double.infinity,
                            height: 2,
                            color: Colors.red,
                          ),
                          const SizedBox(height: 8),
                          const AppText('Below', variant: AppTextVariant.bodySmall),
                        ],
                      ),
                    ),
                  ),
                ),
                AppSpacerFactory.mediumVertical(),
                _buildShowcaseItem(
                  'Normal (1px)',
                  AppCard(
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          const AppText('Above', variant: AppTextVariant.bodySmall),
                          const SizedBox(height: 8),
                          Container(
                            width: double.infinity,
                            height: 3,
                            color: Colors.blue,
                          ),
                          const SizedBox(height: 8),
                          const AppText('Below', variant: AppTextVariant.bodySmall),
                        ],
                      ),
                    ),
                  ),
                ),
                AppSpacerFactory.mediumVertical(),
                _buildShowcaseItem(
                  'Thick (2px)',
                  AppCard(
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          const AppText('Above', variant: AppTextVariant.bodySmall),
                          const SizedBox(height: 8),
                          Container(
                            width: double.infinity,
                            height: 4,
                            color: Colors.green,
                          ),
                          const SizedBox(height: 8),
                          const AppText('Below', variant: AppTextVariant.bodySmall),
                        ],
                      ),
                    ),
                  ),
                ),
                AppSpacerFactory.mediumVertical(),
                _buildShowcaseItem(
                  'Extra Thick (4px)',
                  AppCard(
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          const AppText('Above', variant: AppTextVariant.bodySmall),
                          const SizedBox(height: 8),
                          Container(
                            width: double.infinity,
                            height: 6,
                            color: Colors.orange,
                          ),
                          const SizedBox(height: 8),
                          const AppText('Below', variant: AppTextVariant.bodySmall),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          AppSpacerFactory.largeVertical(),

          // Factory Methods Section
          AppSection(
            title: 'Factory Methods',
            child: Column(
              children: [
                _buildShowcaseItem(
                  'Thin',
                  AppCard(
                    child: Column(
                      children: [
                        const AppText('Above', variant: AppTextVariant.bodySmall),
                        AppSpacerFactory.smallVertical(),
                        AppDividerFactory.thin(
                          color: Theme.of(context).colorScheme.outline,
                        ),
                        AppSpacerFactory.smallVertical(),
                        const AppText('Below', variant: AppTextVariant.bodySmall),
                      ],
                    ),
                  ),
                ),
                AppSpacerFactory.mediumVertical(),
                _buildShowcaseItem(
                  'Thick',
                  AppCard(
                    child: Column(
                      children: [
                        const AppText('Above', variant: AppTextVariant.bodySmall),
                        AppSpacerFactory.smallVertical(),
                        AppDividerFactory.thick(
                          color: Theme.of(context).colorScheme.outline,
                        ),
                        AppSpacerFactory.smallVertical(),
                        const AppText('Below', variant: AppTextVariant.bodySmall),
                      ],
                    ),
                  ),
                ),
                AppSpacerFactory.mediumVertical(),
                _buildShowcaseItem(
                  'Vertical',
                  AppCard(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const AppText(
                          'Left',
                          variant: AppTextVariant.bodyMedium,
                        ),
                        AppDividerFactory.vertical(
                          color: Theme.of(context).colorScheme.outline,
                        ),
                        const AppText(
                          'Right',
                          variant: AppTextVariant.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                ),
                AppSpacerFactory.mediumVertical(),
                _buildShowcaseItem(
                  'Section',
                  AppCard(
                    child: Column(
                      children: [
                        const AppText(
                          'Section 1',
                          variant: AppTextVariant.bodyMedium,
                        ),
                        AppDividerFactory.section(
                          color: Theme.of(context).colorScheme.outline,
                        ),
                        const AppText(
                          'Section 2',
                          variant: AppTextVariant.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                ),
                AppSpacerFactory.mediumVertical(),
                _buildShowcaseItem(
                  'List Item',
                  AppCard(
                    child: Column(
                      children: [
                        AppSpacerFactory.mediumVertical(),
                        const AppText(
                          'List Item 1',
                          variant: AppTextVariant.bodyMedium,
                        ),
                        AppSpacerFactory.mediumVertical(),
                        AppDividerFactory.listItem(
                          color: Theme.of(context).colorScheme.outline,
                        ),
                        AppSpacerFactory.mediumVertical(),
                        const AppText(
                          'List Item 2',
                          variant: AppTextVariant.bodyMedium,
                        ),
                        AppSpacerFactory.mediumVertical(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          AppSpacerFactory.largeVertical(),

          // Colors Section
          AppSection(
            title: 'Colors',
            child: Column(
              children: [
                _buildShowcaseItem(
                  'Default',
                  AppCard(
                    child: Column(
                      children: [
                        const AppText('Above', variant: AppTextVariant.bodySmall),
                        AppSpacerFactory.smallVertical(),
                        AppDivider(
                          color: Theme.of(context).colorScheme.outline,
                        ),
                        AppSpacerFactory.smallVertical(),
                        const AppText('Below', variant: AppTextVariant.bodySmall),
                      ],
                    ),
                  ),
                ),
                AppSpacerFactory.mediumVertical(),
                _buildShowcaseItem(
                  'Custom Color',
                  AppCard(
                    child: Builder(
                      builder: (context) => AppDivider(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          AppSpacerFactory.largeVertical(),

          // Indentation Section
          AppSection(
            title: 'Indentation',
            child: Column(
              children: [
                _buildShowcaseItem(
                  'No Indent',
                  AppCard(
                    child: Column(
                      children: [
                        const AppText('Full width divider', variant: AppTextVariant.bodySmall),
                        AppSpacerFactory.smallVertical(),
                        AppDivider(
                          indent: 0,
                          endIndent: 0,
                          thickness: 2.0,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        AppSpacerFactory.smallVertical(),
                        const AppText('Goes edge to edge', variant: AppTextVariant.bodySmall),
                      ],
                    ),
                  ),
                ),
                AppSpacerFactory.mediumVertical(),
                _buildShowcaseItem(
                  'Start Indent',
                  AppCard(
                    child: Column(
                      children: [
                        const AppText('Indented from left', variant: AppTextVariant.bodySmall),
                        AppSpacerFactory.smallVertical(),
                        AppDivider(
                          indent: 16,
                          endIndent: 0,
                          thickness: 2.0,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        AppSpacerFactory.smallVertical(),
                        const AppText('16px from start', variant: AppTextVariant.bodySmall),
                      ],
                    ),
                  ),
                ),
                AppSpacerFactory.mediumVertical(),
                _buildShowcaseItem(
                  'End Indent',
                  AppCard(
                    child: Column(
                      children: [
                        const AppText('Indented from right', variant: AppTextVariant.bodySmall),
                        AppSpacerFactory.smallVertical(),
                        AppDivider(
                          indent: 0,
                          endIndent: 16,
                          thickness: 2.0,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        AppSpacerFactory.smallVertical(),
                        const AppText('16px from end', variant: AppTextVariant.bodySmall),
                      ],
                    ),
                  ),
                ),
                AppSpacerFactory.mediumVertical(),
                _buildShowcaseItem(
                  'Both Indent',
                  AppCard(
                    child: Column(
                      children: [
                        const AppText('Indented both sides', variant: AppTextVariant.bodySmall),
                        AppSpacerFactory.smallVertical(),
                        AppDivider(
                          indent: 16,
                          endIndent: 16,
                          thickness: 2.0,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        AppSpacerFactory.smallVertical(),
                        const AppText('16px from both sides', variant: AppTextVariant.bodySmall),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          AppSpacerFactory.largeVertical(),

          // Margin Section
          AppSection(
            title: 'Margin',
            child: Column(
              children: [
                _buildShowcaseItem(
                  'No Margin',
                  AppCard(
                    child: Column(
                      children: [
                        const AppText(
                          'Content above',
                          variant: AppTextVariant.bodyMedium,
                        ),
                        AppDivider(
                          color: Theme.of(context).colorScheme.outline,
                        ),
                        const AppText(
                          'Content below',
                          variant: AppTextVariant.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                ),
                AppSpacerFactory.mediumVertical(),
                _buildShowcaseItem(
                  'Vertical Margin',
                  AppCard(
                    child: Column(
                      children: [
                        const AppText(
                          'Content above',
                          variant: AppTextVariant.bodyMedium,
                        ),
                        AppSpacerFactory.mediumVertical(),
                        const AppDivider(),
                        AppSpacerFactory.mediumVertical(),
                        const AppText(
                          'Content below',
                          variant: AppTextVariant.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                ),
                AppSpacerFactory.mediumVertical(),
                _buildShowcaseItem(
                  'All Margin',
                  AppCard(
                    child: Column(
                      children: [
                        AppSpacerFactory.mediumVertical(),
                        const AppText(
                          'Content above',
                          variant: AppTextVariant.bodyMedium,
                        ),
                        AppSpacerFactory.mediumVertical(),
                        AppDivider(
                          color: Theme.of(context).colorScheme.outline,
                        ),
                        AppSpacerFactory.mediumVertical(),
                        const AppText(
                          'Content below',
                          variant: AppTextVariant.bodyMedium,
                        ),
                        AppSpacerFactory.mediumVertical(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          AppSpacerFactory.hugeVertical(),
        ],
      ),
    ),
    );
  }

  /// Builds a showcase item with label and content using design system components
  Widget _buildShowcaseItem(String label, Widget content) {
    return AppListItem(
      title: label,
      trailing: SizedBox(
        width: 200,
        child: content,
      ),
    );
  }
}