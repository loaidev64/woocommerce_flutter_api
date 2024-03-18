import 'package:woocommerce_flutter_api/src/helpers/fake_helper.dart';

class WooProductDimension {
  /// Product length.
  final String? length;

  /// Product width.
  final String? width;

  /// Product height.
  final String? height;

  WooProductDimension(this.length, this.height, this.width);

  WooProductDimension.fromJson(Map<String, dynamic> json)
      : length = json['length'],
        width = json['width'],
        height = json['height'];

  Map<String, dynamic> toJson() =>
      {'length': length, 'width': width, 'height': height};

  factory WooProductDimension.fake() => WooProductDimension(
        FakeHelper.integer().toString(),
        FakeHelper.integer().toString(),
        FakeHelper.integer().toString(),
      );
}
