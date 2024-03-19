import 'package:woocommerce_flutter_api/src/helpers/fake_helper.dart';

class WooProductDimension {
  /// Product length.
  final String? length;

  /// Product width.
  final String? width;

  /// Product height.
  final String? height;

  const WooProductDimension({this.length, this.height, this.width});

  WooProductDimension.fromJson(Map<String, dynamic> json)
      : length = json['length'],
        width = json['width'],
        height = json['height'];

  Map<String, dynamic> toJson() =>
      {'length': length, 'width': width, 'height': height};

  factory WooProductDimension.fake() => WooProductDimension(
        length: FakeHelper.integer().toString(),
        height: FakeHelper.integer().toString(),
        width: FakeHelper.integer().toString(),
      );
}
