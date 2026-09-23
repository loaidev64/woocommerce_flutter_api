import '../../helpers/fake_helper.dart';
import '../../json/woo_json.dart';

class WooCustomerDownloadFile {
  WooCustomerDownloadFile({this.name, this.file});
  factory WooCustomerDownloadFile.fromJson(Map<String, dynamic> json) =>
      WooCustomerDownloadFile(
        name: WooJson.readString(json, 'name'),
        file: WooJson.readString(json, 'file'),
      );
  factory WooCustomerDownloadFile.fake() => WooCustomerDownloadFile(
        name: FakeHelper.word(),
        file: FakeHelper.url(),
      );
  final String? name;
  final String? file;
  Map<String, dynamic> toJson() => <String, dynamic>{}
    ..putIfPresent('name', name)
    ..putIfPresent('file', file);
  WooCustomerDownloadFile copyWith({String? name, String? file}) =>
      WooCustomerDownloadFile(
        name: name ?? this.name,
        file: file ?? this.file,
      );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WooCustomerDownloadFile &&
          other.name == name &&
          other.file == file;
  @override
  int get hashCode => Object.hashAll([name, file]);
  @override
  String toString() => 'WooCustomerDownloadFile(name: $name, file: $file)';
}
