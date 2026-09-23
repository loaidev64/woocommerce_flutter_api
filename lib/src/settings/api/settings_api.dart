import '../../helpers/fake_helper.dart';
import '../../json/woo_json.dart';
import '../../woocommerce_flutter_api_base.dart';
import '../models/models.dart';
part 'endpoints.dart';

extension WooSettingsApi on WooCommerce {
  Future<List<WooSettings>> getSettingsGroups({bool? useFaker}) async {
    final isUsingFaker = useFaker ?? this.useFaker;
    if (isUsingFaker) {
      return FakeHelper.list(WooSettings.fake);
    }
    final response =
        await requestGet<List<dynamic>>(_SettingsEndpoints.settings);
    return response.data
            ?.whereType<Map<String, dynamic>>()
            .map(WooSettings.fromJson)
            .toList() ??
        [];
  }

  Future<List<WooSettingOption>> getSettingOptions({
    required String groupId,
    bool? useFaker,
  }) async {
    final isUsingFaker = useFaker ?? this.useFaker;
    if (isUsingFaker) {
      return FakeHelper.list(WooSettingOption.fake);
    }
    final response = await requestGet<List<dynamic>>(
      _SettingsEndpoints.settingOptions(groupId),
    );
    return response.data
            ?.whereType<Map<String, dynamic>>()
            .map(WooSettingOption.fromJson)
            .toList() ??
        [];
  }

  Future<WooSettingOption> getSettingOption({
    required String groupId,
    required String optionId,
    bool? useFaker,
  }) async {
    final isUsingFaker = useFaker ?? this.useFaker;
    if (isUsingFaker) {
      return WooSettingOption.fake();
    }
    final response = await requestGet<Map<String, dynamic>>(
      _SettingsEndpoints.singleSettingOption(groupId, optionId),
    );
    return WooSettingOption.fromJson(response.data!);
  }

  Future<WooSettingOption> updateSettingOption(
    WooSettingOption option, {
    bool? useFaker,
  }) async {
    final isUsingFaker = useFaker ?? this.useFaker;
    if (isUsingFaker) {
      return option;
    }
    final response = await requestPut<Map<String, dynamic>>(
      _SettingsEndpoints.singleSettingOption(option.groupId!, option.id!),
      data: <String, dynamic>{}..putIfPresent('value', option.value),
    );
    return WooSettingOption.fromJson(response.data!);
  }

  Future<WooSettingOptionBatchResponse> batchUpdateSettingOptions(
    String groupId,
    WooSettingOptionBatchRequest request, {
    bool? useFaker,
  }) async {
    final isUsingFaker = useFaker ?? this.useFaker;
    if (isUsingFaker) {
      return WooSettingOptionBatchResponse(
        create:
            request.create?.map((option) => WooSettingOption.fake()).toList(),
        update: request.update,
        delete: request.delete?.map((id) {
          final fakeOption = WooSettingOption.fake();
          return fakeOption.copyWith(id: id, groupId: groupId);
        }).toList(),
      );
    }
    final response = await requestPost<Map<String, dynamic>>(
      _SettingsEndpoints.batchSettingOptions(groupId),
      data: request.toJson(),
    );
    return WooSettingOptionBatchResponse.fromJson(response.data!);
  }
}
