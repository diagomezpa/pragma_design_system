import 'package:flutter/material.dart';

import '../../atoms/app_button/app_button.dart';
import '../../atoms/app_icon/app_icon.dart';
import '../../atoms/app_spacer/app_spacer.dart';
import '../../atoms/app_text/app_text.dart';
import '../../molecules/form_field/app_form_field.dart';
import '../../organisms/app_form_section/app_form_section.dart';
import 'form_page_template.dart';

/// FormPageTemplateShowcase
///
/// **Living Documentation and Educational Showcase**
///
/// A comprehensive demonstration of FormPageTemplate usage across different
/// real-world form scenarios. This showcase serves multiple purposes:
///
/// **Educational Goals:**
/// - Demonstrates proper template usage patterns
/// - Shows how to compose organisms and atoms within the template
/// - Illustrates spacing, hierarchy, and visual design principles
/// - Provides copy-paste examples for common form layouts
///
/// **Template Validation:**
/// - Validates template flexibility across different form complexities
/// - Tests responsive behavior and layout adaptation
/// - Ensures consistent spacing and visual hierarchy
/// - Demonstrates integration with the broader design system
///
/// **Showcase Scenarios:**
/// 1. **Simple Form** - Basic single-section form with minimal complexity
/// 2. **Multi-Section Form** - Complex form with logical section grouping
/// 3. **Validation States** - Form fields with error, helper, and disabled states
///
/// **Design System Integration:**
/// - Uses only existing design system components
/// - Demonstrates proper atom/molecule/organism composition
/// - Shows Material 3 theming and accessibility patterns
/// - Maintains consistent spacing using AppSpacer tokens
///
/// **For Developers:**
/// - Copy examples directly into your applications
/// - Understand when and how to use FormPageTemplate
/// - Learn proper form section organization patterns
/// - See action button hierarchy and styling conventions
class FormPageTemplateShowcase extends StatelessWidget {
  const FormPageTemplateShowcase({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AppText(
          'FormPageTemplate Showcase',
          variant: AppTextVariant.titleLarge,
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // SCENARIO 1: Foundation Pattern - Simple Form
          // Educational Focus: Basic template usage with minimal complexity
          // Design Decisions: Single section, primary action only, clear hierarchy
          _buildShowcaseSection(
            context,
            title: '1. Foundation Pattern - Simple Single Section Form',
            description: 'Demonstrates basic template usage with minimal complexity. Shows proper organism composition and action hierarchy for straightforward user flows like account creation.',
            child: FormPageTemplate(
              // Page title establishes context and visual hierarchy
              title: const AppText(
                'Sign Up',
                variant: AppTextVariant.headlineSmall,
              ),
              sections: [
                // Single AppFormSection organism containing related fields
                AppFormSection(
                  title: 'Account Information',
                  description: 'Create your account to get started',
                  children: [
                    // Email field with semantic icon and proper keyboard type
                    AppFormField(
                      label: 'Email Address',
                      hintText: 'Enter your email',
                      keyboardType: TextInputType.emailAddress,
                      prefixIcon: const AppIcon(Icons.email_outlined),
                      onChanged: (value) => debugPrint('Email: $value'),
                    ),
                    AppSpacerFactory.mediumVertical(), // Consistent field spacing
                    
                    // Password field with security considerations
                    AppFormField(
                      label: 'Password',
                      hintText: 'Create a strong password',
                      obscureText: true, // Security: hide password input
                      prefixIcon: const AppIcon(Icons.lock_outline),
                      helperText: 'Password must be at least 8 characters', // User guidance
                      onChanged: (value) => debugPrint('Password: $value'),
                    ),
                    AppSpacerFactory.mediumVertical(),
                    
                    // Confirmation field following security best practices
                    AppFormField(
                      label: 'Confirm Password',
                      hintText: 'Confirm your password',
                      obscureText: true,
                      prefixIcon: const AppIcon(Icons.lock_outline),
                      onChanged: (value) => debugPrint('Confirm Password: $value'),
                    ),
                  ],
                ),
              ],
              // Primary action only - simple, clear call-to-action
              primaryAction: AppButton(
                text: 'Create Account',
                onPressed: () => debugPrint('Create Account tapped'),
                variant: AppButtonVariant.primary, // Prominent primary action
                size: AppButtonSize.large, // Touch-friendly size
              ),
              // No secondary action - keeps interface focused
            ),
          ),

          AppSpacerFactory.hugeVertical(),

          // SCENARIO 2: Complex Composition - Multi-Section Form
          // Educational Focus: Section organization, logical grouping, action hierarchy
          // Design Decisions: Multiple sections, both actions, responsive field layout
          _buildShowcaseSection(
            context,
            title: '2. Complex Composition - Multi-Section Form',
            description: 'Demonstrates advanced template usage with logical section grouping, responsive field layouts, and dual-action hierarchy. Shows how to organize complex forms for better user experience.',
            child: FormPageTemplate(
              // Descriptive title for complex multi-step process
              title: const AppText(
                'Complete Your Profile',
                variant: AppTextVariant.headlineSmall,
              ),
              sections: [
                // SECTION 1: Personal Information
                // Groups identity-related fields for logical organization
                AppFormSection(
                  title: 'Personal Information',
                  description: 'Tell us about yourself',
                  children: [
                    // Name fields using consistent iconography
                    AppFormField(
                      label: 'First Name',
                      hintText: 'Enter your first name',
                      prefixIcon: const AppIcon(Icons.person_outline),
                      onChanged: (value) => debugPrint('First Name: $value'),
                    ),
                    AppSpacerFactory.mediumVertical(),
                    AppFormField(
                      label: 'Last Name',
                      hintText: 'Enter your last name',
                      prefixIcon: const AppIcon(Icons.person_outline),
                      onChanged: (value) => debugPrint('Last Name: $value'),
                    ),
                    AppSpacerFactory.mediumVertical(),
                    
                    // Contact information with validation guidance
                    AppFormField(
                      label: 'Phone Number',
                      hintText: '+1 (555) 123-4567',
                      keyboardType: TextInputType.phone, // Optimized keyboard
                      prefixIcon: const AppIcon(Icons.phone_outlined),
                      helperText: 'We\'ll use this for account verification', // Clear purpose
                      onChanged: (value) => debugPrint('Phone: $value'),
                    ),
                  ],
                ),

                // SECTION 2: Address Information
                // Demonstrates responsive field layout with Row/Expanded pattern
                AppFormSection(
                  title: 'Address Information',
                  description: 'Where can we reach you?',
                  children: [
                    // Full-width address field
                    AppFormField(
                      label: 'Street Address',
                      hintText: '123 Main Street',
                      prefixIcon: const AppIcon(Icons.home_outlined),
                      onChanged: (value) => debugPrint('Address: $value'),
                    ),
                    AppSpacerFactory.mediumVertical(),
                    
                    // Responsive layout: City takes more space than State
                    Row(
                      children: [
                        Expanded(
                          flex: 2, // City gets 2/3 of available width
                          child: AppFormField(
                            label: 'City',
                            hintText: 'New York',
                            onChanged: (value) => debugPrint('City: $value'),
                          ),
                        ),
                        AppSpacerFactory.mediumHorizontal(), // Horizontal spacing
                        Expanded(
                          child: AppFormField( // State gets 1/3 of available width
                            label: 'State',
                            hintText: 'NY',
                            onChanged: (value) => debugPrint('State: $value'),
                          ),
                        ),
                      ],
                    ),
                    AppSpacerFactory.mediumVertical(),
                    
                    // ZIP code with numeric keyboard optimization
                    AppFormField(
                      label: 'ZIP Code',
                      hintText: '10001',
                      keyboardType: TextInputType.number, // Numeric input
                      prefixIcon: const AppIcon(Icons.location_on_outlined),
                      onChanged: (value) => debugPrint('ZIP: $value'),
                    ),
                  ],
                ),

                // SECTION 3: Preferences
                // Shows multiline input and optional field patterns
                AppFormSection(
                  title: 'Preferences',
                  description: 'Customize your experience',
                  children: [
                    // Multiline text field for longer content
                    AppFormField(
                      label: 'Bio',
                      hintText: 'Tell us about yourself (optional)',
                      maxLines: 3, // Allows multiple lines of input
                      helperText: 'This will be visible on your profile', // Privacy context
                      onChanged: (value) => debugPrint('Bio: $value'),
                    ),
                  ],
                ),
              ],
              // Dual action pattern: Primary and secondary actions
              primaryAction: AppButton(
                text: 'Save Profile',
                onPressed: () => debugPrint('Save Profile tapped'),
                variant: AppButtonVariant.primary, // Prominent completion action
                size: AppButtonSize.large,
              ),
              secondaryAction: AppButton(
                text: 'Save as Draft',
                onPressed: () => debugPrint('Save as Draft tapped'),
                variant: AppButtonVariant.outline, // Less prominent alternative
                size: AppButtonSize.large,
              ),
            ),
          ),

          AppSpacerFactory.hugeVertical(),

          // SCENARIO 3: State Management - Form Validation and Accessibility
          // Educational Focus: Field states, error handling, accessibility patterns
          // Design Decisions: Error states, helper text, disabled fields, diverse action styles
          _buildShowcaseSection(
            context,
            title: '3. State Management - Validation and Accessibility Patterns',
            description: 'Demonstrates form field states including validation errors, helper text, and disabled states. Shows accessibility considerations and diverse action button styling patterns.',
            child: FormPageTemplate(
              // Settings context - different from creation flows
              title: const AppText(
                'Contact Settings',
                variant: AppTextVariant.headlineSmall,
              ),
              sections: [
                AppFormSection(
                  title: 'Contact Preferences',
                  description: 'How would you like us to contact you?',
                  children: [
                    // ERROR STATE EXAMPLE: Shows validation failure
                    AppFormField(
                      label: 'Email Address',
                      hintText: 'your.email@example.com',
                      initialValue: 'invalid-email', // Pre-filled invalid data
                      keyboardType: TextInputType.emailAddress,
                      prefixIcon: const AppIcon(Icons.email_outlined),
                      errorText: 'Please enter a valid email address', // Error overrides helper
                      onChanged: (value) => debugPrint('Email: $value'),
                    ),
                    AppSpacerFactory.mediumVertical(),
                    
                    // HELPER STATE EXAMPLE: Provides user guidance
                    AppFormField(
                      label: 'Phone Number',
                      hintText: '+1 (555) 123-4567',
                      keyboardType: TextInputType.phone,
                      prefixIcon: const AppIcon(Icons.phone_outlined),
                      helperText: 'Used for important account notifications only', // Clear usage context
                      onChanged: (value) => debugPrint('Phone: $value'),
                    ),
                    AppSpacerFactory.mediumVertical(),
                    
                    // DISABLED STATE EXAMPLE: Shows unavailable functionality
                    AppFormField(
                      label: 'Company (Optional)',
                      hintText: 'Your company name',
                      prefixIcon: const AppIcon(Icons.business_outlined),
                      enabled: false, // Disabled state for unavailable features
                      initialValue: 'Feature coming soon', // Explanatory placeholder
                      helperText: 'This field will be available in the next update', // Status communication
                      onChanged: (value) => debugPrint('Company: $value'),
                    ),
                  ],
                ),
              ],
              // Primary action for main flow completion
              primaryAction: AppButton(
                text: 'Update Settings',
                onPressed: () => debugPrint('Update Settings tapped'),
                variant: AppButtonVariant.primary, // Standard primary styling
                size: AppButtonSize.large,
              ),
              // Secondary action with text variant - minimal visual weight
              secondaryAction: AppButton(
                text: 'Cancel Changes',
                onPressed: () => debugPrint('Cancel tapped'),
                variant: AppButtonVariant.text, // Minimal cancel action
                size: AppButtonSize.large,
              ),
            ),
          ),

          // Extra spacing at bottom
          AppSpacerFactory.extraLargeVertical(),
        ],
      ),
    );
  }

  /// Builds a visually consistent showcase section with educational context.
  ///
  /// **Design System Role:**
  /// Creates a standardized container for each template demonstration with:
  /// - Clear section identification (title with primary color)
  /// - Educational description explaining design decisions
  /// - Visual separation through bordered containers
  /// - Consistent spacing using design system tokens
  ///
  /// **Educational Purpose:**
  /// Each section serves as a self-contained lesson showing:
  /// - When to use specific template patterns
  /// - How different components compose together
  /// - Visual hierarchy and spacing relationships
  /// - Real-world usage scenarios
  Widget _buildShowcaseSection(
    BuildContext context, {
    required String title,
    required String description,
    required Widget child,
  }) {
    final theme = Theme.of(context);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section title
        AppText(
          title,
          variant: AppTextVariant.titleMedium,
          color: theme.colorScheme.primary,
        ),
        
        AppSpacerFactory.extraSmallVertical(),
        
        // Section description explaining what this demonstrates
        AppText(
          description,
          variant: AppTextVariant.bodySmall,
          color: theme.colorScheme.onSurfaceVariant,
        ),
        
        AppSpacerFactory.mediumVertical(),
        
        // Template showcase wrapped in a visual container
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(
              color: theme.colorScheme.outline.withOpacity(0.2),
            ),
            borderRadius: BorderRadius.circular(12),
            color: theme.colorScheme.surface.withOpacity(0.5),
          ),
          padding: const EdgeInsets.all(16),
          child: child,
        ),
      ],
    );
  }
}