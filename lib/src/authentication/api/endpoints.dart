part of 'authentication_api.dart';

abstract class _AuthenticationEndpoints {
  static String get login => '/login';

  static String get register => '/register';

  static String get changePassword => '/change-password';

  static String get forgotPassword => '/forgot-password';
}
