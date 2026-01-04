/// AppSpacing - Consistent spacing tokens for the design system
///
/// This class provides a centralized spacing system that eliminates magic numbers
/// and ensures visual consistency across all components and layouts. By defining
/// semantic spacing tokens, we create a predictable rhythm and hierarchy that
/// enhances the user experience.
///
/// **Why Spacing Tokens Matter:**
/// - **Consistency**: All components use the same spacing values
/// - **Maintainability**: Changes to spacing affect the entire system uniformly
/// - **Design System Integrity**: Spacing follows the same token-based approach as colors
/// - **Visual Rhythm**: Creates harmonious relationships between elements
/// - **Developer Experience**: No more guessing what spacing value to use
///
/// **Why We Avoid Magic Numbers:**
/// Magic numbers (hardcoded values like `padding: EdgeInsets.all(12)`) create several problems:
/// - **Inconsistency**: Different developers use different arbitrary values
/// - **Maintenance**: Changing spacing requires finding and updating multiple hardcoded values
/// - **Design Drift**: Over time, spacing becomes inconsistent across the app
/// - **Poor Communication**: Numbers don't convey semantic meaning or intent
/// - **Scalability**: Difficult to maintain visual harmony as the app grows
///
/// **Spacing Scale Philosophy:**
/// The spacing scale follows a progression that provides enough granularity for
/// common use cases while maintaining simplicity. Each step represents a specific
/// semantic purpose:
/// - **xs**: Minimal spacing for tight layouts and fine-tuned adjustments
/// - **sm**: Small gaps between related elements (text lines, icon spacing)
/// - **md**: Default spacing for most component padding and margins
/// - **lg**: Larger separation for distinct content sections
/// - **xl**: Maximum spacing for major layout divisions
///
/// **Usage Examples:**
/// ```dart
/// // Component padding
/// Container(
///   padding: EdgeInsets.all(AppSpacing.md),
///   child: Text('Content'),
/// )
///
/// // Vertical spacing between elements
/// Column(
///   children: [
///     Widget1(),
///     SizedBox(height: AppSpacing.lg),
///     Widget2(),
///   ],
/// )
///
/// // Horizontal spacing in rows
/// Row(
///   children: [
///     Icon(Icons.star),
///     SizedBox(width: AppSpacing.sm),
///     Text('Rating'),
///   ],
/// )
///
/// // Using with AppSpacer atom
/// AppSpacer(size: AppSpacing.md)
/// ```
class AppSpacing {
  // Private constructor prevents instantiation
  AppSpacing._();

  /// Extra small spacing (4dp) - Minimal gaps and fine adjustments
  /// 
  /// Use for:
  /// - Small gaps between text and icons
  /// - Fine-tuned positioning adjustments  
  /// - Tight layouts where space is limited
  /// - Border offsets and small separations
  static const double xs = 4.0;

  /// Small spacing (8dp) - Related element separation
  /// 
  /// Use for:
  /// - Spacing between related text elements
  /// - Icon and text combinations
  /// - Small component internal padding
  /// - List item internal spacing
  static const double sm = 8.0;

  /// Medium spacing (16dp) - Default component spacing
  /// 
  /// Use for:
  /// - Standard component padding (cards, buttons, containers)
  /// - Default margins between unrelated elements  
  /// - Form field spacing
  /// - General purpose spacing (most common use case)
  static const double md = 16.0;

  /// Large spacing (24dp) - Section separation
  /// 
  /// Use for:
  /// - Spacing between content sections
  /// - Larger component margins
  /// - Page-level content separation
  /// - Major visual grouping boundaries
  static const double lg = 24.0;

  /// Extra large spacing (32dp) - Major layout divisions
  /// 
  /// Use for:
  /// - Page header/footer margins
  /// - Major content area separation
  /// - Screen-level layout spacing
  /// - Hero section padding
  static const double xl = 32.0;
}