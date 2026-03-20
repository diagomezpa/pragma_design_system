import 'package:flutter/material.dart';
import 'package:pragma_design_system/pragma_design_system.dart';

/// Simple demo app to test AppSnackbar functionality
/// 
/// This is a standalone demo that can be used to quickly test
/// the feedback system without complex dependencies.
class FeedbackDemo extends StatelessWidget {
  const FeedbackDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Feedback System Demo'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const AppText(
              'Feedback System Test',
              variant: AppTextVariant.headlineLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            
            // Success Button
            AppButton(
              text: '✅ Show Success Message',
              onPressed: () => AppSnackbar.success(
                context,
                message: 'Operation completed successfully!',
              ),
              variant: AppButtonVariant.primary,
            ),
            
            const SizedBox(height: 16),
            
            // Error Button
            AppButton(
              text: '❌ Show Error Message',
              onPressed: () => AppSnackbar.error(
                context,
                message: 'Something went wrong. Please try again.',
              ),
              variant: AppButtonVariant.primary,
            ),
            
            const SizedBox(height: 16),
            
            // Info Button
            AppButton(
              text: 'ℹ️ Show Info Message',
              onPressed: () => AppSnackbar.info(
                context,
                message: 'Loading your data, please wait...',
              ),
              variant: AppButtonVariant.primary,
            ),
            
            const SizedBox(height: 48),
            
            const AppText(
              'Tap any button to test the feedback system. '
              'Notice how each type uses different colors and '
              'automatically dismisses previous messages.',
              variant: AppTextVariant.bodyMedium,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}