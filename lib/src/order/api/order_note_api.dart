import 'package:woocommerce_flutter_api/woocommerce_flutter_api.dart';

part 'order_note_endpoints.dart';

extension WooOrderNoteApi on WooCommerce {
  /// [context] Scope under which the request is made; determines fields present in response. Options: view and edit. Default is view.
  ///
  /// [type] Limit result to customers or internal notes. Options: any, customer and internal. Default is any.
  ///
  /// [useFaker], fakes the api request
  Future<List<WooOrderNote>> getOrderNotes(
    int orderId, {
    WooContext context = WooContext.view,
    WooOrderNoteType type = WooOrderNoteType.any,
    bool? useFaker,
  }) async {
    final isUsingFaker = useFaker ?? this.useFaker;

    if (isUsingFaker) {
      return FakeHelper.list(WooOrderNote.fake);
    }

    final response = await dio.get(
      _OrderNoteEndpoints.notes(orderId),
      queryParameters: _resolveQueryParametersForGettingOrderNotes(
        context: context,
        type: type,
      ),
    );

    return (response.data as List)
        .map((item) => WooOrderNote.fromJson(item))
        .toList();
  }

  Map<String, dynamic> _resolveQueryParametersForGettingOrderNotes({
    required WooContext context,
    required WooOrderNoteType type,
  }) {
    final map = <String, dynamic>{
      'context': context.name,
      'page': type.name,
    };

    return map;
  }

  Future<WooOrderNote> getOrderNote(int orderId, int noteId,
      {bool? useFaker}) async {
    final isUsingFaker = useFaker ?? this.useFaker;

    if (isUsingFaker) {
      return WooOrderNote.fake();
    }

    final response =
        await dio.get(_OrderNoteEndpoints.singleNote(orderId, noteId));

    return WooOrderNote.fromJson(response.data as Map<String, dynamic>);
  }

  Future<WooOrderNote> createOrderNote(int orderId, WooOrderNote note,
      {bool? useFaker}) async {
    final isUsingFaker = useFaker ?? this.useFaker;

    if (isUsingFaker) {
      return note;
    }

    final response = await dio.post(
      _OrderNoteEndpoints.notes(orderId),
      data: note.toJson(),
    );

    return WooOrderNote.fromJson(response.data as Map<String, dynamic>);
  }

  /// [force] Required to be true, as resource does not support trashing.
  Future<bool> deleteOrderNote(
    int orderId,
    int noteId, {
    bool? useFaker,
  }) async {
    final isUsingFaker = useFaker ?? this.useFaker;

    if (isUsingFaker) {
      return true;
    }

    await dio.delete(
      _OrderNoteEndpoints.singleNote(orderId, noteId),
      queryParameters: {
        'force': true,
      },
    );

    return true;
  }
}
