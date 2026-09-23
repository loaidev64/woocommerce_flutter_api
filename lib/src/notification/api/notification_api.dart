import 'package:meta/meta.dart';
import '../../helpers/fake_helper.dart';
import '../../helpers/local_storage_helper.dart';
import '../../json/woo_json.dart';
import '../../pagination/woo_page.dart';
import '../../woocommerce_flutter_api_base.dart';
import '../models/notification.dart';
part 'endpoints.dart';

extension WooNotificationApi on WooCommerce {
  @experimental
  Future<WooPage<WooNotification>> getNotifications({bool? useFaker}) async {
    final isUsingFaker = useFaker ?? this.useFaker;
    if (isUsingFaker) {
      return WooPage(
        items:
            List.generate(FakeHelper.integer(), (_) => WooNotification.fake()),
        page: 1,
      );
    }
    final userId = await LocalStorageHelper.getSecurityUserId();
    final response = await requestGet<List<dynamic>>(
      _NotificationEndpoints.notifications,
      queryParameters: {
        if (userId != null) 'user_id': userId,
      },
    );
    final items = response.data
            ?.whereType<Map<String, dynamic>>()
            .map(WooNotification.fromJson)
            .toList() ??
        const [];
    return WooPage.parse(response: response, items: items, page: 1);
  }

  @experimental
  Future<bool> readNotifications() async {
    final userId = await LocalStorageHelper.getSecurityUserId();
    final response = await requestPost<Map<String, dynamic>>(
      _NotificationEndpoints.readNotifications,
      data: {
        if (userId != null) 'user_id': userId,
      },
    );
    return (response.data ?? const <String, dynamic>{})['message'] == 'success';
  }

  @experimental
  Future<bool> storeFcm(String token) async {
    final userId = await LocalStorageHelper.getSecurityUserId();
    final response = await requestPost<Map<String, dynamic>>(
      _NotificationEndpoints.fcm,
      data: {
        if (userId != null) 'current_user': userId,
        'gen_token': token,
        'device_id': 'mobile',
      },
    );
    return WooJson.readBool(response.data ?? const {}, 'status') ?? false;
  }
}
