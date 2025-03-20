import 'package:woocommerce_flutter_api/woocommerce_flutter_api.dart';

part 'system_status_tool_endpoints.dart';

extension WooSystemStatusToolApi on WooCommerce {
  /// Get all system status tools
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

  /// Get specific system status tool
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

  /// Run a system status tool
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