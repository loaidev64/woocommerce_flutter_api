import 'package:woocommerce_flutter_api/woocommerce_flutter_api.dart';

part 'system_status_endpoints.dart';

extension WooSystemStatusApi on WooCommerce {
  /// Fetches system status information
  ///
  /// [useFaker] If true, returns fake data for testing purposes.
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