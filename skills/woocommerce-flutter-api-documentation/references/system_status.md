# system_status

## system_status_api

### extension WooSystemStatusApi on WooCommerce

WooCommerce System Status API Extension

This extension provides comprehensive system status monitoring capabilities for WooCommerce stores.
System status information helps you understand your store's health, performance, and configuration,
including environment details, database status, active plugins, and security information.

## System Status Overview

System status provides detailed information about your WooCommerce store's technical environment,
including server configuration, WordPress setup, database status, and security settings.
This information is crucial for troubleshooting, performance optimization, and maintenance.

## Key Features

- **Environment monitoring**: Server, PHP, and WordPress configuration details
- **Database status**: Database version, tables, and connectivity information
- **Plugin tracking**: Active plugins and their impact on performance
- **Theme information**: Current theme and compatibility details
- **Security assessment**: Security settings and potential vulnerabilities
- **Performance metrics**: Memory limits, execution times, and optimization status

## System Status Components

1. **Environment**: Server info, PHP version, WordPress version, memory limits
2. **Database**: WooCommerce database version, table structure, connectivity
3. **Active Plugins**: List of currently active plugins
4. **Theme**: Current theme information and compatibility
5. **Settings**: WooCommerce configuration and settings
6. **Security**: Security settings and potential issues
7. **Pages**: WooCommerce-specific pages and their status

## Example Usage

```dart
// Get complete system status
final status = await wooCommerce.getSystemStatus();

// Check environment details
print('PHP Version: ${status.environment?.phpVersion}');
print('WordPress Version: ${status.environment?.wpVersion}');

// Check database status
print('Database Version: ${status.database?.wcDatabaseVersion}');
print('Tables: ${status.database?.databaseTables}');
```

### Future<WooSystemStatus> getSystemStatus({bool? useFaker}) async

Retrieves comprehensive system status information from the WooCommerce store.

This method fetches detailed information about your store's technical environment,
including server configuration, WordPress setup, database status, active plugins,
theme information, security settings, and WooCommerce-specific pages.
https://woocommerce.github.io/woocommerce-rest-api-docs/#list-all-system-status-items

## Parameters

* [useFaker] - When true, returns fake data for testing purposes

## Returns

A `Future<WooSystemStatus>` containing comprehensive system status information.

## Throws

* `WooCommerceException` if the request fails or access is denied

## Example Usage

```dart
// Get complete system status
final status = await wooCommerce.getSystemStatus();

// Check environment details
print('PHP Version: ${status.environment?.phpVersion}');
print('WordPress Version: ${status.environment?.wpVersion}');
print('Memory Limit: ${status.environment?.wpMemoryLimit}MB');

// Check database status
print('Database Version: ${status.database?.wcDatabaseVersion}');
print('Database Tables: ${status.database?.databaseTables?.length}');

// Check active plugins
print('Active Plugins: ${status.activePlugins?.length}');
for (final plugin in status.activePlugins ?? []) {
  print('  - $plugin');
}

// Check security status
print('Security Issues: ${status.security != null}');
```

## system_status_tool_api

### extension WooSystemStatusToolApi on WooCommerce

WooCommerce System Status Tool API Extension

This extension provides comprehensive system status tool management capabilities for WooCommerce stores.
System status tools are diagnostic and maintenance utilities that help you manage your store's
health, performance, and data integrity through automated tools and processes.

## System Status Tools Overview

System status tools are automated utilities that perform various maintenance and diagnostic
tasks on your WooCommerce store. These tools help with database optimization, cache clearing,
data synchronization, and other maintenance operations that keep your store running smoothly.

## Key Features

- **Diagnostic tools**: Automated health checks and system diagnostics
- **Maintenance utilities**: Database optimization and cleanup tools
- **Data synchronization**: Sync tools for orders, products, and customer data
- **Cache management**: Clear and optimize various caches
- **Security tools**: Security scanning and vulnerability assessment
- **Performance optimization**: Tools to improve store performance

## Common System Status Tools

- **Database cleanup**: Remove orphaned data and optimize database
- **Cache clearing**: Clear various caches (page, object, transients)
- **Log cleanup**: Remove old log files and optimize storage
- **Data synchronization**: Sync data between systems
- **Security scanning**: Check for security vulnerabilities
- **Performance monitoring**: Analyze and optimize performance

## Example Usage

```dart
// Get all available tools
final tools = await wooCommerce.getSystemStatusTools();

// Get a specific tool
final tool = await wooCommerce.getSystemStatusTool(id: 'clear_cache');

// Run a tool with confirmation
final result = await wooCommerce.runSystemStatusTool(
  id: 'clear_cache',
  confirm: true,
);
```

### Future<List<WooSystemStatusTool>> getSystemStatusTools

Retrieves all available system status tools from the WooCommerce store.

This method fetches all diagnostic and maintenance tools available for your store.
These tools help with database optimization, cache clearing, data synchronization,
and other maintenance operations that keep your store running smoothly.
https://woocommerce.github.io/woocommerce-rest-api-docs/#list-all-tools-from-system-status

## Parameters

* [useFaker] - When true, returns fake data for testing purposes

## Returns

A `Future<List<WooSystemStatusTool>>` containing all available system status tools.

## Throws

* `WooCommerceException` if the request fails or access is denied

## Example Usage

```dart
// Get all available tools
final tools = await wooCommerce.getSystemStatusTools();

// Print tool information
for (final tool in tools) {
  print('Tool: ${tool.name} (${tool.id})');
  print('Description: ${tool.description}');
  print('Action: ${tool.action}');
}

// Find specific tools
final cacheTools = tools.where((tool) =>
  tool.name?.toLowerCase().contains('cache') == true
);
```

### Future<WooSystemStatusTool> getSystemStatusTool({ required String id, bool? useFaker, }) async

Retrieves a specific system status tool by its ID.

This method fetches detailed information about a single system status tool,
including its description, action, and configuration. Useful when you need
to work with a specific tool without loading all available tools.
https://woocommerce.github.io/woocommerce-rest-api-docs/#retrieve-a-tool-from-system-status

## Parameters

* [id] - The unique identifier of the system status tool
* [useFaker] - When true, returns fake data for testing purposes

## Returns

A `Future<WooSystemStatusTool>` containing the tool details.

## Throws

* `WooCommerceException` if the tool is not found or access is denied

## Example Usage

```dart
// Get a specific tool
final tool = await wooCommerce.getSystemStatusTool(id: 'clear_cache');

print('Tool: ${tool.name}');
print('Description: ${tool.description}');
print('Action: ${tool.action}');
print('Requires confirmation: ${tool.confirm}');

// Check if tool is available
if (tool.id != null) {
  print('Tool is available for execution');
}
```

### Future<WooSystemStatusTool> runSystemStatusTool({ required String id, required bool confirm, bool? useFaker, }) async

Executes a system status tool in the WooCommerce store.

This method runs a specific system status tool, such as cache clearing,
database optimization, or data synchronization. Some tools require confirmation
to prevent accidental execution of potentially destructive operations.
https://woocommerce.github.io/woocommerce-rest-api-docs/#run-a-tool-from-system-status

## Parameters

* [id] - The unique identifier of the system status tool to run
* [confirm] - Whether to confirm the execution (required for destructive tools)
* [useFaker] - When true, returns fake data for testing purposes

## Returns

A `Future<WooSystemStatusTool>` containing the tool execution result.

## Throws

* `WooCommerceException` if the tool execution fails or tool not found

## Example Usage

```dart
// Run a cache clearing tool
final result = await wooCommerce.runSystemStatusTool(
  id: 'clear_cache',
  confirm: true,
);

print('Tool executed: ${result.success}');
print('Message: ${result.message}');

// Run database optimization
final dbResult = await wooCommerce.runSystemStatusTool(
  id: 'optimize_database',
  confirm: true,
);

if (dbResult.success == true) {
  print('Database optimization completed successfully');
}
```

## system_status

### class WooSystemStatus

WooCommerce System Status Model

Represents comprehensive system status information for a WooCommerce store.
This model contains detailed information about the store's technical environment,
including server configuration, database status, active plugins, theme information,
security settings, and WooCommerce-specific pages.

## System Status Structure

A system status consists of several key components:

- **Environment**: Server info, PHP version, WordPress version, memory limits
- **Database**: WooCommerce database version, table structure, connectivity
- **Active Plugins**: List of currently active plugins and their impact
- **Theme**: Current theme information and compatibility details
- **Settings**: WooCommerce configuration and settings
- **Security**: Security settings and potential vulnerabilities
- **Pages**: WooCommerce-specific pages and their status

## Key Information Provided

- **Server Environment**: PHP version, memory limits, server software
- **WordPress Configuration**: Version, multisite status, debug mode
- **Database Status**: WooCommerce database version, table structure
- **Plugin Management**: Active plugins and their impact on performance
- **Theme Compatibility**: Current theme and WooCommerce compatibility
- **Security Assessment**: Security settings and potential issues
- **Performance Metrics**: Memory usage, execution times, optimization status

## Example Usage

```dart
// Get system status
final status = await wooCommerce.getSystemStatus();

// Check environment details
print('PHP Version: ${status.environment?.phpVersion}');
print('WordPress Version: ${status.environment?.wpVersion}');
print('Memory Limit: ${status.environment?.wpMemoryLimit}MB');

// Check database status
print('Database Version: ${status.database?.wcDatabaseVersion}');
print('Database Tables: ${status.database?.databaseTables?.length}');

// Check active plugins
print('Active Plugins: ${status.activePlugins?.length}');
```

### WooSystemStatus({ this.environment, this.database, this.activePlugins, this.theme, this.settings, this.security, this.pages, })

WooCommerce System Status Model

Represents comprehensive system status information for a WooCommerce store.
This model contains detailed information about the store's technical environment,
including server configuration, database status, active plugins, theme information,
security settings, and WooCommerce-specific pages.

## System Status Structure

A system status consists of several key components:

- **Environment**: Server info, PHP version, WordPress version, memory limits
- **Database**: WooCommerce database version, table structure, connectivity
- **Active Plugins**: List of currently active plugins and their impact
- **Theme**: Current theme information and compatibility details
- **Settings**: WooCommerce configuration and settings
- **Security**: Security settings and potential vulnerabilities
- **Pages**: WooCommerce-specific pages and their status

## Key Information Provided

- **Server Environment**: PHP version, memory limits, server software
- **WordPress Configuration**: Version, multisite status, debug mode
- **Database Status**: WooCommerce database version, table structure
- **Plugin Management**: Active plugins and their impact on performance
- **Theme Compatibility**: Current theme and WooCommerce compatibility
- **Security Assessment**: Security settings and potential issues
- **Performance Metrics**: Memory usage, execution times, optimization status

## Example Usage

```dart
// Get system status
final status = await wooCommerce.getSystemStatus();

// Check environment details
print('PHP Version: ${status.environment?.phpVersion}');
print('WordPress Version: ${status.environment?.wpVersion}');
print('Memory Limit: ${status.environment?.wpMemoryLimit}MB');

// Check database status
print('Database Version: ${status.database?.wcDatabaseVersion}');
print('Database Tables: ${status.database?.databaseTables?.length}');

// Check active plugins
print('Active Plugins: ${status.activePlugins?.length}');
```

### factory WooSystemStatus.fromJson(Map<String, dynamic> json)

Creates a WooSystemStatus instance from JSON data

This factory constructor is used to deserialize system status data received
from the WooCommerce REST API. It handles the conversion of JSON fields
to the appropriate Dart types and provides fallback values where needed.

## Parameters

* [json] - A Map containing the system status data in JSON format

## Returns

A `WooSystemStatus` instance populated with data from the JSON.

## JSON Structure

The expected JSON structure includes:
```json
{
  "environment": {
    "php_version": "8.1.10",
    "wp_version": "6.2.2",
    "wp_memory_limit": 256
  },
  "database": {
    "wc_database_version": "7.4.0",
    "database_tables": ["wp_posts", "wp_postmeta"]
  },
  "active_plugins": ["woocommerce", "jetpack"],
  "theme": {
    "name": "Storefront",
    "version": "4.1.0"
  },
  "settings": {
    "api_enabled": true,
    "force_ssl": false
  },
  "security": {
    "secure_connection": true,
    "hide_errors": false
  },
  "pages": ["shop", "cart", "checkout", "my-account"]
}
```

## Example Usage

```dart
// Parse system status from API response
final jsonData = {
  'environment': {'php_version': '8.1.10', 'wp_version': '6.2.2'},
  'active_plugins': ['woocommerce', 'jetpack'],
  'pages': ['shop', 'cart', 'checkout']
};

final status = WooSystemStatus.fromJson(jsonData);
print('PHP Version: ${status.environment?.phpVersion}');
print('Active Plugins: ${status.activePlugins?.length}');
```

### ? null

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### ? null

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### ? null

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### ? null

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### ? null

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### factory WooSystemStatus.fake()

Creates a fake WooSystemStatus instance for testing purposes

This factory constructor generates a system status with random but realistic
data, making it useful for testing, development, and demonstration purposes.
The generated system status will have valid data for all fields.

## Generated Data

The fake system status includes:
- Random environment information with realistic server details
- Random database information with realistic table structure
- Random list of active plugins
- Random theme information with realistic details
- Random settings information
- Random security information
- Random list of WooCommerce pages

## Returns

A `WooSystemStatus` instance with randomly generated fake data.

## Example Usage

```dart
// Generate a fake system status for testing
final fakeStatus = WooSystemStatus.fake();
print('Fake status: ${fakeStatus.environment?.phpVersion}');
print('Active Plugins: ${fakeStatus.activePlugins?.length}');
print('Pages: ${fakeStatus.pages?.length}');

// Use in tests
test('system status creation', () {
  final status = WooSystemStatus.fake();
  expect(status.environment, isNotNull);
  expect(status.database, isNotNull);
  expect(status.activePlugins, isNotNull);
});
```

### final WooSystemStatusEnvironment? environment

Environment information

Contains detailed information about the server environment, including
PHP version, WordPress version, memory limits, server software, and
various PHP extensions and configurations.

### final WooSystemStatusDatabase? database

Database information

Contains information about the WooCommerce database, including version,
table structure, connectivity status, and database-specific settings.

### final List<String>? activePlugins

Active plugins

List of currently active plugins in the WordPress installation.
This helps identify potential conflicts and performance impacts.

### final WooSystemStatusTheme? theme

Theme information

Contains details about the current WordPress theme, including version,
WooCommerce compatibility, and theme-specific settings.

### final WooSystemStatusSettings? settings

Settings information

Contains WooCommerce-specific settings and configuration details,
including store settings, payment methods, and other configurations.

### final WooSystemStatusSecurity? security

Security information

Contains security-related information, including potential vulnerabilities,
security settings, and recommendations for improving store security.

### final List<String>? pages

WooCommerce pages

List of WooCommerce-specific pages (shop, cart, checkout, my-account)
and their current status and accessibility.

### Map<String, dynamic> toJson()

Converts the WooSystemStatus instance to JSON format

This method serializes the system status data into a Map that can be sent
to the WooCommerce REST API. It handles the conversion of Dart types
to JSON-compatible formats and includes all necessary fields.

## Returns

A `Map<String, dynamic>` containing the system status data in JSON format.

## JSON Structure

The returned JSON structure includes:
```json
{
  "environment": {
    "php_version": "8.1.10",
    "wp_version": "6.2.2",
    "wp_memory_limit": 256
  },
  "database": {
    "wc_database_version": "7.4.0",
    "database_tables": ["wp_posts", "wp_postmeta"]
  },
  "active_plugins": ["woocommerce", "jetpack"],
  "theme": {
    "name": "Storefront",
    "version": "4.1.0"
  },
  "settings": {
    "api_enabled": true,
    "force_ssl": false
  },
  "security": {
    "secure_connection": true,
    "hide_errors": false
  },
  "pages": ["shop", "cart", "checkout", "my-account"]
}
```

## Example Usage

```dart
// Convert system status to JSON for API calls
final status = WooSystemStatus(
  environment: environmentInfo,
  activePlugins: ['woocommerce', 'jetpack'],
);

final jsonData = status.toJson();
print('JSON: $jsonData');

// Send to API
await dio.post('/system_status', data: status.toJson());
```

### WooSystemStatus copyWith({ WooSystemStatusEnvironment? environment, WooSystemStatusDatabase? database, List<String>? activePlugins, WooSystemStatusTheme? theme, WooSystemStatusSettings? settings, WooSystemStatusSecurity? security, List<String>? pages, })

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### bool operator ==(Object other)

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### int get hashCode

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### String toString()

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

## system_status_database

### class WooSystemStatusDatabase

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### WooSystemStatusDatabase({ this.wcDatabaseVersion, this.databasePrefix, this.maxmindGeoipDatabase, this.databaseTables, })

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### factory WooSystemStatusDatabase.fromJson(Map<String, dynamic> json)

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### factory WooSystemStatusDatabase.fake()

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final String? wcDatabaseVersion

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final String? databasePrefix

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final String? maxmindGeoipDatabase

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final List<String>? databaseTables

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### Map<String, dynamic> toJson()

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### WooSystemStatusDatabase copyWith({ String? wcDatabaseVersion, String? databasePrefix, String? maxmindGeoipDatabase, List<String>? databaseTables, })

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### bool operator ==(Object other)

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### int get hashCode

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### String toString()

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

## system_status_environment

### class WooSystemStatusEnvironment

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### WooSystemStatusEnvironment({ this.homeUrl, this.siteUrl, this.version, this.logDirectory, this.logDirectoryWritable, this.wpVersion, this.wpMultisite, this.wpMemoryLimit, this.wpDebugMode, this.wpCron, this.language, this.serverInfo, this.phpVersion, this.phpPostMaxSize, this.phpMaxExecutionTime, this.phpMaxInputVars, this.curlVersion, this.suhosinInstalled, this.maxUploadSize, this.mysqlVersion, this.defaultTimezone, this.fsockOpenOrCurlEnabled, this.soapClientEnabled, this.domDocumentEnabled, this.gzipEnabled, this.mbstringEnabled, this.remotePostSuccessful, this.remotePostResponse, this.remoteGetSuccessful, this.remoteGetResponse, })

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### factory WooSystemStatusEnvironment.fromJson(Map<String, dynamic> json)

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### factory WooSystemStatusEnvironment.fake()

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final String? homeUrl

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final String? siteUrl

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final String? version

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final String? logDirectory

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final bool? logDirectoryWritable

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final String? wpVersion

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final bool? wpMultisite

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final int? wpMemoryLimit

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final bool? wpDebugMode

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final bool? wpCron

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final String? language

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final String? serverInfo

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final String? phpVersion

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final int? phpPostMaxSize

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final int? phpMaxExecutionTime

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final int? phpMaxInputVars

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final String? curlVersion

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final bool? suhosinInstalled

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final int? maxUploadSize

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final String? mysqlVersion

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final String? defaultTimezone

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final bool? fsockOpenOrCurlEnabled

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final bool? soapClientEnabled

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final bool? domDocumentEnabled

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final bool? gzipEnabled

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final bool? mbstringEnabled

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final bool? remotePostSuccessful

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final String? remotePostResponse

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final bool? remoteGetSuccessful

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final String? remoteGetResponse

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### Map<String, dynamic> toJson()

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### WooSystemStatusEnvironment copyWith({ String? homeUrl, String? siteUrl, String? version, String? logDirectory, bool? logDirectoryWritable, String? wpVersion, bool? wpMultisite, int? wpMemoryLimit, bool? wpDebugMode, bool? wpCron, String? language, String? serverInfo, String? phpVersion, int? phpPostMaxSize, int? phpMaxExecutionTime, int? phpMaxInputVars, String? curlVersion, bool? suhosinInstalled, int? maxUploadSize, String? mysqlVersion, String? defaultTimezone, bool? fsockOpenOrCurlEnabled, bool? soapClientEnabled, bool? domDocumentEnabled, bool? gzipEnabled, bool? mbstringEnabled, bool? remotePostSuccessful, String? remotePostResponse, bool? remoteGetSuccessful, String? remoteGetResponse, })

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### bool operator ==(Object other)

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### int get hashCode

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### String toString()

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

## system_status_security

### class WooSystemStatusSecurity

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### WooSystemStatusSecurity({this.secureConnection, this.hideErrors})

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### factory WooSystemStatusSecurity.fromJson(Map<String, dynamic> json)

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### factory WooSystemStatusSecurity.fake()

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final bool? secureConnection

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final bool? hideErrors

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### Map<String, dynamic> toJson()

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### WooSystemStatusSecurity copyWith({ bool? secureConnection, bool? hideErrors, })

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### bool operator ==(Object other)

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### int get hashCode

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### String toString()

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

## system_status_settings

### class WooSystemStatusSettings

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### WooSystemStatusSettings({ this.apiEnabled, this.forceSsl, this.currency, this.currencySymbol, this.currencyPosition, this.thousandSeparator, this.decimalSeparator, this.numberOfDecimals, this.geolocationEnabled, this.taxonomies, })

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### factory WooSystemStatusSettings.fromJson(Map<String, dynamic> json)

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### factory WooSystemStatusSettings.fake()

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final bool? apiEnabled

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final bool? forceSsl

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final String? currency

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final String? currencySymbol

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final String? currencyPosition

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final String? thousandSeparator

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final String? decimalSeparator

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final int? numberOfDecimals

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final bool? geolocationEnabled

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final List<String>? taxonomies

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### Map<String, dynamic> toJson()

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### WooSystemStatusSettings copyWith({ bool? apiEnabled, bool? forceSsl, String? currency, String? currencySymbol, String? currencyPosition, String? thousandSeparator, String? decimalSeparator, int? numberOfDecimals, bool? geolocationEnabled, List<String>? taxonomies, })

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### bool operator ==(Object other)

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### int get hashCode

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### String toString()

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

## system_status_theme

### class WooSystemStatusTheme

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### WooSystemStatusTheme({ this.name, this.version, this.versionLatest, this.authorUrl, this.isChildTheme, this.hasWooCommerceSupport, this.hasWooCommerceFile, this.hasOutdatedTemplates, this.overrides, this.parentName, this.parentVersion, this.parentAuthorUrl, })

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### factory WooSystemStatusTheme.fromJson(Map<String, dynamic> json)

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### factory WooSystemStatusTheme.fake()

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final String? name

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final String? version

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final String? versionLatest

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final String? authorUrl

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final bool? isChildTheme

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final bool? hasWooCommerceSupport

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final bool? hasWooCommerceFile

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final bool? hasOutdatedTemplates

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final List<String>? overrides

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final String? parentName

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final String? parentVersion

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final String? parentAuthorUrl

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### Map<String, dynamic> toJson()

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### WooSystemStatusTheme copyWith({ String? name, String? version, String? versionLatest, String? authorUrl, bool? isChildTheme, bool? hasWooCommerceSupport, bool? hasWooCommerceFile, bool? hasOutdatedTemplates, List<String>? overrides, String? parentName, String? parentVersion, String? parentAuthorUrl, })

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### bool operator ==(Object other)

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### int get hashCode

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### String toString()

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

## system_status_tool

### class WooSystemStatusTool

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### WooSystemStatusTool({ this.id, this.name, this.action, this.description, this.success, this.message, this.confirm, })

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### factory WooSystemStatusTool.fromJson(Map<String, dynamic> json)

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### factory WooSystemStatusTool.fake()

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final String? id

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final String? name

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final String? action

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final String? description

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final bool? success

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final String? message

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final bool? confirm

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### Map<String, dynamic> toJson()

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### WooSystemStatusTool copyWith({ String? id, String? name, String? action, String? description, bool? success, String? message, bool? confirm, })

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### bool operator ==(Object other)

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### int get hashCode

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### String toString()

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

