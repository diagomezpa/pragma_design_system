/// Pragma Design System
///
/// A Flutter package that implements a Design System based on Atomic Design.
/// This package provides reusable UI components following atomic design principles:
/// atoms, molecules, organisms, templates, and pages.
///
/// This library focuses on providing consistent, reusable, and well-structured
/// UI components for Flutter applications, particularly for e-commerce use cases.

library pragma_design_system;

// Export all atoms
export 'atoms/app_text.dart';
export 'atoms/app_button.dart';
export 'atoms/app_icon.dart';
export 'atoms/app_image.dart';
export 'atoms/app_divider.dart';
export 'atoms/app_spacer.dart';

// Export themes (when implemented)
// export 'theme/app_theme.dart';

// Export layout components


// Export feedback utilities
export 'feedback/app_dialog.dart';
export 'feedback/app_dialog_demo.dart';
export 'feedback/app_snackbar.dart';
export 'feedback/app_snackbar_type.dart';
export 'feedback/app_snackbar_showcase.dart';
export 'feedback/feedback_demo.dart';
export 'feedback/practical_feedback_example.dart';

// Export molecules
export 'molecules/form_field/app_form_field.dart';
export 'molecules/app_section/app_section.dart';
export 'molecules/list_item/app_list_item.dart';
export 'molecules/app_card/app_card.dart';
export 'molecules/app_empty_state/app_empty_state.dart';
export 'molecules/app_price/app_price.dart';

// Export organisms (when implemented)
// export 'organisms/organisms.dart';
export 'organisms/app_product_list_item/app_product_list_item.dart';
export 'organisms/app_form_section/app_form_section.dart';
export 'organisms/app_card_list/app_card_list.dart';
export 'organisms/app_empty_state_section/app_empty_state_section.dart';
export 'organisms/app_settings_group/app_settings_group.dart';

// Export templates (when implemented)
// export 'templates/templates.dart';
export 'templates/product_list/product_list_template.dart';
export 'templates/form_pages/form_page_template.dart';
export 'templates/empty_state_dashboard/empty_state_dashboard_template.dart';
export 'templates/settings_page/settings_page_template.dart';
export 'templates/app_page/app_page.dart';

// Export pages (when implemented)
export 'pages/home/home_page.dart';
export 'pages/molecules/molecules_list_page.dart';
export 'pages/other_pages/other_pages_list_pages.dart';
export 'pages/organisms/organisms_list_page.dart';
export 'pages/templates/templates_list_page.dart';

// export 'pages/pages.dart';
