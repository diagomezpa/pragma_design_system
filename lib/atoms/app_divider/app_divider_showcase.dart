import 'package:flutter/material.dart';
import 'app_divider.dart';

/// AppDividerShowcase
///
/// Design System Documentation for the AppDivider atom component.
/// This showcase demonstrates all available orientations, thickness variations,
/// factory methods, and customization options of the AppDivider in a clean,
/// minimal format suitable for design system documentation.
class AppDividerShowcase extends StatelessWidget {
  const AppDividerShowcase({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            const Text(
              'AppDivider',
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Visual separation component for content organization',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 40),

            // Orientations Section
            ShowcaseSection(
              title: 'Orientations',
              children: [
                ShowcaseRow(
                  label: 'Horizontal',
                  child: Container(
                    width: 200,
                    height: 50,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Content above'),
                        const AppDivider(
                          orientation: AppDividerOrientation.horizontal,
                        ),
                        const Text('Content below'),
                      ],
                    ),
                  ),
                ),
                ShowcaseRow(
                  label: 'Vertical',
                  child: Container(
                    width: 200,
                    height: 50,
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Left'),
                        AppDivider(
                          orientation: AppDividerOrientation.vertical,
                        ),
                        Text('Right'),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // Thickness Variations Section
            ShowcaseSection(
              title: 'Thickness Variations',
              children: [
                ShowcaseRow(
                  label: 'Thin (0.5px)',
                  child: Container(
                    width: 200,
                    child: const AppDivider(
                      thickness: 0.5,
                    ),
                  ),
                ),
                ShowcaseRow(
                  label: 'Normal (1px)',
                  child: Container(
                    width: 200,
                    child: const AppDivider(
                      thickness: 1.0,
                    ),
                  ),
                ),
                ShowcaseRow(
                  label: 'Thick (2px)',
                  child: Container(
                    width: 200,
                    child: const AppDivider(
                      thickness: 2.0,
                    ),
                  ),
                ),
                ShowcaseRow(
                  label: 'Extra Thick (4px)',
                  child: Container(
                    width: 200,
                    child: const AppDivider(
                      thickness: 4.0,
                    ),
                  ),
                ),
              ],
            ),

            // Factory Methods Section
            ShowcaseSection(
              title: 'Factory Methods',
              children: [
                ShowcaseRow(
                  label: 'Thin',
                  child: Container(
                    width: 200,
                    child: AppDividerFactory.thin(),
                  ),
                ),
                ShowcaseRow(
                  label: 'Thick',
                  child: Container(
                    width: 200,
                    child: AppDividerFactory.thick(),
                  ),
                ),
                ShowcaseRow(
                  label: 'Vertical',
                  child: Container(
                    width: 200,
                    height: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Left'),
                        AppDividerFactory.vertical(),
                        const Text('Right'),
                      ],
                    ),
                  ),
                ),
                ShowcaseRow(
                  label: 'Section',
                  child: Container(
                    width: 200,
                    child: Column(
                      children: [
                        const Text('Section 1'),
                        AppDividerFactory.section(),
                        const Text('Section 2'),
                      ],
                    ),
                  ),
                ),
                ShowcaseRow(
                  label: 'List Item',
                  child: Container(
                    width: 200,
                    child: Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(16),
                          child: Text('List Item 1'),
                        ),
                        AppDividerFactory.listItem(),
                        const Padding(
                          padding: EdgeInsets.all(16),
                          child: Text('List Item 2'),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // Colors Section
            ShowcaseSection(
              title: 'Colors',
              children: [
                ShowcaseRow(
                  label: 'Default',
                  child: Container(
                    width: 200,
                    child: const AppDivider(),
                  ),
                ),
                ShowcaseRow(
                  label: 'Primary',
                  child: Container(
                    width: 200,
                    child: AppDivider(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
                ShowcaseRow(
                  label: 'Secondary',
                  child: Container(
                    width: 200,
                    child: AppDivider(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                ),
                ShowcaseRow(
                  label: 'Error',
                  child: Container(
                    width: 200,
                    child: AppDivider(
                      color: Theme.of(context).colorScheme.error,
                    ),
                  ),
                ),
              ],
            ),

            // Indentation Section
            ShowcaseSection(
              title: 'Indentation',
              children: [
                ShowcaseRow(
                  label: 'No Indent',
                  child: Container(
                    width: 200,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.withOpacity(0.3)),
                    ),
                    child: const AppDivider(
                      indent: 0,
                      endIndent: 0,
                    ),
                  ),
                ),
                ShowcaseRow(
                  label: 'Start Indent',
                  child: Container(
                    width: 200,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.withOpacity(0.3)),
                    ),
                    child: const AppDivider(
                      indent: 16,
                      endIndent: 0,
                    ),
                  ),
                ),
                ShowcaseRow(
                  label: 'End Indent',
                  child: Container(
                    width: 200,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.withOpacity(0.3)),
                    ),
                    child: const AppDivider(
                      indent: 0,
                      endIndent: 16,
                    ),
                  ),
                ),
                ShowcaseRow(
                  label: 'Both Indent',
                  child: Container(
                    width: 200,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.withOpacity(0.3)),
                    ),
                    child: const AppDivider(
                      indent: 16,
                      endIndent: 16,
                    ),
                  ),
                ),
              ],
            ),

            // Margin Section
            ShowcaseSection(
              title: 'Margin',
              children: [
                ShowcaseRow(
                  label: 'No Margin',
                  child: Container(
                    width: 200,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.withOpacity(0.3)),
                    ),
                    child: Column(
                      children: [
                        const Text('Content above'),
                        const AppDivider(),
                        const Text('Content below'),
                      ],
                    ),
                  ),
                ),
                ShowcaseRow(
                  label: 'Vertical Margin',
                  child: Container(
                    width: 200,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.withOpacity(0.3)),
                    ),
                    child: Column(
                      children: [
                        const Text('Content above'),
                        const AppDivider(
                          margin: EdgeInsets.symmetric(vertical: 16),
                        ),
                        const Text('Content below'),
                      ],
                    ),
                  ),
                ),
                ShowcaseRow(
                  label: 'All Margin',
                  child: Container(
                    width: 200,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.withOpacity(0.3)),
                    ),
                    child: Column(
                      children: [
                        const Text('Content above'),
                        const AppDivider(
                          margin: EdgeInsets.all(16),
                        ),
                        const Text('Content below'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// ShowcaseSection
/// 
/// A reusable widget for displaying sections in design system documentation.
/// Handles consistent spacing, title styling, and layout for showcase sections.
class ShowcaseSection extends StatelessWidget {
  const ShowcaseSection({
    super.key,
    required this.title,
    required this.children,
  });

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section title
          Text(
            title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 16),
          // Section content with spacing between items
          Column(
            children: [
              for (int i = 0; i < children.length; i++) ...[
                children[i],
                if (i < children.length - 1) const SizedBox(height: 12),
              ],
            ],
          ),
        ],
      ),
    );
  }
}

/// ShowcaseRow
/// 
/// A reusable widget for displaying individual showcase items with consistent
/// label-widget layout. Used within ShowcaseSection for design system documentation.
class ShowcaseRow extends StatelessWidget {
  const ShowcaseRow({
    super.key,
    required this.label,
    required this.child,
  });

  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 100,
          child: Text(label),
        ),
        child,
      ],
    );
  }
}