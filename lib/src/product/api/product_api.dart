import 'dart:async';

import 'package:woocommerce_flutter_api/src/product/models/product_with_childrens.dart';
import 'package:woocommerce_flutter_api/woocommerce_flutter_api.dart';

part 'product_endpoints.dart';

/// WooCommerce Product API Extension
///
/// This extension provides comprehensive product management capabilities for WooCommerce stores.
/// Products are the core entities in any e-commerce store, representing items that customers can purchase.
///
/// ## Key Features
///
/// - **Product Retrieval**: Get products with extensive filtering and pagination
/// - **Product Management**: Create, update, and delete products
/// - **Product Variations**: Handle variable products with multiple options
/// - **Product Relationships**: Manage related, upsell, and cross-sell products
/// - **Advanced Filtering**: Filter by category, tag, price, stock status, and more
/// - **Bulk Operations**: Duplicate products and manage product hierarchies
///
/// ## Example Usage
///
/// ```dart
/// // Get all products
/// final products = await wooCommerce.getProducts();
///
/// // Create a new product
/// final product = WooProduct(
///   name: 'New Product',
///   type: WooProductType.simple,
///   price: 29.99,
/// );
/// final createdProduct = await wooCommerce.createProduct(product);
///
/// // Get products with filtering
/// final featuredProducts = await wooCommerce.getProducts(
///   featured: true,
///   status: WooFilterStatus.publish,
/// );
/// ```
extension WooProductApi on WooCommerce {
  /// Retrieves a list of products from the WooCommerce store.
  ///
  /// This method supports extensive filtering and pagination options to help you
  /// find exactly the products you need.
  ///
  /// ## Parameters
  ///
  /// - [context]: Scope under which the request is made; determines fields present in response. Options: view and edit. Default is view.
  /// - [page]: Current page of the collection. Default is 1.
  /// - [perPage]: Maximum number of items to be returned in result set. Default is 10.
  /// - [search]: Limit results to those matching a string.
  /// - [after]: Limit response to resources published after a given ISO8601 compliant date.
  /// - [before]: Limit response to resources published before a given ISO8601 compliant date.
  /// - [modifiedAfter]: Limit response to resources modified after a given ISO8601 compliant date.
  /// - [modifiedBefore]: Limit response to resources modified after a given ISO8601 compliant date.
  /// - [datesAreGmt]: Whether to consider GMT post dates when limiting response by published or modified date.
  /// - [exclude]: Ensure result set excludes specific IDs.
  /// - [include]: Limit result set to specific ids.
  /// - [offset]: Offset the result set by a specific number of items.
  /// - [order]: Order sort attribute ascending or descending. Options: asc and desc. Default is desc.
  /// - [orderBy]: Sort collection by object attribute. Options: date, id, include, title, slug, price, popularity and rating. Default is date.
  /// - [parent]: Limit result set to those of particular parent IDs.
  /// - [parentExclude]: Limit result set to all items except those of a particular parent ID.
  /// - [slug]: Limit result set to products with a specific slug.
  /// - [status]: Limit result set to products assigned a specific status. Options: any, draft, pending, private and publish. Default is any.
  /// - [type]: Limit result set to products assigned a specific type. Options: simple, grouped, external and variable.
  /// - [sku]: Limit result set to products with a specific SKU.
  /// - [featured]: Limit result set to featured products.
  /// - [category]: Limit result set to products assigned a specific category ID.
  /// - [tag]: Limit result set to products assigned a specific tag ID.
  /// - [shippingClass]: Limit result set to products assigned a specific shipping class ID.
  /// - [attribute]: Limit result set to products with a specific attribute.
  /// - [attributeTerm]: Limit result set to products with a specific attribute term ID (required an assigned attribute).
  /// - [taxClass]: Limit result set to products with a specific tax class. Default options: standard, reduced-rate and zero-rate.
  /// - [onSale]: Limit result set to products on sale.
  /// - [minPrice]: Limit result set to products based on a minimum price.
  /// - [maxPrice]: Limit result set to products based on a maximum price.
  /// - [stockStatus]: Limit result set to products with specified stock status. Options: instock, outofstock and onbackorder.
  /// - [useFaker]: Override the global useFaker setting for this request.
  ///
  /// ## Returns
  ///
  /// A [Future] that completes with a list of [WooProduct] objects.
  ///
  /// ## Example
  ///
  /// ```dart
  /// // Get first 10 published products
  /// final products = await woocommerce.getProducts(
  ///   perPage: 10,
  ///   status: WooFilterStatus.publish,
  /// );
  ///
  /// // Search for products
  /// final searchResults = await woocommerce.getProducts(
  ///   search: 'laptop',
  ///   perPage: 20,
  /// );
  ///
  /// // Get featured products on sale
  /// final featuredOnSale = await woocommerce.getProducts(
  ///   featured: true,
  ///   onSale: true,
  /// );
  /// ```
  Future<List<WooProduct>> getProducts({
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
    WooSortOrderBy orderBy = WooSortOrderBy.date,
    List<int>? parent,
    List<int>? parentExclude,
    String? slug,
    WooFilterStatus status = WooFilterStatus.any,
    WooProductType? type,
    String? sku,
    bool? featured,
    int? category,
    int? tag,
    int? shippingClass,
    String? attribute,
    String? attributeTerm,
    String? taxClass,
    bool? onSale,
    double? minPrice,
    double? maxPrice,
    WooProductStockStatus? stockStatus,
    bool? useFaker,
  }) async {
    final isUsingFaker = useFaker ?? this.useFaker;

    if (isUsingFaker) {
      return List.generate(perPage, (index) => WooProduct.fake());
    }

    final response = await dio.get(
      _ProductEndpoints.products,
      queryParameters: _resolveQueryParametersForGettingProducts(
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
        slug: slug,
        status: status,
        type: type,
        sku: sku,
        featured: featured,
        category: category,
        tag: tag,
        shippingClass: shippingClass,
        attribute: attribute,
        attributeTerm: attributeTerm,
        taxClass: taxClass,
        onSale: onSale,
        minPrice: minPrice,
        maxPrice: maxPrice,
        stockStatus: stockStatus,
      ),
    );

    return (response.data as List)
        .map((item) => WooProduct.fromJson(item))
        .toList();
  }

  Map<String, dynamic> _resolveQueryParametersForGettingProducts({
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
    required WooSortOrderBy orderBy,
    required List<int>? parent,
    required List<int>? parentExclude,
    required String? slug,
    required WooFilterStatus status,
    required WooProductType? type,
    required String? sku,
    required bool? featured,
    required int? category,
    required int? tag,
    required int? shippingClass,
    required String? attribute,
    required String? attributeTerm,
    required String? taxClass,
    required bool? onSale,
    required double? minPrice,
    required double? maxPrice,
    required WooProductStockStatus? stockStatus,
  }) {
    final map = <String, dynamic>{
      'context': context.name,
      'page': page,
      'per_page': perPage,
      'order': order.name,
      'orderby': orderBy.name,
      'status': status.name,
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

    if (slug != null) {
      map['slug'] = slug;
    }

    if (type != null) {
      map['type'] = type.name;
    }

    if (sku != null) {
      map['sku'] = sku;
    }

    if (featured != null) {
      map['featured'] = featured;
    }

    if (category != null) {
      map['category'] = category;
    }

    if (tag != null) {
      map['tag'] = tag;
    }

    if (shippingClass != null) {
      map['shipping_class'] = shippingClass;
    }

    if (attribute != null) {
      map['attribute'] = attribute;
    }

    if (attributeTerm != null) {
      map['attribute_term'] = attributeTerm;
    }

    if (taxClass != null) {
      map['tax_class'] = taxClass;
    }

    if (onSale != null) {
      map['on_sale'] = onSale;
    }

    if (minPrice != null) {
      map['min_price'] = minPrice;
    }

    if (maxPrice != null) {
      map['max_price'] = maxPrice;
    }

    if (stockStatus != null) {
      map['stock_status'] = stockStatus.name;
    }

    return map;
  }

  /// Retrieves a single product by its ID.
  ///
  /// ## Parameters
  ///
  /// - [id]: The unique identifier of the product to retrieve.
  /// - [useFaker]: Override the global useFaker setting for this request.
  ///
  /// ## Returns
  ///
  /// A [Future] that completes with a [WooProduct] object.
  ///
  /// ## Example
  ///
  /// ```dart
  /// final product = await woocommerce.getProduct(123);
  /// print('Product: ${product.name}');
  /// ```
  Future<WooProduct> getProduct(int id, {bool? useFaker}) async {
    final isUsingFaker = useFaker ?? this.useFaker;

    if (isUsingFaker) {
      return WooProduct.fake();
    }

    final response = await dio.get(
      _ProductEndpoints.singleProduct(id),
    );

    return WooProduct.fromJson(response.data as Map<String, dynamic>);
  }

  /// Retrieves a product along with its related products in a single optimized request.
  ///
  /// This method is particularly useful for product detail pages where you need
  /// to display the main product along with its variations, upsells, cross-sells,
  /// or related products without making multiple API calls.
  ///
  /// ## Parameters
  ///
  /// - [product]: The main product for which to fetch related data.
  /// - [types]: List of related product types to fetch (variations, upsells, etc.).
  /// - [useFaker]: Override the global useFaker setting for this request.
  ///
  /// ## Returns
  ///
  /// A [Future] that completes with a [WooProductWithChildrens] object containing
  /// the main product and all requested related products.
  ///
  /// ## Example
  ///
  /// ```dart
  /// final productWithDetails = await woocommerce.getProductWithOptions(
  ///   selectedProduct,
  ///   [
  ///     WooProductFilterWithType.variations,
  ///     WooProductFilterWithType.upsellIds,
  ///     WooProductFilterWithType.relatedIds,
  ///   ],
  /// );
  ///
  /// // Access main product
  /// print('Main: ${productWithDetails.mainProduct.name}');
  ///
  /// // Access variations
  /// for (final variation in productWithDetails.variations ?? []) {
  ///   print('Variation: ${variation.name}');
  /// }
  /// ```
  Future<WooProductWithChildrens> getProductWithOptions(
      WooProduct product, List<WooProductFilterWithType> types,
      {bool? useFaker}) async {
    final isUsingFaker = useFaker ?? this.useFaker;

    if (isUsingFaker) {
      return WooProductWithChildrens.fake().copyWith(mainProduct: product);
    }

    final response = await dio.get(_ProductEndpoints.products,
        queryParameters:
            _resolveQueryParametersForGettingProductWithOption(types, product));

    return WooProductWithChildrens.fromData(
        response.data as List<Map<String, dynamic>>, product);
  }

  Map<String, dynamic> _resolveQueryParametersForGettingProductWithOption(
      List<WooProductFilterWithType> options, WooProduct product) {
    final map = <String, dynamic>{};
    final includes = <int>[product.id!];

    for (final option in options) {
      if (option == WooProductFilterWithType.crossSellIds) {
        includes.addAll(product.crossSellIds ?? []);
      }
      if (option == WooProductFilterWithType.groupedProducts) {
        includes.addAll(product.groupedProducts ?? []);
      }
      if (option == WooProductFilterWithType.relatedIds) {
        includes.addAll(product.relatedIds ?? []);
      }
      if (option == WooProductFilterWithType.upsellIds) {
        includes.addAll(product.upsellIds ?? []);
      }
      if (option == WooProductFilterWithType.variations) {
        includes.addAll(product.variations ?? []);
      }
      if (option == WooProductFilterWithType.parentId) {
        if (product.parentId case final id?) {
          includes.add(id);
        }
      }
    }
    map['include'] = includes.join(',');

    return map;
  }

  /// Creates a new product in the WooCommerce store.
  ///
  /// ## Parameters
  ///
  /// - [product]: The product object to create.
  /// - [useFaker]: Override the global useFaker setting for this request.
  ///
  /// ## Returns
  ///
  /// A [Future] that completes with the created [WooProduct] object (including the assigned ID).
  ///
  /// ## Example
  ///
  /// ```dart
  /// final newProduct = WooProduct(
  ///   name: 'New Product',
  ///   type: WooProductType.simple,
  ///   status: WooProductStatus.publish,
  ///   price: 29.99,
  /// );
  ///
  /// final createdProduct = await woocommerce.createProduct(newProduct);
  /// print('Created product with ID: ${createdProduct.id}');
  /// ```
  Future<WooProduct> createProduct(WooProduct product, {bool? useFaker}) async {
    final isUsingFaker = useFaker ?? this.useFaker;

    if (isUsingFaker) {
      return WooProduct.fake();
    }

    final response = await dio.post(
      _ProductEndpoints.products,
      data: product.toJson(),
    );

    return WooProduct.fromJson(response.data);
  }

  /// Duplicates an existing product, creating a copy with a new ID.
  ///
  /// This is useful for creating product variants or templates based on existing products.
  ///
  /// ## Parameters
  ///
  /// - [productId]: The ID of the product to duplicate.
  /// - [useFaker]: Override the global useFaker setting for this request.
  ///
  /// ## Returns
  ///
  /// A [Future] that completes with the duplicated [WooProduct] object.
  ///
  /// ## Example
  ///
  /// ```dart
  /// final duplicatedProduct = await woocommerce.duplicateProduct(123);
  /// print('Duplicated product: ${duplicatedProduct.name}');
  /// ```
  Future<WooProduct> duplicateProduct(int productId, {bool? useFaker}) async {
    final isUsingFaker = useFaker ?? this.useFaker;

    if (isUsingFaker) {
      return WooProduct.fake();
    }

    final response = await dio.post(
      _ProductEndpoints.duplicateProduct(productId),
    );

    return WooProduct.fromJson(response.data);
  }

  /// Updates an existing product in the WooCommerce store.
  ///
  /// ## Parameters
  ///
  /// - [id]: The ID of the product to update.
  /// - [product]: The updated product data.
  /// - [useFaker]: Override the global useFaker setting for this request.
  ///
  /// ## Returns
  ///
  /// A [Future] that completes with the updated [WooProduct] object.
  ///
  /// ## Example
  ///
  /// ```dart
  /// final updatedProduct = product.copyWith(
  ///   name: 'Updated Product Name',
  ///   price: 39.99,
  /// );
  ///
  /// final result = await woocommerce.updateProduct(123, updatedProduct);
  /// print('Updated: ${result.name}');
  /// ```
  Future<WooProduct> updateProduct(int id, WooProduct product,
      {bool? useFaker}) async {
    final isUsingFaker = useFaker ?? this.useFaker;

    if (isUsingFaker) {
      return WooProduct.fake();
    }

    final response = await dio.put(
      _ProductEndpoints.singleProduct(id),
      data: product.toJson(),
    );

    return WooProduct.fromJson(response.data);
  }

  /// Deletes a product from the WooCommerce store.
  ///
  /// ## Parameters
  ///
  /// - [id]: The ID of the product to delete.
  /// - [force]: Whether to permanently delete the product (defaults to false - move to trash).
  /// - [useFaker]: Override the global useFaker setting for this request.
  ///
  /// ## Returns
  ///
  /// A [Future] that completes with the deleted [WooProduct] object.
  ///
  /// ## Example
  ///
  /// ```dart
  /// // Move to trash (default)
  /// final deletedProduct = await woocommerce.deleteProduct(123);
  ///
  /// // Permanently delete
  /// final permanentlyDeleted = await woocommerce.deleteProduct(123, force: true);
  /// ```
  Future<WooProduct> deleteProduct(int id,
      {bool force = false, bool? useFaker}) async {
    final isUsingFaker = useFaker ?? this.useFaker;

    if (isUsingFaker) {
      return WooProduct.fake();
    }

    final response = await dio.delete(
      _ProductEndpoints.singleProduct(id),
      queryParameters: {'force': force},
    );

    return WooProduct.fromJson(response.data);
  }

  /// Performs batch operations on products (create, update, delete) in a single request.
  ///
  /// This method allows you to create, update, and delete multiple products
  /// efficiently in a single API call, reducing the number of requests needed
  /// for bulk operations.
  /// https://woocommerce.github.io/woocommerce-rest-api-docs/#batch-update-products
  ///
  /// ## Parameters
  ///
  /// * [request] - The batch request containing products to create, update, and/or delete
  ///   - `create`: List of `WooProduct` objects to create (should not have IDs)
  ///   - `update`: List of `WooProduct` objects to update (must include valid IDs)
  ///   - `delete`: List of product IDs (integers) to delete
  /// * [useFaker] - When true, returns fake data for testing purposes
  ///
  /// ## Returns
  ///
  /// A `Future<WooProductBatchResponse>` containing the results of all batch operations:
  /// - `create`: List of successfully created products with server-assigned IDs
  /// - `update`: List of successfully updated products
  /// - `delete`: List of successfully deleted products
  ///
  /// ## Throws
  ///
  /// * `WooCommerceException` if the batch operation fails or validation errors occur
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// // Create a batch request with multiple operations
  /// final batchRequest = WooProductBatchRequest(
  ///   create: [
  ///     WooProduct(
  ///       name: 'New Product 1',
  ///       type: WooProductType.simple,
  ///       price: 29.99,
  ///       status: WooProductStatus.publish,
  ///     ),
  ///     WooProduct(
  ///       name: 'New Product 2',
  ///       type: WooProductType.simple,
  ///       price: 49.99,
  ///       status: WooProductStatus.publish,
  ///     ),
  ///   ],
  ///   update: [
  ///     existingProduct.copyWith(
  ///       name: 'Updated Product Name',
  ///       price: 39.99,
  ///     ),
  ///   ],
  ///   delete: [123, 456],
  /// );
  ///
  /// // Execute the batch operation
  /// final response = await wooCommerce.batchUpdateProducts(batchRequest);
  ///
  /// // Process results
  /// print('Created ${response.create?.length ?? 0} products');
  /// print('Updated ${response.update?.length ?? 0} products');
  /// print('Deleted ${response.delete?.length ?? 0} products');
  ///
  /// // Access individual results
  /// for (final product in response.create ?? []) {
  ///   print('Created product: ${product.name} with ID: ${product.id}');
  /// }
  /// ```
  ///
  /// ## Batch Operations Best Practices
  ///
  /// - **Create operations**: Products should not have IDs assigned
  /// - **Update operations**: Products must have valid IDs and will be updated with provided values
  /// - **Delete operations**: Provide only the IDs of products to delete
  /// - **Mixed operations**: You can combine create, update, and delete in a single request
  /// - **Error handling**: If any operation fails, the entire batch may fail depending on API behavior
  Future<WooProductBatchResponse> batchUpdateProducts(
    WooProductBatchRequest request, {
    bool? useFaker,
  }) async {
    final isUsingFaker = useFaker ?? this.useFaker;

    if (isUsingFaker) {
      return WooProductBatchResponse(
        create: request.create
            ?.map((product) => WooProduct.fake())
            .toList(),
        update: request.update,
        delete: request.delete
            ?.map((id) => WooProduct.fake())
            .toList(),
      );
    }

    final response = await dio.post(
      _ProductEndpoints.batchProducts(),
      data: request.toJson(),
    );

    return WooProductBatchResponse.fromJson(
      response.data as Map<String, dynamic>,
    );
  }
}
