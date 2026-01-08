import 'package:flutter/material.dart';
import 'package:pragma_design_system/pragma_design_system.dart';
import 'package:pragma_design_system/pages/other_pages/form/form_page.dart';

/// FormPageShowcase - Demonstrates a real Page implementation in action.
///
/// This showcase serves as **living documentation** for the Page layer in
/// Atomic Design methodology. Unlike component showcases that demonstrate
/// isolated widgets, this showcase embeds a complete, interactive Page
/// to demonstrate real-world form state management and business logic.
///
/// **Why Pages Are Showcased Separately:**
/// Pages represent the highest level of Atomic Design and require different
/// demonstration approaches than lower-level components:
///
/// - **Components (Atoms/Molecules)**: Showcased in isolation with various states
/// - **Organisms**: Showcased with mock data to show composition patterns
/// - **Templates**: Showcased with placeholder content to show layout structure
/// - **Pages**: Showcased as complete, interactive implementations with real logic
///
/// **How This Demonstrates Atomic Design Maturity:**
/// This showcase validates the entire design system hierarchy working together:
///
/// 1. **Atoms** (AppText, AppIcon, AppSpacer) provide consistent visual building blocks
/// 2. **Molecules** (AppFormField) compose atoms into reusable input components
/// 3. **Organisms** (AppFormSection) group molecules into logical form sections
/// 4. **Templates** (FormPageTemplate) define page structure and layout patterns
/// 5. **Pages** (FormPage) provide real data, state management, and business logic
///
/// The fact that you can interact with a fully functional form demonstrates
/// that all layers work harmoniously without tight coupling, proving the
/// design system's architectural soundness.
///
/// **Educational Value:**
/// By experiencing a real Page in action, developers understand:
/// - How state management works at the Page level
/// - Why business logic stays separate from presentation components
/// - How Templates enable consistent layouts across different contexts
/// - The scalability benefits of proper separation of concerns
class FormPageShowcase extends StatelessWidget {
  /// Creates a showcase demonstrating real Page implementation and interaction patterns.
  const FormPageShowcase({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Form Page Showcase'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Page title
            const AppText(
              'Form Page Implementation',
              variant: AppTextVariant.titleLarge,
            ),

            const SizedBox(height: 16),

            // Educational description explaining Page vs Template responsibilities
            _buildPageDescription(context),

            const SizedBox(height: 32),

            // Visual separator
            Container(
              width: double.infinity,
              height: 1,
              color: Theme.of(context).colorScheme.outlineVariant,
            ),

            const SizedBox(height: 24),

            // Interactive form section header
            AppText(
              'Interactive Form Demo',
              variant: AppTextVariant.titleMedium,
              color: Theme.of(context).colorScheme.primary,
            ),

            const SizedBox(height: 8),

            AppText(
              'Try the form below to experience real Page-level state management, validation, and business logic in action.',
              variant: AppTextVariant.bodyMedium,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),

            const SizedBox(height: 24),

            // Embedded FormPage - fully interactive and functional
            // This demonstrates the complete Page implementation without modification
            _buildEmbeddedFormPage(),
          ],
        ),
      ),
    );
  }

  /// Builds the educational description explaining Page responsibilities and architecture.
  Widget _buildPageDescription(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colorScheme.surfaceVariant.withOpacity(0.3),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: colorScheme.outlineVariant,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(
            'About Pages in Atomic Design',
            variant: AppTextVariant.titleMedium,
            color: colorScheme.primary,
          ),
          const SizedBox(height: 12),
          AppText(
            'This is a Page - the highest level in Atomic Design methodology. '
            'Pages are complete, functional implementations that demonstrate '
            'how all design system components work together.',
            variant: AppTextVariant.bodyMedium,
            color: colorScheme.onSurfaceVariant,
          ),
          const SizedBox(height: 16),
          _buildResponsibilityItem(
            context,
            'State Management',
            'Form controllers, validation logic, and user interaction state live at the Page level.',
          ),
          const SizedBox(height: 12),
          _buildResponsibilityItem(
            context,
            'Business Logic',
            'Form submission, validation rules, and error handling are Page responsibilities.',
          ),
          const SizedBox(height: 12),
          _buildResponsibilityItem(
            context,
            'Template Integration',
            'Pages use Templates for layout structure while providing real data and functionality.',
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: colorScheme.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.info_outline,
                  size: 20,
                  color: colorScheme.primary,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: AppText(
                    'The form below is a real, interactive implementation. '
                    'Try filling it out to experience genuine form validation and state management.',
                    variant: AppTextVariant.bodySmall,
                    color: colorScheme.primary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Builds individual responsibility explanation items with consistent styling.
  Widget _buildResponsibilityItem(
    BuildContext context,
    String title,
    String description,
  ) {
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 2),
          width: 6,
          height: 6,
          decoration: BoxDecoration(
            color: colorScheme.primary,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(
                title,
                variant: AppTextVariant.labelLarge,
                color: colorScheme.onSurface,
              ),
              const SizedBox(height: 4),
              AppText(
                description,
                variant: AppTextVariant.bodySmall,
                color: colorScheme.onSurfaceVariant,
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// Builds the embedded FormPage with visual container styling.
  ///
  /// The FormPage is embedded without any modifications to demonstrate
  /// that it works as a complete, standalone implementation. This approach
  /// shows the real Page in action rather than creating a simplified demo.
  ///
  /// Note: The FormPage is constrained to a specific height to prevent
  /// infinite layout constraints when embedding a Scaffold within a scrollable container.
  Widget _buildEmbeddedFormPage() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.grey.withOpacity(0.2),
          width: 1,
        ),
      ),
      // ClipRRect ensures the FormPage content respects the container boundaries
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        // Constrain height to prevent infinite layout issues when embedding Scaffold
        child: SizedBox(
          height: 800, // Fixed height to contain the full form experience
          child: const FormPage(),
        ),
      ),
    );
  }
}
