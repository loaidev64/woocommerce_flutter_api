import 'package:woocommerce_flutter_api/woocommerce_flutter_api.dart';

/// Represents an order note in a WooCommerce order.
///
/// Contains note information, author details, and visibility settings for notes
/// added to an order. Used for order communication and tracking.
class WooOrderNote {
  /// Unique identifier for the order note.
  int? id;

  /// Author of the order note.
  String? author;

  /// Date when the note was created (local time).
  DateTime? dateCreated;

  /// Date when the note was created (GMT).
  DateTime? dateCreatedGmt;

  /// Content of the order note.
  String? note;

  /// Whether the note is visible to customers.
  bool? customerNote;

  /// Whether the note was added by a user.
  bool? addedByUser;

  /// Creates a new WooOrderNote instance.
  WooOrderNote({
    this.id,
    this.author,
    this.dateCreated,
    this.dateCreatedGmt,
    required this.note,
    this.customerNote = false,
    this.addedByUser = false,
  });

  /// Creates a WooOrderNote instance from JSON data.
  WooOrderNote.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    author = json['author'];
    dateCreated = DateTime.tryParse(json['date_created']);
    dateCreatedGmt = DateTime.tryParse(json['date_created_gmt']);
    note = json['note'];
    customerNote = json['customer_note'];
    addedByUser = json['added_by_user'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['author'] = author;
    data['date_created'] = dateCreated?.toIso8601String();
    data['date_created_gmt'] = dateCreatedGmt?.toIso8601String();
    data['note'] = note;
    data['customer_note'] = customerNote;
    data['added_by_user'] = addedByUser;
    return data;
  }

  /// Returns a string representation of the WooOrderNote instance.
  ///
  /// Displays all main fields for debugging and logging purposes.
  @override
  String toString() {
    return 'WooOrderNote(id: $id, author: $author, note: $note, customerNote: $customerNote)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is WooOrderNote && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  factory WooOrderNote.fake() => WooOrderNote(
        id: FakeHelper.integer(),
        author: FakeHelper.firstName(),
        dateCreated: FakeHelper.datetime(),
        dateCreatedGmt: FakeHelper.datetime(),
        note: FakeHelper.sentence(),
        customerNote: FakeHelper.boolean(),
        addedByUser: FakeHelper.boolean(),
      );
}
