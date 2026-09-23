part of 'customer_api.dart';

abstract class _CustomerEndpoints {
  static String get customers => '/customers';

  static String customer(int id) => '/customers/$id';

  static String downloads(int id) => '/customers/$id/downloads';

  static String get batch => '/customers/batch';
}
