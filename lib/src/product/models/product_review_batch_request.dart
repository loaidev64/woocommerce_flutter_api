import '../../json/woo_json.dart';
import '../../helpers/fake_helper.dart';
import 'product_review.dart';

class WooProductReviewBatchRequest {
  WooProductReviewBatchRequest({this.create, this.update, this.delete});
  factory WooProductReviewBatchRequest.fromJson(Map<String, dynamic> json) =>
      WooProductReviewBatchRequest(
        create: WooJson.readList(json, 'create', WooProductReview.fromJson),
        update: WooJson.readList(json, 'update', WooProductReview.fromJson),
        delete: WooJson.readIntList(json, 'delete'),
      );
  factory WooProductReviewBatchRequest.fake() => WooProductReviewBatchRequest(
        create: FakeHelper.list(() => WooProductReview.fake()),
        update: FakeHelper.list(() => WooProductReview.fake()),
        delete: FakeHelper.listOfIntegers(),
      );
  final List<WooProductReview>? create;
  final List<WooProductReview>? update;
  final List<int>? delete;
  Map<String, dynamic> toJson() => <String, dynamic>{}
    ..putIfPresent('create', create?.map((review) => review.toJson()).toList())
    ..putIfPresent('update', update?.map((review) => review.toJson()).toList())
    ..putIfPresent('delete', delete);
  WooProductReviewBatchRequest copyWith({
    List<WooProductReview>? create,
    List<WooProductReview>? update,
    List<int>? delete,
  }) =>
      WooProductReviewBatchRequest(
        create: create ?? this.create,
        update: update ?? this.update,
        delete: delete ?? this.delete,
      );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WooProductReviewBatchRequest &&
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
      'WooProductReviewBatchRequest(create: ${create?.length ?? 0}, '
      'update: ${update?.length ?? 0}, delete: ${delete?.length ?? 0})';
}
