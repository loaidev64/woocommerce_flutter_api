import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Helper class for managing secure local storage of user data.
///
/// This class provides methods to securely store and retrieve user IDs
/// using Flutter's secure storage mechanism.
abstract class LocalStorageHelper {
  static const _secureStorage = FlutterSecureStorage();
  static const String _userIdKey = 'woocommerce_user_id';

  /// Stores the user ID securely in local storage.
  ///
  /// [userId] The user ID to store. Pass null to clear the stored ID.
  static Future<void> updateSecurityUserId(int? userId) async {
    if (userId != null) {
      await _secureStorage.write(key: _userIdKey, value: userId.toString());
    } else {
      await _secureStorage.delete(key: _userIdKey);
    }
  }

  /// Deletes the stored user ID from secure storage.
  static Future<void> deleteSecurityUserId() async {
    await _secureStorage.delete(key: _userIdKey);
  }

  /// Retrieves the stored user ID from secure storage.
  ///
  /// Returns the user ID if found, null otherwise.
  static Future<int?> getSecurityUserId() async {
    final String? userIdString = await _secureStorage.read(key: _userIdKey);
    return userIdString != null ? int.tryParse(userIdString) : null;
  }
}
