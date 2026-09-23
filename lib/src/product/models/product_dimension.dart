import '../../helpers/fake_helper.dart';
import '../../json/woo_json.dart';

class WooProductDimension {
  WooProductDimension({this.length, this.height, this.width});
  factory WooProductDimension.fromJson(Map<String, dynamic> json) =>
      WooProductDimension(
        length: WooJson.readString(json, 'length'),
        height: WooJson.readString(json, 'height'),
        width: WooJson.readString(json, 'width'),
      );
  factory WooProductDimension.fake() => WooProductDimension(
        length: FakeHelper.integer().toString(),
        height: FakeHelper.integer().toString(),
        width: FakeHelper.integer().toString(),
      );
  final String? length;
  final String? width;
  final String? height;
  Map<String, dynamic> toJson() => <String, dynamic>{}
    ..putIfPresent('length', length)
    ..putIfPresent('height', height)
    ..putIfPresent('width', width);
  WooProductDimension copyWith({
    String? length,
    String? height,
    String? width,
  }) =>
      WooProductDimension(
        length: length ?? this.length,
        height: height ?? this.height,
        width: width ?? this.width,
      );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WooProductDimension &&
          other.length == length &&
          other.height == height &&
          other.width == width;
  @override
  int get hashCode => Object.hashAll([length, height, width]);
  @override
  String toString() =>
      'WooProductDimension(length: $length, width: $width, height: $height)';
}
