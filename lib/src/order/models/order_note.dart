import 'package:woocommerce_flutter_api/woocommerce_flutter_api.dart';

class WooOrderNote {
  /// Unique identifier for the resource. Read-only.
  int? id;

  /// Order note author. Read-only.
  String? author;

  /// The date the order note was created, in the site's timezone. Read-only.
  DateTime? dateCreated;

  /// The date the order note was created, as GMT. Read-only.
  DateTime? dateCreatedGmt;

  /// Order note content. Mandatory.
  String? note;

  /// If true, the note will be shown to customers and they will be notified.
  /// If false, the note will be for admin reference only. Default is false.
  bool? customerNote;

  /// If true, this note will be attributed to the current user.
  /// If false, the note will be attributed to the system. Default is false.
  bool? addedByUser;

  WooOrderNote({
    this.id,
    this.author,
    this.dateCreated,
    this.dateCreatedGmt,
    required this.note,
    this.customerNote = false,
    this.addedByUser = false,
  });

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

  @override
  String toString() => toJson().toString();

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
