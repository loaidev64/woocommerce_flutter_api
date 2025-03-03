import 'dart:async';
import 'package:woocommerce_flutter_api/woocommerce_flutter_api.dart';

part 'endpoints.dart';

extension WooCouponApi on WooCommerce {
  /// [context]	Scope under which the request is made; determines fields present in response. Options: view and edit. Default is view.
  ///
  /// [page] integer	Current page of the collection. Default is 1.
  ///
  /// [perPage] integer	Maximum number of items to be returned in result set. Default is 10.
  ///
  /// [search] Limit results to those matching a string.
  ///
  /// [after] Limit response to resources published after a given ISO8601 compliant date.
  ///
  /// [before] Limit response to resources published before a given ISO8601 compliant date.
  ///
  /// [modifiedAfter] Limit response to resources modified after a given ISO8601 compliant date.
  ///
  /// [modifiedBefore] Limit response to resources modified after a given ISO8601 compliant date.
  ///
  /// [datesAreGmt] Whether to consider GMT post dates when limiting response by published or modified date.
  ///
  /// [exclude] Ensure result set excludes specific IDs.
  ///
  /// [include] Limit result set to specific ids.
  ///
  /// [offset] Offset the result set by a specific number of items.
  ///
  /// [order] Order sort attribute ascending or descending. Options: asc and desc. Default is desc.
  ///
  /// [orderby] Sort collection by object attribute. Options: date, modified, id, include, title and slug. Default is date.
  ///
  /// [code] Limit result set to resources with a specific code.
  Future<List<WooCoupon>> getCoupons({
    WooContext context = WooContext.view,
    int page = 1,
    int perPage = 10,
    String? search,
    DateTime? after,
    DateTime? before,
    DateTime? modifiedAfter,
    DateTime? modifiedBefore,
    bool? datesAreGmt,
    List<int>? exclude,
    List<int>? include,
    int? offset,
    WooSortOrder order = WooSortOrder.desc,
    WooSortCoupon orderby = WooSortCoupon.date,
    String? code,
    bool? useFaker,
  }) async {
    final isUsingFaker = useFaker ?? this.useFaker;

    if (isUsingFaker) {
      return List.generate(perPage, (index) => WooCoupon.fake());
    }

    final response = await dio.get(
      _CouponEndpoints.coupons,
      queryParameters: _resolveQueryParametersForGettingCoupons(
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
        orderBy: orderby,
        code: code,
      ),
    );

    return (response.data as List)
        .map((item) => WooCoupon.fromJson(item))
        .toList();
  }

  Map<String, dynamic> _resolveQueryParametersForGettingCoupons({
    required WooContext context,
    required int page,
    required int perPage,
    required String? search,
    required DateTime? after,
    required DateTime? before,
    required DateTime? modifiedAfter,
    required DateTime? modifiedBefore,
    required bool? datesAreGmt,
    required List<int>? exclude,
    required List<int>? include,
    required int? offset,
    required WooSortOrder order,
    required WooSortCoupon orderBy,
    required String? code,
  }) {
    final map = <String, dynamic>{
      'context': context.name,
      'page': page,
      'per_page': perPage,
      'order': order.name,
      'orderby': orderBy.name,
    };

    if (search != null) {
      map['search'] = search;
    }

    if (after != null) {
      map['after'] = after.toIso8601String();
    }

    if (before != null) {
      map['before'] = before.toIso8601String();
    }

    if (modifiedAfter != null) {
      map['modified_after'] = modifiedAfter.toIso8601String();
    }

    if (modifiedBefore != null) {
      map['modified_before'] = modifiedBefore.toIso8601String();
    }

    if (datesAreGmt != null) {
      map['dates_are_gmt'] = datesAreGmt;
    }

    if (exclude != null) {
      map['exclude'] = exclude.join(',');
    }

    if (include != null) {
      map['include'] = include.join(',');
    }

    if (offset != null) {
      map['offset'] = offset;
    }

    if (code != null) {
      map['code'] = code;
    }

    return map;
  }

  Future<WooCoupon> getCoupon(int id, {bool? useFaker}) async {
    final isUsingFaker = useFaker ?? this.useFaker;

    if (isUsingFaker) {
      return WooCoupon.fake(id);
    }

    final response = await dio.get(
      _CouponEndpoints.singleCoupon(id),
    );

    return WooCoupon.fromJson(response.data as Map<String, dynamic>);
  }

  Future<WooCoupon> createCoupon(WooCoupon coupon, {bool? useFaker}) async {
    final isUsingFaker = useFaker ?? this.useFaker;

    if (isUsingFaker) {
      return coupon;
    }

    final response = await dio.post(
      _CouponEndpoints.coupons,
      data: coupon.toJson(),
    );

    return WooCoupon.fromJson(response.data as Map<String, dynamic>);
  }

  Future<WooCoupon> updateCoupon(WooCoupon coupon, {bool? useFaker}) async {
    final isUsingFaker = useFaker ?? this.useFaker;

    if (isUsingFaker) {
      return coupon;
    }

    final response = await dio.put(
      _CouponEndpoints.singleCoupon(coupon.id!),
      data: coupon.toJson(),
    );

    return WooCoupon.fromJson(response.data as Map<String, dynamic>);
  }

  /// [force] Use true whether to permanently delete the order, Default is false.
  Future<bool> deleteCoupon(
    int id, {
    bool? useFaker,
    bool force = false,
  }) async {
    final isUsingFaker = useFaker ?? this.useFaker;

    if (isUsingFaker) {
      return true;
    }

    await dio.delete(
      _CouponEndpoints.singleCoupon(id),
      queryParameters: {
        'force': force,
      },
    );

    return true;
  }
}
