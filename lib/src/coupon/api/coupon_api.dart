import '../../base/enums/context.dart';
import '../../base/enums/sort.dart';
import '../../base/models/woo_delete_result.dart';
import '../../exceptions/woocommerce_exception.dart';
import '../../pagination/woo_page.dart';
import '../../woocommerce_flutter_api_base.dart';
import '../models/coupon.dart';
import '../models/coupon_batch_request.dart';
import '../models/coupon_batch_response.dart';
import 'coupon_query.dart';
part 'endpoints.dart';

extension WooCouponApi on WooCommerce {
  Future<WooPage<WooCoupon>> getCoupons({
    WooContext context = WooContext.view,
    int? page,
    int? perPage,
    String? search,
    DateTime? after,
    DateTime? before,
    DateTime? modifiedAfter,
    DateTime? modifiedBefore,
    bool? datesAreGmt,
    List<int>? exclude,
    List<int>? include,
    int? offset,
    WooSort order = WooSort.desc,
    WooOrderBy orderBy = WooOrderBy.date,
    String? code,
    bool? useFaker,
  }) async {
    final isUsingFaker = useFaker ?? this.useFaker;
    if (isUsingFaker) {
      return WooPage(
        items: List.generate(perPage ?? 10, (_) => WooCoupon.fake()),
        page: page ?? 1,
      );
    }
    final query = WooCouponQuery(
      context: context,
      page: page,
      perPage: perPage,
      search: search,
      after: after,
      before: before,
      modifiedAfter: modifiedAfter,
      modifiedBefore: modifiedBefore,
      datesAreGmt: datesAreGmt,
      exclude: exclude,
      include: include,
      offset: offset,
      order: order,
      orderBy: orderBy,
      code: code,
    );
    final response = await requestGet<List<dynamic>>(
      _CouponEndpoints.coupons,
      queryParameters: query.toMap(),
    );
    final items = response.data
            ?.whereType<Map<String, dynamic>>()
            .map(WooCoupon.fromJson)
            .toList() ??
        const [];
    return WooPage.parse(response: response, items: items, page: page ?? 1);
  }

  Future<WooCoupon> getCoupon(int id, {bool? useFaker}) async {
    final isUsingFaker = useFaker ?? this.useFaker;
    if (isUsingFaker) {
      return WooCoupon.fake(id: id);
    }
    final response = await requestGet<Map<String, dynamic>>(
      _CouponEndpoints.singleCoupon(id),
    );
    final data = response.data;
    if (data is! Map<String, dynamic>) {
      throw WooCommerceParseException(
        message: 'Expected a coupon object for coupon $id',
        statusCode: response.statusCode,
        path: _CouponEndpoints.singleCoupon(id),
      );
    }
    return WooCoupon.fromJson(data);
  }

  Future<WooCoupon> createCoupon(WooCoupon coupon, {bool? useFaker}) async {
    final isUsingFaker = useFaker ?? this.useFaker;
    if (isUsingFaker) {
      return coupon;
    }
    final response = await requestPost<Map<String, dynamic>>(
      _CouponEndpoints.coupons,
      data: coupon.toJson(),
    );
    final data = response.data;
    if (data is! Map<String, dynamic>) {
      throw WooCommerceParseException(
        message: 'Expected a coupon object in the create response',
        statusCode: response.statusCode,
        path: _CouponEndpoints.coupons,
      );
    }
    return WooCoupon.fromJson(data);
  }

  Future<WooCoupon> updateCoupon(
    int id,
    WooCoupon coupon, {
    bool? useFaker,
  }) async {
    final isUsingFaker = useFaker ?? this.useFaker;
    if (isUsingFaker) {
      return coupon;
    }
    final response = await requestPut<Map<String, dynamic>>(
      _CouponEndpoints.singleCoupon(id),
      data: coupon.toJson(),
    );
    final data = response.data;
    if (data is! Map<String, dynamic>) {
      throw WooCommerceParseException(
        message: 'Expected a coupon object in the update response',
        statusCode: response.statusCode,
        path: _CouponEndpoints.singleCoupon(id),
      );
    }
    return WooCoupon.fromJson(data);
  }

  Future<WooDeleteResult> deleteCoupon(
    int id, {
    bool force = false,
    bool? useFaker,
  }) async {
    final isUsingFaker = useFaker ?? this.useFaker;
    if (isUsingFaker) {
      return WooDeleteResult(id: id, deleted: true);
    }
    final response = await requestDelete<Map<String, dynamic>>(
      _CouponEndpoints.singleCoupon(id),
      queryParameters: {'force': force},
    );
    return WooDeleteResult.fromJson(response.data!);
  }

  Future<WooCouponBatchResponse> batchUpdateCoupons(
    WooCouponBatchRequest request, {
    bool? useFaker,
  }) async {
    final isUsingFaker = useFaker ?? this.useFaker;
    if (isUsingFaker) {
      return WooCouponBatchResponse(
        create: request.create?.map((coupon) => WooCoupon.fake()).toList(),
        update: request.update,
        delete: request.delete?.map((id) => WooCoupon.fake(id: id)).toList(),
      );
    }
    final response = await requestPost<Map<String, dynamic>>(
      _CouponEndpoints.batchCoupons(),
      data: request.toJson(),
    );
    return WooCouponBatchResponse.fromJson(response.data!);
  }
}
