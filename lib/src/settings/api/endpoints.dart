part of 'settings_api.dart';

abstract class _SettingsEndpoints {
  static String get settings => '/settings';

  static String settingOptions(String groupId) => '/settings/$groupId';

  static String singleSettingOption(String groupId, String optionId) =>
      '/settings/$groupId/$optionId';
}
