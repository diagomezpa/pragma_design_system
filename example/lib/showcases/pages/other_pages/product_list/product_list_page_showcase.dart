import 'package:flutter/material.dart';
import 'package:pragma_design_system/pragma_design_system.dart';
import 'package:pragma_design_system/pages.dart';



/// ProductListPageShowcase - A showcase demonstrating Page layer implementation.
///
/// This showcase presents a real Page implementation to demonstrate how the
/// Page layer in Atomic Design differs from Templates. Unlike Template showcases
/// which focus on layout and component arrangement, Page showcases demonstrate
/// real data, state management, and user interactions.
///
/// Purpose of Page Showcases:
/// - **Validation**: Verify that Templates work correctly with real data and state
/// - **Documentation**: Show how Pages consume Templates in practice
/// - **Exploration**: Allow developers to interact with complete page implementations
/// - **Education**: Demonstrate the difference between Templates and Pages
///
/// Why Pages are showcased separately:
/// - Pages contain business logic and state that Templates should not have
/// - Pages provide real data while Templates focus on layout structure
/// - Page showcases demonstrate the complete user experience
/// - Templates are pure and stateless, Pages are stateful and interactive
///
/// Atomic Design Validation:
/// - Confirms Templates can be consumed without modification
/// - Validates separation of concerns between layout and logic
/// - Demonstrates the template → page composition pattern
/// - Shows how state and data flow through the component hierarchy
class ProductListPageShowcase extends StatelessWidget {
  /// Creates a showcase for the ProductListPage implementation.
  const ProductListPageShowcase({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product List Page Showcase'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Showcase title and description
            const AppText(
              'Page Layer Demonstration',
              variant: AppTextVariant.titleLarge,
            ),
            const SizedBox(height: 16),
            const AppText(
              'This showcase presents a complete Page implementation that demonstrates how the Page layer consumes Templates in practice. Pages provide real data, state management, and business logic while Templates focus purely on layout structure.',
              variant: AppTextVariant.bodyMedium,
            ),
            const SizedBox(height: 12),
            const AppText(
              'Key Page Characteristics:',
              variant: AppTextVariant.titleMedium,
            ),
            const SizedBox(height: 8),
            const AppText(
              '• Contains state management (toggle between populated/empty)\n'
              '• Provides real data to Template components\n'
              '• Handles user interactions and business logic\n'
              '• Consumes ProductListTemplate without modification\n'
              '• Demonstrates template → page composition pattern',
              variant: AppTextVariant.bodySmall,
            ),
            const SizedBox(height: 24),
            
            // Visual separator
            Container(
              height: 1,
              color: Theme.of(context).colorScheme.outline.withOpacity(0.2),
            ),
            const SizedBox(height: 24),
            
            // Interactive page demonstration
            const AppText(
              'Interactive Page Example',
              variant: AppTextVariant.titleMedium,
            ),
            const SizedBox(height: 8),
            const AppText(
              'Use the toggle button in the AppBar to switch between populated and empty states. This demonstrates how Pages manage state while Templates remain pure.',
              variant: AppTextVariant.bodySmall,
            ),
            const SizedBox(height: 16),
            
            // Embedded ProductListPage in a container to provide clear boundaries
            Container(
              height: 600, // Fixed height to contain the page
              decoration: BoxDecoration(
                border: Border.all(
                  color: Theme.of(context).colorScheme.outline.withOpacity(0.2),
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: const ProductListPage(),
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Additional context
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.3),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    'Architecture Notes',
                    variant: AppTextVariant.titleSmall,
                  ),
                  SizedBox(height: 8),
                  AppText(
                    'This Page demonstrates the clear separation between Templates (layout) and Pages (data + logic). The ProductListTemplate remains completely unaware of the data source or state management, while the ProductListPage provides all the necessary data and handles user interactions.',
                    variant: AppTextVariant.bodySmall,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}