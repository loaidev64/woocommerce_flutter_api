import 'dart:async';
import 'package:woocommerce_flutter_api/woocommerce_flutter_api.dart';

part 'endpoints.dart';

/// WooCommerce Coupon API Extension
///
/// This extension provides comprehensive coupon management capabilities for WooCommerce stores.
/// It allows you to create, read, update, and delete coupons, as well as retrieve coupon lists
/// with extensive filtering and pagination options.
///
/// ## Key Features
///
/// - **Coupon Management**: Create, read, update, and delete coupons
/// - **Advanced Filtering**: Filter coupons by date, status, code, and more
/// - **Pagination Support**: Efficiently handle large coupon collections
/// - **Search Capabilities**: Find coupons by code or other criteria
/// - **Bulk Operations**: Handle multiple coupons efficiently
///
/// ## Example Usage
///
/// ```dart
/// // Get all coupons
/// final coupons = await wooCommerce.getCoupons();
///
/// // Create a new coupon
/// final coupon = WooCoupon(
///   code: 'SAVE20',
///   discountType: WooCouponDiscountType.percent,
///   amount: '20',
/// );
/// final created = await wooCommerce.createCoupon(coupon);
/// ```
extension WooCouponApi on WooCommerce {
  /// Retrieves a list of coupons from the WooCommerce store.
  ///
  /// This method supports extensive filtering and pagination options to help you
  /// find exactly the coupons you need.
  /// https://woocommerce.github.io/woocommerce-rest-api-docs/#list-all-coupons
  ///
  /// ## Parameters
  ///
  /// * [context] - Scope under which the request is made; determines fields present in response.
  ///   - `WooContext.view`: Returns basic coupon information (default)
  ///   - `WooContext.edit`: Returns full coupon details including sensitive data
  ///
  /// * [page] - Current page of the collection (default: 1)
  /// * [perPage] - Maximum number of items to return (default: 10, max: 100)
  /// * [search] - Limit results to coupons matching a search string
  /// * [after] - Limit response to coupons published after a given ISO8601 compliant date
  /// * [before] - Limit response to coupons published before a given ISO8601 compliant date
  /// * [modifiedAfter] - Limit response to coupons modified after a given ISO8601 compliant date
  /// * [modifiedBefore] - Limit response to coupons modified before a given ISO8601 compliant date
  /// * [datesAreGmt] - Whether to consider GMT post dates when limiting response by published or modified date
  /// * [exclude] - Ensure result set excludes specific coupon IDs
  /// * [include] - Limit result set to specific coupon IDs
  /// * [offset] - Offset the result set by a specific number of items
  /// * [order] - Order sort attribute ascending or descending (default: desc)
  /// * [orderby] - Sort collection by object attribute (default: date)
  /// * [code] - Limit result set to coupons with a specific code
  /// * [useFaker] - When true, returns fake data for testing purposes
  ///
  /// ## Returns
  ///
  /// A `Future<List<WooCoupon>>` containing the coupon objects.
  ///
  /// ## Throws
  ///
  /// * `WooCommerceException` if the request fails or access is denied
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// // Get all coupons
  /// final coupons = await wooCommerce.getCoupons();
  ///
  /// // Search for coupons with specific code
  /// final searchResults = await wooCommerce.getCoupons(
  ///   search: 'SAVE20',
  ///   perPage: 20,
  /// );
  ///
  /// // Get coupons created after a specific date
  /// final recentCoupons = await wooCommerce.getCoupons(
  ///   after: DateTime(2024, 1, 1),
  ///   order: WooSortOrder.desc,
  /// );
  /// ```
  Future<List<WooCoupon>> getCoupons({
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
    WooSortCoupon orderby = WooSortCoupon.date,
    String? code,
    bool? useFaker,
  }) async {
    final isUsingFaker = useFaker ?? this.useFaker;

    if (isUsingFaker) {
      return List.generate(perPage, (index) => WooCoupon.fake());
    }

    final response = await dio.get(
      _CouponEndpoints.coupons,
      queryParameters: _resolveQueryParametersForGettingCoupons(
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
        orderBy: orderby,
        code: code,
      ),
    );

    return (response.data as List)
        .map((item) => WooCoupon.fromJson(item))
        .toList();
  }

  /// Resolves query parameters for the getCoupons method.
  ///
  /// This private helper method converts the method parameters into the appropriate
  /// query parameters format expected by the WooCommerce REST API.
  ///
  /// ## Parameters
  ///
  /// All parameters correspond to the getCoupons method parameters.
  ///
  /// ## Returns
  ///
  /// A `Map<String, dynamic>` containing the formatted query parameters.
  Map<String, dynamic> _resolveQueryParametersForGettingCoupons({
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
    required WooSortCoupon orderBy,
    required String? code,
  }) {
    final map = <String, dynamic>{
      'context': context.name,
      'page': page,
      'per_page': perPage,
      'order': order.name,
      'orderby': orderBy.name,
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

    if (code != null) {
      map['code'] = code;
    }

    return map;
  }

  /// Retrieves a single coupon by its ID from the WooCommerce store.
  ///
  /// This method fetches detailed information about a specific coupon,
  /// including all its properties and settings.
  /// https://woocommerce.github.io/woocommerce-rest-api-docs/#retrieve-a-coupon
  ///
  /// ## Parameters
  ///
  /// * [id] - The unique identifier of the coupon to retrieve
  /// * [useFaker] - When true, returns fake data for testing purposes
  ///
  /// ## Returns
  ///
  /// A `Future<WooCoupon>` containing the coupon object.
  ///
  /// ## Throws
  ///
  /// * `WooCommerceException` if the coupon is not found or access is denied
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// // Get a specific coupon
  /// final coupon = await wooCommerce.getCoupon(123);
  ///
  /// // Check coupon details
  /// if (coupon.isActive) {
  ///   print('Coupon ${coupon.code} is active');
  /// }
  /// ```
  Future<WooCoupon> getCoupon(int id, {bool? useFaker}) async {
    final isUsingFaker = useFaker ?? this.useFaker;

    if (isUsingFaker) {
      return WooCoupon.fake(id);
    }

    final response = await dio.get(
      _CouponEndpoints.singleCoupon(id),
    );

    return WooCoupon.fromJson(response.data as Map<String, dynamic>);
  }

  /// Creates a new coupon in the WooCommerce store.
  ///
  /// This method creates a new coupon with the specified properties and settings.
  /// The coupon will be immediately available for use in the store.
  /// https://woocommerce.github.io/woocommerce-rest-api-docs/#create-a-coupon
  ///
  /// ## Parameters
  ///
  /// * [coupon] - The coupon object containing all the coupon details
  /// * [useFaker] - When true, returns fake data for testing purposes
  ///
  /// ## Returns
  ///
  /// A `Future<WooCoupon>` containing the created coupon object with server-assigned ID.
  ///
  /// ## Throws
  ///
  /// * `WooCommerceException` if the coupon creation fails or validation errors occur
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// // Create a percentage discount coupon
  /// final coupon = WooCoupon(
  ///   code: 'SAVE20',
  ///   discountType: WooCouponDiscountType.percent,
  ///   amount: '20',
  ///   description: '20% off your order',
  /// );
  /// final created = await wooCommerce.createCoupon(coupon);
  ///
  /// // Create a fixed amount discount coupon
  /// final fixedCoupon = WooCoupon(
  ///   code: 'FIXED10',
  ///   discountType: WooCouponDiscountType.fixedCart,
  ///   amount: '10.00',
  /// );
  /// final createdFixed = await wooCommerce.createCoupon(fixedCoupon);
  /// ```
  Future<WooCoupon> createCoupon(WooCoupon coupon, {bool? useFaker}) async {
    final isUsingFaker = useFaker ?? this.useFaker;

    if (isUsingFaker) {
      return coupon;
    }

    final response = await dio.post(
      _CouponEndpoints.coupons,
      data: coupon.toJson(),
    );

    return WooCoupon.fromJson(response.data as Map<String, dynamic>);
  }

  /// Updates an existing coupon in the WooCommerce store.
  ///
  /// This method updates the properties and settings of an existing coupon.
  /// The coupon must have a valid ID to be updated.
  /// https://woocommerce.github.io/woocommerce-rest-api-docs/#update-a-coupon
  ///
  /// ## Parameters
  ///
  /// * [coupon] - The coupon object with updated properties (must include valid ID)
  /// * [useFaker] - When true, returns fake data for testing purposes
  ///
  /// ## Returns
  ///
  /// A `Future<WooCoupon>` containing the updated coupon object.
  ///
  /// ## Throws
  ///
  /// * `WooCommerceException` if the coupon update fails, coupon not found, or validation errors occur
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// // Update an existing coupon
  /// final existingCoupon = await wooCommerce.getCoupon(123);
  /// final updatedCoupon = existingCoupon.copyWith(
  ///   amount: '25', // Change discount from 20% to 25%
  ///   description: 'Updated 25% off your order',
  /// );
  /// final result = await wooCommerce.updateCoupon(updatedCoupon);
  ///
  /// // Update coupon status
  /// final deactivatedCoupon = existingCoupon.copyWith(
  ///   status: WooCouponStatus.draft,
  /// );
  /// await wooCommerce.updateCoupon(deactivatedCoupon);
  /// ```
  Future<WooCoupon> updateCoupon(WooCoupon coupon, {bool? useFaker}) async {
    final isUsingFaker = useFaker ?? this.useFaker;

    if (isUsingFaker) {
      return coupon;
    }

    final response = await dio.put(
      _CouponEndpoints.singleCoupon(coupon.id!),
      data: coupon.toJson(),
    );

    return WooCoupon.fromJson(response.data as Map<String, dynamic>);
  }

  /// Deletes a coupon from the WooCommerce store.
  ///
  /// This method removes a coupon from the store. By default, the coupon is moved to trash,
  /// but it can be permanently deleted using the force parameter.
  /// https://woocommerce.github.io/woocommerce-rest-api-docs/#delete-a-coupon
  ///
  /// ## Parameters
  ///
  /// * [id] - The unique identifier of the coupon to delete
  /// * [useFaker] - When true, returns fake data for testing purposes
  /// * [force] - Whether to permanently delete the coupon (default: false, moves to trash)
  ///
  /// ## Returns
  ///
  /// A `Future<bool>` indicating whether the deletion was successful.
  ///
  /// ## Throws
  ///
  /// * `WooCommerceException` if the coupon deletion fails or coupon not found
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// // Move coupon to trash (can be restored)
  /// final success = await wooCommerce.deleteCoupon(123);
  ///
  /// // Permanently delete coupon
  /// final permanentDelete = await wooCommerce.deleteCoupon(
  ///   123,
  ///   force: true,
  /// );
  ///
  /// if (success) {
  ///   print('Coupon deleted successfully');
  /// }
  /// ```
  Future<bool> deleteCoupon(
    int id, {
    bool? useFaker,
    bool force = false,
  }) async {
    final isUsingFaker = useFaker ?? this.useFaker;

    if (isUsingFaker) {
      return true;
    }

    await dio.delete(
      _CouponEndpoints.singleCoupon(id),
      queryParameters: {
        'force': force,
      },
    );

    return true;
  }

  /// Performs batch operations on coupons (create, update, delete) in a single request.
  ///
  /// This method allows you to create, update, and delete multiple coupons
  /// efficiently in a single API call, reducing the number of requests needed
  /// for bulk operations.
  /// https://woocommerce.github.io/woocommerce-rest-api-docs/#batch-update-coupons
  ///
  /// ## Parameters
  ///
  /// * [request] - The batch request containing coupons to create, update, and/or delete
  ///   - `create`: List of `WooCoupon` objects to create (should not have IDs)
  ///   - `update`: List of `WooCoupon` objects to update (must include valid IDs)
  ///   - `delete`: List of coupon IDs (integers) to delete
  /// * [useFaker] - When true, returns fake data for testing purposes
  ///
  /// ## Returns
  ///
  /// A `Future<WooCouponBatchResponse>` containing the results of all batch operations:
  /// - `create`: List of successfully created coupons with server-assigned IDs
  /// - `update`: List of successfully updated coupons
  /// - `delete`: List of successfully deleted coupons
  ///
  /// ## Throws
  ///
  /// * `WooCommerceException` if the batch operation fails or validation errors occur
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// // Create a batch request with multiple operations
  /// final batchRequest = WooCouponBatchRequest(
  ///   create: [
  ///     WooCoupon(
  ///       code: 'SAVE20',
  ///       discountType: 'percent',
  ///       amount: '20',
  ///       description: '20% off your order',
  ///     ),
  ///     WooCoupon(
  ///       code: 'FIXED10',
  ///       discountType: 'fixed_cart',
  ///       amount: '10.00',
  ///       description: '$10 off your order',
  ///     ),
  ///   ],
  ///   update: [
  ///     existingCoupon.copyWith(
  ///       amount: '25',
  ///       description: 'Updated 25% off',
  ///     ),
  ///   ],
  ///   delete: [123, 456],
  /// );
  ///
  /// // Execute the batch operation
  /// final response = await wooCommerce.batchUpdateCoupons(batchRequest);
  ///
  /// // Process results
  /// print('Created ${response.create?.length ?? 0} coupons');
  /// print('Updated ${response.update?.length ?? 0} coupons');
  /// print('Deleted ${response.delete?.length ?? 0} coupons');
  ///
  /// // Access individual results
  /// for (final coupon in response.create ?? []) {
  ///   print('Created coupon: ${coupon.code} with ID: ${coupon.id}');
  /// }
  /// ```
  ///
  /// ## Batch Operations Best Practices
  ///
  /// - **Create operations**: Coupons should not have IDs assigned
  /// - **Update operations**: Coupons must have valid IDs and will be updated with provided values
  /// - **Delete operations**: Provide only the IDs of coupons to delete
  /// - **Mixed operations**: You can combine create, update, and delete in a single request
  /// - **Error handling**: If any operation fails, the entire batch may fail depending on API behavior
  Future<WooCouponBatchResponse> batchUpdateCoupons(
    WooCouponBatchRequest request, {
    bool? useFaker,
  }) async {
    final isUsingFaker = useFaker ?? this.useFaker;

    if (isUsingFaker) {
      return WooCouponBatchResponse(
        create: request.create?.map((coupon) => WooCoupon.fake()).toList(),
        update: request.update,
        delete: request.delete?.map((id) => WooCoupon.fake(id)).toList(),
      );
    }

    final response = await dio.post(
      _CouponEndpoints.batchCoupons(),
      data: request.toJson(),
    );

    return WooCouponBatchResponse.fromJson(
      response.data as Map<String, dynamic>,
    );
  }
}
