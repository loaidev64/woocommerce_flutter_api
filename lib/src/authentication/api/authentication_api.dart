import 'package:meta/meta.dart';
import '../../helpers/fake_helper.dart';
import '../../helpers/local_storage_helper.dart';
import '../../json/woo_json.dart';
import '../../woocommerce_flutter_api_base.dart';
import '../models/customer.dart';
part 'authentication_endpoints.dart';

extension WooAuthenticationApi on WooCommerce {
  @experimental
  Future<void> login(String email, String password) async {
    if (useFaker) {
      return;
    }
    final response = await requestPost<Map<String, dynamic>>(
      _AuthenticationEndpoints.login,
      data: {
        'email': email,
        'password': password,
      },
    );
    final userId = WooJson.readInt(response.data ?? const {}, 'user_id');
    await LocalStorageHelper.updateSecurityUserId(userId);
  }

  @experimental
  Future<void> register(WooCustomer customer) async {
    if (useFaker) {
      return;
    }
    final response = await requestPost<Map<String, dynamic>>(
      _AuthenticationEndpoints.register,
      data: customer.toJson(),
    );
    final userId = WooJson.readInt(response.data ?? const {}, 'user_id');
    await LocalStorageHelper.updateSecurityUserId(userId);
  }

  @experimental
  Future<void> changePassword(String password) async {
    if (useFaker) {
      return;
    }
    await requestPost<Map<String, dynamic>>(
      _AuthenticationEndpoints.changePassword,
      data: {
        'user_id': await LocalStorageHelper.getSecurityUserId(),
        'password': password,
      },
    );
  }

  @experimental
  Future<({int userId, String code})> forgotPassword(String email) async {
    if (useFaker) {
      return (userId: FakeHelper.integer(), code: FakeHelper.code());
    }
    final response = await requestPost<Map<String, dynamic>>(
      _AuthenticationEndpoints.forgotPassword,
      data: {
        'email': email,
      },
    );
    final data = response.data ?? const <String, dynamic>{};
    return (
      userId: WooJson.readInt(data, 'user_id') ?? 0,
      code: WooJson.readString(data, 'code') ?? '',
    );
  }

  Future<void> logout() async {
    await LocalStorageHelper.deleteSecurityUserId();
  }
}
