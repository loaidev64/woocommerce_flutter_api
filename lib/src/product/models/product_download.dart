import 'package:woocommerce_flutter_api/src/helpers/fake_helper.dart';

/// Represents a downloadable file associated with a product.
///
/// Brief description of the model's purpose and usage for product downloads.
class WooProductDownload {

  /// Creates a new WooProductDownload instance.
  WooProductDownload(this.id, this.name, this.file);

  /// Creates a WooProductDownload instance from JSON data.
  WooProductDownload.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        file = json['file'];

  /// Creates a fake WooProductDownload instance for testing purposes.
  factory WooProductDownload.fake() => WooProductDownload(
        FakeHelper.integer().toString(),
        FakeHelper.word(),
        FakeHelper.url(),
      );
  /// File ID.
  final String? id;

  /// File name.
  final String? name;

  /// File URL.
  final String? file;

  /// Converts the WooProductDownload instance to JSON format.
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'file': file,
      };

  /// Returns a string representation of the WooProductDownload instance.
  ///
  /// Displays all main fields for debugging and logging purposes.
  @override
  String toString() {
    return 'WooProductDownload(id: $id, name: $name, file: $file)';
  }
}
