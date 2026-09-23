import '../../helpers/fake_helper.dart';
import '../../json/woo_json.dart';

class WooProductDownload {
  WooProductDownload({this.id, this.name, this.file});
  factory WooProductDownload.fromJson(Map<String, dynamic> json) =>
      WooProductDownload(
        id: WooJson.readString(json, 'id'),
        name: WooJson.readString(json, 'name'),
        file: WooJson.readString(json, 'file'),
      );
  factory WooProductDownload.fake() => WooProductDownload(
        id: FakeHelper.integer().toString(),
        name: FakeHelper.word(),
        file: FakeHelper.url(),
      );
  final String? id;
  final String? name;
  final String? file;
  Map<String, dynamic> toJson() => <String, dynamic>{}
    ..putIfPresent('id', id)
    ..putIfPresent('name', name)
    ..putIfPresent('file', file);
  WooProductDownload copyWith({String? id, String? name, String? file}) =>
      WooProductDownload(
        id: id ?? this.id,
        name: name ?? this.name,
        file: file ?? this.file,
      );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WooProductDownload &&
          other.id == id &&
          other.name == name &&
          other.file == file;
  @override
  int get hashCode => Object.hashAll([id, name, file]);
  @override
  String toString() => 'WooProductDownload(id: $id, name: $name, file: $file)';
}
