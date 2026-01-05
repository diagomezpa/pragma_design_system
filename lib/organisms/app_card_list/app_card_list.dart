import 'package:flutter/material.dart';
import 'package:pragma_design_system/pragma_design_system.dart';

/// AppCardList - An organism for displaying a vertical list of cards with consistent spacing
///
/// This organism provides a structured way to display multiple cards in a vertical
/// layout with proper spacing, optional titles, and flexible scrolling behavior.
/// It combines design system components to create consistent card-based interfaces.
///
/// **Organism Responsibility:**
/// - Arranges multiple cards in a vertical layout
/// - Provides consistent spacing between cards
/// - Offers optional title and separator customization
/// - Handles both scrollable and non-scrollable layouts
/// - Maintains design system spacing and theming
///
/// **What this organism does NOT do:**
/// - Data fetching or API calls
/// - Empty state handling (use AppEmptyState separately)
/// - Business logic or state management
/// - Card content generation (cards should be pre-built)
/// - Navigation or routing logic
///
/// **Composition:**
/// Uses design system components:
/// - AppText for optional title display
/// - AppSpacer for consistent spacing
/// - AppDivider as default separator
/// - ListView.separated or Column for layout structure
///
/// **Usage Examples:**
/// ```dart
/// // Basic card list
/// AppCardList(
///   children: [
///     AppCard(child: Text('Card 1')),
///     AppCard(child: Text('Card 2')),
///     AppCard(child: Text('Card 3')),
///   ],
/// )
///
/// // Card list with title and custom separator
/// AppCardList(
///   title: 'Recent Items',
///   children: cardWidgets,
///   separator: AppSpacer(size: AppSpacerSize.large),
///   isScrollable: true,
/// )
///
/// // Scrollable card list with custom padding
/// AppCardList(
///   title: 'Product Categories',
///   children: productCards,
///   isScrollable: true,
///   padding: EdgeInsets.all(16.0),
///   scrollPhysics: BouncingScrollPhysics(),
/// )
/// ```
class AppCardList extends StatelessWidget {
  const AppCardList({
    super.key,
    this.title,
    required this.children,
    this.separator,
    this.padding,
    this.isScrollable = false,
    this.scrollPhysics,
    this.shrinkWrap = true,
  });

  /// Optional title displayed at the top of the card list
  final String? title;

  /// List of card widgets to display (typically AppCard instances)
  final List<Widget> children;

  /// Optional separator widget between cards (defaults to AppSpacer.medium)
  final Widget? separator;

  /// Optional padding around the entire card list
  final EdgeInsetsGeometry? padding;

  /// Whether the card list should be scrollable (uses ListView when true, Column when false)
  final bool isScrollable;

  /// Scroll physics for scrollable lists (only applies when isScrollable is true)
  final ScrollPhysics? scrollPhysics;

  /// Whether to wrap content in minimum space (only applies when isScrollable is true)
  final bool shrinkWrap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    // Default separator if none provided
    final effectiveSeparator = separator ?? const AppSpacer(size: AppSpacerSize.medium);

    return Container(
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Optional title
          if (title != null) ...[
            AppText(
              title!,
              variant: AppTextVariant.titleLarge,
              color: colorScheme.onSurface,
            ),
            const AppSpacer(size: AppSpacerSize.large),
          ],

          // Card list content
          if (isScrollable)
            _buildScrollableList(effectiveSeparator)
          else
            _buildStaticList(effectiveSeparator),
        ],
      ),
    );
  }

  /// Builds a scrollable ListView.separated for the cards
  Widget _buildScrollableList(Widget effectiveSeparator) {
    return ListView.separated(
      shrinkWrap: shrinkWrap,
      physics: scrollPhysics,
      itemCount: children.length,
      separatorBuilder: (context, index) => effectiveSeparator,
      itemBuilder: (context, index) => children[index],
    );
  }

  /// Builds a static Column for the cards when scrolling is disabled
  Widget _buildStaticList(Widget effectiveSeparator) {
    if (children.isEmpty) {
      return const SizedBox.shrink();
    }

    final List<Widget> separatedChildren = [];

    for (int i = 0; i < children.length; i++) {
      separatedChildren.add(children[i]);
      
      // Add separator between items (not after the last item)
      if (i < children.length - 1) {
        separatedChildren.add(effectiveSeparator);
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: separatedChildren,
    );
  }
}