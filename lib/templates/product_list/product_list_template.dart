import 'package:flutter/material.dart';

import '../../atoms/app_spacer.dart';
import '../../molecules/app_section/app_section.dart';
import '../../organisms/app_card_list/app_card_list.dart';

/// ProductListTemplate
///
/// A **template** that defines the structural layout for product listing pages.
/// This component operates at the Template layer of Atomic Design, composing
/// organisms and molecules to create consistent product list page structure
/// without any business logic, data fetching, or state management.
///
/// **IMPORTANT: This is a TEMPLATE, not a Page or Screen**
/// Templates define page structure and layout patterns. They are:
/// - Stateless and presentation-only
/// - Reusable across different product contexts
/// - Focused on layout composition, not data or business logic
/// - Independent of specific product types or business requirements
///
/// **Template vs Page/Screen:**
/// - Template: Layout structure with placeholder content areas for product listings
/// - Page/Screen: Complete implementation with data fetching, business logic, and navigation
///
/// **Atomic Design Level:**
/// Templates sit above organisms and below pages, focusing on:
/// - Content structure and hierarchy for product listings
/// - Spacing and layout relationships between product components
/// - Component composition patterns for consistent product displays
/// - Responsive layout behavior across different screen sizes
///
/// **When to use this template:**
/// - Building product catalog pages with consistent layout structure
/// - Creating reusable listing page layouts across different product types
/// - Defining page structure for e-commerce or marketplace screens
/// - When you need standardized product grid/list presentation
/// - Establishing consistent empty state handling for product lists
///
/// **When NOT to use this template:**
/// - For non-product listing pages (use appropriate domain templates)
/// - When you need complex business logic or data fetching (create a page/screen instead)
/// - For single product displays (use organisms like AppProductListItem directly)
/// - When layout requirements are completely different from this structure
/// - For simple lists that don't need section organization
///
/// **Template Structure:**
/// ```
/// AppSection (provides consistent section styling)
/// └── Child: Column
///     ├── Header (optional - titles, filters, actions)
///     ├── AppSpacer (conditional spacing)
///     └── Content Area:
///         ├── AppCardList (when products exist)
///         └── EmptyState (when no products and provided)
/// ```
///
/// **Usage Example:**
/// ```dart
/// ProductListTemplate(
///   header: AppText('Featured Products', variant: AppTextVariant.titleLarge),
///   products: [
///     AppProductListItem(title: 'Product 1', ...),
///     AppProductListItem(title: 'Product 2', ...),
///   ],
///   emptyState: AppEmptyStateSection(
///     title: 'No products found',
///     description: 'Try adjusting your search criteria.',
///   ),
/// )
/// ```
class ProductListTemplate extends StatelessWidget {
  /// Creates a product list template with configurable header and content areas.
  ///
  /// This constructor defines the structural layout for product listing pages
  /// without implementing any business logic, data fetching, or state management.
  /// All parameters are focused on layout composition and visual presentation.
  ///
  /// **Template Design Principles:**
  /// - Accepts pre-built widget components (organisms, molecules, atoms)
  /// - Defines spacing and layout relationships between product components
  /// - Remains agnostic to specific product types or business logic
  /// - Provides consistent layout patterns across different product implementations
  /// - Handles empty states gracefully with fallback options
  const ProductListTemplate({
    super.key,
    this.header,
    required this.products,
    this.emptyState,
  });

  /// Optional header widget displayed at the top of the product list template.
  ///
  /// **Template Role:** Provides a dedicated content area for list context and actions.
  /// **Common Usage:** AppText for titles, filter controls, or action buttons for list management.
  /// **Layout Impact:** When provided, adds medium vertical spacing below using AppSpacer.
  /// **Design Intent:** Establishes product list context and provides space for list-level controls.
  /// **Visual Hierarchy:** Positioned above product content for clear information hierarchy.
  ///
  /// **Examples:**
  /// ```dart
  /// // Simple title header
  /// header: AppText('Featured Products', variant: AppTextVariant.titleLarge)
  /// 
  /// // Complex header with actions
  /// header: Row(
  ///   mainAxisAlignment: MainAxisAlignment.spaceBetween,
  ///   children: [
  ///     AppText('Products', variant: AppTextVariant.titleLarge),
  ///     AppButton(text: 'Filter', onPressed: () {}),
  ///   ],
  /// )
  /// ```
  final Widget? header;

  /// Required list of product widgets arranged in a responsive grid/list layout.
  ///
  /// **Template Role:** Primary content area for product display components.
  /// **Expected Content:** AppProductListItem organisms or similar product representations.
  /// **Layout Behavior:** Passed directly to AppCardList for responsive grid rendering.
  /// **Design Intent:** Flexible product display supporting various product widget types.
  /// **Empty State:** When empty, triggers emptyState display if provided.
  /// **Template Agnosticism:** Accepts any Widget list for maximum reusability across product types.
  ///
  /// **Examples:**
  /// ```dart
  /// // Standard product list
  /// products: [
  ///   AppProductListItem(title: 'Product 1', price: '\$29.99', ...),
  ///   AppProductListItem(title: 'Product 2', price: '\$39.99', ...),
  /// ]
  /// 
  /// // Mixed product representations
  /// products: [
  ///   CustomProductCard(...),
  ///   ProductTileWidget(...),
  /// ]
  /// ```
  final List<Widget> products;

  /// Optional widget displayed when the products list is empty.
  ///
  /// **Template Role:** Defines empty state presentation for zero-product scenarios.
  /// **Common Usage:** AppEmptyStateSection organism with contextual messaging.
  /// **Layout Position:** Replaces AppCardList entirely when products.isEmpty is true.
  /// **Fallback Behavior:** If not provided, AppCardList handles empty state with default behavior.
  /// **Design Intent:** Provides meaningful feedback and potential user actions for empty lists.
  /// **User Experience:** Prevents blank screens and guides users toward productive actions.
  ///
  /// **Examples:**
  /// ```dart
  /// // Search results empty state
  /// emptyState: AppEmptyStateSection(
  ///   title: 'No products found',
  ///   description: 'Try adjusting your search criteria or browse categories.',
  ///   action: AppButton(text: 'Browse Categories', onPressed: () {}),
  /// )
  /// 
  /// // Catalog empty state
  /// emptyState: AppEmptyStateSection(
  ///   title: 'Coming Soon',
  ///   description: 'We\'re adding new products. Check back soon!',
  /// )
  /// ```
  final Widget? emptyState;

  @override
  Widget build(BuildContext context) {
    // AppSection provides consistent section styling and structure
    // Following design system patterns for sectioned content
    return AppSection(
      title: 'Products', // Default section title for accessibility and structure
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // Left-aligned content
        mainAxisSize: MainAxisSize.min, // Shrink to content size
        children: _buildTemplateContent(),
      ),
    );
  }

  /// Builds the template content with proper spacing and conditional rendering.
  ///
  /// **Layout Logic:**
  /// - Renders optional header with conditional spacing
  /// - Shows either emptyState or AppCardList based on products availability
  /// - Uses design system spacing tokens for visual consistency
  /// - Maintains clear visual hierarchy between header and content
  List<Widget> _buildTemplateContent() {
    return [
      // Optional header section with conditional spacing
      if (header != null) ...[
        header!, // Render the provided header widget
        AppSpacerFactory.mediumVertical(), // Consistent spacing between header and content
      ],

      // Main content area: empty state takes priority over empty product list
      if (products.isEmpty && emptyState != null)
        emptyState! // Show meaningful empty state when no products
      else
        AppCardList(
          children: products, // Delegate product layout to AppCardList organism
        ),
    ];
  }
}