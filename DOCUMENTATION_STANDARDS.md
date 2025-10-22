# Documentation Standards for WooCommerce Flutter API

This document outlines the documentation standards for the WooCommerce Flutter API package to ensure consistency and clarity across all modules.

## Overview

The package uses a hybrid documentation approach:
- **Complex resources** (Product, Order, Customer, Webhook) get comprehensive documentation
- **Simple resources** (supporting models, basic enums) get concise documentation

## Model Documentation Standards

### Complex Models (Product, Order, Customer, Webhook)

Complex models should include:

1. **Class-level documentation**:
   ```dart
   /// WooCommerce [Resource] Model
   ///
   /// Brief description of what the model represents and its purpose.
   /// Include key use cases and relationships to other models.
   ///
   /// ## Key Features
   ///
   /// - **Feature 1**: Description of the feature
   /// - **Feature 2**: Description of the feature
   /// - **Feature 3**: Description of the feature
   ///
   /// ## Usage Examples
   ///
   /// ### Creating a [Resource]
   ///
   /// ```dart
   /// final resource = WooResource(
   ///   name: 'Example Resource',
   ///   type: WooResourceType.example,
   /// );
   /// ```
   ///
   /// ### Working with [Resource] Data
   ///
   /// ```dart
   /// // Example usage
   /// if (resource.isActive) {
   ///   print('Resource is active');
   /// }
   /// ```
   ///
   /// ## JSON Serialization
   ///
   /// The class supports full JSON serialization for API communication:
   ///
   /// ```dart
   /// // Convert to JSON for API requests
   /// final json = resource.toJson();
   ///
   /// // Create from JSON response
   /// final resource = WooResource.fromJson(jsonData);
   /// ```
   ```

2. **Field documentation**:
   ```dart
   /// Brief description of the field
   ///
   /// Optional additional details about the field's purpose,
   /// constraints, or relationships to other fields.
   final Type? fieldName;
   ```

3. **Constructor documentation**:
   ```dart
   /// Creates a new WooResource instance
   ///
   /// ## Required Parameters
   ///
   /// * [name] - Description of the parameter
   /// * [type] - Description of the parameter
   ///
   /// ## Optional Parameters
   ///
   /// * [id] - Description of the parameter
   /// * [status] - Description of the parameter
   ///
   /// ## Example Usage
   ///
   /// ```dart
   /// final resource = WooResource(
   ///   name: 'Example',
   ///   type: WooResourceType.example,
   /// );
   /// ```
   ```

4. **Factory constructors**:
   ```dart
   /// Creates a WooResource instance from JSON data
   ///
   /// This factory constructor is used to deserialize resource data received
   /// from the WooCommerce REST API.
   ///
   /// ## Parameters
   ///
   /// * [json] - A Map containing the resource data in JSON format
   ///
   /// ## Returns
   ///
   /// A `WooResource` instance populated with data from the JSON.
   ///
   /// ## Example Usage
   ///
   /// ```dart
   /// final resource = WooResource.fromJson(jsonData);
   /// ```
   ```

5. **Methods**:
   ```dart
   /// Converts the WooResource instance to JSON format
   ///
   /// This method serializes the resource data into a Map that can be sent
   /// to the WooCommerce REST API.
   ///
   /// ## Returns
   ///
   /// A `Map<String, dynamic>` containing the resource data in JSON format.
   ///
   /// ## Example Usage
   ///
   /// ```dart
   /// final jsonData = resource.toJson();
   /// ```
   ```

6. **Fake factory**:
   ```dart
   /// Creates a fake WooResource instance for testing purposes
   ///
   /// This factory constructor generates a resource with random but realistic
   /// data, making it useful for testing and development.
   ///
   /// ## Returns
   ///
   /// A `WooResource` instance with randomly generated fake data.
   ///
   /// ## Example Usage
   ///
   /// ```dart
   /// final fakeResource = WooResource.fake();
   /// ```
   ```

7. **toString method**:
   ```dart
   /// Returns a string representation of the WooResource instance
   ///
   /// This method provides a human-readable representation of the resource,
   /// displaying all main fields for debugging and logging purposes.
   ///
   /// ## Returns
   ///
   /// A `String` containing the resource's main field values in a readable format.
   ///
   /// ## Example Usage
   ///
   /// ```dart
   /// final resource = WooResource(name: 'Example', type: WooResourceType.example);
   /// print(resource.toString());
   /// // Output: WooResource(id: 1, name: Example, type: example, status: active)
   /// ```
   ```

### Simple Models (Billing, Shipping, CategoryImage, etc.)

Simple models should include:

1. **Class-level documentation**:
   ```dart
   /// Represents a [Resource] with basic information.
   ///
   /// Brief description of the model's purpose and usage.
   ```

2. **Field documentation**:
   ```dart
   /// Brief description of the field.
   final Type? fieldName;
   ```

3. **Constructor documentation** (brief):
   ```dart
   /// Creates a new [Resource] instance.
   ```

4. **Factory constructors** (brief):
   ```dart
   /// Creates a [Resource] instance from JSON data.
   ```

5. **toString method** (brief):
   ```dart
   /// Returns a string representation of the [Resource] instance.
   ///
   /// Displays all main fields for debugging and logging purposes.
   ```

## API Extension Documentation Standards

### Extension-level Documentation

```dart
/// WooCommerce [Resource] API Extension
///
/// This extension provides comprehensive [resource] management capabilities for WooCommerce stores.
/// Brief description of what the extension does and its main purpose.
///
/// ## Key Features
///
/// - **Feature 1**: Description
/// - **Feature 2**: Description
/// - **Feature 3**: Description
///
/// ## Example Usage
///
/// ```dart
/// // Get all resources
/// final resources = await wooCommerce.getResources();
///
/// // Create a new resource
/// final resource = WooResource(name: 'Example');
/// final created = await wooCommerce.createResource(resource);
/// ```
```

### Method Documentation

```dart
/// Retrieves a list of [resources] from the WooCommerce store.
///
/// This method supports extensive filtering and pagination options to help you
/// find exactly the resources you need.
/// https://woocommerce.github.io/woocommerce-rest-api-docs/#list-all-[resources]
///
/// ## Parameters
///
/// * [context] - Scope under which the request is made; determines fields present in response.
///   - `WooContext.view`: Returns basic resource information (default)
///   - `WooContext.edit`: Returns full resource details including sensitive data
///
/// * [page] - Current page of the collection (default: 1)
/// * [perPage] - Maximum number of items to return (default: 10, max: 100)
/// * [search] - Limit results to resources matching a search string
/// * [useFaker] - When true, returns fake data for testing purposes
///
/// ## Returns
///
/// A `Future<List<WooResource>>` containing the resource objects.
///
/// ## Throws
///
/// * `WooCommerceException` if the request fails or access is denied
///
/// ## Example Usage
///
/// ```dart
/// // Get all resources
/// final resources = await wooCommerce.getResources();
///
/// // Search for resources
/// final searchResults = await wooCommerce.getResources(
///   search: 'example',
///   perPage: 20,
/// );
/// ```
```

## Enum Documentation Standards

### Simple Enums

```dart
/// WooCommerce [Resource] [Type] Enumeration
///
/// Defines the possible [types] for a [resource] in WooCommerce.
/// Brief description of what the enum represents and its purpose.
///
/// ## Usage Examples
///
/// ```dart
/// // Create resource with specific type
/// final resource = WooResource(
///   name: 'Example',
///   type: WooResourceType.example,
/// );
///
/// // Check resource type
/// if (resource.type == WooResourceType.example) {
///   print('Resource is of example type');
/// }
/// ```
enum WooResourceType {
  /// Brief description of this enum value.
  example,

  /// Brief description of this enum value.
  another,

  /// Brief description of this enum value.
  third;
}
```

## Implementation Guidelines

### Documentation Structure

1. **Always start with a brief overview** of what the class/enum/method does
2. **Use consistent section headers**: `## Key Features`, `## Parameters`, `## Returns`, `## Example Usage`
3. **Include practical examples** that developers can copy and use
4. **Link to WooCommerce REST API docs** when applicable
5. **Document all public methods and constructors**
6. **Include parameter descriptions** with types and constraints
7. **Document return types** and what they contain
8. **Include error conditions** in `## Throws` sections

### Code Examples

- Use realistic, practical examples
- Show both basic and advanced usage patterns
- Include error handling where appropriate
- Use consistent variable naming (`wooCommerce`, `resource`, etc.)

### Formatting

- Use proper markdown formatting
- Keep line lengths reasonable (80-100 characters)
- Use consistent indentation in code blocks
- Include blank lines between sections for readability

### toString Method Implementation

The `toString` method should be implemented for all models to provide meaningful debugging information:

```dart
@override
String toString() {
  return 'WooResource(id: $id, name: $name, type: $type, status: $status)';
}
```

#### Guidelines for toString Implementation

1. **Include main fields**: Display the most important fields that identify the object
2. **Use consistent format**: Follow the pattern `ClassName(field1: value1, field2: value2, ...)`
3. **Handle null values**: Use null-aware operators or conditional display
4. **Keep it readable**: Avoid overly long strings, truncate if necessary
5. **Include identifying fields**: Always include ID and name/title fields when available

#### Example Implementations

**Complex Model (Product)**:
```dart
@override
String toString() {
  return 'WooProduct(id: $id, name: $name, type: $type, status: $status, price: $price)';
}
```

**Simple Model (Billing)**:
```dart
@override
String toString() {
  return 'WooBilling(firstName: $firstName, lastName: $lastName, email: $email, phone: $phone)';
}
```

**Model with many fields (Order)**:
```dart
@override
String toString() {
  return 'WooOrder(id: $id, status: $status, total: $total, customerId: $customerId, dateCreated: $dateCreated)';
}
```

## Quality Checklist

Before considering documentation complete, ensure:

- [ ] Class/enum has clear purpose statement
- [ ] All public methods are documented
- [ ] Parameters are described with types and constraints
- [ ] Return values are documented
- [ ] Practical examples are included
- [ ] Error conditions are documented
- [ ] Code examples are tested and work
- [ ] Documentation follows the established format
- [ ] No typos or grammatical errors
- [ ] Links to external docs are valid
- [ ] toString method is implemented and documented
- [ ] toString method displays all main fields appropriately

## Examples

See the following files for reference implementations:
- **Complex Model**: `lib/src/webhook/models/webhook.dart`
- **API Extension**: `lib/src/webhook/api/webhook_api.dart`
- **Enum**: `lib/src/webhook/enums/webhook_status.dart`
