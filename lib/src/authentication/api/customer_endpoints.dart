part of 'customer_api.dart';

abstract class _CustomerEndpoints {
  static String get customers => '/customers';

  static String singleCustomer(int id) => '/customers/$id';
}
