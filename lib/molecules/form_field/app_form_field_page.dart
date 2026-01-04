import 'package:flutter/material.dart';
import 'package:pragma_design_system/pragma_design_system.dart';

/// ShowcasePage - Demonstrates various `AppFormField` variants.
///
/// This page is part of the example app and intentionally keeps presentation
/// logic only — no business or validation logic is added to `AppFormField`.
class ShowcasePage extends StatefulWidget {
  const ShowcasePage({super.key});

  @override
  State<ShowcasePage> createState() => _ShowcasePageState();
}

class _ShowcasePageState extends State<ShowcasePage> {
  // Controllers for fields that require programmatic access
  final TextEditingController _defaultController = TextEditingController();
  final TextEditingController _helperController = TextEditingController();
  final TextEditingController _errorController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _iconsController = TextEditingController();

  // Simulate an error state for the error variant
  bool _showError = true;

  @override
  void dispose() {
    _defaultController.dispose();
    _helperController.dispose();
    _errorController.dispose();
    _passwordController.dispose();
    _iconsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AppFormField Showcase'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // Section: Default field (label + hint)
          const AppText('Default', variant: AppTextVariant.titleLarge),
          const SizedBox(height: 8),
          // Default field demonstrates a simple label and hint
          AppFormField(
            label: 'Name',
            hintText: 'Enter your full name',
            controller: _defaultController,
            onChanged: (v) {},
          ),

          const SizedBox(height: 24),

          // Section: Field with helper text
          const AppText('With Helper Text', variant: AppTextVariant.titleLarge),
          const SizedBox(height: 8),
          // Helper text shows additional guidance below the field
          AppFormField(
            label: 'Email',
            hintText: 'name@example.com',
            helperText: 'We will never share your email.',
            controller: _helperController,
            keyboardType: TextInputType.emailAddress,
            onChanged: (v) {},
          ),

          const SizedBox(height: 24),

          // Section: Field with error text (simulation)
          const AppText('Error State (simulated)',
              variant: AppTextVariant.titleLarge),
          const SizedBox(height: 8),
          // Error text overrides helper text. We toggle error simulation with a button.
          AppFormField(
            label: 'Username',
            hintText: 'Choose a username',
            helperText: 'Must be unique',
            errorText: _showError ? 'Username already taken' : null,
            controller: _errorController,
            onChanged: (v) {},
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              ElevatedButton(
                onPressed: () => setState(() => _showError = !_showError),
                child: Text(_showError ? 'Clear Error' : 'Simulate Error'),
              ),
              const SizedBox(width: 12),
              // Show current value for demonstration purposes
              Text('Value: ${_errorController.text}'),
            ],
          ),

          const SizedBox(height: 24),

          // Section: Password field using obscureText
          const AppText('Password Field', variant: AppTextVariant.titleLarge),
          const SizedBox(height: 8),
          // Obscure text is used for passwords; controller used to access value
          AppFormField(
            label: 'Password',
            hintText: 'Enter your password',
            obscureText: true,
            controller: _passwordController,
            onChanged: (v) {},
          ),

          const SizedBox(height: 24),

          // Section: Field with prefix and suffix icons
          const AppText('With Prefix & Suffix Icons',
              variant: AppTextVariant.titleLarge),
          const SizedBox(height: 8),
          // Demonstrates how to pass AppIcon atoms as prefix and suffix
          AppFormField(
            label: 'Search',
            hintText: 'Search products',
            prefixIcon:
                AppIcon.search(onTap: () => debugPrint('Search prefix tapped')),
            suffixIcon: AppIcon.close(onTap: () => _iconsController.clear()),
            controller: _iconsController,
            onChanged: (v) {},
          ),

          const SizedBox(height: 40),

          // Footer note
          AppText('End of showcase', variant: AppTextVariant.bodySmall),
        ],
      ),
    );
  }
}
