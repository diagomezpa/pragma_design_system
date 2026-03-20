import 'package:flutter/material.dart';
import 'package:pragma_design_system/pragma_design_system.dart';

/// AppFormSectionShowcase - Demuestra varias variantes de `AppFormSection`.
///
/// Esta página muestra diferentes configuraciones y casos de uso del organismo AppFormSection.
/// Demuestra cómo puede usarse para estructurar formularios con espaciado adecuado,
/// títulos, descripciones y separación visual.
class AppFormSectionShowcase extends StatelessWidget {
  const AppFormSectionShowcase({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AppFormSection Showcase'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // Demo Section 1: Basic form section
          const AppText(
            'Basic Form Section',
            variant: AppTextVariant.titleLarge,
          ),
          const SizedBox(height: 8),
          // Simple form section with title and two basic fields
          AppFormSection(
            title: 'Personal Information',
            children: [
              AppFormField(
                label: 'First Name',
                hintText: 'Enter your first name',
              ),
              const AppSpacer(size: AppSpacerSize.medium),
              AppFormField(
                label: 'Last Name',
                hintText: 'Enter your last name',
              ),
            ],
          ),

          const SizedBox(height: 32),

          // Demo Section 2: Section with description
          const AppText(
            'Section with Description',
            variant: AppTextVariant.titleLarge,
          ),
          const SizedBox(height: 8),
          // Form section with descriptive text to guide users
          AppFormSection(
            title: 'Account Settings',
            description: 'Configure your account preferences and security settings. These changes will be applied immediately.',
            children: [
              AppFormField(
                label: 'Email Address',
                hintText: 'your.email@example.com',
              ),
              const AppSpacer(size: AppSpacerSize.medium),
              AppFormField(
                label: 'Current Password',
                hintText: 'Enter your current password',
                obscureText: true,
              ),
              const AppSpacer(size: AppSpacerSize.medium),
              AppFormField(
                label: 'New Password',
                hintText: 'Enter a new password',
                obscureText: true,
              ),
            ],
          ),

          const SizedBox(height: 32),

          // Demo Section 3: Section with many fields (long form)
          const AppText(
            'Section with Multiple Fields',
            variant: AppTextVariant.titleLarge,
          ),
          const SizedBox(height: 8),
          // Longer form section demonstrating handling of multiple fields
          AppFormSection(
            title: 'Shipping Address',
            description: 'Please provide a complete shipping address for your order delivery.',
            children: [
              AppFormField(
                label: 'Street Address',
                hintText: '123 Main Street',
              ),
              const AppSpacer(size: AppSpacerSize.medium),
              Row(
                children: [
                  Expanded(
                    child: AppFormField(
                      label: 'City',
                      hintText: 'City name',
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: AppFormField(
                      label: 'State',
                      hintText: 'State/Province',
                    ),
                  ),
                ],
              ),
              const AppSpacer(size: AppSpacerSize.medium),
              Row(
                children: [
                  Expanded(
                    child: AppFormField(
                      label: 'ZIP Code',
                      hintText: '12345',
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: AppFormField(
                      label: 'Country',
                      hintText: 'Country name',
                    ),
                  ),
                ],
              ),
              const AppSpacer(size: AppSpacerSize.medium),
              AppFormField(
                label: 'Delivery Instructions',
                hintText: 'Special delivery notes (optional)',
                maxLines: 3,
              ),
            ],
          ),

          const SizedBox(height: 32),

          // Demo Section 4: Section with divider
          const AppText(
            'Section with Divider',
            variant: AppTextVariant.titleLarge,
          ),
          const SizedBox(height: 8),
          // Form section with divider for visual separation
          AppFormSection(
            title: 'Billing Information',
            description: 'Enter your payment and billing details below.',
            showDivider: true,
            children: [
              AppFormField(
                label: 'Card Number',
                hintText: '1234 5678 9012 3456',
              ),
              const AppSpacer(size: AppSpacerSize.medium),
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: AppFormField(
                      label: 'Expiry Date',
                      hintText: 'MM/YY',
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: AppFormField(
                      label: 'CVV',
                      hintText: '123',
                    ),
                  ),
                ],
              ),
              const AppSpacer(size: AppSpacerSize.medium),
              AppFormField(
                label: 'Cardholder Name',
                hintText: 'Name as it appears on card',
              ),
            ],
          ),

          const SizedBox(height: 24),

          // Demo Section 5: Section with custom padding
          const AppText(
            'Section with Custom Padding',
            variant: AppTextVariant.titleLarge,
          ),
          const SizedBox(height: 8),
          // Form section with custom padding to show flexibility
          AppFormSection(
            title: 'Preferences',
            padding: const EdgeInsets.all(20),
            children: [
              AppFormField(
                label: 'Notification Preferences',
                hintText: 'Email, SMS, Push notifications',
              ),
              const AppSpacer(size: AppSpacerSize.medium),
              AppFormField(
                label: 'Language',
                hintText: 'Select your preferred language',
              ),
            ],
          ),

          const SizedBox(height: 40),

          // Footer note
          AppText(
            'All sections demonstrate different AppFormSection configurations for various form layouts',
            variant: AppTextVariant.bodySmall,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}