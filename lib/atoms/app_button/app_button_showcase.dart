import 'package:flutter/material.dart';
import 'app_button.dart';

/// AppButtonShowcase
///
/// Design System Documentation for the AppButton atom component.
/// This showcase demonstrates all available variants, sizes, and states
/// of the AppButton in a clean, minimal format suitable for design
/// system documentation.
class AppButtonShowcase extends StatefulWidget {
  const AppButtonShowcase({super.key});

  @override
  State<AppButtonShowcase> createState() => _AppButtonShowcaseState();
}

class _AppButtonShowcaseState extends State<AppButtonShowcase> {
  bool _isLoading = false;

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
              'AppButton',
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Button component for user interactions',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 40),

            // Variants Section
            ShowcaseSection(
              title: 'Variants',
              children: [
                ShowcaseRow(
                  label: 'Primary',
                  child: AppButton(
                    text: 'Primary',
                    variant: AppButtonVariant.primary,
                    onPressed: () {},
                  ),
                ),
                ShowcaseRow(
                  label: 'Secondary',
                  child: AppButton(
                    text: 'Secondary',
                    variant: AppButtonVariant.secondary,
                    onPressed: () {},
                  ),
                ),
                ShowcaseRow(
                  label: 'Outline',
                  child: AppButton(
                    text: 'Outline',
                    variant: AppButtonVariant.outline,
                    onPressed: () {},
                  ),
                ),
                ShowcaseRow(
                  label: 'Text',
                  child: AppButton(
                    text: 'Text',
                    variant: AppButtonVariant.text,
                    onPressed: () {},
                  ),
                ),
              ],
            ),

            // Sizes Section
            ShowcaseSection(
              title: 'Sizes',
              children: [
                ShowcaseRow(
                  label: 'Extra Small',
                  child: AppButton(
                    text: 'Extra Small',
                    size: AppButtonSize.extraSmall,
                    onPressed: () {},
                  ),
                ),
                ShowcaseRow(
                  label: 'Small',
                  child: AppButton(
                    text: 'Small',
                    size: AppButtonSize.small,
                    onPressed: () {},
                  ),
                ),
                ShowcaseRow(
                  label: 'Medium',
                  child: AppButton(
                    text: 'Medium',
                    size: AppButtonSize.medium,
                    onPressed: () {},
                  ),
                ),
                ShowcaseRow(
                  label: 'Large',
                  child: AppButton(
                    text: 'Large',
                    size: AppButtonSize.large,
                    onPressed: () {},
                  ),
                ),
              ],
            ),

            // States Section
            ShowcaseSection(
              title: 'States',
              children: [
                ShowcaseRow(
                  label: 'Enabled',
                  child: AppButton(
                    text: 'Enabled',
                    onPressed: () {},
                  ),
                ),
                ShowcaseRow(
                  label: 'Disabled',
                  child: const AppButton(
                    text: 'Disabled',
                    onPressed: null, // Disabled by null callback
                  ),
                ),
                ShowcaseRow(
                  label: 'Loading',
                  child: AppButton(
                    text: 'Loading',
                    isLoading: _isLoading,
                    onPressed: _toggleLoading,
                  ),
                ),
              ],
            ),

            // With Icons Section
            ShowcaseSection(
              title: 'With Icons',
              children: [
                ShowcaseRow(
                  label: 'Icon + Text',
                  child: AppButton(
                    text: 'Save',
                    icon: Icons.save,
                    onPressed: () {},
                  ),
                ),
                ShowcaseRow(
                  label: 'Icon Only',
                  child: AppButton(
                    text: '', // Empty text for icon-only
                    icon: Icons.add,
                    size: AppButtonSize.extraSmall,
                    onPressed: () {},
                  ),
                ),
              ],
            ),

            // Enable State Control Section
            ShowcaseSection(
              title: 'Enable State Control',
              children: [
                ShowcaseRow(
                  label: 'isEnabled',
                  child: AppButton(
                    text: 'Controlled',
                    isEnabled: true, // Can be controlled by state
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Simple loading state toggle for demonstration
  void _toggleLoading() {
    setState(() {
      _isLoading = !_isLoading;
    });

    if (_isLoading) {
      // Auto-reset loading after 2 seconds
      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      });
    }
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