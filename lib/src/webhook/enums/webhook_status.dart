/// WooCommerce Webhook Status Enumeration
///
/// Defines the possible states for a webhook in WooCommerce. The status determines
/// whether a webhook is actively delivering payloads, temporarily paused, or disabled
/// due to failures or administrative action.
///
/// ## Webhook Status Lifecycle
///
/// Webhooks can transition between different statuses based on various conditions:
///
/// 1. **Active**: Webhook is functioning normally and delivering payloads
/// 2. **Paused**: Webhook is temporarily disabled by admin action
/// 3. **Disabled**: Webhook is automatically disabled due to delivery failures
///
/// ## Status Descriptions
///
/// ### Active Status
/// - Webhook is actively monitoring for events
/// - Payloads are delivered to the configured URL
/// - All webhook functionality is operational
/// - This is the default status for new webhooks
///
/// ### Paused Status
/// - Webhook is temporarily disabled by administrator
/// - No payloads are delivered while paused
/// - Can be reactivated by changing status back to active
/// - Useful for maintenance or temporary disabling
///
/// ### Disabled Status
/// - Webhook is automatically disabled due to delivery failures
/// - Occurs when delivery attempts fail repeatedly
/// - Requires manual intervention to reactivate
/// - Indicates potential issues with delivery URL or network
///
/// ## Usage Examples
///
/// ```dart
/// // Create webhook with active status
/// final webhook = WooWebhook(
///   name: 'Order Updates',
///   topic: WooWebhookTopic.orderUpdated,
///   deliveryUrl: 'https://example.com/webhook',
///   status: WooWebhookStatus.active,
/// );
///
/// // Pause webhook temporarily
/// webhook.status = WooWebhookStatus.paused;
/// await wooCommerce.updateWebhook(webhook);
///
/// // Check webhook status
/// if (webhook.status == WooWebhookStatus.active) {
///   print('Webhook is delivering payloads');
/// } else if (webhook.status == WooWebhookStatus.paused) {
///   print('Webhook is paused by admin');
/// } else if (webhook.status == WooWebhookStatus.disabled) {
///   print('Webhook is disabled due to failures');
/// }
///
/// // Filter webhooks by status
/// final activeWebhooks = await wooCommerce.getWebhooks(
///   status: WooWebhookStatus.active,
/// );
/// ```
///
/// ## Status Transitions
///
/// | From Status | To Status | Trigger | Description |
/// |-------------|-----------|---------|-------------|
/// | - | Active | Webhook creation | Default status for new webhooks |
/// | Active | Paused | Admin action | Manually paused by administrator |
/// | Paused | Active | Admin action | Manually reactivated by administrator |
/// | Active | Disabled | Delivery failures | Automatically disabled after repeated failures |
/// | Disabled | Active | Admin action | Manually reactivated after fixing issues |
///
/// ## Best Practices
///
/// - **Monitor Status**: Regularly check webhook status to ensure delivery
/// - **Handle Failures**: Implement retry logic for disabled webhooks
/// - **Use Paused Status**: Pause webhooks during maintenance instead of deleting
/// - **Log Status Changes**: Track status transitions for debugging
///
/// ## Related Documentation
///
/// - [WooWebhook] - Webhook model with status property
/// - [WooWebhookApi] - API methods for managing webhook status
/// - [WooWebhookTopic] - Webhook topics that trigger delivery
enum WooWebhookStatus {
  /// Webhook is active and delivering payloads
  ///
  /// This status indicates that the webhook is functioning normally and will
  /// deliver payloads when the subscribed events occur. This is the default
  /// status for new webhooks and the desired state for operational webhooks.
  ///
  /// ## Characteristics
  /// - Payloads are delivered to the configured URL
  /// - Events are monitored and processed
  /// - All webhook functionality is operational
  /// - No delivery restrictions or limitations
  ///
  /// ## When to Use
  /// - New webhooks (default status)
  /// - After resolving delivery issues
  /// - When webhook is ready for production use
  ///
  /// ## Example Usage
  /// ```dart
  /// final webhook = WooWebhook(
  ///   name: 'Order Updates',
  ///   topic: 'order.updated',
  ///   deliveryUrl: 'https://example.com/webhook',
  ///   status: WooWebhookStatus.active,
  /// );
  /// ```
  active,

  /// Webhook is paused by administrator
  ///
  /// This status indicates that the webhook has been temporarily disabled by
  /// an administrator. While paused, no payloads will be delivered, but the
  /// webhook configuration is preserved and can be reactivated.
  ///
  /// ## Characteristics
  /// - No payloads are delivered
  /// - Events are not processed
  /// - Configuration is preserved
  /// - Can be reactivated by admin action
  ///
  /// ## When to Use
  /// - Temporary maintenance periods
  /// - Testing or debugging scenarios
  /// - When delivery URL is temporarily unavailable
  /// - Administrative control over webhook delivery
  ///
  /// ## Example Usage
  /// ```dart
  /// // Pause webhook for maintenance
  /// webhook.status = WooWebhookStatus.paused;
  /// await wooCommerce.updateWebhook(webhook);
  ///
  /// // Reactivate after maintenance
  /// webhook.status = WooWebhookStatus.active;
  /// await wooCommerce.updateWebhook(webhook);
  /// ```
  paused,

  /// Webhook is disabled due to delivery failures
  ///
  /// This status indicates that the webhook has been automatically disabled
  /// due to repeated delivery failures. The webhook will not deliver payloads
  /// until the issues are resolved and the status is manually changed back to active.
  ///
  /// ## Characteristics
  /// - No payloads are delivered
  /// - Events are not processed
  /// - Automatically set by WooCommerce
  /// - Requires manual intervention to reactivate
  /// - Indicates potential delivery issues
  ///
  /// ## Common Causes
  /// - Invalid or unreachable delivery URL
  /// - Network connectivity issues
  /// - Server errors at delivery endpoint
  /// - Authentication or authorization failures
  /// - Payload size or format issues
  ///
  /// ## When This Occurs
  /// - After repeated delivery failures
  /// - When delivery endpoint returns error codes
  /// - When network timeouts occur
  /// - When authentication fails
  ///
  /// ## Example Usage
  /// ```dart
  /// // Check if webhook is disabled
  /// if (webhook.status == WooWebhookStatus.disabled) {
  ///   print('Webhook is disabled due to delivery failures');
  ///   print('Check delivery URL and endpoint configuration');
  /// }
  ///
  /// // Reactivate after fixing issues
  /// webhook.status = WooWebhookStatus.active;
  /// await wooCommerce.updateWebhook(webhook);
  /// ```
  disabled,
}
