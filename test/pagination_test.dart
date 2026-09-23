import 'package:dio/dio.dart';
import 'package:test/test.dart';
import 'package:woocommerce_flutter_api/woocommerce_flutter_api.dart';

void main() {
  group('WooPage', () {
    test('parses pagination headers', () {
      final response = Response<List<String>>(
        requestOptions: RequestOptions(path: '/products'),
        statusCode: 200,
        data: ['a', 'b'],
      );
      response.headers.add('x-wp-total', '123');
      response.headers.add('x-wp-totalpages', '7');
      final page = WooPage.fromResponse(response, page: 2);
      expect(page.items, ['a', 'b']);
      expect(page.totalItems, 123);
      expect(page.totalPages, 7);
      expect(page.hasNextPage, isTrue);
    });

    test('last page has no next', () {
      const page = WooPage<String>(
        items: ['a'],
        page: 7,
        totalItems: 123,
        totalPages: 7,
      );
      expect(page.hasNextPage, isFalse);
    });

    test('missing headers fall back to item-count heuristic', () {
      final response = Response<dynamic>(
        requestOptions: RequestOptions(path: '/products'),
        statusCode: 200,
      );
      final page = WooPage<String>.parse(
        response: response,
        items: ['a', 'b'],
        page: 1,
      );
      expect(page.totalItems, isNull);
      expect(page.hasNextPage, isTrue);
    });
  });

  group('query serialization', () {
    test('base query omits nulls and uses wire values', () {
      final map = const _TestQuery(
        page: 2,
        perPage: 20,
        order: WooSort.desc,
        orderBy: WooOrderBy.dateGmt,
      ).toMap();
      expect(map,
          {'page': 2, 'per_page': 20, 'order': 'desc', 'orderby': 'date_gmt'});
    });

    test('empty query serializes to empty map', () {
      expect(const _TestQuery().toMap(), isEmpty);
    });
  });

  group('WooDeleteResult', () {
    test('parses delete responses', () {
      expect(
        WooDeleteResult.fromJson({'id': 12, 'deleted': true}).deleted,
        isTrue,
      );
      expect(
        WooDeleteResult.fromJson({'deleted': false, 'previous': {}}).deleted,
        isFalse,
      );
      expect(WooDeleteResult.fromJson({'id': '42'}).id, 42);
    });
  });
}

class _TestQuery extends WooQuery {
  const _TestQuery({super.page, super.perPage, super.order, super.orderBy});
}
