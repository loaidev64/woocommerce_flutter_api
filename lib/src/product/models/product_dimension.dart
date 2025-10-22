import 'package:woocommerce_flutter_api/src/helpers/fake_helper.dart';

/// Represents product dimensions with length, width, and height.
///
/// Brief description of the model's purpose and usage for product physical dimensions.
class WooProductDimension {

  /// Creates a new WooProductDimension instance.
  const WooProductDimension({this.length, this.height, this.width});

  /// Creates a WooProductDimension instance from JSON data.
  WooProductDimension.fromJson(Map<String, dynamic> json)
      : length = json['length'],
        width = json['width'],
        height = json['height'];

  /// Creates a fake WooProductDimension instance for testing purposes.
  factory WooProductDimension.fake() => WooProductDimension(
        length: FakeHelper.integer().toString(),
        height: FakeHelper.integer().toString(),
        width: FakeHelper.integer().toString(),
      );
  /// Product length.
  final String? length;

  /// Product width.
  final String? width;

  /// Product height.
  final String? height;

  /// Converts the WooProductDimension instance to JSON format.
  Map<String, dynamic> toJson() =>
      {'length': length, 'width': width, 'height': height};

  /// Returns a string representation of the WooProductDimension instance.
  ///
  /// Displays all main fields for debugging and logging purposes.
  @override
  String toString() {
    return 'WooProductDimension(length: $length, width: $width, height: $height)';
  }
}
