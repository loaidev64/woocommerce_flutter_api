import '../../base/base.dart';
import '../../exceptions/woocommerce_exception.dart';
import '../../helpers/fake_helper.dart';
import '../enums/order_note_type.dart';
import '../models/order_note.dart';
import '../../woocommerce_flutter_api_base.dart';
import 'order_note_query.dart';
export 'order_note_query.dart';
part 'order_note_endpoints.dart';

extension WooOrderNoteApi on WooCommerce {
  Future<WooPage<WooOrderNote>> getOrderNotes(
    int orderId, {
    WooContext context = WooContext.view,
    WooOrderNoteType type = WooOrderNoteType.any,
    int? page,
    int? perPage,
    bool? useFaker,
  }) async {
    final isUsingFaker = useFaker ?? this.useFaker;
    if (isUsingFaker) {
      return WooPage(
        items: FakeHelper.list(WooOrderNote.fake),
        page: page ?? 1,
      );
    }
    final query = WooOrderNoteQuery(
      context: context,
      type: type,
      page: page,
      perPage: perPage,
    );
    final response = await requestGet<List<dynamic>>(
      _OrderNoteEndpoints.notes(orderId),
      queryParameters: query.toMap(),
    );
    final items = response.data
            ?.whereType<Map<String, dynamic>>()
            .map(WooOrderNote.fromJson)
            .toList() ??
        const <WooOrderNote>[];
    return WooPage.parse(response: response, items: items, page: page ?? 1);
  }

  Future<WooOrderNote> getOrderNote(
    int orderId,
    int noteId, {
    bool? useFaker,
  }) async {
    final isUsingFaker = useFaker ?? this.useFaker;
    if (isUsingFaker) {
      return WooOrderNote.fake();
    }
    final response = await requestGet<Map<String, dynamic>>(
      _OrderNoteEndpoints.singleNote(orderId, noteId),
    );
    final data = response.data;
    if (data == null) {
      throw WooCommerceParseException(
        message: 'Failed to parse order note response',
        statusCode: response.statusCode,
        path: _OrderNoteEndpoints.singleNote(orderId, noteId),
      );
    }
    return WooOrderNote.fromJson(data);
  }

  Future<WooOrderNote> createOrderNote(
    int orderId,
    WooOrderNote note, {
    bool? useFaker,
  }) async {
    final isUsingFaker = useFaker ?? this.useFaker;
    if (isUsingFaker) {
      return note;
    }
    final response = await requestPost<Map<String, dynamic>>(
      _OrderNoteEndpoints.notes(orderId),
      data: note.toJson()..remove('id'),
    );
    return WooOrderNote.fromJson(response.data!);
  }

  Future<WooOrderNote> updateOrderNote(
    int orderId,
    int noteId,
    WooOrderNote note, {
    bool? useFaker,
  }) async {
    final isUsingFaker = useFaker ?? this.useFaker;
    if (isUsingFaker) {
      return note;
    }
    final response = await requestPut<Map<String, dynamic>>(
      _OrderNoteEndpoints.singleNote(orderId, noteId),
      data: note.toJson()..remove('id'),
    );
    return WooOrderNote.fromJson(response.data!);
  }

  Future<WooDeleteResult> deleteOrderNote(
    int orderId,
    int noteId, {
    bool? useFaker,
  }) async {
    final isUsingFaker = useFaker ?? this.useFaker;
    if (isUsingFaker) {
      return WooDeleteResult(id: noteId, deleted: true);
    }
    final response = await requestDelete<Map<String, dynamic>>(
      _OrderNoteEndpoints.singleNote(orderId, noteId),
      queryParameters: {'force': true},
    );
    return WooDeleteResult.fromJson(response.data!);
  }
}
