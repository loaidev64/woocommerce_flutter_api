import '../../woocommerce_flutter_api_base.dart';
import '../models/system_status.dart';
part 'system_status_endpoints.dart';

extension WooSystemStatusApi on WooCommerce {
  Future<WooSystemStatus> getSystemStatus({bool? useFaker}) async {
    final isUsingFaker = useFaker ?? this.useFaker;
    if (isUsingFaker) {
      return WooSystemStatus.fake();
    }
    final response = await requestGet<Map<String, dynamic>>(
      _SystemStatusEndpoints.systemStatus,
    );
    return WooSystemStatus.fromJson(response.data!);
  }
}
