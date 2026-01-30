import 'package:flutter/material.dart';

/// AppSemanticIcons - Semantic icon definitions for app functionality
///
/// This class provides semantic icon references instead of using Material Icons directly.
/// It centralizes icon choices within the design system and allows for easy theming
/// and icon family changes without touching application code.
///
/// Example usage:
/// ```dart
/// AppIcon(AppSemanticIcons.search)
/// AppIcon(AppSemanticIcons.clear)
/// AppIcon(AppSemanticIcons.searchOff)
/// ```
class AppSemanticIcons {
  // Prevent instantiation
  const AppSemanticIcons._();

  // Search related icons
  static const IconData search = Icons.search;
  static const IconData searchOutlined = Icons.search_outlined;
  static const IconData searchOff = Icons.search_off_outlined;
  static const IconData clear = Icons.clear;

  // Navigation icons
  static const IconData back = Icons.arrow_back;
  static const IconData close = Icons.close;

  // Product actions
  static const IconData shoppingCart = Icons.shopping_cart;
  static const IconData favorite = Icons.favorite_border;
  static const IconData share = Icons.share;

  // Content states
  static const IconData error = Icons.error_outline;
  static const IconData info = Icons.info_outline;
  static const IconData warning = Icons.warning_outline;
  static const IconData success = Icons.check_circle_outline;

  // General actions
  static const IconData add = Icons.add;
  static const IconData remove = Icons.remove;
  static const IconData edit = Icons.edit;
  static const IconData delete = Icons.delete_outline;
  static const IconData settings = Icons.settings;

  // Store/catalog icons
  static const IconData store = Icons.store_outlined;
  static const IconData gridView = Icons.grid_view;
  static const IconData filterList = Icons.filter_list;
  static const IconData filterListOff = Icons.filter_list_off;
}