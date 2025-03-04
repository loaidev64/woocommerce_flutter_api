part of 'order_note_api.dart';

abstract class _OrderNoteEndpoints {
  static String notes(int orderId) => '/orders/$orderId/notes';

  static String singleNote(int orderId, int noteId) =>
      '/orders/$orderId/notes/$noteId';
}
