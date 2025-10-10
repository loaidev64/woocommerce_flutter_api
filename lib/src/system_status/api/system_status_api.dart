import 'package:woocommerce_flutter_api/woocommerce_flutter_api.dart';

part 'system_status_endpoints.dart';

/// WooCommerce System Status API Extension
///
/// This extension provides comprehensive system status monitoring capabilities for WooCommerce stores.
/// System status information helps you understand your store's health, performance, and configuration,
/// including environment details, database status, active plugins, and security information.
///
/// ## System Status Overview
///
/// System status provides detailed information about your WooCommerce store's technical environment,
/// including server configuration, WordPress setup, database status, and security settings.
/// This information is crucial for troubleshooting, performance optimization, and maintenance.
///
/// ## Key Features
///
/// - **Environment monitoring**: Server, PHP, and WordPress configuration details
/// - **Database status**: Database version, tables, and connectivity information
/// - **Plugin tracking**: Active plugins and their impact on performance
/// - **Theme information**: Current theme and compatibility details
/// - **Security assessment**: Security settings and potential vulnerabilities
/// - **Performance metrics**: Memory limits, execution times, and optimization status
///
/// ## System Status Components
///
/// 1. **Environment**: Server info, PHP version, WordPress version, memory limits
/// 2. **Database**: WooCommerce database version, table structure, connectivity
/// 3. **Active Plugins**: List of currently active plugins
/// 4. **Theme**: Current theme information and compatibility
/// 5. **Settings**: WooCommerce configuration and settings
/// 6. **Security**: Security settings and potential issues
/// 7. **Pages**: WooCommerce-specific pages and their status
///
/// ## Example Usage
///
/// ```dart
/// // Get complete system status
/// final status = await wooCommerce.getSystemStatus();
///
/// // Check environment details
/// print('PHP Version: ${status.environment?.phpVersion}');
/// print('WordPress Version: ${status.environment?.wpVersion}');
///
/// // Check database status
/// print('Database Version: ${status.database?.wcDatabaseVersion}');
/// print('Tables: ${status.database?.databaseTables}');
/// ```
extension WooSystemStatusApi on WooCommerce {
  /// Retrieves comprehensive system status information from the WooCommerce store.
  ///
  /// This method fetches detailed information about your store's technical environment,
  /// including server configuration, WordPress setup, database status, active plugins,
  /// theme information, security settings, and WooCommerce-specific pages.
  /// https://woocommerce.github.io/woocommerce-rest-api-docs/#list-all-system-status-items
  ///
  /// ## Parameters
  ///
  /// * [useFaker] - When true, returns fake data for testing purposes
  ///
  /// ## Returns
  ///
  /// A `Future<WooSystemStatus>` containing comprehensive system status information.
  ///
  /// ## Throws
  ///
  /// * `WooCommerceException` if the request fails or access is denied
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// // Get complete system status
  /// final status = await wooCommerce.getSystemStatus();
  ///
  /// // Check environment details
  /// print('PHP Version: ${status.environment?.phpVersion}');
  /// print('WordPress Version: ${status.environment?.wpVersion}');
  /// print('Memory Limit: ${status.environment?.wpMemoryLimit}MB');
  ///
  /// // Check database status
  /// print('Database Version: ${status.database?.wcDatabaseVersion}');
  /// print('Database Tables: ${status.database?.databaseTables?.length}');
  ///
  /// // Check active plugins
  /// print('Active Plugins: ${status.activePlugins?.length}');
  /// for (final plugin in status.activePlugins ?? []) {
  ///   print('  - $plugin');
  /// }
  ///
  /// // Check security status
  /// print('Security Issues: ${status.security != null}');
  /// ```
  Future<WooSystemStatus> getSystemStatus({
    bool? useFaker,
  }) async {
    final isUsingFaker = useFaker ?? this.useFaker;

    if (isUsingFaker) {
      return WooSystemStatus.fake();
    }

    final response = await dio.get(
      _SystemStatusEndpoints.systemStatus,
    );

    return WooSystemStatus.fromJson(response.data);
  }
}
