import '../../helpers/fake_helper.dart';
import '../../json/woo_json.dart';
import 'customer_download_file.dart';

class WooCustomerDownload {
  WooCustomerDownload({
    this.downloadId,
    this.downloadUrl,
    this.productId,
    this.productName,
    this.downloadName,
    this.orderId,
    this.orderKey,
    this.downloadsRemaining,
    this.accessExpires,
    this.accessExpiresGmt,
    this.file,
  });
  factory WooCustomerDownload.fromJson(Map<String, dynamic> json) {
    final fileJson = WooJson.readMap(json, 'file');
    return WooCustomerDownload(
      downloadId: WooJson.readString(json, 'download_id'),
      downloadUrl: WooJson.readString(json, 'download_url'),
      productId: WooJson.readInt(json, 'product_id'),
      productName: WooJson.readString(json, 'product_name'),
      downloadName: WooJson.readString(json, 'download_name'),
      orderId: WooJson.readInt(json, 'order_id'),
      orderKey: WooJson.readString(json, 'order_key'),
      downloadsRemaining: WooJson.readString(json, 'downloads_remaining'),
      accessExpires: WooJson.readDate(json, 'access_expires'),
      accessExpiresGmt: WooJson.readDate(json, 'access_expires_gmt'),
      file:
          fileJson == null ? null : WooCustomerDownloadFile.fromJson(fileJson),
    );
  }
  factory WooCustomerDownload.fake() => WooCustomerDownload(
        downloadId: FakeHelper.word(),
        downloadUrl: FakeHelper.url(),
        productId: FakeHelper.integer(),
        productName: FakeHelper.word(),
        downloadName: FakeHelper.word(),
        orderId: FakeHelper.integer(),
        orderKey: FakeHelper.word(),
        downloadsRemaining: FakeHelper.word(),
        accessExpires: FakeHelper.datetime(),
        accessExpiresGmt: FakeHelper.datetime(),
        file: WooCustomerDownloadFile.fake(),
      );
  final String? downloadId;
  final String? downloadUrl;
  final int? productId;
  final String? productName;
  final String? downloadName;
  final int? orderId;
  final String? orderKey;
  final String? downloadsRemaining;
  final DateTime? accessExpires;
  final DateTime? accessExpiresGmt;
  final WooCustomerDownloadFile? file;
  Map<String, dynamic> toJson() => <String, dynamic>{}
    ..putIfPresent('download_id', downloadId)
    ..putIfPresent('download_url', downloadUrl)
    ..putIfPresent('product_id', productId)
    ..putIfPresent('product_name', productName)
    ..putIfPresent('download_name', downloadName)
    ..putIfPresent('order_id', orderId)
    ..putIfPresent('order_key', orderKey)
    ..putIfPresent('downloads_remaining', downloadsRemaining)
    ..putDate('access_expires', accessExpires)
    ..putDate('access_expires_gmt', accessExpiresGmt)
    ..putIfPresent('file', file?.toJson());
  WooCustomerDownload copyWith({
    String? downloadId,
    String? downloadUrl,
    int? productId,
    String? productName,
    String? downloadName,
    int? orderId,
    String? orderKey,
    String? downloadsRemaining,
    DateTime? accessExpires,
    DateTime? accessExpiresGmt,
    WooCustomerDownloadFile? file,
  }) =>
      WooCustomerDownload(
        downloadId: downloadId ?? this.downloadId,
        downloadUrl: downloadUrl ?? this.downloadUrl,
        productId: productId ?? this.productId,
        productName: productName ?? this.productName,
        downloadName: downloadName ?? this.downloadName,
        orderId: orderId ?? this.orderId,
        orderKey: orderKey ?? this.orderKey,
        downloadsRemaining: downloadsRemaining ?? this.downloadsRemaining,
        accessExpires: accessExpires ?? this.accessExpires,
        accessExpiresGmt: accessExpiresGmt ?? this.accessExpiresGmt,
        file: file ?? this.file,
      );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WooCustomerDownload &&
          other.downloadId == downloadId &&
          other.downloadUrl == downloadUrl &&
          other.productId == productId &&
          other.productName == productName &&
          other.downloadName == downloadName &&
          other.orderId == orderId &&
          other.orderKey == orderKey &&
          other.downloadsRemaining == downloadsRemaining &&
          other.accessExpires == accessExpires &&
          other.accessExpiresGmt == accessExpiresGmt &&
          other.file == file;
  @override
  int get hashCode => Object.hashAll([
        downloadId,
        downloadUrl,
        productId,
        productName,
        downloadName,
        orderId,
        orderKey,
        downloadsRemaining,
        accessExpires,
        accessExpiresGmt,
        file,
      ]);
  @override
  String toString() =>
      'WooCustomerDownload(downloadId: $downloadId, productId: $productId, '
      'orderId: $orderId)';
}
