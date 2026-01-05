import 'package:flutter/material.dart';

import '../../atoms/app_icon.dart';
import '../../atoms/app_spacer.dart';
import '../../atoms/app_text.dart';
import '../../molecules/list_item/app_list_item.dart';
import 'app_settings_group.dart';

/// AppSettingsGroupShowcase
///
/// A comprehensive demonstration of the AppSettingsGroup organism showcasing
/// different configurations, use cases, and integration patterns with other
/// design system components.
///
/// **Purpose:**
/// - Demonstrates real-world settings screen scenarios
/// - Shows proper usage patterns and composability
/// - Validates theming, spacing, and visual hierarchy
/// - Serves as living documentation for developers and designers
///
/// **What developers should learn:**
/// - How to structure settings sections with proper grouping
/// - When to use card styling vs plain grouping
/// - How to combine AppSettingsGroup with AppListItem effectively
/// - Best practices for settings interaction patterns
/// - Proper spacing and visual separation techniques
class AppSettingsGroupShowcase extends StatefulWidget {
  const AppSettingsGroupShowcase({super.key});

  @override
  State<AppSettingsGroupShowcase> createState() => _AppSettingsGroupShowcaseState();
}

class _AppSettingsGroupShowcaseState extends State<AppSettingsGroupShowcase> {
  // Minimal state for demonstration purposes
  bool _notificationsEnabled = true;
  bool _darkModeEnabled = false;
  bool _biometricsEnabled = true;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      appBar: AppBar(
        title: const AppText(
          'AppSettingsGroup Showcase',
          variant: AppTextVariant.titleLarge,
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Section 1: Basic settings group
          _buildSectionHeader('1. Basic Settings Group'),
          const AppText(
            'Simple group with title and default dividers between items',
            variant: AppTextVariant.bodySmall,
          ),
          AppSpacerFactory.mediumVertical(),
          AppSettingsGroup(
            title: 'Account Settings',
            children: [
              AppListItem(
                leading: const AppIcon(Icons.person_outline),
                title: 'Profile Information',
                trailing: const AppIcon(Icons.chevron_right),
                onTap: () => debugPrint('Tapped Profile Information'),
              ),
              AppListItem(
                leading: const AppIcon(Icons.email_outlined),
                title: 'Email Preferences',
                trailing: const AppIcon(Icons.chevron_right),
                onTap: () => debugPrint('Tapped Email Preferences'),
              ),
              AppListItem(
                leading: const AppIcon(Icons.lock_outline),
                title: 'Change Password',
                trailing: const AppIcon(Icons.chevron_right),
                onTap: () => debugPrint('Tapped Change Password'),
              ),
            ],
          ),

          AppSpacerFactory.extraLargeVertical(),

          // Section 2: Settings group with description
          _buildSectionHeader('2. Group with Description'),
          const AppText(
            'Group with both title and description for additional context',
            variant: AppTextVariant.bodySmall,
          ),
          AppSpacerFactory.mediumVertical(),
          AppSettingsGroup(
            title: 'Privacy & Security',
            description: 'Manage your privacy settings and account security features.',
            children: [
              AppListItem(
                leading: const AppIcon(Icons.security),
                title: 'Two-Factor Authentication',
                subtitle: 'Add an extra layer of security',
                trailing: Switch(
                  value: _biometricsEnabled,
                  onChanged: (value) {
                    setState(() => _biometricsEnabled = value);
                    debugPrint('Two-Factor Authentication: $value');
                  },
                ),
              ),
              AppListItem(
                leading: const AppIcon(Icons.fingerprint),
                title: 'Biometric Login',
                subtitle: 'Use fingerprint or face recognition',
                trailing: const AppIcon(Icons.chevron_right),
                onTap: () => debugPrint('Tapped Biometric Login'),
              ),
              AppListItem(
                leading: const AppIcon(Icons.download),
                title: 'Download My Data',
                subtitle: 'Export your account information',
                trailing: const AppIcon(Icons.chevron_right),
                onTap: () => debugPrint('Tapped Download My Data'),
              ),
            ],
          ),

          AppSpacerFactory.extraLargeVertical(),

          // Section 3: Card-style settings group
          _buildSectionHeader('3. Card-Style Group'),
          const AppText(
            'Elevated card styling for modern settings screens',
            variant: AppTextVariant.bodySmall,
          ),
          AppSpacerFactory.mediumVertical(),
          AppSettingsGroup(
            title: 'Notifications',
            description: 'Control how and when you receive notifications.',
            isCard: true,
            children: [
              AppListItem(
                leading: const AppIcon(Icons.notifications_outlined),
                title: 'Push Notifications',
                trailing: Switch(
                  value: _notificationsEnabled,
                  onChanged: (value) {
                    setState(() => _notificationsEnabled = value);
                    debugPrint('Push Notifications: $value');
                  },
                ),
              ),
              AppListItem(
                leading: const AppIcon(Icons.email_outlined),
                title: 'Email Notifications',
                trailing: const AppIcon(Icons.chevron_right),
                onTap: () => debugPrint('Tapped Email Notifications'),
              ),
              AppListItem(
                leading: const AppIcon(Icons.sms_outlined),
                title: 'SMS Notifications',
                trailing: const AppIcon(Icons.chevron_right),
                onTap: () => debugPrint('Tapped SMS Notifications'),
              ),
            ],
          ),

          AppSpacerFactory.extraLargeVertical(),

          // Section 4: Settings group without dividers
          _buildSectionHeader('4. Group Without Dividers'),
          const AppText(
            'Compact layout with showDividers set to false',
            variant: AppTextVariant.bodySmall,
          ),
          AppSpacerFactory.mediumVertical(),
          AppSettingsGroup(
            title: 'Appearance',
            showDividers: false,
            children: [
              AppListItem(
                leading: const AppIcon(Icons.palette_outlined),
                title: 'Theme',
                subtitle: 'Light',
                trailing: const AppIcon(Icons.chevron_right),
                onTap: () => debugPrint('Tapped Theme'),
              ),
              AppListItem(
                leading: const AppIcon(Icons.dark_mode_outlined),
                title: 'Dark Mode',
                trailing: Switch(
                  value: _darkModeEnabled,
                  onChanged: (value) {
                    setState(() => _darkModeEnabled = value);
                    debugPrint('Dark Mode: $value');
                  },
                ),
              ),
              AppListItem(
                leading: const AppIcon(Icons.text_fields),
                title: 'Font Size',
                subtitle: 'Medium',
                trailing: const AppIcon(Icons.chevron_right),
                onTap: () => debugPrint('Tapped Font Size'),
              ),
            ],
          ),

          AppSpacerFactory.extraLargeVertical(),

          // Section 5: Mixed content group
          _buildSectionHeader('5. Mixed Content Group'),
          const AppText(
            'Flexible children with enabled and disabled states',
            variant: AppTextVariant.bodySmall,
          ),
          AppSpacerFactory.mediumVertical(),
          AppSettingsGroup(
            title: 'Advanced Settings',
            description: 'Advanced configuration options for power users.',
            isCard: true,
            children: [
              AppListItem(
                leading: const AppIcon(Icons.developer_mode),
                title: 'Developer Mode',
                subtitle: 'Enable advanced debugging features',
                trailing: const AppIcon(Icons.chevron_right),
                onTap: () => debugPrint('Tapped Developer Mode'),
              ),
              AppListItem(
                leading: AppIcon(
                  Icons.analytics_outlined,
                  color: theme.colorScheme.onSurface.withOpacity(0.38),
                ),
                title: 'Analytics',
                subtitle: 'Feature temporarily unavailable',
                trailing: AppIcon(
                  Icons.chevron_right,
                  color: theme.colorScheme.onSurface.withOpacity(0.38),
                ),
                onTap: null, // Disabled state
              ),
              AppListItem(
                leading: const AppIcon(Icons.bug_report_outlined),
                title: 'Send Feedback',
                subtitle: 'Help us improve the app',
                trailing: const AppIcon(Icons.chevron_right),
                onTap: () => debugPrint('Tapped Send Feedback'),
              ),
              AppListItem(
                leading: const AppIcon(Icons.info_outline),
                title: 'About',
                subtitle: 'Version 1.0.0',
                trailing: const AppIcon(Icons.chevron_right),
                onTap: () => debugPrint('Tapped About'),
              ),
            ],
          ),

          // Extra spacing at bottom
          AppSpacerFactory.hugeVertical(),
        ],
      ),
    );
  }

  /// Builds a consistent section header for the showcase
  Widget _buildSectionHeader(String title) {
    final theme = Theme.of(context);
    
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: AppText(
        title,
        variant: AppTextVariant.titleMedium,
        color: theme.colorScheme.primary,
      ),
    );
  }
}