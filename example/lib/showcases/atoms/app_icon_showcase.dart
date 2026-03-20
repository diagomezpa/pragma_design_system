import 'package:flutter/material.dart';
import 'package:pragma_design_system/pragma_design_system.dart';

/// AppIconShowcase
///
/// Design System Documentation for the AppIcon atom component.
/// This showcase demonstrates all available sizes, color options, interactive states,
/// named constructors, and semantic usage of the AppIcon in a clean,
/// minimal format suitable for design system documentation.
/// 
/// This showcase is built entirely using design system components,
/// serving as an example of how to create pages using the design system.
class AppIconShowcase extends StatelessWidget {
  const AppIconShowcase({super.key});

  @override
  Widget build(BuildContext context) {
    return AppPage(
      title: 'AppIcon',
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section
            AppSection(
              title: 'AppIcon',
              description: 'Icon components for visual communication and navigation',
              child: AppSpacerFactory.extraSmallVertical(),
            ),
            
            AppSpacerFactory.largeVertical(),

            // Sizes Section
            AppSection(
              title: 'Sizes',
              child: Column(
                children: [
                  _buildShowcaseItem(
                    'Extra Small (12px)',
                    AppCard(
                      child: AppIconGroup(
                        icons: const [
                          AppIcon(
                            Icons.star,
                            size: AppIconSize.extraSmall,
                          ),
                          AppIcon(
                            Icons.favorite,
                            size: AppIconSize.extraSmall,
                          ),
                          AppIcon(
                            Icons.home,
                            size: AppIconSize.extraSmall,
                          ),
                        ],
                      ),
                    ),
                  ),
                  AppSpacerFactory.mediumVertical(),
                  _buildShowcaseItem(
                    'Small (16px)',
                    AppCard(
                      child: AppIconGroup(
                        icons: const [
                          AppIcon(
                            Icons.star,
                            size: AppIconSize.small,
                          ),
                          AppIcon(
                            Icons.favorite,
                            size: AppIconSize.small,
                          ),
                          AppIcon(
                            Icons.home,
                            size: AppIconSize.small,
                          ),
                        ],
                      ),
                    ),
                  ),
                  AppSpacerFactory.mediumVertical(),
                  _buildShowcaseItem(
                    'Medium (24px)',
                    AppCard(
                      child: AppIconGroup(
                        icons: const [
                          AppIcon(
                            Icons.star,
                            size: AppIconSize.medium,
                          ),
                          AppIcon(
                            Icons.favorite,
                            size: AppIconSize.medium,
                          ),
                          AppIcon(
                            Icons.home,
                            size: AppIconSize.medium,
                          ),
                        ],
                      ),
                    ),
                  ),
                  AppSpacerFactory.mediumVertical(),
                  _buildShowcaseItem(
                    'Large (32px)',
                    AppCard(
                      child: AppIconGroup(
                        icons: const [
                          AppIcon(
                            Icons.star,
                            size: AppIconSize.large,
                          ),
                          AppIcon(
                            Icons.favorite,
                            size: AppIconSize.large,
                          ),
                          AppIcon(
                            Icons.home,
                            size: AppIconSize.large,
                          ),
                        ],
                      ),
                    ),
                  ),
                  AppSpacerFactory.mediumVertical(),
                  _buildShowcaseItem(
                    'Extra Large (48px)',
                    AppCard(
                      child: AppIconGroup(
                        icons: const [
                          AppIcon(
                            Icons.star,
                            size: AppIconSize.extraLarge,
                          ),
                          AppIcon(
                            Icons.favorite,
                            size: AppIconSize.extraLarge,
                          ),
                          AppIcon(
                            Icons.home,
                            size: AppIconSize.extraLarge,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            AppSpacerFactory.largeVertical(),

            // Default vs Custom Color Section
            AppSection(
              title: 'Default vs Custom Color',
              child: Column(
                children: [
                  _buildShowcaseItem(
                    'Default Color',
                    AppCard(
                      child: AppIconGroup(
                        icons: const [
                          AppIcon(
                            Icons.notifications,
                            size: AppIconSize.large,
                          ),
                          AppIcon(
                            Icons.settings,
                            size: AppIconSize.large,
                          ),
                          AppIcon(
                            Icons.account_circle,
                            size: AppIconSize.large,
                          ),
                        ],
                      ),
                    ),
                  ),
                  AppSpacerFactory.mediumVertical(),
                  _buildShowcaseItem(
                    'Custom Colors',
                    AppCard(
                      child: Builder(
                        builder: (context) => AppIconGroup(
                          icons: [
                            AppIcon(
                              Icons.notifications,
                              size: AppIconSize.large,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            AppIcon(
                              Icons.settings,
                              size: AppIconSize.large,
                              color: Theme.of(context).colorScheme.error,
                            ),
                            AppIcon(
                              Icons.account_circle,
                              size: AppIconSize.large,
                              color: Theme.of(context).colorScheme.tertiary,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            AppSpacerFactory.largeVertical(),

            // Interactive vs Non-interactive Section
            AppSection(
              title: 'Interactive vs Non-interactive',
              child: Column(
                children: [
                  _buildShowcaseItem(
                    'Non-interactive',
                    AppLabeledCard(
                      label: 'Static display icons',
                      child: AppIconGroup(
                        includeVerticalPadding: false,
                        icons: const [
                          AppIcon(Icons.info, size: AppIconSize.large),
                          AppIcon(Icons.warning, size: AppIconSize.large),
                          AppIcon(Icons.check_circle, size: AppIconSize.large),
                        ],
                      ),
                    ),
                  ),
                  AppSpacerFactory.mediumVertical(),
                  _buildShowcaseItem(
                    'Interactive (Tap to test)',
                    AppLabeledCard(
                      label: 'Tappable icons with ripple effect',
                      child: AppIconGroup(
                        includeVerticalPadding: false,
                        icons: [
                          AppIcon(
                            Icons.thumb_up,
                            size: AppIconSize.large,
                            onTap: () {}
                          ),
                          AppIcon(
                            Icons.share,
                            size: AppIconSize.large,
                            onTap: () {}
                          ),
                          AppIcon(
                            Icons.bookmark,
                            size: AppIconSize.large,
                            onTap: () {}
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            AppSpacerFactory.largeVertical(),

            // Named Constructors Section
            AppSection(
              title: 'Named Constructors',
              child: Column(
                children: [
                  _buildShowcaseItem(
                    'Close Icon',
                    AppLabeledCard(
                      label: 'AppIcon.close() with semantic label',
                      child: AppIconGroup(
                        includeVerticalPadding: false,
                        icons: const [
                          AppIcon.close(size: AppIconSize.small),
                          AppIcon.close(size: AppIconSize.medium),
                          AppIcon.close(size: AppIconSize.large),
                        ],
                      ),
                    ),
                  ),
                  AppSpacerFactory.mediumVertical(),
                  _buildShowcaseItem(
                    'Back Icon',
                    AppLabeledCard(
                      label: 'AppIcon.back() with semantic label',
                      child: AppIconGroup(
                        includeVerticalPadding: false,
                        icons: const [
                          AppIcon.back(size: AppIconSize.small),
                          AppIcon.back(size: AppIconSize.medium),
                          AppIcon.back(size: AppIconSize.large),
                        ],
                      ),
                    ),
                  ),
                  AppSpacerFactory.mediumVertical(),
                  _buildShowcaseItem(
                    'Menu Icon',
                    AppLabeledCard(
                      label: 'AppIcon.menu() with semantic label',
                      child: AppIconGroup(
                        includeVerticalPadding: false,
                        icons: const [
                          AppIcon.menu(size: AppIconSize.small),
                          AppIcon.menu(size: AppIconSize.medium),
                          AppIcon.menu(size: AppIconSize.large),
                        ],
                      ),
                    ),
                  ),
                  AppSpacerFactory.mediumVertical(),
                  _buildShowcaseItem(
                    'Search Icon',
                    AppLabeledCard(
                      label: 'AppIcon.search() with semantic label',
                      child: AppIconGroup(
                        includeVerticalPadding: false,
                        icons: const [
                          AppIcon.search(size: AppIconSize.small),
                          AppIcon.search(size: AppIconSize.medium),
                          AppIcon.search(size: AppIconSize.large),
                        ],
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
                    'AppIconFactory.close()',
                    AppLabeledCard(
                      label: 'Static factory method for close icon',
                      child: AppIconGroup(
                        includeVerticalPadding: false,
                        icons: [
                          AppIconFactory.close(size: AppIconSize.small),
                          AppIconFactory.close(size: AppIconSize.medium),
                          AppIconFactory.close(size: AppIconSize.large),
                        ],
                      ),
                    ),
                  ),
                  AppSpacerFactory.mediumVertical(),
                  _buildShowcaseItem(
                    'AppIconFactory.search()',
                    AppLabeledCard(
                      label: 'Static factory method for search icon',
                      child: AppIconGroup(
                        includeVerticalPadding: false,
                        icons: [
                          AppIconFactory.search(size: AppIconSize.small),
                          AppIconFactory.search(size: AppIconSize.medium),
                          AppIconFactory.search(size: AppIconSize.large),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            AppSpacerFactory.largeVertical(),

            // Accessibility / Semantics Section
            AppSection(
              title: 'Accessibility & Semantics',
              child: Column(
                children: [
                  _buildShowcaseItem(
                    'Semantic Labels',
                    AppLabeledCard(
                      label: 'Icons with proper semantic labels for screen readers',
                      child: AppIconGroup(
                        includeVerticalPadding: false,
                        icons: const [
                          AppIcon(
                            Icons.delete,
                            size: AppIconSize.large,
                            semanticLabel: 'Delete item',
                          ),
                          AppIcon(
                            Icons.edit,
                            size: AppIconSize.large,
                            semanticLabel: 'Edit item',
                          ),
                          AppIcon(
                            Icons.visibility,
                            size: AppIconSize.large,
                            semanticLabel: 'View item',
                          ),
                        ],
                      ),
                    ),
                  ),
                  AppSpacerFactory.mediumVertical(),
                  _buildShowcaseItem(
                    'Interactive with Semantics',
                    AppLabeledCard(
                      label: 'Tappable icons with semantic descriptions',
                      child: AppIconGroup(
                        includeVerticalPadding: false,
                        icons: [
                          AppIcon(
                            Icons.add,
                            size: AppIconSize.large,
                            semanticLabel: 'Add new item',
                            onTap: () {},
                          ),
                          AppIcon(
                            Icons.refresh,
                            size: AppIconSize.large,
                            semanticLabel: 'Refresh content',
                            onTap: () {},
                          ),
                          AppIcon(
                            Icons.more_vert,
                            size: AppIconSize.large,
                            semanticLabel: 'More options',
                            onTap: () {},
                          ),
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