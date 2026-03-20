import 'package:flutter/material.dart';
import 'package:pragma_design_system/pragma_design_system.dart';

/// SettingsPageTemplateShowcase
///
/// **Living Documentation and Visual Validation**
///
/// A comprehensive demonstration of SettingsPageTemplate usage showing realistic
/// settings page composition. This showcase serves multiple purposes:
///
/// **Educational Goals:**
/// - Demonstrates proper template usage patterns for settings pages
/// - Shows how to compose organisms and molecules within the template
/// - Illustrates settings grouping, hierarchy, and visual organization
/// - Provides copy-paste examples for common settings page layouts
///
/// **Template Validation:**
/// - Validates template flexibility across different settings categories
/// - Tests scrollable behavior and spacing consistency
/// - Ensures proper visual hierarchy and grouping
/// - Demonstrates integration with the broader design system
///
/// **Showcase Scenario:**
/// **Complete Settings Page** - Full application settings with logical grouping:
/// - Account & Profile management
/// - Notification preferences
/// - Privacy & Security controls
///
/// **Design System Integration:**
/// - Uses only existing design system components
/// - Demonstrates proper atom/molecule/organism composition
/// - Shows Material 3 theming and accessibility patterns
/// - Maintains consistent spacing using AppSpacer tokens
///
/// **For Developers:**
/// - Copy examples directly into your applications
/// - Understand when and how to use SettingsPageTemplate
/// - Learn proper settings organization patterns
/// - See realistic settings content and structure
class SettingsPageTemplateShowcase extends StatelessWidget {
  const SettingsPageTemplateShowcase({super.key});

  @override
  Widget build(BuildContext context) {
    return SettingsPageTemplate(
      // Page title establishes context and hierarchy
      title: const AppText(
        'Settings',
        variant: AppTextVariant.headlineSmall,
      ),
      groups: [
        // ACCOUNT GROUP: User profile and account management
        // Shows primary user-focused settings with personal data management
        AppSettingsGroup(
          title: 'Account',
          children: [
            AppListItem(
              leading: const Icon(Icons.person_outline),
              title: 'Profile Information',
              subtitle: 'Manage your personal details and preferences',
              trailing: const Icon(Icons.chevron_right),
              onTap: () {}, // Mock navigation - showcase only
            ),
            AppListItem(
              leading: const Icon(Icons.lock_outline),
              title: 'Change Password',
              subtitle: 'Update your account security',
              trailing: const Icon(Icons.chevron_right),
              onTap: () {}, // Mock navigation - showcase only
            ),
            AppListItem(
              leading: const Icon(Icons.email_outlined),
              title: 'Email Address',
              subtitle: 'john.doe@example.com',
              trailing: const Icon(Icons.chevron_right),
              onTap: () {}, // Mock navigation - showcase only
            ),
          ],
        ),

        // NOTIFICATIONS GROUP: Communication preferences
        // Demonstrates settings with different interaction patterns (toggles, navigation)
        AppSettingsGroup(
          title: 'Notifications',
          children: [
            AppListItem(
              leading: const Icon(Icons.notifications_outlined),
              title: 'Push Notifications',
              subtitle: 'Receive alerts on your device',
              trailing: Switch(
                value: true, // Mock state - showcase only
                onChanged: (value) {}, // Mock action - showcase only
              ),
              onTap: () {}, // Mock navigation - showcase only
            ),
            AppListItem(
              leading: const Icon(Icons.mail_outline),
              title: 'Email Notifications',
              subtitle: 'Get updates via email',
              trailing: Switch(
                value: false, // Mock state - showcase only
                onChanged: (value) {}, // Mock action - showcase only
              ),
              onTap: () {}, // Mock navigation - showcase only
            ),
            AppListItem(
              leading: const Icon(Icons.sms_outlined),
              title: 'SMS Alerts',
              subtitle: 'Receive text message notifications',
              trailing: const Icon(Icons.chevron_right),
              onTap: () {}, // Mock navigation - showcase only
            ),
          ],
        ),

        // PRIVACY & SECURITY GROUP: Security and privacy controls
        // Shows advanced settings with security implications and detailed descriptions
        AppSettingsGroup(
          title: 'Privacy & Security',
          children: [
            AppListItem(
              leading: const Icon(Icons.privacy_tip_outlined),
              title: 'Privacy Settings',
              subtitle: 'Control who can see your information',
              trailing: const Icon(Icons.chevron_right),
              onTap: () {}, // Mock navigation - showcase only
            ),
            AppListItem(
              leading: const Icon(Icons.security_outlined),
              title: 'Two-Factor Authentication',
              subtitle: 'Add an extra layer of security',
              trailing: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: AppText(
                  'Enabled',
                  variant: AppTextVariant.bodySmall,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              onTap: () {}, // Mock navigation - showcase only
            ),
            AppListItem(
              leading: const Icon(Icons.devices_outlined),
              title: 'Active Sessions',
              subtitle: 'Manage devices signed into your account',
              trailing: const Icon(Icons.chevron_right),
              onTap: () {}, // Mock navigation - showcase only
            ),
            AppListItem(
              leading: const Icon(Icons.delete_outline),
              title: 'Delete Account',
              subtitle: 'Permanently remove your account and data',
              trailing: const Icon(Icons.chevron_right),
              onTap: () {}, // Mock navigation - showcase only
            ),
          ],
        ),

        // ADDITIONAL GROUP: App preferences and support
        // Demonstrates how template handles many groups with consistent spacing
        AppSettingsGroup(
          title: 'App Preferences',
          children: [
            AppListItem(
              leading: const Icon(Icons.palette_outlined),
              title: 'Theme',
              subtitle: 'Dark mode, light mode, or system default',
              trailing: const AppText(
                'System',
                variant: AppTextVariant.bodyMedium,
              ),
              onTap: () {}, // Mock navigation - showcase only
            ),
            AppListItem(
              leading: const Icon(Icons.language_outlined),
              title: 'Language',
              subtitle: 'Choose your preferred language',
              trailing: const AppText(
                'English',
                variant: AppTextVariant.bodyMedium,
              ),
              onTap: () {}, // Mock navigation - showcase only
            ),
          ],
        ),

        // SUPPORT GROUP: Help and legal information
        // Shows final group demonstrating complete settings page structure
        AppSettingsGroup(
          title: 'Support',
          children: [
            AppListItem(
              leading: const Icon(Icons.help_outline),
              title: 'Help Center',
              subtitle: 'Get answers to common questions',
              trailing: const Icon(Icons.chevron_right),
              onTap: () {}, // Mock navigation - showcase only
            ),
            AppListItem(
              leading: const Icon(Icons.feedback_outlined),
              title: 'Send Feedback',
              subtitle: 'Help us improve the app',
              trailing: const Icon(Icons.chevron_right),
              onTap: () {}, // Mock navigation - showcase only
            ),
            AppListItem(
              leading: const Icon(Icons.info_outline),
              title: 'About',
              subtitle: 'App version and legal information',
              trailing: const Icon(Icons.chevron_right),
              onTap: () {}, // Mock navigation - showcase only
            ),
          ],
        ),
      ],
    );
  }
}