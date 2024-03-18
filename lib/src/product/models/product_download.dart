import 'package:woocommerce_flutter_api/src/helpers/fake_helper.dart';

class WooProductDownload {
  /// File ID.
  final String? id;

  /// File name.
  final String? name;

  /// File URL.
  final String? file;

  WooProductDownload(this.id, this.name, this.file);

  WooProductDownload.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        file = json['file'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'file': file,
      };

  factory WooProductDownload.fake() => WooProductDownload(
        FakeHelper.integer().toString(),
        FakeHelper.word(),
        FakeHelper.url(),
      );
}
