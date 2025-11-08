import 'package:woocommerce_flutter_api/woocommerce_flutter_api.dart';

/// WooCommerce System Status Model
///
/// Represents comprehensive system status information for a WooCommerce store.
/// This model contains detailed information about the store's technical environment,
/// including server configuration, database status, active plugins, theme information,
/// security settings, and WooCommerce-specific pages.
///
/// ## System Status Structure
///
/// A system status consists of several key components:
///
/// - **Environment**: Server info, PHP version, WordPress version, memory limits
/// - **Database**: WooCommerce database version, table structure, connectivity
/// - **Active Plugins**: List of currently active plugins and their impact
/// - **Theme**: Current theme information and compatibility details
/// - **Settings**: WooCommerce configuration and settings
/// - **Security**: Security settings and potential vulnerabilities
/// - **Pages**: WooCommerce-specific pages and their status
///
/// ## Key Information Provided
///
/// - **Server Environment**: PHP version, memory limits, server software
/// - **WordPress Configuration**: Version, multisite status, debug mode
/// - **Database Status**: WooCommerce database version, table structure
/// - **Plugin Management**: Active plugins and their impact on performance
/// - **Theme Compatibility**: Current theme and WooCommerce compatibility
/// - **Security Assessment**: Security settings and potential issues
/// - **Performance Metrics**: Memory usage, execution times, optimization status
///
/// ## Example Usage
///
/// ```dart
/// // Get system status
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
/// ```
class WooSystemStatus {

  /// Creates a new WooSystemStatus instance
  ///
  /// This constructor creates a system status object with the specified properties.
  /// All parameters are optional, allowing for flexible status creation.
  ///
  /// ## Parameters
  ///
  /// * [environment] - Server environment information (PHP, WordPress, server details)
  /// * [database] - Database information (version, tables, connectivity)
  /// * [activePlugins] - List of currently active plugins
  /// * [theme] - Current theme information and compatibility
  /// * [settings] - WooCommerce settings and configuration
  /// * [security] - Security information and potential issues
  /// * [pages] - WooCommerce-specific pages and their status
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// // Create a basic system status
  /// final status = WooSystemStatus(
  ///   environment: environmentInfo,
  ///   database: databaseInfo,
  ///   activePlugins: ['woocommerce', 'jetpack'],
  /// );
  ///
  /// // Create a complete system status
  /// final fullStatus = WooSystemStatus(
  ///   environment: environmentInfo,
  ///   database: databaseInfo,
  ///   activePlugins: ['woocommerce', 'jetpack', 'yoast-seo'],
  ///   theme: themeInfo,
  ///   settings: settingsInfo,
  ///   security: securityInfo,
  ///   pages: ['shop', 'cart', 'checkout', 'my-account'],
  /// );
  /// ```
  WooSystemStatus({
    this.environment,
    this.database,
    this.activePlugins,
    this.theme,
    this.settings,
    this.security,
    this.pages,
  });

  /// Creates a WooSystemStatus instance from JSON data
  ///
  /// This factory constructor is used to deserialize system status data received
  /// from the WooCommerce REST API. It handles the conversion of JSON fields
  /// to the appropriate Dart types and provides fallback values where needed.
  ///
  /// ## Parameters
  ///
  /// * [json] - A Map containing the system status data in JSON format
  ///
  /// ## Returns
  ///
  /// A `WooSystemStatus` instance populated with data from the JSON.
  ///
  /// ## JSON Structure
  ///
  /// The expected JSON structure includes:
  /// ```json
  /// {
  ///   "environment": {
  ///     "php_version": "8.1.10",
  ///     "wp_version": "6.2.2",
  ///     "wp_memory_limit": 256
  ///   },
  ///   "database": {
  ///     "wc_database_version": "7.4.0",
  ///     "database_tables": ["wp_posts", "wp_postmeta"]
  ///   },
  ///   "active_plugins": ["woocommerce", "jetpack"],
  ///   "theme": {
  ///     "name": "Storefront",
  ///     "version": "4.1.0"
  ///   },
  ///   "settings": {
  ///     "api_enabled": true,
  ///     "force_ssl": false
  ///   },
  ///   "security": {
  ///     "secure_connection": true,
  ///     "hide_errors": false
  ///   },
  ///   "pages": ["shop", "cart", "checkout", "my-account"]
  /// }
  /// ```
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// // Parse system status from API response
  /// final jsonData = {
  ///   'environment': {'php_version': '8.1.10', 'wp_version': '6.2.2'},
  ///   'active_plugins': ['woocommerce', 'jetpack'],
  ///   'pages': ['shop', 'cart', 'checkout']
  /// };
  ///
  /// final status = WooSystemStatus.fromJson(jsonData);
  /// print('PHP Version: ${status.environment?.phpVersion}');
  /// print('Active Plugins: ${status.activePlugins?.length}');
  /// ```
  factory WooSystemStatus.fromJson(Map<String, dynamic> json) =>
      WooSystemStatus(
        environment: json['environment'] != null
            ? WooSystemStatusEnvironment.fromJson(json['environment'])
            : null,
        database: json['database'] != null
            ? WooSystemStatusDatabase.fromJson(json['database'])
            : null,
        activePlugins: json['active_plugins'] != null
            ? List<String>.from(json['active_plugins'])
            : null,
        theme: json['theme'] != null
            ? WooSystemStatusTheme.fromJson(json['theme'])
            : null,
        settings: json['settings'] != null
            ? WooSystemStatusSettings.fromJson(json['settings'])
            : null,
        security: json['security'] != null
            ? WooSystemStatusSecurity.fromJson(json['security'])
            : null,
        pages: json['pages'] != null ? List<String>.from(json['pages']) : null,
      );

  /// Creates a fake WooSystemStatus instance for testing purposes
  ///
  /// This factory constructor generates a system status with random but realistic
  /// data, making it useful for testing, development, and demonstration purposes.
  /// The generated system status will have valid data for all fields.
  ///
  /// ## Generated Data
  ///
  /// The fake system status includes:
  /// - Random environment information with realistic server details
  /// - Random database information with realistic table structure
  /// - Random list of active plugins
  /// - Random theme information with realistic details
  /// - Random settings information
  /// - Random security information
  /// - Random list of WooCommerce pages
  ///
  /// ## Returns
  ///
  /// A `WooSystemStatus` instance with randomly generated fake data.
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// // Generate a fake system status for testing
  /// final fakeStatus = WooSystemStatus.fake();
  /// print('Fake status: ${fakeStatus.environment?.phpVersion}');
  /// print('Active Plugins: ${fakeStatus.activePlugins?.length}');
  /// print('Pages: ${fakeStatus.pages?.length}');
  ///
  /// // Use in tests
  /// test('system status creation', () {
  ///   final status = WooSystemStatus.fake();
  ///   expect(status.environment, isNotNull);
  ///   expect(status.database, isNotNull);
  ///   expect(status.activePlugins, isNotNull);
  /// });
  /// ```
  factory WooSystemStatus.fake() => WooSystemStatus(
        environment: WooSystemStatusEnvironment.fake(),
        database: WooSystemStatusDatabase.fake(),
        activePlugins: FakeHelper.list(() => FakeHelper.word()),
        theme: WooSystemStatusTheme.fake(),
        settings: WooSystemStatusSettings.fake(),
        security: WooSystemStatusSecurity.fake(),
        pages: FakeHelper.list(() => FakeHelper.word()),
      );
  /// Environment information
  ///
  /// Contains detailed information about the server environment, including
  /// PHP version, WordPress version, memory limits, server software, and
  /// various PHP extensions and configurations.
  final WooSystemStatusEnvironment? environment;

  /// Database information
  ///
  /// Contains information about the WooCommerce database, including version,
  /// table structure, connectivity status, and database-specific settings.
  final WooSystemStatusDatabase? database;

  /// Active plugins
  ///
  /// List of currently active plugins in the WordPress installation.
  /// This helps identify potential conflicts and performance impacts.
  final List<String>? activePlugins;

  /// Theme information
  ///
  /// Contains details about the current WordPress theme, including version,
  /// WooCommerce compatibility, and theme-specific settings.
  final WooSystemStatusTheme? theme;

  /// Settings information
  ///
  /// Contains WooCommerce-specific settings and configuration details,
  /// including store settings, payment methods, and other configurations.
  final WooSystemStatusSettings? settings;

  /// Security information
  ///
  /// Contains security-related information, including potential vulnerabilities,
  /// security settings, and recommendations for improving store security.
  final WooSystemStatusSecurity? security;

  /// WooCommerce pages
  ///
  /// List of WooCommerce-specific pages (shop, cart, checkout, my-account)
  /// and their current status and accessibility.
  final List<String>? pages;

  /// Converts the WooSystemStatus instance to JSON format
  ///
  /// This method serializes the system status data into a Map that can be sent
  /// to the WooCommerce REST API. It handles the conversion of Dart types
  /// to JSON-compatible formats and includes all necessary fields.
  ///
  /// ## Returns
  ///
  /// A `Map<String, dynamic>` containing the system status data in JSON format.
  ///
  /// ## JSON Structure
  ///
  /// The returned JSON structure includes:
  /// ```json
  /// {
  ///   "environment": {
  ///     "php_version": "8.1.10",
  ///     "wp_version": "6.2.2",
  ///     "wp_memory_limit": 256
  ///   },
  ///   "database": {
  ///     "wc_database_version": "7.4.0",
  ///     "database_tables": ["wp_posts", "wp_postmeta"]
  ///   },
  ///   "active_plugins": ["woocommerce", "jetpack"],
  ///   "theme": {
  ///     "name": "Storefront",
  ///     "version": "4.1.0"
  ///   },
  ///   "settings": {
  ///     "api_enabled": true,
  ///     "force_ssl": false
  ///   },
  ///   "security": {
  ///     "secure_connection": true,
  ///     "hide_errors": false
  ///   },
  ///   "pages": ["shop", "cart", "checkout", "my-account"]
  /// }
  /// ```
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// // Convert system status to JSON for API calls
  /// final status = WooSystemStatus(
  ///   environment: environmentInfo,
  ///   activePlugins: ['woocommerce', 'jetpack'],
  /// );
  ///
  /// final jsonData = status.toJson();
  /// print('JSON: $jsonData');
  ///
  /// // Send to API
  /// await dio.post('/system_status', data: status.toJson());
  /// ```
  Map<String, dynamic> toJson() => {
        'environment': environment?.toJson(),
        'database': database?.toJson(),
        'active_plugins': activePlugins,
        'theme': theme?.toJson(),
        'settings': settings?.toJson(),
        'security': security?.toJson(),
        'pages': pages,
      };
}
