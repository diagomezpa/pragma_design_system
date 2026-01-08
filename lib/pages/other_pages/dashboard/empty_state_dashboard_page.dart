import 'package:flutter/material.dart';
import 'package:pragma_design_system/pragma_design_system.dart';

/// EmptyStateDashboardPage - A concrete Page implementation demonstrating empty state UX.
///
/// This page represents the Page layer in Atomic Design methodology, which is
/// responsible for providing meaningful content, user guidance, and interaction
/// patterns to Templates. Pages are complete user experiences that leverage
/// Templates for consistent layout structure.
///
/// **Why Empty States Are Critical UX Moments:**
/// Empty states are among the most important user experience touchpoints because they:
/// - **First Impressions**: Often the first screen new users encounter in an application
/// - **User Onboarding**: Provide essential guidance for getting started with the system
/// - **Motivation**: Can inspire users to take action or discourage them from continuing
/// - **Value Communication**: Explain what the dashboard will become once populated
/// - **Reduced Friction**: Clear next steps prevent user confusion and abandonment
/// - **Brand Opportunity**: Friendly, helpful copy reinforces positive brand perception
///
/// Empty states that provide clear guidance and motivation can significantly
/// improve user activation rates, engagement, and long-term retention.
///
/// **How This Page Guides First-Time Users:**
/// This implementation follows empty state best practices for user guidance:
/// - **Welcoming Tone**: Creates a positive first impression with friendly language
/// - **Clear Context**: Explains what the dashboard is and why it's currently empty
/// - **Obvious Action**: Provides a prominent call-to-action for the next step
/// - **Value Preview**: Hints at the value users will receive after taking action
/// - **Visual Hierarchy**: Uses design system components to create clear information flow
/// - **Accessible Design**: Ensures screen readers and assistive technologies work properly
///
/// The combination of encouraging copy, clear visual hierarchy, and obvious next
/// steps helps convert first-time visitors into active users.
///
/// **Why This Belongs in the Pages Layer:**
/// While empty states might seem like simple content, they represent complete user experiences:
/// - **Content Strategy**: Pages decide what message resonates with users at this moment
/// - **User Psychology**: Pages understand user needs, emotions, and motivations
/// - **Business Goals**: Pages align empty state messaging with business objectives
/// - **User Journey**: Pages consider where users came from and where they should go next
/// - **Personalization**: Pages can adapt content based on user context or segmentation
/// - **A/B Testing**: Pages enable testing different messaging approaches for optimization
///
/// Templates provide layout structure, but Pages provide the meaningful human
/// experience that determines whether users continue their journey or abandon the app.
///
/// **Implementation Philosophy:**
/// - Page owns content strategy and user motivation messaging
/// - Template (EmptyStateDashboardTemplate) owns layout structure and visual hierarchy
/// - Organisms (AppEmptyStateSection) handle visual composition and accessibility
/// - Atoms provide consistent visual building blocks for the overall experience
/// - Clear separation enables testing different messaging without affecting layout
class EmptyStateDashboardPage extends StatelessWidget {
  /// Creates an empty state dashboard page demonstrating user guidance and motivation.
  const EmptyStateDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Empty State Dashboard'),
        centerTitle: true,
      ),
      body: EmptyStateDashboardTemplate(
        emptyState: _buildEmptyStateSection(),
      ),
    );
  }

  /// Builds the empty state section with user guidance and primary action.
  ///
  /// **Content Strategy:**
  /// The messaging follows empty state best practices:
  /// - Welcoming and encouraging tone to create positive first impression
  /// - Clear explanation of what the dashboard provides when populated
  /// - Obvious next step with actionable, benefit-focused button text
  /// - Visual hierarchy that guides attention to the call-to-action
  ///
  /// **Psychological Considerations:**
  /// - "Welcome" creates inclusion and belonging
  /// - "Your dashboard" establishes ownership and personal value
  /// - "Create your first item" implies progress and achievement
  /// - Friendly language reduces anxiety about getting started
  AppEmptyStateSection _buildEmptyStateSection() {
    return AppEmptyStateSection(
      icon: Icons.dashboard_outlined,
      title: 'Welcome to your dashboard',
      description:
          'Your dashboard is where you\'ll track progress, view insights, and manage your most important items. Once you create your first item, you\'ll see it come to life here.',
      primaryAction: AppButton(
        text: 'Create your first item',
        onPressed: _handleCreateFirstItem,
        variant: AppButtonVariant.primary,
        size: AppButtonSize.large,
      ),
    );
  }

  /// Handles the primary action for creating the first dashboard item.
  ///
  /// **User Experience Flow:**
  /// This represents the critical conversion moment where users move from
  /// passive observation to active engagement with the application.
  ///
  /// **Real-world Implementation:**
  /// In a production app, this would typically:
  /// ```dart
  /// void _handleCreateFirstItem() {
  ///   // Track analytics event for empty state conversion
  ///   analytics.track('empty_state_create_tapped', {
  ///     'source': 'dashboard',
  ///     'user_type': 'new',
  ///   });
  ///
  ///   // Navigate to item creation flow
  ///   Navigator.push(context, MaterialPageRoute(
  ///     builder: (context) => CreateItemPage(
  ///       source: 'empty_dashboard',
  ///       onSuccess: () => Navigator.pushReplacement(
  ///         context,
  ///         MaterialPageRoute(builder: (context) => DashboardPage()),
  ///       ),
  ///     ),
  ///   ));
  /// }
  /// ```
  ///
  /// **Success Metrics:**
  /// - Conversion rate from empty state to first item creation
  /// - Time to first item creation from empty state view
  /// - User retention after completing first item creation
  /// - Reduction in user abandonment at the dashboard level
  void _handleCreateFirstItem() {
    debugPrint('Create first item');

    // In a real application, this would handle:
    // - Analytics tracking for empty state conversion measurement
    // - Navigation to item creation flow or onboarding wizard
    // - User guidance through first-time setup process
    // - Success feedback and celebration of first achievement
    // - Contextual help or tutorials for complex features
  }
}
