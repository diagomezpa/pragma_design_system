/// Pragma Design System
///
/// A Flutter package that implements a Design System based on Atomic Design.
/// This package provides reusable UI components following atomic design principles:
/// atoms, molecules, organisms, templates, and pages.
///
/// This library focuses on providing consistent, reusable, and well-structured
/// UI components for Flutter applications, particularly for e-commerce use cases.

library pragma_design_system;

// Export submodule barrels
export 'atoms.dart';
export 'molecules.dart';
export 'organisms.dart';
export 'templates.dart';

// Export themes
export 'theme/app_colors.dart';
export 'theme/app_color_scheme.dart';
export 'theme/app_theme.dart';

// Export feedback utilities
export 'feedback/app_dialog.dart';
export 'feedback/app_snackbar.dart';
export 'feedback/app_snackbar_type.dart';
