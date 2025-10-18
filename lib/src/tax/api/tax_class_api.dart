import 'package:woocommerce_flutter_api/woocommerce_flutter_api.dart';

part 'tax_class_endpoints.dart';

/// WooCommerce Tax Class API Extension
///
/// This extension provides comprehensive tax class management capabilities for WooCommerce stores.
/// It enables creation, retrieval, and deletion of tax classes to help store owners
/// organize and manage different tax categories for their products.
///
/// ## Key Features
///
/// - **Tax Class Retrieval**: Get all available tax classes
/// - **Tax Class Creation**: Create new custom tax classes
/// - **Tax Class Deletion**: Remove unwanted tax classes
/// - **Simple Management**: Easy-to-use methods for tax class operations
///
/// ## Example Usage
///
/// ```dart
/// // Get all tax classes
/// final taxClasses = await wooCommerce.getTaxClasses();
///
/// // Create a new tax class
/// final newTaxClass = WooTaxClass(
///   slug: 'reduced-rate',
///   name: 'Reduced Rate',
/// );
/// final created = await wooCommerce.createTaxClass(newTaxClass);
///
/// // Delete a tax class
/// await wooCommerce.deleteTaxClass(taxClass);
/// ```
extension WooTaxClassApi on WooCommerce {
  /// Retrieves all tax classes from the WooCommerce store.
  ///
  /// This method returns a list of all available tax classes, including
  /// standard tax classes and any custom tax classes that have been created.
  ///
  /// ## Parameters
  ///
  /// * [useFaker] - When true, returns fake data for testing purposes
  ///
  /// ## Returns
  ///
  /// A `Future<List<WooTaxClass>>` containing all tax class objects.
  ///
  /// ## Throws
  ///
  /// * `WooCommerceException` if the request fails or access is denied
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// // Get all tax classes
  /// final taxClasses = await wooCommerce.getTaxClasses();
  ///
  /// // Get tax classes with fake data for testing
  /// final fakeTaxClasses = await wooCommerce.getTaxClasses(useFaker: true);
  /// ```
  Future<List<WooTaxClass>> getTaxClasses({
    bool? useFaker,
  }) async {
    final isUsingFaker = useFaker ?? this.useFaker;

    if (isUsingFaker) {
      return FakeHelper.list(WooTaxClass.fake);
    }

    final response = await dio.get(
      _TaxRateEndpoints.taxeClasses,
    );

    return (response.data as List)
        .map((item) => WooTaxClass.fromJson(item))
        .toList();
  }

  /// Creates a new tax class in the WooCommerce store.
  ///
  /// This method creates a new tax class with the specified slug and name.
  /// Tax classes are used to categorize products for different tax treatments.
  ///
  /// ## Parameters
  ///
  /// * [taxClass] - The tax class object to create
  /// * [useFaker] - When true, returns the input tax class without API call
  ///
  /// ## Returns
  ///
  /// A `Future<WooTaxClass>` containing the created tax class object.
  ///
  /// ## Throws
  ///
  /// * `WooCommerceException` if the request fails or access is denied
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// final newTaxClass = WooTaxClass(
  ///   slug: 'reduced-rate',
  ///   name: 'Reduced Rate',
  /// );
  /// final created = await wooCommerce.createTaxClass(newTaxClass);
  /// ```
  Future<WooTaxClass> createTaxClass(WooTaxClass taxClass,
      {bool? useFaker}) async {
    final isUsingFaker = useFaker ?? this.useFaker;

    if (isUsingFaker) {
      return taxClass;
    }

    final response = await dio.post(
      _TaxRateEndpoints.taxeClasses,
      data: taxClass.toJson(),
    );

    return WooTaxClass.fromJson(response.data);
  }

  /// Deletes a tax class from the WooCommerce store.
  ///
  /// This method permanently removes a tax class from the store.
  /// Use with caution as this action cannot be undone.
  ///
  /// ## Parameters
  ///
  /// * [taxClass] - The tax class object to delete
  /// * [useFaker] - When true, performs no actual deletion
  ///
  /// ## Returns
  ///
  /// A `Future<void>` that completes when the deletion is successful.
  ///
  /// ## Throws
  ///
  /// * `WooCommerceException` if the request fails or access is denied
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// await wooCommerce.deleteTaxClass(taxClass);
  /// ```
  Future<void> deleteTaxClass(WooTaxClass taxClass, {bool? useFaker}) async {
    final isUsingFaker = useFaker ?? this.useFaker;

    if (isUsingFaker) {
      return;
    }

    await dio.delete(
      _TaxRateEndpoints.singleTaxClass(taxClass.slug!),
      queryParameters: {
        'force': true,
      },
    );
  }
}
