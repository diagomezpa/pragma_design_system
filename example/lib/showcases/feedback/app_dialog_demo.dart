import 'package:flutter/material.dart';
import 'package:pragma_design_system/pragma_design_system.dart';

/// AppDialogDemo - Demonstrates various usage patterns for AppDialog
///
/// This demo showcases the different ways to use AppDialog component,
/// including simple dialogs, confirmation dialogs, and dialogs with
/// custom content. It serves as both documentation and testing for
/// the AppDialog component.
class AppDialogDemo extends StatelessWidget {
  const AppDialogDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AppDialog Demo'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const AppText(
              'AppDialog Examples',
              variant: AppTextVariant.headlineSmall,
            ),
            const AppSpacer(size: AppSpacerSize.large),
            
            // Simple dialog
            AppButton(
              text: 'Simple Dialog',
              onPressed: () => _showSimpleDialog(context),
              variant: AppButtonVariant.primary,
            ),
            const AppSpacer(size: AppSpacerSize.medium),
            
            // Confirmation dialog
            AppButton(
              text: 'Confirmation Dialog',
              onPressed: () => _showConfirmationDialog(context),
              variant: AppButtonVariant.secondary,
            ),
            const AppSpacer(size: AppSpacerSize.medium),
            
            // Dialog with custom content
            AppButton(
              text: 'Custom Content Dialog',
              onPressed: () => _showCustomContentDialog(context),
              variant: AppButtonVariant.outline,
            ),
            const AppSpacer(size: AppSpacerSize.medium),
            
            // Dialog without title
            AppButton(
              text: 'No Title Dialog',
              onPressed: () => _showNoTitleDialog(context),
              variant: AppButtonVariant.text,
            ),
            const AppSpacer(size: AppSpacerSize.medium),
            
            // Dialog with return value
            AppButton(
              text: 'Dialog with Return Value',
              onPressed: () => _showDialogWithReturnValue(context),
              variant: AppButtonVariant.primary,
            ),
          ],
        ),
      ),
    );
  }

  /// Shows a simple dialog with just title and content
  void _showSimpleDialog(BuildContext context) {
    AppDialog.show(
      context: context,
      title: 'Information',
      content: const AppText(
        'This is a simple dialog with just informational content.',
        variant: AppTextVariant.bodyMedium,
      ),
    );
  }

  /// Shows a confirmation dialog with cancel and confirm actions
  Future<void> _showConfirmationDialog(BuildContext context) async {
    final result = await AppDialog.show<bool>(
      context: context,
      title: 'Confirm Action',
      content: const AppText(
        'Are you sure you want to proceed with this action?',
        variant: AppTextVariant.bodyMedium,
      ),
      actions: [
        AppButton(
          text: 'Cancel',
          onPressed: () => Navigator.pop(context, false),
          variant: AppButtonVariant.text,
          size: AppButtonSize.medium,
        ),
        AppButton(
          text: 'Confirm',
          onPressed: () => Navigator.pop(context, true),
          variant: AppButtonVariant.primary,
          size: AppButtonSize.medium,
        ),
      ],
    );

    if (result == true && context.mounted) {
      AppSnackbar.success(context, message: 'Action confirmed!');
    }
  }

  /// Shows a dialog with custom widget content
  void _showCustomContentDialog(BuildContext context) {
    AppDialog.show(
      context: context,
      title: 'Custom Content',
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const AppText(
            'This dialog contains custom widgets:',
            variant: AppTextVariant.bodyMedium,
          ),
          const AppSpacer(size: AppSpacerSize.medium),
          Container(
            height: 100,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: AppText(
                'Custom Widget',
                variant: AppTextVariant.titleSmall,
                color: Theme.of(context).colorScheme.onPrimaryContainer,
              ),
            ),
          ),
          const AppSpacer(size: AppSpacerSize.medium),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              AppIcon(Icons.star, size: AppIconSize.large),
              AppIcon(Icons.favorite, size: AppIconSize.large),
              AppIcon(Icons.thumb_up, size: AppIconSize.large),
            ],
          ),
        ],
      ),
      actions: [
        AppButton(
          text: 'Close',
          onPressed: () => Navigator.pop(context),
          variant: AppButtonVariant.primary,
          size: AppButtonSize.medium,
        ),
      ],
    );
  }

  /// Shows a dialog without a title
  void _showNoTitleDialog(BuildContext context) {
    AppDialog.show(
      context: context,
      content: const AppText(
        'This dialog has no title, just content and an action button.',
        variant: AppTextVariant.bodyMedium,
      ),
      actions: [
        AppButton(
          text: 'Got it',
          onPressed: () => Navigator.pop(context),
          variant: AppButtonVariant.primary,
          size: AppButtonSize.medium,
        ),
      ],
    );
  }

  /// Shows a dialog that returns a value and demonstrates different action types
  Future<void> _showDialogWithReturnValue(BuildContext context) async {
    final result = await AppDialog.show<String>(
      context: context,
      title: 'Choose Option',
      content: const AppText(
        'Please select one of the following options:',
        variant: AppTextVariant.bodyMedium,
      ),
      actions: [
        AppButton(
          text: 'Option A',
          onPressed: () => Navigator.pop(context, 'A'),
          variant: AppButtonVariant.outline,
          size: AppButtonSize.medium,
        ),
        AppButton(
          text: 'Option B',
          onPressed: () => Navigator.pop(context, 'B'),
          variant: AppButtonVariant.primary,
          size: AppButtonSize.medium,
        ),
        AppButton(
          text: 'Cancel',
          onPressed: () => Navigator.pop(context),
          variant: AppButtonVariant.text,
          size: AppButtonSize.medium,
        ),
      ],
    );

    if (result != null && context.mounted) {
      AppSnackbar.info(context, message: 'You selected Option $result');
    }
  }
}