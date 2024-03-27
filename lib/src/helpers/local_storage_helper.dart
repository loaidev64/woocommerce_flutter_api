// import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class LocalStorageHelper {
  // static final secureStorage = FlutterSecureStorage();

  static Future<void> updateSecurityUserId(int? userId) async {
    // await secureStorage.write(key: 'userId', value: userId.toString());
  }

  static Future<void> deleteSecurityUserId() async {
    // await secureStorage.delete(key: 'userId');
  }

  static Future<int?> getSecurityUserId() async {
    // String? userId = await secureStorage.read(key: 'userId');

    return int.tryParse('c');
  }
}
