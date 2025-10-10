import 'package:woocommerce_flutter_api/src/helpers/fake_helper.dart';

/// WooCommerce Settings Group Model
///
/// Represents a settings group in WooCommerce. Settings groups are top-level
/// categories that organize related settings together, such as 'general',
/// 'products', 'shipping', or 'payments'. Each group contains multiple
/// setting options that can be configured independently.
///
/// ## Key Features
///
/// - **Hierarchical organization**: Support for parent-child relationships
/// - **Sub-groups**: Nested organization for complex settings structures
/// - **Human-readable labels**: User-friendly names for display
/// - **Descriptive information**: Help text for understanding group purpose
///
/// ## Common Settings Groups
///
/// - **general**: Store name, currency, location, and basic settings
/// - **products**: Product catalog, inventory, and display settings
/// - **shipping**: Shipping zones, methods, and rate calculations
/// - **payments**: Payment gateway configurations and options
/// - **tax**: Tax calculation and display settings
///
/// ## Usage Examples
///
/// ```dart
/// // Create a settings group
/// final group = WooSettings(
///   id: 'custom_settings',
///   label: 'Custom Settings',
///   description: 'Custom store configuration options',
/// );
///
/// // Access group properties
/// print('Group: ${group.label}');
/// print('Description: ${group.description}');
/// print('Has sub-groups: ${group.subGroups?.isNotEmpty ?? false}');
/// ```
class WooSettings {
  /// A unique identifier that can be used to link settings together.
  ///
  /// This identifier is used to reference the settings group in API calls
  /// and to organize related settings. Common values include 'general',
  /// 'products', 'shipping', and 'payments'.
  final String? id;

  /// A human readable label for the setting used in interfaces.
  ///
  /// This is the display name shown to users in the WooCommerce admin
  /// interface. It should be descriptive and user-friendly.
  final String? label;

  /// A human readable description for the setting used in interfaces.
  ///
  /// Provides additional context about what the settings group contains
  /// and how it affects store functionality.
  final String? description;

  /// ID of parent grouping.
  ///
  /// Used to create hierarchical relationships between settings groups.
  /// When set, this group becomes a sub-group of the parent.
  final String? parentId;

  /// IDs for settings sub groups.
  ///
  /// Contains a list of sub-group identifiers that belong to this
  /// settings group, enabling nested organization of settings.
  final List<String>? subGroups;

  /// Creates a new WooSettings instance
  ///
  /// This constructor creates a settings group with the specified properties.
  /// All parameters are optional, allowing for flexible group creation.
  ///
  /// ## Parameters
  ///
  /// * [id] - Unique identifier for the settings group
  /// * [label] - Human-readable label for display in interfaces
  /// * [description] - Detailed description of the group's purpose
  /// * [parentId] - ID of parent group for hierarchical organization
  /// * [subGroups] - List of sub-group IDs for nested organization
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// // Create a basic settings group
  /// final group = WooSettings(
  ///   id: 'custom_settings',
  ///   label: 'Custom Settings',
  ///   description: 'Custom store configuration options',
  /// );
  ///
  /// // Create a group with sub-groups
  /// final parentGroup = WooSettings(
  ///   id: 'shipping',
  ///   label: 'Shipping Settings',
  ///   description: 'Configure shipping options and rates',
  ///   subGroups: ['shipping_zones', 'shipping_methods'],
  /// );
  /// ```
  WooSettings({
    this.id,
    this.label,
    this.description,
    this.parentId,
    this.subGroups,
  });

  /// Creates a WooSettings instance from JSON data
  ///
  /// This factory constructor is used to deserialize settings group data received
  /// from the WooCommerce REST API. It handles the conversion of JSON fields
  /// to the appropriate Dart types and provides fallback values where needed.
  ///
  /// ## Parameters
  ///
  /// * [json] - A Map containing the settings group data in JSON format
  ///
  /// ## Returns
  ///
  /// A `WooSettings` instance populated with data from the JSON.
  ///
  /// ## JSON Structure
  ///
  /// The expected JSON structure includes:
  /// ```json
  /// {
  ///   "id": "general",
  ///   "label": "General",
  ///   "description": "General store settings",
  ///   "parent_id": null,
  ///   "sub_groups": ["store_address", "store_currency"]
  /// }
  /// ```
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// // Parse settings group from API response
  /// final jsonData = {
  ///   'id': 'general',
  ///   'label': 'General Settings',
  ///   'description': 'Basic store configuration',
  ///   'sub_groups': ['store_info', 'currency']
  /// };
  ///
  /// final group = WooSettings.fromJson(jsonData);
  /// print('Group: ${group.label}');
  /// print('Sub-groups: ${group.subGroups}');
  /// ```
  WooSettings.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        label = json['label'],
        description = json['description'],
        parentId = json['parent_id'],
        subGroups = json['sub_groups'] != null
            ? List<String>.from(json['sub_groups'])
            : null;

  /// Converts the WooSettings instance to JSON format
  ///
  /// This method serializes the settings group data into a Map that can be sent
  /// to the WooCommerce REST API. It handles the conversion of Dart types
  /// to JSON-compatible formats and includes all necessary fields.
  ///
  /// ## Returns
  ///
  /// A `Map<String, dynamic>` containing the settings group data in JSON format.
  ///
  /// ## JSON Structure
  ///
  /// The returned JSON structure includes:
  /// ```json
  /// {
  ///   "id": "general",
  ///   "label": "General Settings",
  ///   "description": "Basic store configuration",
  ///   "parent_id": null,
  ///   "sub_groups": ["store_info", "currency"]
  /// }
  /// ```
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// // Convert settings group to JSON for API calls
  /// final group = WooSettings(
  ///   id: 'custom_settings',
  ///   label: 'Custom Settings',
  ///   description: 'Custom store configuration',
  /// );
  ///
  /// final jsonData = group.toJson();
  /// print('JSON: $jsonData');
  ///
  /// // Send to API
  /// await dio.post('/settings', data: group.toJson());
  /// ```
  Map<String, dynamic> toJson() => {
        'id': id,
        'label': label,
        'description': description,
        'parent_id': parentId,
        'sub_groups': subGroups,
      };

  /// Creates a fake WooSettings instance for testing purposes
  ///
  /// This factory constructor generates a settings group with random but realistic
  /// data, making it useful for testing, development, and demonstration purposes.
  /// The generated settings group will have valid data for all fields.
  ///
  /// ## Generated Data
  ///
  /// The fake settings group includes:
  /// - Random ID from word generator
  /// - Random label from sentence generator
  /// - Random description from sentence generator
  /// - Random parent ID from word generator
  /// - Random list of sub-group IDs
  ///
  /// ## Returns
  ///
  /// A `WooSettings` instance with randomly generated fake data.
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// // Generate a fake settings group for testing
  /// final fakeGroup = WooSettings.fake();
  /// print('Fake group: ${fakeGroup.label}');
  /// print('ID: ${fakeGroup.id}');
  ///
  /// // Use in tests
  /// test('settings group creation', () {
  ///   final group = WooSettings.fake();
  ///   expect(group.id, isNotNull);
  ///   expect(group.label, isNotNull);
  ///   expect(group.description, isNotNull);
  /// });
  /// ```
  factory WooSettings.fake() => WooSettings(
        id: FakeHelper.word(),
        label: FakeHelper.sentence(),
        description: FakeHelper.sentence(),
        parentId: FakeHelper.word(),
        subGroups: FakeHelper.list(() => FakeHelper.word()),
      );
}
