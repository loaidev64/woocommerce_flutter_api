import 'package:faker/faker.dart';

/// WooCommerce Product Status Enumeration
///
/// Defines the publication status of products in WooCommerce.
/// Controls the visibility and availability of products to customers.
///
/// ## Usage Examples
///
/// ```dart
/// // Create a published product
/// final product = WooProduct(
///   name: 'T-Shirt',
///   status: WooProductStatus.publish,
/// );
///
/// // Create a draft product
/// final draftProduct = WooProduct(
///   name: 'Work in Progress',
///   status: WooProductStatus.draft,
/// );
///
/// // Check product status
/// if (product.status == WooProductStatus.publish) {
///   print('Product is live and visible');
/// }
/// ```
enum WooProductStatus {
  /// Product is saved but not visible to customers
  ///
  /// Draft products are work-in-progress items that are saved
  /// but not yet ready for publication.
  draft,

  /// Product is pending review before publication
  ///
  /// Pending products are submitted for review and will be
  /// published once approved by an administrator.
  pending,

  /// Product is visible only to specific users
  ///
  /// Private products are only visible to users with appropriate
  /// permissions, typically administrators and editors.
  private,

  /// Product is live and visible to all customers
  ///
  /// Published products are live on the website and available
  /// for customers to view and purchase.
  publish;

  static WooProductStatus fake() {
    return values[Faker().randomGenerator.integer(values.length - 1)];
  }

  static WooProductStatus fromString(String type) {
    if (type == 'draft') {
      return WooProductStatus.draft;
    }
    if (type == 'pending') {
      return WooProductStatus.pending;
    }
    if (type == 'private') {
      return WooProductStatus.private;
    }
    return WooProductStatus.publish;
  }
}
