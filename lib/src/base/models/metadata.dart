import 'package:woocommerce_flutter_api/src/helpers/fake_helper.dart';

class WooMetaData {
  /// Meta ID.
  final int? id;

  /// Meta key.
  final String? key;

  /// Meta value.
  final String value;

  WooMetaData(this.id, this.key, this.value);

  WooMetaData.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        key = json['key'],
        value = json['value'].toString();

  Map<String, dynamic> toJson() => {'id': id, 'key': key, 'value': value};

  factory WooMetaData.fake() => WooMetaData(
        FakeHelper.integer(),
        FakeHelper.word(),
        FakeHelper.word(),
      );
}
