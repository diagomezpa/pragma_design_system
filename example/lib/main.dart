import 'package:flutter/material.dart';
import 'package:pragma_design_system/molecules/form_field/app_form_field_page.dart';
import 'package:pragma_design_system/molecules/list_item/app_list_item_showcase.dart';
import 'package:pragma_design_system/molecules/app_section/app_section_showcase.dart';
import 'package:pragma_design_system/molecules/app_card/app_card_showcase.dart';

void main() {
  runApp(const ExampleApp());
}

class ExampleApp extends StatelessWidget {
  const ExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pragma Design System - Example',
      theme: ThemeData(useMaterial3: true),
      home: const AppCardShowcase(),
    );
  }
}
