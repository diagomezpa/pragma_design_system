import 'package:flutter/material.dart';
import 'package:pragma_design_system/pragma_design_system.dart';

/// AppImageShowcase - demonstrates AppImage atom component
class AppImageShowcase extends StatelessWidget {
  const AppImageShowcase({super.key});

  @override
  Widget build(BuildContext context) {
    return AppSection(
      title: 'AppImage Examples',
      child: AppLabeledCard(
        label: 'Network Image',
        child: AppImage(
          imageUrl: 'https://picsum.photos/120/120',
          width: 120,
          height: 120,
          semanticLabel: 'Network image',
        ),
      ),
    );
  }
}