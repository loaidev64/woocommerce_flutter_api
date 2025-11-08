import 'tax_rate.dart';

/// WooCommerce Tax Rate Batch Response Model
///
/// This class represents the response from a batch tax rate operation. It contains
/// the results of create, update, and delete operations performed in a single
/// batch request.
///
/// ## Key Features
///
/// - **Create Results**: List of successfully created tax rates with server-assigned IDs
/// - **Update Results**: List of successfully updated tax rates
/// - **Delete Results**: List of successfully deleted tax rates
/// - **Comprehensive Response**: All operations results in a single response object
///
/// ## Usage Examples
///
/// ### Processing Batch Response
///
/// ```dart
/// final response = await wooCommerce.batchUpdateTaxRates(batchRequest);
///
/// // Process created tax rates
/// for (final taxRate in response.create ?? []) {
///   print('Created tax rate: ${taxRate.name} with ID: ${taxRate.id}');
///   print('Rate: ${taxRate.rate}% for ${taxRate.country}/${taxRate.state}');
/// }
///
/// // Process updated tax rates
/// for (final taxRate in response.update ?? []) {
///   print('Updated tax rate: ${taxRate.name}');
///   print('New rate: ${taxRate.rate}%');
/// }
///
/// // Process deleted tax rates
/// for (final taxRate in response.delete ?? []) {
///   print('Deleted tax rate: ${taxRate.name}');
/// }
/// ```
///
/// ### Checking Batch Results
///
/// ```dart
/// final response = await wooCommerce.batchUpdateTaxRates(batchRequest);
///
/// final createdCount = response.create?.length ?? 0;
/// final updatedCount = response.update?.length ?? 0;
/// final deletedCount = response.delete?.length ?? 0;
///
/// print('Batch operation completed:');
/// print('  Created: $createdCount');
/// print('  Updated: $updatedCount');
/// print('  Deleted: $deletedCount');
/// ```
///
/// ### Analyzing Geographical Distribution
///
/// ```dart
/// final response = await wooCommerce.batchUpdateTaxRates(batchRequest);
///
/// // Group created tax rates by country
/// final byCountry = <String, List<WooTaxRate>>{};
/// for (final taxRate in response.create ?? []) {
///   final country = taxRate.country ?? 'Unknown';
///   byCountry.putIfAbsent(country, () => []).add(taxRate);
/// }
///
/// print('Tax rates by country:');
/// byCountry.forEach((country, rates) {
///   print('  $country: ${rates.length} rates');
/// });
/// ```
///
/// ## JSON Serialization
///
/// The class supports full JSON serialization for API communication:
///
/// ```dart
/// // Create from JSON response
/// final batchResponse = WooTaxRateBatchResponse.fromJson(jsonData);
///
/// // Convert to JSON if needed
/// final json = batchResponse.toJson();
/// ```
class WooTaxRateBatchResponse {

  /// Creates a new WooTaxRateBatchResponse instance
  ///
  /// ## Required Parameters
  ///
  /// None - all parameters are optional. The API may return any combination
  /// of create, update, and delete results based on the request.
  ///
  /// ## Optional Parameters
  ///
  /// * [create] - List of created `WooTaxRate` objects
  /// * [update] - List of updated `WooTaxRate` objects
  /// * [delete] - List of deleted `WooTaxRate` objects
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// final batchResponse = WooTaxRateBatchResponse(
  ///   create: [createdTaxRate1, createdTaxRate2],
  ///   update: [updatedTaxRate1],
  ///   delete: [deletedTaxRate1],
  /// );
  /// ```
  WooTaxRateBatchResponse({
    this.create,
    this.update,
    this.delete,
  });

  /// Creates a WooTaxRateBatchResponse instance from JSON data
  ///
  /// This factory constructor is used to deserialize batch response data
  /// received from the WooCommerce REST API.
  ///
  /// ## Parameters
  ///
  /// * [json] - A Map containing the batch response data in JSON format
  ///
  /// ## Returns
  ///
  /// A `WooTaxRateBatchResponse` instance populated with data from the JSON.
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// final batchResponse = WooTaxRateBatchResponse.fromJson(jsonData);
  /// ```
  factory WooTaxRateBatchResponse.fromJson(Map<String, dynamic> json) =>
      WooTaxRateBatchResponse(
        create: json['create'] != null
            ? (json['create'] as List)
                .map((item) =>
                    WooTaxRate.fromJson(item as Map<String, dynamic>))
                .toList()
            : null,
        update: json['update'] != null
            ? (json['update'] as List)
                .map((item) =>
                    WooTaxRate.fromJson(item as Map<String, dynamic>))
                .toList()
            : null,
        delete: json['delete'] != null
            ? (json['delete'] as List)
                .map((item) =>
                    WooTaxRate.fromJson(item as Map<String, dynamic>))
                .toList()
            : null,
      );
  /// List of created tax rates
  ///
  /// Contains the tax rates that were successfully created, each with a
  /// server-assigned ID and all other properties as returned by the API.
  final List<WooTaxRate>? create;

  /// List of updated tax rates
  ///
  /// Contains the tax rates that were successfully updated, reflecting
  /// the current state after the update operation.
  final List<WooTaxRate>? update;

  /// List of deleted tax rates
  ///
  /// Contains the tax rates that were successfully deleted. These tax rates
  /// may have limited information depending on the API response.
  final List<WooTaxRate>? delete;

  /// Converts the WooTaxRateBatchResponse instance to JSON format
  ///
  /// This method serializes the batch response data into a Map.
  ///
  /// ## Returns
  ///
  /// A `Map<String, dynamic>` containing the batch response data in JSON format.
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// final jsonData = batchResponse.toJson();
  /// ```
  Map<String, dynamic> toJson() => {
        if (create != null)
          'create': create!.map((taxRate) => taxRate.toJson()).toList(),
        if (update != null)
          'update': update!.map((taxRate) => taxRate.toJson()).toList(),
        if (delete != null)
          'delete': delete!.map((taxRate) => taxRate.toJson()).toList(),
      };

  /// Returns a string representation of the WooTaxRateBatchResponse instance
  ///
  /// This method provides a human-readable representation of the batch response,
  /// displaying the counts of create, update, and delete results.
  ///
  /// ## Returns
  ///
  /// A `String` containing the batch response's result counts in a readable format.
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// final batchResponse = WooTaxRateBatchResponse(
  ///   create: [taxRate1, taxRate2],
  ///   update: [taxRate3],
  ///   delete: [taxRate4, taxRate5],
  /// );
  /// print(batchResponse.toString());
  /// // Output: WooTaxRateBatchResponse(create: 2, update: 1, delete: 2)
  /// ```
  @override
  String toString() {
    return 'WooTaxRateBatchResponse(create: ${create?.length ?? 0}, update: ${update?.length ?? 0}, delete: ${delete?.length ?? 0})';
  }
}

