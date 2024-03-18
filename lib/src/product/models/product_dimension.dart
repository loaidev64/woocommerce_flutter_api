import 'package:faker/faker.dart';

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
        Faker().randomGenerator.integer(100).toString(),
        Faker().randomGenerator.integer(100).toString(),
        Faker().randomGenerator.integer(100).toString(),
      );
}
