import 'package:woocommerce_flutter_api/woocommerce_flutter_api.dart';

part 'authentication_endpoints.dart';

extension WooAuthenticationApi on WooCommerce {
  Future<void> login(String email, String password) async {
    if (useFaker) {
      return;
    }

    final response = await dio.post(_AuthenticationEndpoints.login, data: {
      'email': email,
      'password': password,
    });

    final userId = (response.data as Map<String, dynamic>)['user_id'] as int;
    await LocalStorageHelper.updateSecurityUserId(userId);
  }

  Future<void> register(WooCustomer customer) async {
    if (useFaker) {
      return;
    }
    final response = await dio.post(
      _AuthenticationEndpoints.register,
      data: customer.toJson(),
    );

    final userId = (response.data as Map<String, dynamic>)['user_id'] as int;
    await LocalStorageHelper.updateSecurityUserId(userId);
  }

  Future<void> changePassword(String password) async {
    if (useFaker) {
      return;
    }
    final response = await dio.post(
      _AuthenticationEndpoints.changePassword,
      data: {
        'user_id': await LocalStorageHelper.getSecurityUserId(),
        'password': password,
      },
    );

    return (response.data as Map<String, dynamic>)['status'];
  }

  Future<({int userId, String code})> forgotPassword(String email) async {
    if (useFaker) {
      return (userId: FakeHelper.integer(), code: FakeHelper.code());
    }
    final response = await dio.post(
      _AuthenticationEndpoints.forgotPassword,
      data: {
        'email': email,
      },
    );

    final data = (response.data as Map<String, dynamic>);
    final userId = int.parse(data['user_id']);
    final code = data['code'] as String;

    return (userId: userId, code: code);
  }

  //TODO:: logout
}
