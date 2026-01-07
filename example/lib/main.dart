import 'package:flutter/material.dart';
import 'package:pragma_design_system/theme/app_theme.dart';
import 'package:pragma_design_system/pages/home/home_page.dart';


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
      home: const HomePage(),
    
    );
  }
}
