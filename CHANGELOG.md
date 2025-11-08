## 1.0.0

- Initial version.

## 1.0.2

- [List any new changes, bug fixes, or improvements for version 1.0.2]

## 1.0.3

- Added support for retrieving WooCommerce product tags.
- Implemented `getProductTags()` to fetch product tags with various filtering options.
- Introduced `WooProductTagSort` enum for sorting product tags.
- Improved API structure and documentation.
- Fixed minor issues in query parameter handling.

## 1.1.0

- Added support for product review, shipping classses, reports, tax rates and tax classes.
- Improved API structure and documentation.

# 1.2.0

- Almost finished with all of the apis in Woocommerce official api.

# 1.2.1

- Improved API structure and documentation.
- Added interceptors property to Woocommerce class

# 1.2.2

- Fixes issue #23 in category orderby queryParameter.

# 1.3.0

- Fixes issue in getOrders orderby queryParameter.
- Added create, update, delete product category apis.
- Added create, update, delete, duplicate product apis.

## 1.4.0

- Updated dependencies to the latest versions.

# 1.5.0

- Enhanced documentation for WooCommerce API, adding detailed descriptions, usage examples, and JSON serialization for refund, report, tax, and variation models.
- Added comprehensive API documentation with examples for all apis.

# 1.6.0

- Added batch update API for product shipping classes with `batchUpdateProductShippingClasses()` method.
- Added batch update API for product reviews with `batchUpdateProductReviews()` method.
- Added batch update API for tax rates with `batchUpdateTaxRates()` method.
- Added batch update API for webhooks with `batchUpdateWebhooks()` method.
- Added batch update API for settings options with `batchUpdateSettingOptions()` method.
- Created batch request and response models for all new batch APIs:
  - `WooProductShippingClassBatchRequest` and `WooProductShippingClassBatchResponse`
  - `WooProductReviewBatchRequest` and `WooProductReviewBatchResponse`
  - `WooTaxRateBatchRequest` and `WooTaxRateBatchResponse`
  - `WooWebhookBatchRequest` and `WooWebhookBatchResponse`
  - `WooSettingOptionBatchRequest` and `WooSettingOptionBatchResponse`
- Enhanced batch API documentation with comprehensive usage examples, best practices, and workflow guides.
- Improved API structure for bulk operations across multiple WooCommerce resources.
