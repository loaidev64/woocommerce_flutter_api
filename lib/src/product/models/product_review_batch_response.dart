import '../../json/woo_json.dart';
import '../../helpers/fake_helper.dart';
import 'product_review.dart';

class WooProductReviewBatchResponse {
  WooProductReviewBatchResponse({this.create, this.update, this.delete});
  factory WooProductReviewBatchResponse.fromJson(Map<String, dynamic> json) =>
      WooProductReviewBatchResponse(
        create: WooJson.readList(json, 'create', WooProductReview.fromJson),
        update: WooJson.readList(json, 'update', WooProductReview.fromJson),
        delete: WooJson.readList(json, 'delete', WooProductReview.fromJson),
      );
  factory WooProductReviewBatchResponse.fake() => WooProductReviewBatchResponse(
        create: FakeHelper.list(() => WooProductReview.fake()),
        update: FakeHelper.list(() => WooProductReview.fake()),
        delete: FakeHelper.list(() => WooProductReview.fake()),
      );
  final List<WooProductReview>? create;
  final List<WooProductReview>? update;
  final List<WooProductReview>? delete;
  Map<String, dynamic> toJson() => <String, dynamic>{}
    ..putIfPresent('create', create?.map((review) => review.toJson()).toList())
    ..putIfPresent('update', update?.map((review) => review.toJson()).toList())
    ..putIfPresent('delete', delete?.map((review) => review.toJson()).toList());
  WooProductReviewBatchResponse copyWith({
    List<WooProductReview>? create,
    List<WooProductReview>? update,
    List<WooProductReview>? delete,
  }) =>
      WooProductReviewBatchResponse(
        create: create ?? this.create,
        update: update ?? this.update,
        delete: delete ?? this.delete,
      );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WooProductReviewBatchResponse &&
          WooJson.listEquals(other.create, create) &&
          WooJson.listEquals(other.update, update) &&
          WooJson.listEquals(other.delete, delete);
  @override
  int get hashCode => Object.hashAll([
        ...(create ?? const []),
        ...(update ?? const []),
        ...(delete ?? const []),
      ]);
  @override
  String toString() =>
      'WooProductReviewBatchResponse(create: ${create?.length ?? 0}, '
      'update: ${update?.length ?? 0}, delete: ${delete?.length ?? 0})';
}
