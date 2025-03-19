import 'package:woocommerce_flutter_api/woocommerce_flutter_api.dart';

part 'endpoints.dart';

extension WooSettingsApi on WooCommerce {
  /// Fetches all settings groups from WooCommerce.
  ///
  /// [useFaker] If true, returns fake data for testing purposes.
  Future<List<WooSettings>> getSettingsGroups({
    bool? useFaker,
  }) async {
    final isUsingFaker = useFaker ?? this.useFaker;

    if (isUsingFaker) {
      return FakeHelper.list(WooSettings.fake);
    }

    final response = await dio.get(
      _SettingsEndpoints.settings,
    );

    return (response.data as List)
        .map((e) => WooSettings.fromJson(e))
        .toList();
  }

  /// Fetches all setting options for a specific group
  Future<List<WooSettingOption>> getSettingOptions({
    required String groupId,
    bool? useFaker,
  }) async {
    final isUsingFaker = useFaker ?? this.useFaker;

    if (isUsingFaker) {
      return FakeHelper.list(WooSettingOption.fake);
    }

    final response = await dio.get(
      _SettingsEndpoints.settingOptions(groupId),
    );

    return (response.data as List)
        .map((e) => WooSettingOption.fromJson(e))
        .toList();
  }

  /// Retrieves a specific setting option
  Future<WooSettingOption> getSettingOption({
    required String groupId,
    required String optionId,
    bool? useFaker,
  }) async {
    final isUsingFaker = useFaker ?? this.useFaker;

    if (isUsingFaker) {
      return WooSettingOption.fake();
    }

    final response = await dio.get(
      _SettingsEndpoints.singleSettingOption(groupId, optionId),
    );

    return WooSettingOption.fromJson(response.data);
  }

  /// Updates a specific setting option
  Future<WooSettingOption> updateSettingOption(
    WooSettingOption option, {
    bool? useFaker,
  }) async {
    final isUsingFaker = useFaker ?? this.useFaker;

    if (isUsingFaker) {
      return option;
    }

    final response = await dio.put(
      _SettingsEndpoints.singleSettingOption(option.groupId!, option.id!),
      data: option.toJson(),
    );

    return WooSettingOption.fromJson(response.data);
  }
}