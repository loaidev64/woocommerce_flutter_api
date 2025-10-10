/// Comprehensive WooCommerce Flutter API Example
///
/// This file demonstrates all major features of the package.
/// Run different examples by uncommenting the desired function in main().
///
/// ## Setup Instructions
///
/// 1. Replace the placeholder credentials below with your actual WooCommerce store details
/// 2. Uncomment the example function you want to run in main()
/// 3. Run the example with: `dart run example/woocommerce_flutter_api_example.dart`
///
/// ## Important Notes
///
/// - For development, use `useFaker: true` to get fake data without a real store
/// - For production, set `useFaker: false` and provide real credentials
/// - Always handle errors appropriately in production code
/// - Consider implementing proper state management for larger applications

import 'package:dio/dio.dart';
import 'package:woocommerce_flutter_api/woocommerce_flutter_api.dart';

// ============================================================================
// CONFIGURATION
// ============================================================================

/// Your WooCommerce store configuration
/// TODO: Replace with your actual store details
const String storeUrl = 'https://yourstore.com';
const String consumerKey = 'ck_your_consumer_key_here';
const String consumerSecret = 'cs_your_consumer_secret_here';

// ============================================================================
// SETUP EXAMPLES
// ============================================================================

/// Basic setup example for production use
Future<void> setupExample() async {
  print('🚀 Setting up WooCommerce client for production...');

  final woocommerce = WooCommerce(
    baseUrl: storeUrl,
    username: consumerKey,
    password: consumerSecret,
    isDebug: true, // Enable debug logging
    useFaker: false, // Use real data
  );

  print('✅ WooCommerce client initialized successfully');
  print('Base URL: ${woocommerce.baseUrl}');
  print('Debug mode: ${woocommerce.isDebug}');
}

/// Setup example for development with fake data
Future<void> setupWithFakeData() async {
  print('🧪 Setting up WooCommerce client for development...');

  final woocommerce = WooCommerce(
    baseUrl: 'https://example.com', // Not used when useFaker is true
    username: 'dev_key', // Not used when useFaker is true
    password: 'dev_secret', // Not used when useFaker is true
    isDebug: true,
    useFaker: true, // This will return fake data for all API calls
  );

  print('✅ Development client initialized with fake data');

  // Test with fake data
  try {
    final products = await woocommerce.getProducts(perPage: 3);
    print('📦 Fetched ${products.length} fake products:');
    for (final product in products) {
      print('  - ${product.name} (ID: ${product.id})');
    }
  } catch (e) {
    print('❌ Error: $e');
  }
}

// ============================================================================
// AUTHENTICATION EXAMPLES
// ============================================================================

/// User login example
Future<void> authenticationExample() async {
  print('🔐 Authentication Example');

  final woocommerce = WooCommerce(
    baseUrl: storeUrl,
    username: consumerKey,
    password: consumerSecret,
    useFaker: true, // Use fake data for this example
  );

  try {
    // Login user
    await woocommerce.login('user@example.com', 'password123');
    print('✅ User logged in successfully');

    // Get user ID from storage
    final userId = await LocalStorageHelper.getSecurityUserId();
    print('👤 User ID: $userId');

    // Logout user
    await woocommerce.logout();
    print('👋 User logged out successfully');
  } catch (e) {
    print('❌ Authentication error: $e');
  }
}

/// User registration example
Future<void> registrationExample() async {
  print('📝 Registration Example');

  final woocommerce = WooCommerce(
    baseUrl: storeUrl,
    username: consumerKey,
    password: consumerSecret,
    useFaker: true,
  );

  try {
    // Create new customer
    final newCustomer = WooCustomer(
      email: 'newuser@example.com',
      firstName: 'John',
      lastName: 'Doe',
    );

    await woocommerce.register(newCustomer);
    print('✅ Customer registered successfully');
  } catch (e) {
    print('❌ Registration error: $e');
  }
}

// ============================================================================
// PRODUCT EXAMPLES
// ============================================================================

/// Fetch products with various filters
Future<void> fetchProductsExample() async {
  print('📦 Fetch Products Example');

  final woocommerce = WooCommerce(
    baseUrl: storeUrl,
    username: consumerKey,
    password: consumerSecret,
    useFaker: true,
  );

  try {
    // Get first 5 published products
    final products = await woocommerce.getProducts(
      perPage: 5,
      status: WooFilterStatus.publish,
      orderBy: WooSortOrderBy.title,
      order: WooSortOrder.asc,
    );

    print('✅ Fetched ${products.length} products:');
    for (final product in products) {
      print('  📦 ${product.name}');
      print('     ID: ${product.id}');
      print('     Price: \$${product.price}');
      print('     Status: ${product.status}');
      print('     Featured: ${product.featured}');
      print('     Stock: ${product.stockStatus}');
      print('     ---');
    }
  } catch (e) {
    print('❌ Error fetching products: $e');
  }
}

/// Search products example
Future<void> searchProductsExample() async {
  print('🔍 Search Products Example');

  final woocommerce = WooCommerce(
    baseUrl: storeUrl,
    username: consumerKey,
    password: consumerSecret,
    useFaker: true,
  );

  try {
    // Search for products
    final searchResults = await woocommerce.getProducts(
      search: 'laptop',
      perPage: 10,
      status: WooFilterStatus.publish,
    );

    print('🔍 Search results for "laptop":');
    for (final product in searchResults) {
      print('  📦 ${product.name} - \$${product.price}');
    }

    // Get featured products
    final featuredProducts = await woocommerce.getProducts(
      featured: true,
      perPage: 5,
    );

    print('\n⭐ Featured products:');
    for (final product in featuredProducts) {
      print('  ⭐ ${product.name}');
    }
  } catch (e) {
    print('❌ Search error: $e');
  }
}

/// Create a new product
Future<void> createProductExample() async {
  print('➕ Create Product Example');

  final woocommerce = WooCommerce(
    baseUrl: storeUrl,
    username: consumerKey,
    password: consumerSecret,
    useFaker: true,
  );

  try {
    // Create a new product
    final newProduct = WooProduct(
      name: 'Amazing Widget',
      type: WooProductType.simple,
      status: WooProductStatus.publish,
      description: 'This is an amazing widget that does amazing things!',
      shortDescription: 'Amazing widget for amazing people',
      price: 29.99,
      regularPrice: 39.99,
      salePrice: 29.99,
      sku: 'WIDGET-001',
      manageStock: true,
      stockQuantity: 100,
      stockStatus: WooProductStockStatus.instock,
      featured: true,
      virtual: false,
      downloadable: false,
    );

    final createdProduct = await woocommerce.createProduct(newProduct);
    print('✅ Product created successfully!');
    print('📦 Name: ${createdProduct.name}');
    print('🆔 ID: ${createdProduct.id}');
    print('💰 Price: \$${createdProduct.price}');
  } catch (e) {
    print('❌ Error creating product: $e');
  }
}

/// Update an existing product
Future<void> updateProductExample() async {
  print('✏️ Update Product Example');

  final woocommerce = WooCommerce(
    baseUrl: storeUrl,
    username: consumerKey,
    password: consumerSecret,
    useFaker: true,
  );

  try {
    // First, get a product to update
    final products = await woocommerce.getProducts(perPage: 1);
    if (products.isEmpty) {
      print('❌ No products found to update');
      return;
    }

    final product = products.first;
    print('📦 Original product: ${product.name} - \$${product.price}');

    // Update the product
    final updatedProduct = product.copyWith(
      name: '${product.name} (Updated)',
      price: (product.price ?? 0) + 10.0,
      onSale: true,
    );

    final result = await woocommerce.updateProduct(product.id!, updatedProduct);
    print('✅ Product updated successfully!');
    print('📦 New name: ${result.name}');
    print('💰 New price: \$${result.price}');
    print('🏷️ On sale: ${result.onSale}');
  } catch (e) {
    print('❌ Error updating product: $e');
  }
}

// ============================================================================
// ORDER EXAMPLES
// ============================================================================

/// Create a new order
Future<void> createOrderExample() async {
  print('🛒 Create Order Example');

  final woocommerce = WooCommerce(
    baseUrl: storeUrl,
    username: consumerKey,
    password: consumerSecret,
    useFaker: true,
  );

  try {
    // Create billing address
    final billing = WooBilling(
      firstName: 'John',
      lastName: 'Doe',
      email: 'john.doe@example.com',
      phone: '+1234567890',
      address1: '123 Main St',
      city: 'New York',
      state: 'NY',
      postcode: '10001',
      country: 'US',
    );

    // Create shipping address
    final shipping = WooShipping(
      firstName: 'John',
      lastName: 'Doe',
      address1: '123 Main St',
      city: 'New York',
      state: 'NY',
      postcode: '10001',
      country: 'US',
    );

    // Create line items
    final lineItems = [
      WooLineItem(
        productId: 1,
        quantity: 2,
        name: 'Sample Product',
        price: 25.99,
      ),
    ];

    // Create the order
    final order = WooOrder(
      id: 0, // Will be assigned by WooCommerce
      status: WooOrderStatus.pending,
      currency: WooOrderCurrency.USD,
      customerId: 1,
      billing: billing,
      shipping: shipping,
      lineItems: lineItems,
      total: 51.98,
      paymentMethod: 'credit_card',
      paymentMethodTitle: 'Credit Card',
    );

    final createdOrder = await woocommerce.createOrder(order);
    print('✅ Order created successfully!');
    print('🆔 Order ID: ${createdOrder.id}');
    print('📧 Customer: ${createdOrder.billing?.email}');
    print('💰 Total: \$${createdOrder.total}');
    print('📦 Items: ${createdOrder.lineItems?.length}');
  } catch (e) {
    print('❌ Error creating order: $e');
  }
}

/// Fetch orders with filters
Future<void> fetchOrdersExample() async {
  print('📋 Fetch Orders Example');

  final woocommerce = WooCommerce(
    baseUrl: storeUrl,
    username: consumerKey,
    password: consumerSecret,
    useFaker: true,
  );

  try {
    // Get recent orders
    final orders = await woocommerce.getOrders(
      perPage: 5,
      status: [WooOrderStatus.processing],
      orderBy: WooOrderOrderBy.date,
      order: WooSortOrder.desc,
    );

    print('✅ Fetched ${orders.length} orders:');
    for (final order in orders) {
      print('📋 Order #${order.number}');
      print('   Status: ${order.status}');
      print('   Total: \$${order.total}');
      print('   Customer: ${order.billing?.email}');
      print('   Date: ${order.dateCreated}');
      print('   ---');
    }
  } catch (e) {
    print('❌ Error fetching orders: $e');
  }
}

// ============================================================================
// CART EXAMPLES
// ============================================================================

/// Get user's cart
Future<void> cartExample() async {
  print('🛒 Cart Example');

  final woocommerce = WooCommerce(
    baseUrl: storeUrl,
    username: consumerKey,
    password: consumerSecret,
    useFaker: true,
  );

  try {
    // Get user's cart
    final cart = await woocommerce.getCart();
    print('✅ Cart retrieved successfully!');
    print('🛒 Total items: ${cart.items?.length ?? 0}');
    print('💰 Total price: \$${cart.totalPrice}');

    if (cart.items != null && cart.items!.isNotEmpty) {
      for (final item in cart.items!) {
        print('  📦 ${item.name} x${item.quantity} - \$${item.price}');
      }
    } else {
      print('🛒 Cart is empty');
    }
  } catch (e) {
    print('❌ Error fetching cart: $e');
  }
}

// ============================================================================
// ADVANCED EXAMPLES
// ============================================================================

/// Pagination example
Future<void> paginationExample() async {
  print('📄 Pagination Example');

  final woocommerce = WooCommerce(
    baseUrl: storeUrl,
    username: consumerKey,
    password: consumerSecret,
    useFaker: true,
  );

  try {
    const int itemsPerPage = 3;
    int currentPage = 1;
    bool hasMorePages = true;

    while (hasMorePages) {
      print('📄 Fetching page $currentPage...');

      final products = await woocommerce.getProducts(
        page: currentPage,
        perPage: itemsPerPage,
      );

      if (products.isEmpty) {
        hasMorePages = false;
        print('📄 No more products found');
        break;
      }

      print('📦 Page $currentPage - ${products.length} products:');
      for (final product in products) {
        print('  📦 ${product.name} (ID: ${product.id})');
      }

      // Check if we have more pages
      hasMorePages = products.length == itemsPerPage;
      currentPage++;

      // Safety check to prevent infinite loops
      if (currentPage > 5) {
        print('⚠️ Stopping pagination after 5 pages for demo purposes');
        break;
      }
    }
  } catch (e) {
    print('❌ Pagination error: $e');
  }
}

/// Error handling example
Future<void> errorHandlingExample() async {
  print('⚠️ Error Handling Example');

  final woocommerce = WooCommerce(
    baseUrl: 'https://invalid-store.com', // Invalid URL
    username: 'invalid_key',
    password: 'invalid_secret',
    useFaker: false, // Try real API call to demonstrate error handling
  );

  try {
    print('🔄 Attempting to fetch products from invalid store...');
    await woocommerce.getProducts();
  } on DioException catch (e) {
    print('🌐 Network error: ${e.message}');
    print('📊 Status code: ${e.response?.statusCode}');
    print('📝 Response data: ${e.response?.data}');
  } catch (e) {
    print('❌ Unexpected error: $e');
  }

  // Demonstrate proper error handling pattern
  print('\n✅ Proper error handling pattern:');
  try {
    final woocommerce = WooCommerce(
      baseUrl: storeUrl,
      username: consumerKey,
      password: consumerSecret,
      useFaker: true,
    );

    final products = await woocommerce.getProducts(perPage: 1);
    print(
        '✅ Successfully handled API call - found ${products.length} products');
  } catch (e) {
    print('❌ Error occurred: $e');
    // In a real app, you would:
    // 1. Log the error
    // 2. Show user-friendly message
    // 3. Implement retry logic if appropriate
    // 4. Report to crash analytics
  }
}

// ============================================================================
// COMPREHENSIVE E-COMMERCE FLOW EXAMPLE
// ============================================================================

/// Complete e-commerce flow example
Future<void> completeEcommerceFlow() async {
  print('🛍️ Complete E-commerce Flow Example');

  final woocommerce = WooCommerce(
    baseUrl: storeUrl,
    username: consumerKey,
    password: consumerSecret,
    useFaker: true,
  );

  try {
    // Step 1: User authentication
    print('🔐 Step 1: User Authentication');
    await woocommerce.login('customer@example.com', 'password123');
    print('✅ User logged in');

    // Step 2: Browse products
    print('\n📦 Step 2: Browse Products');
    final products = await woocommerce.getProducts(
      perPage: 3,
      status: WooFilterStatus.publish,
    );
    print('✅ Found ${products.length} products');

    // Display first few products
    for (int i = 0; i < products.length && i < 2; i++) {
      print('  📦 ${products[i].name} - \$${products[i].price}');
    }

    // Step 3: Search for specific products
    print('\n🔍 Step 3: Search Products');
    final searchResults = await woocommerce.getProducts(
      search: 'widget',
      perPage: 2,
    );
    print('✅ Found ${searchResults.length} matching products');

    // Step 4: Get product details
    if (products.isNotEmpty) {
      print('\n📋 Step 4: Product Details');
      final product = products.first;
      final productDetails = await woocommerce.getProduct(product.id!);
      print('✅ Product details: ${productDetails.name}');
      print('💰 Price: \$${productDetails.price}');
      print('📦 Stock: ${productDetails.stockStatus}');
    }

    // Step 5: Get user's cart
    print('\n🛒 Step 5: Shopping Cart');
    final cart = await woocommerce.getCart();
    print('✅ Cart retrieved');
    print('🛒 Items in cart: ${cart.items?.length ?? 0}');

    // Step 6: Create an order
    print('\n📋 Step 6: Create Order');
    final order = WooOrder(
      id: 0,
      status: WooOrderStatus.pending,
      currency: WooOrderCurrency.USD,
      customerId: 1,
      billing: WooBilling(
        firstName: 'John',
        lastName: 'Doe',
        email: 'john.doe@example.com',
        address1: '123 Main St',
        city: 'New York',
        state: 'NY',
        postcode: '10001',
        country: 'US',
      ),
      lineItems: [
        WooLineItem(
          productId: 1,
          quantity: 1,
          name: 'Sample Product',
          price: 25.99,
        ),
      ],
      total: 25.99,
    );

    final createdOrder = await woocommerce.createOrder(order);
    print('✅ Order created: #${createdOrder.number}');
    print('💰 Total: \$${createdOrder.total}');

    // Step 7: Logout
    print('\n👋 Step 7: Logout');
    await woocommerce.logout();
    print('✅ User logged out');

    print('\n🎉 Complete e-commerce flow finished successfully!');
  } catch (e) {
    print('❌ Error in e-commerce flow: $e');
  }
}

// ============================================================================
// MAIN FUNCTION
// ============================================================================

void main() async {
  print('🚀 WooCommerce Flutter API Examples');
  print('=====================================\n');

  // Uncomment the example you want to run:

  // Setup examples
  // await setupExample();
  // await setupWithFakeData();

  // Authentication examples
  // await authenticationExample();
  // await registrationExample();

  // Product examples
  // await fetchProductsExample();
  // await searchProductsExample();
  // await createProductExample();
  // await updateProductExample();

  // Order examples
  // await createOrderExample();
  // await fetchOrdersExample();

  // Cart examples
  // await cartExample();

  // Advanced examples
  // await paginationExample();
  // await errorHandlingExample();

  // Complete flow
  await completeEcommerceFlow();

  print('\n✨ All examples completed!');
  print('💡 Uncomment different examples in main() to try them out');
}
