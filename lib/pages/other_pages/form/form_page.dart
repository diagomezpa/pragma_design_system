import 'package:flutter/material.dart';
import 'package:pragma_design_system/pragma_design_system.dart';

/// FormPage - A concrete Page implementation demonstrating template usage.
///
/// This page represents the Page layer in Atomic Design methodology, which is
/// responsible for providing real data, state management, and business logic
/// to Templates. Pages are specific instances of Templates with actual content.
///
/// **Atomic Design Page Principles:**
/// - **Pages** are specific instances of templates with real representative content
/// - Pages provide data and state to templates without modifying template structure
/// - Business logic, form validation, and user interactions live at the Page level
/// - Templates remain pure and focused on layout and component arrangement
///
/// **Why Pages Own Form State:**
/// Form state management is a business concern that should not leak into templates.
/// Pages handle:
/// - TextEditingControllers for input management
/// - Form validation logic and error states
/// - Data submission and processing
/// - User interaction callbacks and navigation
///
/// **How This Differs From Templates:**
/// - Template (FormPageTemplate): Defines layout structure and component arrangement
/// - Page (FormPage): Provides real data, manages state, handles business logic
/// - Clear separation allows template reuse across different form contexts
///
/// **How This Scales For Real Apps:**
/// This pattern scales excellently because:
/// - Templates can be reused for different form types (signup, edit profile, settings)
/// - Business logic stays in Pages, making testing and maintenance easier
/// - State management can be upgraded (setState → Provider → Bloc) without touching templates
/// - Form validation can be centralized at the Page level
/// - Navigation and error handling remain consistent across form implementations
///
/// **Implementation Philosophy:**
/// - Page owns form controllers, validation, and submission logic
/// - Template (FormPageTemplate) owns layout and component arrangement
/// - Components (AppFormField, AppFormSection) remain stateless and reusable
/// - Clear separation of concerns between data/logic and presentation
class FormPage extends StatefulWidget {
  /// Creates a form page demonstrating template usage for account creation.
  const FormPage({super.key});

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  // Form controllers - Page level state management
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _fullNameController = TextEditingController();
  final _usernameController = TextEditingController();

  // Form validation state
  final _formKey = GlobalKey<FormState>();
  bool _isPasswordVisible = false;

  // Validation error state
  String? _emailError;
  String? _passwordError;
  String? _fullNameError;
  String? _usernameError;

  @override
  void dispose() {
    // Proper cleanup of controllers
    _emailController.dispose();
    _passwordController.dispose();
    _fullNameController.dispose();
    _usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Form Page Example'),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: FormPageTemplate(
          title: const AppText(
            'Create Account',
            variant: AppTextVariant.headlineSmall,
          ),
          sections: [
            _buildAccountInformationSection(),
            _buildProfileInformationSection(),
          ],
          primaryAction: AppButton(
            text: 'Create Account',
            onPressed: _handleSubmit,
            variant: AppButtonVariant.primary,
            size: AppButtonSize.large,
          ),
          secondaryAction: AppButton(
            text: 'Cancel',
            onPressed: _handleCancel,
            variant: AppButtonVariant.secondary,
            size: AppButtonSize.large,
          ),
        ),
      ),
    );
  }

  /// Builds the Account Information section with email and password fields
  Widget _buildAccountInformationSection() {
    return AppFormSection(
      title: 'Account Information',
      description: 'Set up your login credentials',
      children: [
        // Email field with validation
        AppFormField(
          label: 'Email',
          hintText: 'Enter your email address',
          controller: _emailController,
          keyboardType: TextInputType.emailAddress,
          prefixIcon: const AppIcon(Icons.email_outlined),
          helperText: 'We\'ll use this for account verification and login',
          errorText: _emailError,
          onChanged: _handleEmailChanged,
        ),
        const AppSpacer(size: AppSpacerSize.medium),

        // Password field with visibility toggle
        AppFormField(
          label: 'Password',
          hintText: 'Create a secure password',
          controller: _passwordController,
          obscureText: !_isPasswordVisible,
          prefixIcon: const AppIcon(Icons.lock_outline),
          suffixIcon: AppIcon(
            _isPasswordVisible ? Icons.visibility_off : Icons.visibility,
          ),
          helperText: 'Minimum 8 characters with letters and numbers',
          errorText: _passwordError,
          onChanged: _handlePasswordChanged,
        ),
      ],
    );
  }

  /// Builds the Profile Information section with name and username fields
  Widget _buildProfileInformationSection() {
    return AppFormSection(
      title: 'Profile Information',
      description: 'Tell us about yourself',
      children: [
        // Full Name field
        AppFormField(
          label: 'Full Name',
          hintText: 'Enter your full name',
          controller: _fullNameController,
          keyboardType: TextInputType.name,
          prefixIcon: const AppIcon(Icons.person_outline),
          helperText: 'This will be displayed on your profile',
          errorText: _fullNameError,
          onChanged: _handleFullNameChanged,
        ),
        const AppSpacer(size: AppSpacerSize.medium),

        // Username field
        AppFormField(
          label: 'Username',
          hintText: 'Choose a unique username',
          controller: _usernameController,
          keyboardType: TextInputType.text,
          prefixIcon: const AppIcon(Icons.alternate_email),
          helperText: 'This will be your unique identifier',
          errorText: _usernameError,
          onChanged: _handleUsernameChanged,
        ),
      ],
    );
  }

  // Form field change handlers with basic validation
  void _handleEmailChanged(String value) {
    setState(() {
      if (value.isEmpty) {
        _emailError = 'Email is required';
      } else if (!_isValidEmail(value)) {
        _emailError = 'Please enter a valid email address';
      } else {
        _emailError = null;
      }
    });
  }

  void _handlePasswordChanged(String value) {
    setState(() {
      if (value.isEmpty) {
        _passwordError = 'Password is required';
      } else if (value.length < 8) {
        _passwordError = 'Password must be at least 8 characters';
      } else if (!_isValidPassword(value)) {
        _passwordError = 'Password must contain letters and numbers';
      } else {
        _passwordError = null;
      }
    });
  }

  void _handleFullNameChanged(String value) {
    setState(() {
      if (value.isEmpty) {
        _fullNameError = 'Full name is required';
      } else if (value.trim().length < 2) {
        _fullNameError = 'Please enter a valid name';
      } else {
        _fullNameError = null;
      }
    });
  }

  void _handleUsernameChanged(String value) {
    setState(() {
      if (value.isEmpty) {
        _usernameError = 'Username is required';
      } else if (value.length < 3) {
        _usernameError = 'Username must be at least 3 characters';
      } else if (!_isValidUsername(value)) {
        _usernameError =
            'Username can only contain letters, numbers, and underscores';
      } else {
        _usernameError = null;
      }
    });
  }

  // Form submission handler - demonstrates Page-level business logic
  void _handleSubmit() {
    // Trigger validation for all fields
    _handleEmailChanged(_emailController.text);
    _handlePasswordChanged(_passwordController.text);
    _handleFullNameChanged(_fullNameController.text);
    _handleUsernameChanged(_usernameController.text);

    // Check if form is valid
    final hasErrors = _emailError != null ||
        _passwordError != null ||
        _fullNameError != null ||
        _usernameError != null;

    if (hasErrors) {
      _showErrorSnackBar('Please fix the errors before submitting');
      return;
    }

    // All validations passed - print form values (simulates API call)
    debugPrint('=== Form Submission ===');
    debugPrint('Email: ${_emailController.text}');
    debugPrint('Password: ${_passwordController.text}');
    debugPrint('Full Name: ${_fullNameController.text}');
    debugPrint('Username: ${_usernameController.text}');
    debugPrint('=====================');

    // Show success feedback
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Account created successfully!'),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 3),
      ),
    );

    // In a real app, you would:
    // 1. Make API call to create account
    // 2. Handle loading state
    // 3. Navigate to next screen on success
    // 4. Show proper error handling
  }

  /// Handles cancel action - demonstrates Page-level navigation logic
  void _handleCancel() {
    // Show confirmation if user has entered data
    final hasData = _emailController.text.isNotEmpty ||
        _passwordController.text.isNotEmpty ||
        _fullNameController.text.isNotEmpty ||
        _usernameController.text.isNotEmpty;

    if (hasData) {
      showDialog<void>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Discard Changes'),
          content: const Text('Are you sure you want to discard your changes?'),
          actions: [
            AppButton(
              onPressed: () => Navigator.of(context).pop(),
              text: 'Cancel',
              variant: AppButtonVariant.text,
              size: AppButtonSize.medium,
            ),
            AppButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
              text: 'Discard',
              variant: AppButtonVariant.text,
              size: AppButtonSize.medium,
            ),
          ],
        ),
      );
    } else {
      Navigator.of(context).pop();
    }
  }

  // Helper methods for validation - business logic at Page level
  bool _isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  bool _isValidPassword(String password) {
    // Must contain at least one letter and one number
    return RegExp(r'^(?=.*[A-Za-z])(?=.*\d)').hasMatch(password);
  }

  bool _isValidUsername(String username) {
    // Only letters, numbers, and underscores allowed
    return RegExp(r'^[a-zA-Z0-9_]+$').hasMatch(username);
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Theme.of(context).colorScheme.error,
        duration: const Duration(seconds: 3),
      ),
    );
  }
}
