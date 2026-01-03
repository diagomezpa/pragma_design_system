import 'package:flutter/material.dart';
import 'package:pragma_design_system/pragma_design_system.dart';

/// AppSectionShowcase - Demonstrates various `AppSection` variants.
///
/// This page showcases different configurations and use cases of the AppSection molecule.
/// It demonstrates how to structure content sections consistently across the application
/// using titles, descriptions, and various content types.
class AppSectionShowcase extends StatefulWidget {
  const AppSectionShowcase({super.key});

  @override
  State<AppSectionShowcase> createState() => _AppSectionShowcaseState();
}

class _AppSectionShowcaseState extends State<AppSectionShowcase> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AppSection Showcase'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // Variante 1: Sección básica - Solo title con contenido simple
          AppSection(
            title: 'Basic Section',
            child: const AppText(
              'This is a basic section with just a title. It demonstrates the minimal configuration of AppSection with simple text content.',
              variant: AppTextVariant.body,
            ),
          ),

          // Espaciado entre secciones
          const AppSpacer(size: AppSpacerSize.large),

          // Variante 2: Sección con descripción - title + description + contenido
          AppSection(
            title: 'Section with Description',
            description: 'This section includes both a title and a descriptive subtitle that provides additional context about the content below.',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                AppText(
                  'Content with Context',
                  variant: AppTextVariant.subtitle,
                ),
                AppSpacer(size: AppSpacerSize.small),
                AppText(
                  'When you need to provide additional context or explanation, use the description parameter to give users more information about what they\'ll find in this section.',
                  variant: AppTextVariant.body,
                ),
              ],
            ),
          ),

          // Espaciado entre secciones
          const AppSpacer(size: AppSpacerSize.large),

          // Variante 3: Sección con lista - Usando AppListItem como contenido
          AppSection(
            title: 'Settings Menu',
            description: 'Configure your app preferences and account settings',
            child: Column(
              children: const [
                AppListItem(
                  leading: AppIcon(Icons.notifications),
                  title: 'Notifications',
                  subtitle: 'Manage push notifications and alerts',
                  trailing: AppIcon(Icons.chevron_right),
                ),
                AppSpacer(size: AppSpacerSize.extraSmall),
                AppListItem(
                  leading: AppIcon(Icons.privacy_tip),
                  title: 'Privacy',
                  subtitle: 'Control your privacy and data sharing',
                  trailing: AppIcon(Icons.chevron_right),
                ),
                AppSpacer(size: AppSpacerSize.extraSmall),
                AppListItem(
                  leading: AppIcon(Icons.security),
                  title: 'Security',
                  subtitle: 'Manage passwords and two-factor authentication',
                  trailing: AppIcon(Icons.chevron_right),
                ),
                AppSpacer(size: AppSpacerSize.extraSmall),
                AppListItem(
                  leading: AppIcon(Icons.language),
                  title: 'Language',
                  subtitle: 'Change app language and region',
                  trailing: AppIcon(Icons.chevron_right),
                ),
              ],
            ),
          ),

          // Espaciado entre secciones
          const AppSpacer(size: AppSpacerSize.large),

          // Variante 4: Sección con formulario - Usando AppFormField
          AppSection(
            title: 'Contact Form',
            description: 'Fill out this form to get in touch with our support team',
            child: Column(
              children: const [
                AppFormField(
                  label: 'Full Name',
                  hintText: 'Enter your full name',
                  helperText: 'This will be used to identify your request',
                ),
                AppSpacer(size: AppSpacerSize.medium),
                AppFormField(
                  label: 'Email Address',
                  hintText: 'your.email@example.com',
                  helperText: 'We\'ll use this to respond to your inquiry',
                  prefixIcon: AppIcon(Icons.email),
                ),
              ],
            ),
          ),

          // Espaciado final
          const AppSpacer(size: AppSpacerSize.extraLarge),

          // Footer note
          const AppText(
            'All examples demonstrate the flexibility and consistency of AppSection molecule',
            variant: AppTextVariant.caption,
          ),
        ],
      ),
    );
  }
}