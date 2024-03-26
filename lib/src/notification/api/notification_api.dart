import 'package:woocommerce_flutter_api/woocommerce_flutter_api.dart';

part 'endpoints.dart';

extension WooNotificationApi on WooCommerce {
  /// Gets all of the notifications of the logged in user
  ///
  /// [useFaker], fakes the api request
  Future<List<WooNotification>> getNotifications({bool? useFaker}) async {
    final isUsingFaker = useFaker ?? this.useFaker;

    if (isUsingFaker) {
      return List.generate(
          FakeHelper.integer(), (index) => WooNotification.fake());
    }

    final response =
        await dio.get(_NotificationEndpoints.notifications, queryParameters: {
      'user_id': await LocalStorageHelper.getSecurityUserId(),
    });

    return (response.data as List)
        .map((item) => WooNotification.fromJson(item))
        .toList();
  }

  /// Reads all of the notifications of the logged in user
  Future<bool> readNotifications() async {
    final response =
        await dio.post(_NotificationEndpoints.readNotifications, data: {
      'user_id': await LocalStorageHelper.getSecurityUserId(),
    });

    return (response.data as Map<String, dynamic>)['message'] == 'success';
  }

  /// Stores fcm tokens
  Future<bool> storeFcm(String token) async {
    final response = await dio.post(_NotificationEndpoints.fcm, data: {
      'current_user': await LocalStorageHelper.getSecurityUserId(),
      'gen_token': token,
      'device_id': 'mobile',
    });

    return (response.data as Map<String, dynamic>)['status'];
  }
}
