import 'package:flutter/material.dart';
import 'package:pragma_design_system/pragma_design_system.dart';

/// SettingsPage - A concrete Page implementation demonstrating template usage.
///
/// This page represents the Page layer in Atomic Design methodology, which is
/// responsible for providing real data, content organization, and navigation
/// callbacks to Templates. Pages are specific instances of Templates with actual
/// representative content and user interaction patterns.
///
/// **Why Settings Screens Map Well to Atomic Design:**
/// Settings screens are naturally hierarchical and benefit from atomic composition:
/// - **Atoms**: Icons, text labels, and interactive elements provide consistent building blocks
/// - **Molecules**: AppListItem combines atoms into reusable setting row components
/// - **Organisms**: AppSettingsGroup logically groups related setting molecules
/// - **Templates**: SettingsPageTemplate defines overall page structure and spacing
/// - **Pages**: SettingsPage provides real content, organization, and interaction patterns
///
/// This hierarchical approach ensures visual consistency, reusable components,
/// and maintainable code structure across all settings contexts in the application.
///
/// **How Scannability Is Achieved Using Groups:**
/// Visual scannability in settings is critical for user experience. This is achieved through:
/// - **Logical Grouping**: Related settings are clustered using AppSettingsGroup organisms
/// - **Visual Separation**: Groups provide clear boundaries and section titles
/// - **Consistent Hierarchy**: Each group follows the same visual pattern and spacing
/// - **Predictable Layout**: Users can quickly locate settings through familiar organization
/// - **Icon Consistency**: Leading icons provide quick visual identification
/// - **Progressive Disclosure**: Complex settings can be organized into sub-categories
///
/// **Why This Belongs in the Pages Layer:**
/// While settings content might seem simple, it represents complete user workflows:
/// - **Content Organization**: Pages decide which settings belong together
/// - **Navigation Logic**: Pages handle where each setting action leads
/// - **User Context**: Pages understand the broader app context and user needs
/// - **Business Logic**: Pages can integrate with user preferences, permissions, and state
/// - **Accessibility**: Pages ensure proper semantic structure and screen reader support
/// - **Localization**: Pages can adapt content based on user locale and preferences
///
/// Templates remain pure layout definitions, while Pages provide the complete
/// user experience including content strategy, interaction design, and business context.
///
/// **Implementation Philosophy:**
/// - Page owns content organization and navigation callbacks
/// - Template (SettingsPageTemplate) owns layout structure and visual hierarchy
/// - Organisms (AppSettingsGroup) handle logical grouping and section styling
/// - Molecules (AppListItem) provide consistent row behavior and interaction patterns
/// - Clear separation enables template reuse across different settings contexts
class SettingsPage extends StatelessWidget {
  /// Creates a settings page demonstrating template usage for app configuration.
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings Page Example'),
        centerTitle: true,
      ),
      body: SettingsPageTemplate(
        title: const AppText(
          'Settings',
          variant: AppTextVariant.headlineSmall,
        ),
        groups: [
          _buildProfileGroup(),
          _buildNotificationsGroup(),
          _buildPrivacyGroup(),
        ],
      ),
    );
  }

  /// Builds the Profile settings group with user account related options.
  ///
  /// **Content Strategy:**
  /// Groups user-facing profile management features that directly affect
  /// how the user appears and manages their account within the application.
  AppSettingsGroup _buildProfileGroup() {
    return AppSettingsGroup(
      title: 'Profile',
      children: [
        AppListItem(
          leading: const AppIcon(Icons.person_outline),
          title: 'Edit Profile',
          subtitle: 'Update your name, photo, and bio',
          trailing: const AppIcon(Icons.chevron_right),
          onTap: () => _handleSettingsTap('Edit Profile'),
        ),
        AppListItem(
          leading: const AppIcon(Icons.account_circle_outlined),
          title: 'Account Information',
          subtitle: 'View and manage account details',
          trailing: const AppIcon(Icons.chevron_right),
          onTap: () => _handleSettingsTap('Account Information'),
        ),
      ],
    );
  }

  /// Builds the Notifications settings group with communication preferences.
  ///
  /// **Content Strategy:**
  /// Groups all notification-related settings to give users control over
  /// how and when the application communicates with them across different channels.
  AppSettingsGroup _buildNotificationsGroup() {
    return AppSettingsGroup(
      title: 'Notifications',
      children: [
        AppListItem(
          leading: const AppIcon(Icons.notifications_outlined),
          title: 'Push Notifications',
          subtitle: 'Manage app notifications and alerts',
          trailing: const AppIcon(Icons.chevron_right),
          onTap: () => _handleSettingsTap('Push Notifications'),
        ),
        AppListItem(
          leading: const AppIcon(Icons.email_outlined),
          title: 'Email Notifications',
          subtitle: 'Configure email preferences and frequency',
          trailing: const AppIcon(Icons.chevron_right),
          onTap: () => _handleSettingsTap('Email Notifications'),
        ),
      ],
    );
  }

  /// Builds the Privacy settings group with security and privacy controls.
  ///
  /// **Content Strategy:**
  /// Groups privacy and security features to help users understand and control
  /// their data protection options and account security settings.
  AppSettingsGroup _buildPrivacyGroup() {
    return AppSettingsGroup(
      title: 'Privacy',
      children: [
        AppListItem(
          leading: const AppIcon(Icons.lock_outline),
          title: 'Change Password',
          subtitle: 'Update your account password',
          trailing: const AppIcon(Icons.chevron_right),
          onTap: () => _handleSettingsTap('Change Password'),
        ),
        AppListItem(
          leading: const AppIcon(Icons.privacy_tip_outlined),
          title: 'Privacy Policy',
          subtitle: 'Review our data usage and privacy practices',
          trailing: const AppIcon(Icons.chevron_right),
          onTap: () => _handleSettingsTap('Privacy Policy'),
        ),
      ],
    );
  }

  /// Handles settings item tap interactions.
  ///
  /// **Navigation Strategy:**
  /// In a real application, this method would route to specific settings screens
  /// based on the action type. For demonstration purposes, it logs the action
  /// to show how Pages handle user interactions and navigation logic.
  ///
  /// **Real-world Implementation:**
  /// ```dart
  /// void _handleSettingsTap(String action) {
  ///   switch (action) {
  ///     case 'Edit Profile':
  ///       Navigator.push(context, MaterialPageRoute(
  ///         builder: (context) => EditProfilePage(),
  ///       ));
  ///       break;
  ///     case 'Account Information':
  ///       Navigator.push(context, MaterialPageRoute(
  ///         builder: (context) => AccountInfoPage(),
  ///       ));
  ///       break;
  ///     // ... additional cases for each setting
  ///   }
  /// }
  /// ```
  void _handleSettingsTap(String action) {
    debugPrint('Settings action tapped: $action');

    // In a real application, this would handle:
    // - Navigation to specific settings screens
    // - Deep linking support for settings URLs
    // - Analytics tracking for settings usage
    // - Permission checks for sensitive settings
    // - Integration with user preferences system
  }
}
