import '../../helpers/fake_helper.dart';
import '../../woocommerce_flutter_api_base.dart';
import '../models/system_status_tool.dart';
part 'system_status_tool_endpoints.dart';

extension WooSystemStatusToolApi on WooCommerce {
  Future<List<WooSystemStatusTool>> getSystemStatusTools(
      {bool? useFaker}) async {
    final isUsingFaker = useFaker ?? this.useFaker;
    if (isUsingFaker) {
      return FakeHelper.list(WooSystemStatusTool.fake);
    }
    final response =
        await requestGet<List<dynamic>>(_SystemStatusToolEndpoints.tools);
    return response.data
            ?.whereType<Map<String, dynamic>>()
            .map(WooSystemStatusTool.fromJson)
            .toList() ??
        [];
  }

  Future<WooSystemStatusTool> getSystemStatusTool({
    required String id,
    bool? useFaker,
  }) async {
    final isUsingFaker = useFaker ?? this.useFaker;
    if (isUsingFaker) {
      return WooSystemStatusTool.fake();
    }
    final response = await requestGet<Map<String, dynamic>>(
      _SystemStatusToolEndpoints.singleTool(id),
    );
    return WooSystemStatusTool.fromJson(response.data!);
  }

  Future<WooSystemStatusTool> runSystemStatusTool({
    required String id,
    required bool confirm,
    bool? useFaker,
  }) async {
    final isUsingFaker = useFaker ?? this.useFaker;
    if (isUsingFaker) {
      return WooSystemStatusTool.fake().copyWith(
        id: id,
        success: true,
        message: 'Tool executed',
      );
    }
    final response = await requestPut<Map<String, dynamic>>(
      _SystemStatusToolEndpoints.singleTool(id),
      queryParameters: {'confirm': confirm},
    );
    return WooSystemStatusTool.fromJson(response.data!);
  }
}
