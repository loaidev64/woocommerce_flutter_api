import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:meta/meta.dart';

@experimental
abstract class LocalStorageHelper {
  static const _secureStorage = FlutterSecureStorage();
  static const String _userIdKey = 'woocommerce_user_id';
  static Future<void> updateSecurityUserId(int? userId) async {
    if (userId != null) {
      await _secureStorage.write(key: _userIdKey, value: userId.toString());
    } else {
      await _secureStorage.delete(key: _userIdKey);
    }
  }

  static Future<void> deleteSecurityUserId() async {
    await _secureStorage.delete(key: _userIdKey);
  }

  static Future<int?> getSecurityUserId() async {
    final String? userIdString = await _secureStorage.read(key: _userIdKey);
    return userIdString != null ? int.tryParse(userIdString) : null;
  }
}
