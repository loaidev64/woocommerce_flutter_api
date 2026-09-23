import 'package:dio/dio.dart';

class WooPage<T> {
  const WooPage({
    required this.items,
    required this.page,
    this.totalItems,
    this.totalPages,
  });
  factory WooPage.fromResponse(
    Response<List<T>> response, {
    required int page,
  }) =>
      WooPage(
        items: response.data ?? const [],
        page: page,
        totalItems: _readHeader(response, 'x-wp-total'),
        totalPages: _readHeader(response, 'x-wp-totalpages'),
      );
  factory WooPage.parse({
    required Response<dynamic> response,
    required List<T> items,
    required int page,
  }) =>
      WooPage(
        items: items,
        page: page,
        totalItems: _readHeader(response, 'x-wp-total'),
        totalPages: _readHeader(response, 'x-wp-totalpages'),
      );
  final List<T> items;
  final int page;
  final int? totalItems;
  final int? totalPages;
  bool get hasNextPage =>
      totalPages == null ? items.isNotEmpty : page < totalPages!;
}

int? _readHeader(Response<dynamic> response, String name) {
  final value = response.headers.value(name);
  if (value == null) return null;
  return int.tryParse(value);
}
