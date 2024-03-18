import 'package:faker/faker.dart';

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
        Faker().randomGenerator.integer(100).toString(),
        Faker().lorem.word(),
        Faker().internet.httpsUrl(),
      );
}
