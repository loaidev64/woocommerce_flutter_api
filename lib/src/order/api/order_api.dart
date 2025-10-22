import 'package:woocommerce_flutter_api/woocommerce_flutter_api.dart';

part 'order_endpoints.dart';

/// WooCommerce Order API Extension
///
/// This extension provides comprehensive order management capabilities for WooCommerce stores.
/// Orders represent customer purchases and contain all the information needed for fulfillment.
///
/// ## Key Features
///
/// - **Order Retrieval**: Get orders with extensive filtering and pagination
/// - **Order Management**: Create, update, and delete orders
/// - **Order Status Management**: Track order lifecycle from pending to completed
/// - **Customer Orders**: Retrieve orders for specific customers
/// - **Order Notifications**: Send order details to customers via email
/// - **Advanced Filtering**: Filter by status, customer, product, date, and more
///
/// ## Example Usage
///
/// ```dart
/// // Get all orders
/// final orders = await wooCommerce.getOrders();
///
/// // Create a new order
/// final order = WooOrder(
///   id: 0,
///   status: WooOrderStatus.pending,
///   total: 99.99,
/// );
/// final createdOrder = await wooCommerce.createOrder(order);
///
/// // Get orders for a specific customer
/// final customerOrders = await wooCommerce.getOrders(
///   customer: 123,
///   status: [WooOrderStatus.completed],
/// );
/// ```
extension WooOrderApi on WooCommerce {
  /// Retrieves a list of orders from the WooCommerce store.
  ///
  /// This method supports extensive filtering and pagination options to help you
  /// find exactly the orders you need for order management and reporting.
  /// https://woocommerce.github.io/woocommerce-rest-api-docs/#list-all-orders
  ///
  /// ## Parameters
  ///
  /// * [context] - Scope under which the request is made; determines fields present in response.
  ///   - `WooContext.view`: Returns basic order information (default)
  ///   - `WooContext.edit`: Returns full order details including sensitive data
  ///
  /// * [page] - Current page of the collection (default: 1)
  /// * [perPage] - Maximum number of items to return (default: 10, max: 100)
  /// * [search] - Limit results to orders matching a search string
  /// * [after] - Limit response to orders created after this date
  /// * [before] - Limit response to orders created before this date
  /// * [modifiedAfter] - Limit response to orders modified after this date
  /// * [modifiedBefore] - Limit response to orders modified before this date
  /// * [datesAreGmt] - Whether to consider GMT dates when filtering by date
  /// * [exclude] - Exclude orders with specific IDs from results
  /// * [include] - Only include orders with specific IDs
  /// * [offset] - Offset the result set by a specific number of items
  /// * [order] - Sort order: `WooSortOrder.asc` or `WooSortOrder.desc` (default: desc)
  /// * [orderBy] - Sort by: `WooOrderOrderBy.date`, `WooOrderOrderBy.id`, etc. (default: date)
  /// * [parent] - Limit result set to orders with specific parent IDs
  /// * [parentExclude] - Exclude orders with specific parent IDs
  /// * [status] - Filter by order status (default: any)
  /// * [customer] - Filter by customer ID
  /// * [product] - Filter by product ID
  /// * [dp] - Number of decimal points to use in each resource (default: 2)
  /// * [useFaker] - When true, returns fake data for testing purposes
  ///
  /// ## Returns
  ///
  /// A `Future<List<WooOrder>>` containing the order objects.
  ///
  /// ## Throws
  ///
  /// * `WooCommerceException` if the request fails or access is denied
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// // Get all pending orders
  /// final pendingOrders = await wooCommerce.getOrders(
  ///   status: [WooOrderStatus.pending],
  ///   perPage: 50,
  /// );
  ///
  /// // Get orders for a specific customer
  /// final customerOrders = await wooCommerce.getOrders(
  ///   customer: 123,
  ///   orderBy: WooOrderOrderBy.date,
  ///   order: WooSortOrder.desc,
  /// );
  ///
  /// // Get orders from the last 30 days
  /// final recentOrders = await wooCommerce.getOrders(
  ///   after: DateTime.now().subtract(Duration(days: 30)),
  /// );
  /// ```
  Future<List<WooOrder>> getOrders({
    WooContext context = WooContext.view,
    int page = 1,
    int perPage = 10,
    String? search,
    DateTime? after,
    DateTime? before,
    DateTime? modifiedAfter,
    DateTime? modifiedBefore,
    bool? datesAreGmt,
    List<int>? exclude,
    List<int>? include,
    int? offset,
    WooSortOrder order = WooSortOrder.desc,
    WooOrderOrderBy orderBy = WooOrderOrderBy.date,
    List<int>? parent,
    List<int>? parentExclude,
    List<WooOrderStatus> status = const [WooOrderStatus.any],
    int? customer,
    int? product,
    int? dp,
    bool? useFaker,
  }) async {
    final isUsingFaker = useFaker ?? this.useFaker;

    if (isUsingFaker) {
      return List.generate(perPage, (index) => WooOrder.fake());
    }

    final response = await dio.get(
      _OrderEndpoints.orders,
      queryParameters: _resolveQueryParametersForGettingOrders(
        context: context,
        page: page,
        perPage: perPage,
        search: search,
        after: after,
        before: before,
        modifiedAfter: modifiedAfter,
        modifiedBefore: modifiedBefore,
        datesAreGmt: datesAreGmt,
        exclude: exclude,
        include: include,
        offset: offset,
        order: order,
        orderBy: orderBy,
        parent: parent,
        parentExclude: parentExclude,
        status: status,
        customer: customer,
        product: product,
        dp: dp,
      ),
    );

    return (response.data as List)
        .map((item) => WooOrder.fromJson(item))
        .toList();
  }

  /// Resolves query parameters for the getOrders method.
  ///
  /// This private helper method converts the method parameters into the appropriate
  /// query parameters format expected by the WooCommerce REST API.
  ///
  /// ## Parameters
  ///
  /// All parameters correspond to the getOrders method parameters.
  ///
  /// ## Returns
  ///
  /// A `Map<String, dynamic>` containing the formatted query parameters.
  Map<String, dynamic> _resolveQueryParametersForGettingOrders({
    required WooContext context,
    required int page,
    required int perPage,
    required String? search,
    required DateTime? after,
    required DateTime? before,
    required DateTime? modifiedAfter,
    required DateTime? modifiedBefore,
    required bool? datesAreGmt,
    required List<int>? exclude,
    required List<int>? include,
    required int? offset,
    required WooSortOrder order,
    required WooOrderOrderBy orderBy,
    required List<int>? parent,
    required List<int>? parentExclude,
    required List<WooOrderStatus> status,
    required int? customer,
    required int? product,
    required int? dp,
  }) {
    final map = <String, dynamic>{
      'context': context.name,
      'page': page,
      'per_page': perPage,
      'order': order.name,
      'orderby': orderBy.name,
      'status': status.map((item) => item.name).join(','),
    };

    if (search != null) {
      map['search'] = search;
    }

    if (after != null) {
      map['after'] = after.toIso8601String();
    }

    if (before != null) {
      map['before'] = before.toIso8601String();
    }

    if (modifiedAfter != null) {
      map['modified_after'] = modifiedAfter.toIso8601String();
    }

    if (modifiedBefore != null) {
      map['modified_before'] = modifiedBefore.toIso8601String();
    }

    if (datesAreGmt != null) {
      map['dates_are_gmt'] = datesAreGmt;
    }

    if (exclude != null) {
      map['exclude'] = exclude.join(',');
    }

    if (include != null) {
      map['include'] = include.join(',');
    }

    if (offset != null) {
      map['offset'] = offset;
    }

    if (parent != null) {
      map['parent'] = parent.join(',');
    }

    if (parentExclude != null) {
      map['parent_exclude'] = parentExclude.join(',');
    }

    if (customer != null) {
      map['customer'] = customer;
    }

    if (product != null) {
      map['product'] = product;
    }

    if (dp != null) {
      map['dp'] = dp;
    }

    return map;
  }

  /// Retrieves a single order by its ID.
  ///
  /// This method fetches detailed information about a specific order,
  /// including all order data, line items, customer information, and metadata.
  /// https://woocommerce.github.io/woocommerce-rest-api-docs/#retrieve-an-order
  ///
  /// ## Parameters
  ///
  /// * [id] - The unique identifier of the order to retrieve
  /// * [useFaker] - When true, returns fake data for testing purposes
  ///
  /// ## Returns
  ///
  /// A `Future<WooOrder>` containing the order object with all details.
  ///
  /// ## Throws
  ///
  /// * `WooCommerceException` if the order is not found or access is denied
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// // Get a specific order
  /// final order = await wooCommerce.getOrder(123);
  /// print('Order ${order.number}: \$${order.total}');
  ///
  /// // Get order with customer details
  /// if (order.billing != null) {
  ///   print('Customer: ${order.billing!.firstName} ${order.billing!.lastName}');
  /// }
  ///
  /// // Check order status
  /// if (order.status == WooOrderStatus.completed) {
  ///   print('Order has been fulfilled');
  /// }
  /// ```
  Future<WooOrder> getOrder(int id, {bool? useFaker}) async {
    final isUsingFaker = useFaker ?? this.useFaker;

    if (isUsingFaker) {
      return WooOrder.fake();
    }

    final response = await dio.get(_OrderEndpoints.singleOrder(id));

    return WooOrder.fromJson(response.data as Map<String, dynamic>);
  }

  /// Creates a new order in the WooCommerce store.
  ///
  /// This method creates a new order with all the provided details including
  /// customer information, line items, billing, shipping, and payment data.
  /// https://woocommerce.github.io/woocommerce-rest-api-docs/#create-an-order
  ///
  /// ## Parameters
  ///
  /// * [order] - The order object containing all order details
  /// * [useFaker] - When true, returns fake data for testing purposes
  ///
  /// ## Returns
  ///
  /// A `Future<WooOrder>` containing the created order with assigned ID.
  ///
  /// ## Throws
  ///
  /// * `WooCommerceException` if the order creation fails or validation errors occur
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// // Create a new order
  /// final order = WooOrder(
  ///   id: 0, // Will be assigned by WooCommerce
  ///   status: WooOrderStatus.pending,
  ///   currency: WooOrderCurrency.usd,
  ///   customerId: 123,
  ///   billing: WooBilling(
  ///     firstName: 'John',
  ///     lastName: 'Doe',
  ///     email: 'john@example.com',
  ///   ),
  ///   lineItems: [
  ///     WooLineItem(
  ///       productId: 456,
  ///       quantity: 2,
  ///       total: 59.98,
  ///     ),
  ///   ],
  ///   total: 59.98,
  /// );
  ///
  /// final createdOrder = await wooCommerce.createOrder(order);
  /// print('Created order ID: ${createdOrder.id}');
  /// ```
  Future<WooOrder> createOrder(WooOrder order, {bool? useFaker}) async {
    final isUsingFaker = useFaker ?? this.useFaker;

    if (isUsingFaker) {
      return order;
    }

    final response = await dio.post(
      _OrderEndpoints.orders,
      data: order.toJson(),
    );

    return WooOrder.fromJson(response.data as Map<String, dynamic>);
  }

  /// Updates an existing order in the WooCommerce store.
  ///
  /// This method updates an existing order with new information. You can modify
  /// order status, customer details, line items, billing, shipping, and other order data.
  /// https://woocommerce.github.io/woocommerce-rest-api-docs/#update-an-order
  ///
  /// ## Parameters
  ///
  /// * [order] - The order object with updated information (must include valid ID)
  /// * [useFaker] - When true, returns fake data for testing purposes
  ///
  /// ## Returns
  ///
  /// A `Future<WooOrder>` containing the updated order with all changes applied.
  ///
  /// ## Throws
  ///
  /// * `WooCommerceException` if the order update fails or the order doesn't exist
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// // Update order status
  /// final updatedOrder = order.copyWith(
  ///   status: WooOrderStatus.processing,
  ///   setPaid: true,
  /// );
  /// final result = await wooCommerce.updateOrder(updatedOrder);
  ///
  /// // Update customer information
  /// final orderWithNewBilling = order.copyWith(
  ///   billing: WooBilling(
  ///     firstName: 'Jane',
  ///     lastName: 'Smith',
  ///     email: 'jane@example.com',
  ///   ),
  /// );
  /// await wooCommerce.updateOrder(orderWithNewBilling);
  /// ```
  Future<WooOrder> updateOrder(WooOrder order, {bool? useFaker}) async {
    final isUsingFaker = useFaker ?? this.useFaker;

    if (isUsingFaker) {
      return order;
    }

    final response = await dio.put(
      _OrderEndpoints.orders,
      data: order.toJson(),
    );

    return WooOrder.fromJson(response.data as Map<String, dynamic>);
  }

  /// Deletes an order from the WooCommerce store.
  ///
  /// This method removes an order from the store. By default, orders are moved to trash
  /// and can be restored. Use the force parameter to permanently delete the order.
  /// https://woocommerce.github.io/woocommerce-rest-api-docs/#delete-an-order
  ///
  /// ## Parameters
  ///
  /// * [id] - The unique identifier of the order to delete
  /// * [force] - Whether to permanently delete the order (default: false - move to trash)
  /// * [useFaker] - When true, returns fake data for testing purposes
  ///
  /// ## Returns
  ///
  /// A `Future<bool>` indicating whether the deletion was successful.
  ///
  /// ## Throws
  ///
  /// * `WooCommerceException` if the order deletion fails or the order doesn't exist
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// // Move order to trash (default)
  /// final deleted = await wooCommerce.deleteOrder(123);
  /// if (deleted) {
  ///   print('Order moved to trash');
  /// }
  ///
  /// // Permanently delete order
  /// final permanentlyDeleted = await wooCommerce.deleteOrder(123, force: true);
  /// if (permanentlyDeleted) {
  ///   print('Order permanently deleted');
  /// }
  /// ```
  Future<bool> deleteOrder(
    int id, {
    bool? useFaker,
    bool force = false,
  }) async {
    final isUsingFaker = useFaker ?? this.useFaker;

    if (isUsingFaker) {
      return true;
    }

    await dio.delete(
      _OrderEndpoints.singleOrder(id),
      queryParameters: {
        'force': force,
      },
    );

    return true;
  }

  /// Sends order details to the customer via email.
  ///
  /// This method triggers an email notification to the customer containing
  /// their order details, including items, totals, and shipping information.
  /// The email is only sent if the order contains a valid customer email address.
  /// https://woocommerce.github.io/woocommerce-rest-api-docs/#send-order-details-to-customer
  ///
  /// ## Parameters
  ///
  /// * [orderId] - The unique identifier of the order
  /// * [useFaker] - When true, returns fake data for testing purposes
  ///
  /// ## Returns
  ///
  /// A `Future<String>` containing the confirmation message about the email send.
  ///
  /// ## Throws
  ///
  /// * `WooCommerceException` if the email sending fails or the order doesn't exist
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// // Send order confirmation email
  /// final message = await wooCommerce.sendOrderDetailsToCustomer(123);
  /// print('Email status: $message');
  ///
  /// // Send email after order completion
  /// if (order.status == WooOrderStatus.completed) {
  ///   final emailResult = await wooCommerce.sendOrderDetailsToCustomer(order.id!);
  ///   print('Customer notified: $emailResult');
  /// }
  /// ```
  Future<String> sendOrderDetailsToCustomer(
    int orderId, {
    bool? useFaker,
  }) async {
    final isUsingFaker = useFaker ?? this.useFaker;

    if (isUsingFaker) {
      return 'Order details sent to woo@example.com, via REST API.';
    }

    final response = await dio.post(_OrderEndpoints.sendOrderDetails(orderId));

    return (response.data as Map<String, String>)['message']!;
  }
}
