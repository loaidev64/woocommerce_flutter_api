import 'package:woocommerce_flutter_api/woocommerce_flutter_api.dart';

class WooCustomerDownloadFile {
  /// File name.
  String? name;

  /// File URL.
  String? file;

  WooCustomerDownloadFile({
    this.name,
    this.file,
  });

  WooCustomerDownloadFile.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    file = json['file'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['file'] = file;
    return data;
  }

  @override
  String toString() => toJson().toString();

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is WooCustomerDownloadFile && other.name == name;
  }

  @override
  int get hashCode => name.hashCode;

  factory WooCustomerDownloadFile.fake() => WooCustomerDownloadFile(
        name: FakeHelper.word(),
        file: FakeHelper.url(),
      );
}
