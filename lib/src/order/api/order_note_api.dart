import 'package:woocommerce_flutter_api/woocommerce_flutter_api.dart';

part 'order_note_endpoints.dart';

/// WooCommerce Order Note API Extension
///
/// This extension provides comprehensive order note management capabilities for WooCommerce stores.
/// It allows you to retrieve, create, and delete order notes, which are comments or updates
/// associated with specific orders.
///
/// ## Key Features
///
/// - **Retrieve Order Notes**: Get all notes for a specific order with filtering options
/// - **Get Single Note**: Retrieve a specific order note by ID
/// - **Create Notes**: Add new notes to orders (customer or internal)
/// - **Delete Notes**: Remove order notes (with force deletion)
///
/// ## Example Usage
///
/// ```dart
/// // Get all order notes
/// final notes = await wooCommerce.getOrderNotes(123);
///
/// // Create a new order note
/// final note = WooOrderNote(
///   note: 'Order processed successfully',
///   customerNote: true,
/// );
/// final created = await wooCommerce.createOrderNote(123, note);
/// ```
extension WooOrderNoteApi on WooCommerce {
  /// Retrieves a list of order notes for a specific order.
  ///
  /// This method fetches all notes associated with the given order ID, supporting
  /// filtering by note type and context scope.
  /// https://woocommerce.github.io/woocommerce-rest-api-docs/#list-all-order-notes
  ///
  /// ## Parameters
  ///
  /// * [orderId] - The ID of the order to retrieve notes for
  /// * [context] - Scope under which the request is made; determines fields present in response.
  ///   - `WooContext.view`: Returns basic note information (default)
  ///   - `WooContext.edit`: Returns full note details including sensitive data
  /// * [type] - Limit result to customers or internal notes.
  ///   - `WooOrderNoteType.any`: Returns all notes (default)
  ///   - `WooOrderNoteType.customer`: Returns only customer-visible notes
  ///   - `WooOrderNoteType.internal`: Returns only internal notes
  /// * [useFaker] - When true, returns fake data for testing purposes
  ///
  /// ## Returns
  ///
  /// A `Future<List<WooOrderNote>>` containing the order note objects.
  ///
  /// ## Throws
  ///
  /// * `WooCommerceException` if the request fails or access is denied
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// // Get all notes for an order
  /// final notes = await wooCommerce.getOrderNotes(123);
  ///
  /// // Get only customer notes
  /// final customerNotes = await wooCommerce.getOrderNotes(
  ///   123,
  ///   type: WooOrderNoteType.customer,
  /// );
  /// ```
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

  /// Retrieves a specific order note by its ID.
  ///
  /// This method fetches a single order note associated with the given order ID and note ID.
  /// https://woocommerce.github.io/woocommerce-rest-api-docs/#retrieve-an-order-note
  ///
  /// ## Parameters
  ///
  /// * [orderId] - The ID of the order that contains the note
  /// * [noteId] - The ID of the specific note to retrieve
  /// * [useFaker] - When true, returns fake data for testing purposes
  ///
  /// ## Returns
  ///
  /// A `Future<WooOrderNote>` containing the order note object.
  ///
  /// ## Throws
  ///
  /// * `WooCommerceException` if the request fails or access is denied
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// // Get a specific order note
  /// final note = await wooCommerce.getOrderNote(123, 456);
  /// ```
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

  /// Creates a new order note for a specific order.
  ///
  /// This method adds a new note to the specified order. The note can be either
  /// customer-visible or internal, depending on the note configuration.
  /// https://woocommerce.github.io/woocommerce-rest-api-docs/#create-an-order-note
  ///
  /// ## Parameters
  ///
  /// * [orderId] - The ID of the order to add the note to
  /// * [note] - The WooOrderNote object containing the note data
  /// * [useFaker] - When true, returns fake data for testing purposes
  ///
  /// ## Returns
  ///
  /// A `Future<WooOrderNote>` containing the created order note object.
  ///
  /// ## Throws
  ///
  /// * `WooCommerceException` if the request fails or access is denied
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// // Create a customer note
  /// final note = WooOrderNote(
  ///   note: 'Order shipped via express delivery',
  ///   customerNote: true,
  /// );
  /// final created = await wooCommerce.createOrderNote(123, note);
  ///
  /// // Create an internal note
  /// final internalNote = WooOrderNote(
  ///   note: 'Customer called to change shipping address',
  ///   customerNote: false,
  /// );
  /// final createdInternal = await wooCommerce.createOrderNote(123, internalNote);
  /// ```
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

  /// Deletes a specific order note.
  ///
  /// This method permanently removes an order note from the specified order.
  /// Note: The force parameter is required to be true as order notes do not support trashing.
  /// https://woocommerce.github.io/woocommerce-rest-api-docs/#delete-an-order-note
  ///
  /// ## Parameters
  ///
  /// * [orderId] - The ID of the order that contains the note
  /// * [noteId] - The ID of the note to delete
  /// * [useFaker] - When true, simulates successful deletion for testing purposes
  ///
  /// ## Returns
  ///
  /// A `Future<bool>` indicating whether the deletion was successful.
  ///
  /// ## Throws
  ///
  /// * `WooCommerceException` if the request fails or access is denied
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// // Delete an order note
  /// final success = await wooCommerce.deleteOrderNote(123, 456);
  /// if (success) {
  ///   print('Order note deleted successfully');
  /// }
  /// ```
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
