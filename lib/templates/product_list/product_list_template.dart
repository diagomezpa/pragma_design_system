import 'package:flutter/material.dart';

import '../../atoms/app_spacer.dart';
import '../../molecules/app_section/app_section.dart';
import '../../organisms/app_card_list/app_card_list.dart';

/// ProductListTemplate
///
/// A template that defines the structural layout for product listing pages.
/// This template composes organisms and molecules to create a consistent
/// page structure without containing any business logic or data management.
///
/// **What is a template:**
/// In Atomic Design, templates are page-level objects that place components
/// into a layout and articulate the design's underlying content structure.
/// They focus on the page's content structure rather than the content itself.
///
/// **When to use:**
/// - Building product catalog pages
/// - Creating consistent listing page layouts
/// - Defining page structure for e-commerce screens
/// - When you need a reusable product grid/list layout
///
/// **When NOT to use:**
/// - For non-product listing pages (use appropriate domain templates)
/// - When you need complex business logic (create a page/screen instead)
/// - For single product displays (use organisms directly)
/// - When layout requirements are completely different from this structure
///
/// **Template Structure:**
/// ```
/// AppSection
/// └── Child: Column
///     ├── Header (optional)
///     ├── AppSpacer (if header exists)
///     └── AppCardList OR EmptyState
/// ```
///
/// Example:
/// ```dart
/// ProductListTemplate(
///   header: AppText('Featured Products', variant: AppTextVariant.titleLarge),
///   products: [
///     AppProductListItem(...),
///     AppProductListItem(...),
///   ],
///   emptyState: AppEmptyStateSection(
///     title: 'No products found',
///     description: 'Try adjusting your search criteria.',
///   ),
/// )
/// ```
class ProductListTemplate extends StatelessWidget {
  const ProductListTemplate({
    super.key,
    this.header,
    required this.products,
    this.emptyState,
  });

  /// Optional header widget displayed at the top of the template.
  /// Commonly contains titles, filters, or action buttons.
  final Widget? header;

  /// List of product widgets to display in the grid/list.
  /// Typically contains AppProductListItem widgets or similar product
  /// representations. The template remains agnostic to the specific
  /// widget types for maximum flexibility.
  final List<Widget> products;

  /// Optional widget to display when the products list is empty.
  /// If not provided and products is empty, the AppCardList will
  /// handle the empty state using its default behavior.
  final Widget? emptyState;

  @override
  Widget build(BuildContext context) {
    return AppSection(
      title: 'Products', // Default title for section structure
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Optional header section
          if (header != null) ...[
            header!,
            AppSpacerFactory.mediumVertical(),
          ],

          // Main content: either products list or empty state
          if (products.isEmpty && emptyState != null)
            emptyState!
          else
            AppCardList(
              children: products,
            ),
        ],
      ),
    );
  }
}