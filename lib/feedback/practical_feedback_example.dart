import 'package:flutter/material.dart';
import 'package:pragma_design_system/pragma_design_system.dart';

/// Practical example showing AppSnackbar usage in a real form scenario
/// 
/// This example demonstrates how to integrate the feedback system
/// in a typical user interaction flow with form validation and submission.
class PracticalFeedbackExample extends StatefulWidget {
  const PracticalFeedbackExample({super.key});

  @override
  State<PracticalFeedbackExample> createState() => _PracticalFeedbackExampleState();
}

class _PracticalFeedbackExampleState extends State<PracticalFeedbackExample> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  String? _emailError;
  String? _passwordError;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  /// Validates the form and returns true if valid
  bool _validateForm() {
    setState(() {
      _emailError = null;
      _passwordError = null;
    });

    bool isValid = true;

    // Validate email
    final email = _emailController.text.trim();
    if (email.isEmpty) {
      _emailError = 'Email is required';
      isValid = false;
    } else if (!email.contains('@')) {
      _emailError = 'Please enter a valid email';
      isValid = false;
    }

    // Validate password
    final password = _passwordController.text;
    if (password.isEmpty) {
      _passwordError = 'Password is required';
      isValid = false;
    } else if (password.length < 6) {
      _passwordError = 'Password must be at least 6 characters';
      isValid = false;
    }

    setState(() {});
    return isValid;
  }

  /// Simulates a login process with different outcomes
  Future<void> _handleLogin() async {
    if (!_validateForm()) {
      AppSnackbar.error(context, message: 'Please fix the errors above');
      return;
    }

    setState(() => _isLoading = true);
    
    // Show loading feedback
    AppSnackbar.info(context, message: 'Signing you in...');

    // Simulate network delay
    await Future.delayed(const Duration(seconds: 2));

    setState(() => _isLoading = false);

    // Simulate different outcomes based on email
    final email = _emailController.text.toLowerCase();
    
    if (email.contains('error')) {
      // Simulate error scenario
      AppSnackbar.error(
        context,
        message: 'Login failed. Please check your credentials.',
      );
    } else if (email.contains('network')) {
      // Simulate network error
      AppSnackbar.error(
        context,
        message: 'Network error. Please check your connection and try again.',
      );
    } else {
      // Success scenario
      AppSnackbar.success(
        context,
        message: 'Welcome back! Login successful.',
      );
      
      // In a real app, you would navigate to the next screen here
    }
  }

  /// Simulates password reset
  Future<void> _handlePasswordReset() async {
    if (_emailController.text.isEmpty) {
      AppSnackbar.error(context, message: 'Please enter your email first');
      return;
    }

    AppSnackbar.info(context, message: 'Sending password reset email...');
    
    // Simulate delay
    await Future.delayed(const Duration(milliseconds: 1500));
    
    AppSnackbar.success(
      context,
      message: 'Password reset email sent. Check your inbox.',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Practical Feedback Example'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const AppText(
              'Login Form Demo',
              variant: AppTextVariant.headlineLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            const AppText(
              'Test different feedback scenarios:',
              variant: AppTextVariant.bodyLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            
            // Email field
            AppFormField(
              controller: _emailController,
              label: 'Email',
              hintText: 'Enter your email',
              keyboardType: TextInputType.emailAddress,
              errorText: _emailError,
              onChanged: (value) {
                // Clear error when user starts typing
                if (_emailError != null) {
                  setState(() => _emailError = null);
                }
              },
            ),
            
            const SizedBox(height: 16),
            
            // Password field
            AppFormField(
              controller: _passwordController,
              label: 'Password',
              hintText: 'Enter your password',
              obscureText: true,
              errorText: _passwordError,
              onChanged: (value) {
                // Clear error when user starts typing
                if (_passwordError != null) {
                  setState(() => _passwordError = null);
                }
              },
            ),
            
            const SizedBox(height: 32),
            
            // Login button
            AppButton(
              text: _isLoading ? 'Signing In...' : 'Sign In',
              onPressed: _isLoading ? null : _handleLogin,
              variant: AppButtonVariant.primary,
            ),
            
            const SizedBox(height: 16),
            
            // Password reset button
            AppButton(
              text: 'Forgot Password?',
              onPressed: _isLoading ? null : _handlePasswordReset,
              variant: AppButtonVariant.outline,
            ),
            
            const SizedBox(height: 32),
            
            // Instructions
            const AppText(
              'Test Scenarios:',
              variant: AppTextVariant.titleMedium,
            ),
            const SizedBox(height: 8),
            const AppText(
              '• Leave fields empty and tap Sign In → Error feedback\n'
              '• Use email with "error" → Login error\n'
              '• Use email with "network" → Network error\n'
              '• Use any other valid email → Success feedback\n'
              '• Tap "Forgot Password?" → Info then success feedback',
              variant: AppTextVariant.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}