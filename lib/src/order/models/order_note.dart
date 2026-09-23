import '../../helpers/fake_helper.dart';
import '../../json/woo_json.dart';

class WooOrderNote {
  WooOrderNote({
    required this.note,
    this.id,
    this.author,
    this.dateCreated,
    this.dateCreatedGmt,
    this.customerNote = false,
    this.addedByUser = false,
  });
  factory WooOrderNote.fromJson(Map<String, dynamic> json) => WooOrderNote(
        note: WooJson.readString(json, 'note'),
        id: WooJson.readInt(json, 'id'),
        author: WooJson.readString(json, 'author'),
        dateCreated: WooJson.readDate(json, 'date_created'),
        dateCreatedGmt: WooJson.readDate(json, 'date_created_gmt'),
        customerNote: WooJson.readBool(json, 'customer_note'),
        addedByUser: WooJson.readBool(json, 'added_by_user'),
      );
  factory WooOrderNote.fake() => WooOrderNote(
        id: FakeHelper.integer(),
        author: FakeHelper.firstName(),
        dateCreated: FakeHelper.datetime(),
        dateCreatedGmt: FakeHelper.datetime(),
        note: FakeHelper.sentence(),
        customerNote: FakeHelper.boolean(),
        addedByUser: FakeHelper.boolean(),
      );
  final int? id;
  final String? author;
  final DateTime? dateCreated;
  final DateTime? dateCreatedGmt;
  final String? note;
  final bool? customerNote;
  final bool? addedByUser;
  Map<String, dynamic> toJson() => <String, dynamic>{}
    ..putIfPresent('id', id)
    ..putIfPresent('author', author)
    ..putDate('date_created', dateCreated)
    ..putDate('date_created_gmt', dateCreatedGmt)
    ..putIfPresent('note', note)
    ..putIfPresent('customer_note', customerNote)
    ..putIfPresent('added_by_user', addedByUser);
  WooOrderNote copyWith({
    String? note,
    int? id,
    String? author,
    DateTime? dateCreated,
    DateTime? dateCreatedGmt,
    bool? customerNote,
    bool? addedByUser,
  }) =>
      WooOrderNote(
        note: note ?? this.note,
        id: id ?? this.id,
        author: author ?? this.author,
        dateCreated: dateCreated ?? this.dateCreated,
        dateCreatedGmt: dateCreatedGmt ?? this.dateCreatedGmt,
        customerNote: customerNote ?? this.customerNote,
        addedByUser: addedByUser ?? this.addedByUser,
      );
  @override
  String toString() {
    return 'WooOrderNote(id: $id, author: $author, note: $note, customerNote: $customerNote)';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WooOrderNote &&
          other.id == id &&
          other.author == author &&
          other.dateCreated == dateCreated &&
          other.dateCreatedGmt == dateCreatedGmt &&
          other.note == note &&
          other.customerNote == customerNote &&
          other.addedByUser == addedByUser;
  @override
  int get hashCode => Object.hashAll([
        id,
        author,
        dateCreated,
        dateCreatedGmt,
        note,
        customerNote,
        addedByUser,
      ]);
}
