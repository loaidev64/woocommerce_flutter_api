import 'package:woocommerce_flutter_api/woocommerce_flutter_api.dart';

part 'system_status_tool_endpoints.dart';

/// WooCommerce System Status Tool API Extension
///
/// This extension provides comprehensive system status tool management capabilities for WooCommerce stores.
/// System status tools are diagnostic and maintenance utilities that help you manage your store's
/// health, performance, and data integrity through automated tools and processes.
///
/// ## System Status Tools Overview
///
/// System status tools are automated utilities that perform various maintenance and diagnostic
/// tasks on your WooCommerce store. These tools help with database optimization, cache clearing,
/// data synchronization, and other maintenance operations that keep your store running smoothly.
///
/// ## Key Features
///
/// - **Diagnostic tools**: Automated health checks and system diagnostics
/// - **Maintenance utilities**: Database optimization and cleanup tools
/// - **Data synchronization**: Sync tools for orders, products, and customer data
/// - **Cache management**: Clear and optimize various caches
/// - **Security tools**: Security scanning and vulnerability assessment
/// - **Performance optimization**: Tools to improve store performance
///
/// ## Common System Status Tools
///
/// - **Database cleanup**: Remove orphaned data and optimize database
/// - **Cache clearing**: Clear various caches (page, object, transients)
/// - **Log cleanup**: Remove old log files and optimize storage
/// - **Data synchronization**: Sync data between systems
/// - **Security scanning**: Check for security vulnerabilities
/// - **Performance monitoring**: Analyze and optimize performance
///
/// ## Example Usage
///
/// ```dart
/// // Get all available tools
/// final tools = await wooCommerce.getSystemStatusTools();
///
/// // Get a specific tool
/// final tool = await wooCommerce.getSystemStatusTool(id: 'clear_cache');
///
/// // Run a tool with confirmation
/// final result = await wooCommerce.runSystemStatusTool(
///   id: 'clear_cache',
///   confirm: true,
/// );
/// ```
extension WooSystemStatusToolApi on WooCommerce {
  /// Retrieves all available system status tools from the WooCommerce store.
  ///
  /// This method fetches all diagnostic and maintenance tools available for your store.
  /// These tools help with database optimization, cache clearing, data synchronization,
  /// and other maintenance operations that keep your store running smoothly.
  /// https://woocommerce.github.io/woocommerce-rest-api-docs/#list-all-tools-from-system-status
  ///
  /// ## Parameters
  ///
  /// * [useFaker] - When true, returns fake data for testing purposes
  ///
  /// ## Returns
  ///
  /// A `Future<List<WooSystemStatusTool>>` containing all available system status tools.
  ///
  /// ## Throws
  ///
  /// * `WooCommerceException` if the request fails or access is denied
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// // Get all available tools
  /// final tools = await wooCommerce.getSystemStatusTools();
  ///
  /// // Print tool information
  /// for (final tool in tools) {
  ///   print('Tool: ${tool.name} (${tool.id})');
  ///   print('Description: ${tool.description}');
  ///   print('Action: ${tool.action}');
  /// }
  ///
  /// // Find specific tools
  /// final cacheTools = tools.where((tool) =>
  ///   tool.name?.toLowerCase().contains('cache') == true
  /// );
  /// ```
  Future<List<WooSystemStatusTool>> getSystemStatusTools({
    bool? useFaker,
  }) async {
    final isUsingFaker = useFaker ?? this.useFaker;

    if (isUsingFaker) {
      return FakeHelper.list(WooSystemStatusTool.fake);
    }

    final response = await dio.get(
      _SystemStatusToolEndpoints.tools,
    );

    return (response.data as List)
        .map((e) => WooSystemStatusTool.fromJson(e))
        .toList();
  }

  /// Retrieves a specific system status tool by its ID.
  ///
  /// This method fetches detailed information about a single system status tool,
  /// including its description, action, and configuration. Useful when you need
  /// to work with a specific tool without loading all available tools.
  /// https://woocommerce.github.io/woocommerce-rest-api-docs/#retrieve-a-tool-from-system-status
  ///
  /// ## Parameters
  ///
  /// * [id] - The unique identifier of the system status tool
  /// * [useFaker] - When true, returns fake data for testing purposes
  ///
  /// ## Returns
  ///
  /// A `Future<WooSystemStatusTool>` containing the tool details.
  ///
  /// ## Throws
  ///
  /// * `WooCommerceException` if the tool is not found or access is denied
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// // Get a specific tool
  /// final tool = await wooCommerce.getSystemStatusTool(id: 'clear_cache');
  ///
  /// print('Tool: ${tool.name}');
  /// print('Description: ${tool.description}');
  /// print('Action: ${tool.action}');
  /// print('Requires confirmation: ${tool.confirm}');
  ///
  /// // Check if tool is available
  /// if (tool.id != null) {
  ///   print('Tool is available for execution');
  /// }
  /// ```
  Future<WooSystemStatusTool> getSystemStatusTool({
    required String id,
    bool? useFaker,
  }) async {
    final isUsingFaker = useFaker ?? this.useFaker;

    if (isUsingFaker) {
      return WooSystemStatusTool.fake();
    }

    final response = await dio.get(
      _SystemStatusToolEndpoints.singleTool(id),
    );

    return WooSystemStatusTool.fromJson(response.data);
  }

  /// Executes a system status tool in the WooCommerce store.
  ///
  /// This method runs a specific system status tool, such as cache clearing,
  /// database optimization, or data synchronization. Some tools require confirmation
  /// to prevent accidental execution of potentially destructive operations.
  /// https://woocommerce.github.io/woocommerce-rest-api-docs/#run-a-tool-from-system-status
  ///
  /// ## Parameters
  ///
  /// * [id] - The unique identifier of the system status tool to run
  /// * [confirm] - Whether to confirm the execution (required for destructive tools)
  /// * [useFaker] - When true, returns fake data for testing purposes
  ///
  /// ## Returns
  ///
  /// A `Future<WooSystemStatusTool>` containing the tool execution result.
  ///
  /// ## Throws
  ///
  /// * `WooCommerceException` if the tool execution fails or tool not found
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// // Run a cache clearing tool
  /// final result = await wooCommerce.runSystemStatusTool(
  ///   id: 'clear_cache',
  ///   confirm: true,
  /// );
  ///
  /// print('Tool executed: ${result.success}');
  /// print('Message: ${result.message}');
  ///
  /// // Run database optimization
  /// final dbResult = await wooCommerce.runSystemStatusTool(
  ///   id: 'optimize_database',
  ///   confirm: true,
  /// );
  ///
  /// if (dbResult.success == true) {
  ///   print('Database optimization completed successfully');
  /// }
  /// ```
  Future<WooSystemStatusTool> runSystemStatusTool({
    required String id,
    required bool confirm,
    bool? useFaker,
  }) async {
    final isUsingFaker = useFaker ?? this.useFaker;

    if (isUsingFaker) {
      return WooSystemStatusTool.fake();
    }

    final response = await dio.put(
      _SystemStatusToolEndpoints.singleTool(id),
      queryParameters: {'confirm': confirm},
    );

    return WooSystemStatusTool.fromJson(response.data);
  }
}
