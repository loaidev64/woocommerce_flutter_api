import 'package:woocommerce_flutter_api/woocommerce_flutter_api.dart';

class WooCustomerDownload {
  /// Download ID (MD5).
  String? downloadId;

  /// Download file URL.
  String? downloadUrl;

  /// Downloadable product ID.
  int? productId;

  /// Product name.
  String? productName;

  /// Downloadable file name.
  String? downloadName;

  /// Order ID.
  int? orderId;

  /// Order key.
  String? orderKey;

  /// Number of downloads remaining.
  String? downloadsRemaining;

  /// The date when download access expires, in the site's timezone.
  DateTime? accessExpires;

  /// The date when download access expires, as GMT.
  DateTime? accessExpiresGmt;

  /// File details.
  WooCustomerDownloadFile? file;

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

  WooCustomerDownload.fromJson(Map<String, dynamic> json) {
    downloadId = json['download_id'];
    downloadUrl = json['download_url'];
    productId = json['product_id'];
    productName = json['product_name'];
    downloadName = json['download_name'];
    orderId = json['order_id'];
    orderKey = json['order_key'];
    downloadsRemaining = json['downloads_remaining'];
    accessExpires = DateTime.tryParse(json['access_expires']);
    accessExpiresGmt = DateTime.tryParse(json['access_expires_gmt']);
    file = json['file'] != null
        ? WooCustomerDownloadFile.fromJson(json['file'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['download_id'] = downloadId;
    data['download_url'] = downloadUrl;
    data['product_id'] = productId;
    data['product_name'] = productName;
    data['download_name'] = downloadName;
    data['order_id'] = orderId;
    data['order_key'] = orderKey;
    data['downloads_remaining'] = downloadsRemaining;
    data['access_expires'] = accessExpires?.toIso8601String();
    data['access_expires_gmt'] = accessExpiresGmt?.toIso8601String();
    if (file != null) {
      data['file'] = file!.toJson();
    }
    return data;
  }

  @override
  String toString() => toJson().toString();

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is WooCustomerDownload && other.downloadId == downloadId;
  }

  @override
  int get hashCode => downloadId.hashCode;

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
}
