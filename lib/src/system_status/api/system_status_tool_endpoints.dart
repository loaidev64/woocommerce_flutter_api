part of 'system_status_tool_api.dart';

abstract class _SystemStatusToolEndpoints {
  static String get tools => '/system_status/tools';
  static String singleTool(String id) => '/system_status/tools/$id';
}