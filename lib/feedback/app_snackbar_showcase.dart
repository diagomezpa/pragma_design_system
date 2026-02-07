import 'package:flutter/material.dart';
import '../atoms/app_text/app_text.dart';
import '../atoms/app_button/app_button.dart';
import '../atoms/app_spacer/app_spacer.dart';
import '../molecules/app_section/app_section.dart';
import 'app_snackbar.dart';

/// AppSnackbarShowcase - Interactive demonstration of the feedback system
/// 
/// This showcase provides a comprehensive testing interface for the AppSnackbar
/// feedback system, allowing users to explore different feedback types and
/// understand their appropriate use cases.
/// 
/// Features:
/// - Interactive buttons for each feedback type (success, error, info)
/// - Real-world scenarios and message examples
/// - Visual demonstration of Material 3 design compliance
/// - Clear categorization by feedback type and use case
/// - Educational content about when to use each type
/// 
/// Usage Examples Demonstrated:
/// - Success: Form submissions, profile updates, successful operations
/// - Error: Network failures, validation errors, system errors
/// - Info: Loading states, status updates, informational messages
/// 
/// Design Patterns:
/// - Uses AppButton for consistent interaction
/// - Organized with AppSection for clear categorization  
/// - Provides descriptive messages that represent real scenarios
/// - Demonstrates proper semantic usage of feedback types
class AppSnackbarShowcase extends StatelessWidget {
  /// Creates the feedback system showcase page
  const AppSnackbarShowcase({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Feedback System - Showcase'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // Header Section
          const AppText(
            'Feedback System Showcase',
            variant: AppTextVariant.headlineLarge,
            textAlign: TextAlign.center,
          ),
          const AppSpacer(
            size: AppSpacerSize.medium,
            direction: AppSpacerDirection.vertical,
          ),
          
          const AppText(
            'Test the temporal feedback system with different message types. '
            'Each type provides appropriate visual treatment and semantic meaning.',
            variant: AppTextVariant.bodyLarge,
            textAlign: TextAlign.center,
          ),
          const AppSpacer(
            size: AppSpacerSize.large,
            direction: AppSpacerDirection.vertical,
          ),
          
          // Success Feedback Section
          AppSection(
            title: 'Success Feedback',
            description: 'Positive confirmation for successful operations',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildFeedbackButton(
                  context,
                  label: 'Profile Updated',
                  onPressed: () => AppSnackbar.success(
                    context,
                    message: 'Profile updated successfully',
                  ),
                ),
                const AppSpacer(
                  size: AppSpacerSize.small,
                  direction: AppSpacerDirection.vertical,
                ),
                _buildFeedbackButton(
                  context,
                  label: 'Data Saved',
                  onPressed: () => AppSnackbar.success(
                    context,
                    message: 'Your changes have been saved',
                  ),
                ),
                const AppSpacer(
                  size: AppSpacerSize.small,
                  direction: AppSpacerDirection.vertical,
                ),
                _buildFeedbackButton(
                  context,
                  label: 'Order Complete',
                  onPressed: () => AppSnackbar.success(
                    context,
                    message: 'Order placed successfully! You will receive a confirmation email.',
                  ),
                ),
                const AppSpacer(
                  size: AppSpacerSize.small,
                  direction: AppSpacerDirection.vertical,
                ),
                _buildFeedbackButton(
                  context,
                  label: 'Upload Complete',
                  onPressed: () => AppSnackbar.success(
                    context,
                    message: 'File uploaded and processed successfully',
                  ),
                ),
              ],
            ),
          ),
          
          const AppSpacer(
            size: AppSpacerSize.medium,
            direction: AppSpacerDirection.vertical,
          ),
          
          // Error Feedback Section
          AppSection(
            title: 'Error Feedback',
            description: 'Critical alerts for failures and errors',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildFeedbackButton(
                  context,
                  label: 'Network Error',
                  onPressed: () => AppSnackbar.error(
                    context,
                    message: 'Network connection failed. Please try again.',
                  ),
                ),
                const AppSpacer(
                  size: AppSpacerSize.small,
                  direction: AppSpacerDirection.vertical,
                ),
                _buildFeedbackButton(
                  context,
                  label: 'Validation Error',
                  onPressed: () => AppSnackbar.error(
                    context,
                    message: 'Please fill in all required fields',
                  ),
                ),
                const AppSpacer(
                  size: AppSpacerSize.small,
                  direction: AppSpacerDirection.vertical,
                ),
                _buildFeedbackButton(
                  context,
                  label: 'Server Error',
                  onPressed: () => AppSnackbar.error(
                    context,
                    message: 'Server error occurred. Please contact support if the problem persists.',
                  ),
                ),
                const AppSpacer(
                  size: AppSpacerSize.small,
                  direction: AppSpacerDirection.vertical,
                ),
                _buildFeedbackButton(
                  context,
                  label: 'Authentication Failed',
                  onPressed: () => AppSnackbar.error(
                    context,
                    message: 'Invalid credentials. Please check your username and password.',
                  ),
                ),
              ],
            ),
          ),
          
          const AppSpacer(
            size: AppSpacerSize.large,
            direction: AppSpacerDirection.vertical,
          ),
          
          // Info Feedback Section
          AppSection(
            title: 'Informational Feedback',
            description: 'Neutral status updates and general notifications',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildFeedbackButton(
                  context,
                  label: 'Loading Data',
                  onPressed: () => AppSnackbar.info(
                    context,
                    message: 'Loading your data, please wait...',
                  ),
                ),
                const AppSpacer(
                  size: AppSpacerSize.small,
                  direction: AppSpacerDirection.vertical,
                ),
                _buildFeedbackButton(
                  context,
                  label: 'Processing Request',
                  onPressed: () => AppSnackbar.info(
                    context,
                    message: 'Your request is being processed',
                  ),
                ),
                const AppSpacer(
                  size: AppSpacerSize.small,
                  direction: AppSpacerDirection.vertical,
                ),
                _buildFeedbackButton(
                  context,
                  label: 'Sync Status',
                  onPressed: () => AppSnackbar.info(
                    context,
                    message: 'Syncing data with server...',
                  ),
                ),
                const AppSpacer(
                  size: AppSpacerSize.small,
                  direction: AppSpacerDirection.vertical,
                ),
                _buildFeedbackButton(
                  context,
                  label: 'Feature Update',
                  onPressed: () => AppSnackbar.info(
                    context,
                    message: 'New features are available in settings',
                  ),
                ),
              ],
            ),
          ),
          
          const AppSpacer(
            size: AppSpacerSize.large,
            direction: AppSpacerDirection.vertical,
          ),
          
          // Usage Guidelines Section
          AppSection(
            title: 'Usage Guidelines',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const AppText(
                  '🟢 Success: Use for positive confirmations of completed actions',
                  variant: AppTextVariant.bodyMedium,
                ),
               const AppSpacer(
                  size: AppSpacerSize.small,
                  direction: AppSpacerDirection.vertical,
                ),
                const AppText(
                  '🔴 Error: Use for failures, errors, and critical issues that need attention',
                  variant: AppTextVariant.bodyMedium,
                ),
                const AppSpacer(
                  size: AppSpacerSize.small,
                  direction: AppSpacerDirection.vertical,
                ),
                const AppText(
                  '🔵 Info: Use for neutral information, status updates, and general notifications',
                  variant: AppTextVariant.bodyMedium,
                ),
                const AppSpacer(
                  size: AppSpacerSize.medium,
                  direction: AppSpacerDirection.vertical,
                ),
                const AppText(
                  'Technical Features:',
                  variant: AppTextVariant.titleMedium,
                ),
                const AppSpacer(
                  size: AppSpacerSize.small,
                  direction: AppSpacerDirection.vertical,
                ),
                const AppText(
                  '• Automatic dismissal of previous snackbars\n'
                  '• Material 3 floating behavior with rounded corners\n'
                  '• Theme-aware colors and typography\n'
                  '• 2-second display duration\n'
                  '• Semantic API with type safety',
                  variant: AppTextVariant.bodyMedium,
                ),
              ],
            ),
          ),
          
          const AppSpacer(
            size: AppSpacerSize.extraLarge,
            direction: AppSpacerDirection.vertical,
          ),
        ],
      ),
    );
  }
  
  /// Builds a consistent feedback test button
  Widget _buildFeedbackButton(
    BuildContext context, {
    required String label,
    required VoidCallback onPressed,
  }) {
    return AppButton(
      text: label,
      onPressed: onPressed,
      variant: AppButtonVariant.outline,
    );
  }
}
