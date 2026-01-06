import 'package:flutter/material.dart';
import 'package:pragma_design_system/theme/app_theme.dart';
import 'package:pragma_design_system/molecules/molecules_showcase.dart';
import 'package:pragma_design_system/organisms/organisms_showcase.dart';
import 'package:pragma_design_system/templates/templates_showcase.dart';


void main() {
  runApp(const ExampleApp());
}

class ExampleApp extends StatelessWidget {
  const ExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      title: 'Pragma Design System - Example',
      darkTheme: AppTheme.dark(),
      themeMode: ThemeMode.system,
      home: const SettingsPageTemplateShowcase(),
    
    );
  }
}
