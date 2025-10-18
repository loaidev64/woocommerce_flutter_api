/// WooCommerce Order Note Type Enumeration
///
/// Defines the possible types for order notes in WooCommerce.
/// Used to filter and categorize order notes based on their visibility and purpose.
///
/// ## Usage Examples
///
/// ```dart
/// // Filter notes by type
/// final customerNotes = notes.where((note) => note.type == WooOrderNoteType.customer);
///
/// // Check note visibility
/// if (noteType == WooOrderNoteType.customer) {
///   print('This note is visible to customers');
/// }
/// ```
enum WooOrderNoteType { 
  /// Any type of order note (includes both customer and internal notes).
  any, 
  
  /// Customer-visible order notes.
  customer, 
  
  /// Internal order notes (admin only).
  internal 
}
