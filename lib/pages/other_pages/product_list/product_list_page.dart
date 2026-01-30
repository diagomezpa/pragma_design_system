import 'package:flutter/material.dart';
import 'package:pragma_design_system/pragma_design_system.dart';
import 'package:pragma_design_system/templates/product_list/product_list_template_showcase.dart';

/// ProductListPage - A concrete Page implementation demonstrating template usage.
///
/// This page represents the Page layer in Atomic Design methodology, which is
/// responsible for providing real data, state management, and business logic
/// to Templates. Pages are specific instances of Templates with actual content.
///
/// Atomic Design Page Principles:
/// - **Pages** are specific instances of templates with real representative content
/// - Pages provide data and state to templates without modifying template structure
/// - Business logic, data fetching, and user interactions live at the Page level
/// - Templates remain pure and focused on layout and component arrangement
///
/// This page demonstrates:
/// - How Pages consume Templates without modification
/// - Data provision and state management at the Page level
/// - Real-world usage patterns for template-based architecture
/// - Toggle between populated and empty states for comprehensive demonstration
///
/// Implementation Philosophy:
/// - Page owns data (mock products) and state (hasProducts toggle)
/// - Template (ProductListTemplate) owns layout and component arrangement
/// - Clear separation of concerns between data/logic and presentation
class ProductListPage extends StatefulWidget {
  /// Creates a product list page demonstrating template usage.
  const ProductListPage({super.key});

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  /// State flag to toggle between populated and empty product list
  bool hasProducts = true;

  /// Mock product data for demonstration purposes
  final List<MockProduct> _mockProducts = [
    MockProduct(
      id: '1',
      name: 'Premium Wireless Headphones',
      price: 299.99,
      imageUrl: 'https://picsum.photos/200/200?random=1',
      category: 'Electronics',
      inStock: true,
    ),
    MockProduct(
      id: '2',
      name: 'Ergonomic Office Chair',
      price: 459.00,
      imageUrl: 'https://picsum.photos/200/200?random=2',
      category: 'Furniture',
      inStock: true,
    ),
    MockProduct(
      id: '3',
      name: 'Smart Water Bottle',
      price: 79.99,
      imageUrl: 'https://picsum.photos/200/200?random=3',
      category: 'Health & Fitness',
      inStock: false,
    ),
    MockProduct(
      id: '4',
      name: 'Minimalist Desk Lamp',
      price: 129.50,
      imageUrl: 'https://picsum.photos/200/200?random=4',
      category: 'Lighting',
      inStock: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product List Page'),
        centerTitle: true,
        actions: [
          AppButton(
            onPressed: _toggleProductsState,
            text: hasProducts ? 'Clear' : 'Show',
            variant: AppButtonVariant.text,
            size: AppButtonSize.medium,
          ),
        ],
      ),
      body: ProductListTemplate(
        header: _buildHeader(),
        products: hasProducts ? _buildProductsList() : [],
        emptyState: _buildEmptyState(),
      ),
    );
  }

  /// Toggles between populated and empty product list states
  void _toggleProductsState() {
    setState(() {
      hasProducts = !hasProducts;
    });
  }

  /// Builds the header section for the product list
  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const AppText(
          'Our Products',
          variant: AppTextVariant.headlineMedium,
        ),
        const SizedBox(height: 8),
        AppText(
          hasProducts 
              ? 'Discover our curated selection of premium products'
              : 'Browse our complete product catalog',
          variant: AppTextVariant.bodyLarge,
          color: Theme.of(context).colorScheme.onSurfaceVariant,
        ),
      ],
    );
  }

  /// Builds the list of product items using the design system components
  List<Widget> _buildProductsList() {
    return _mockProducts.map((product) {
      return AppProductListItem(
        title: product.name,
        subtitle: product.category,
        imageUrl: product.imageUrl,
        price: '\$${product.price.toStringAsFixed(2)}',
        isEnabled: product.inStock,
        onTap: () => _handleProductTap(product),
      );
    }).toList();
  }

  /// Builds the empty state section when no products are available
  Widget _buildEmptyState() {
    return AppEmptyStateSection(
      icon: Icons.shopping_bag_outlined,
      title: 'No products available',
      description: 'We\'re currently updating our product catalog. Check back soon for new arrivals and exciting deals!',
      primaryAction: AppButton(
        text: 'Browse Categories',
        onPressed: _handleBrowseCategories,
        variant: AppButtonVariant.primary,
      ),
      secondaryAction: AppButton(
        text: 'Get Notified',
        onPressed: _handleGetNotified,
        variant: AppButtonVariant.secondary,
      ),
    );
  }

  /// Handles product item tap - demonstrates page-level interaction logic
  void _handleProductTap(MockProduct product) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Tapped on ${product.name}'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  /// Handles browse categories action from empty state
  void _handleBrowseCategories() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Navigate to categories page'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  /// Handles get notified action from empty state
  void _handleGetNotified() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Notification preferences updated'),
        duration: Duration(seconds: 2),
      ),
    );
  }
}

/// Mock product data model for demonstration purposes
class MockProduct {
  const MockProduct({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.category,
    required this.inStock,
  });

  final String id;
  final String name;
  final double price;
  final String imageUrl;
  final String category;
  final bool inStock;
}

/// Placeholder for ProductListTemplate - this would normally be imported
/// from the templates package, but creating a simple version for demonstration
class ProductListTemplate extends StatelessWidget {
  const ProductListTemplate({
    super.key,
    required this.header,
    required this.products,
    required this.emptyState,
  });

  final Widget header;
  final List<Widget> products;
  final Widget emptyState;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          header,
          const SizedBox(height: 24),
          Expanded(
            child: products.isNotEmpty
                ? ListView.separated(
                    itemCount: products.length,
                    separatorBuilder: (context, index) => const SizedBox(height: 16),
                    itemBuilder: (context, index) => products[index],
                  )
                : emptyState,
          ),
        ],
      ),
    );
  }
}