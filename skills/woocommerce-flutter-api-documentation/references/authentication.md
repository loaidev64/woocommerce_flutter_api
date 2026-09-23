# authentication

## authentication_api

### extension WooAuthenticationApi on WooCommerce

Extension providing authentication-related API methods for WooCommerce.

This extension adds methods for user authentication, registration,
password management, and session handling.

### Future<void> login(String email, String password) async

Authenticates a user with email and password.

Upon successful login, the user ID is securely stored in local storage
and can be retrieved using [LocalStorageHelper.getSecurityUserId()].

## Parameters

- [email]: The user's email address.
- [password]: The user's password.

## Throws

Throws an exception if authentication fails or if the API request fails.

## Example

```dart
try {
  await woocommerce.login('user@example.com', 'password123');
  print('Login successful');
} catch (e) {
  print('Login failed: $e');
}
```

### Future<void> register(WooCustomer customer) async

Registers a new customer account.

Upon successful registration, the user ID is securely stored in local storage
and can be retrieved using [LocalStorageHelper.getSecurityUserId()].

## Parameters

- [customer]: The customer object containing registration details.

## Throws

Throws an exception if registration fails or if the API request fails.

## Example

```dart
final newCustomer = WooCustomer(
  email: 'newuser@example.com',
  firstName: 'John',
  lastName: 'Doe',
);

try {
  await woocommerce.register(newCustomer);
  print('Registration successful');
} catch (e) {
  print('Registration failed: $e');
}
```

### Future<void> changePassword(String password) async

Changes the password for the currently logged-in user.

## Parameters

- [password]: The new password for the user.

## Throws

Throws an exception if the password change fails or if the API request fails.

## Example

```dart
try {
  await woocommerce.changePassword('newPassword123');
  print('Password changed successfully');
} catch (e) {
  print('Password change failed: $e');
}
```

### Future<void> logout() async

Logs out the currently logged-in user.

This method clears the stored user ID from local storage,
effectively ending the user's session.

## Example

```dart
await woocommerce.logout();
print('User logged out successfully');
```

## customer_api

### extension WooCustomerApi on WooCommerce

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### Future<WooPage<WooCustomer>> getCustomers({ WooContext? context, int? page, int? perPage, String? search, List<int>? exclude, List<int>? include, int? offset, WooSort? order, WooOrderBy? orderBy, String? email, WooCustomerRole? role, bool? useFaker, }) async

[context]	Scope under which the request is made; determines fields present in response. Options: view and edit. Default is view.

[page] integer	Current page of the collection. Default is 1.

[perPage] integer	Maximum number of items to be returned in result set. Default is 10.

[search] Limit results to those matching a string.

[exclude] Ensure result set excludes specific IDs.

[include] Limit result set to specific ids.

[offset] Offset the result set by a specific number of items.

[order] Order sort attribute ascending or descending. Options: asc and desc. Default is asc.

[orderby] Sort collection by object attribute. Options: id, include, name and registered_date. Default is name.

[email] Limit result set to resources with a specific email.

[role] Limit result set to resources with a specific role. Options: all, administrator, editor, author, contributor, subscriber, customer and shop_manager. Default is customer.

### Future<WooCustomer> getCustomer(int id, {bool? useFaker}) async

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### Future<WooCustomer> createCustomer

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### Future<WooCustomer> updateCustomer

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### Future<WooDeleteResult> deleteCustomer

[useFaker] When `true`, returns fake data instead of performing the real delete request.

[reassign] User ID to reassign posts to.

### Future<WooPage<WooCustomerDownload>> getCustomerDownloads

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### Future<WooCustomerBatchResponse> batchUpdateCustomers

Performs batch operations on customers (create, update, delete) in a single request.

This method allows you to create, update, and delete multiple customers
efficiently in a single API call, reducing the number of requests needed
for bulk operations.
https://woocommerce.github.io/woocommerce-rest-api-docs/#batch-update-customers

## Parameters

* [request] - The batch request containing customers to create, update, and/or delete
  - `create`: List of `WooCustomer` objects to create (should not have IDs)
  - `update`: List of `WooCustomer` objects to update (must include valid IDs)
  - `delete`: List of customer IDs (integers) to delete
* [useFaker] - When true, returns fake data for testing purposes

## Returns

A `Future<WooCustomerBatchResponse>` containing the results of all batch operations:
- `create`: List of successfully created customers with server-assigned IDs
- `update`: List of successfully updated customers
- `delete`: List of successfully deleted customers

## Throws

* `WooCommerceException` if the batch operation fails or validation errors occur

## Example Usage

```dart
// Create a batch request with multiple operations
final batchRequest = WooCustomerBatchRequest(
  create: [
    WooCustomer(
      email: 'customer1@example.com',
      firstName: 'John',
      lastName: 'Doe',
      username: 'johndoe',
    ),
    WooCustomer(
      email: 'customer2@example.com',
      firstName: 'Jane',
      lastName: 'Smith',
      username: 'janesmith',
    ),
  ],
  update: [
    existingCustomer..firstName = 'Updated Name',
  ],
  delete: [123, 456],
);

// Execute the batch operation
final response = await wooCommerce.batchUpdateCustomers(batchRequest);

// Process results
print('Created ${response.create?.length ?? 0} customers');
print('Updated ${response.update?.length ?? 0} customers');
print('Deleted ${response.delete?.length ?? 0} customers');

// Access individual results
for (final customer in response.create ?? []) {
  print('Created customer: ${customer.email} with ID: ${customer.id}');
}
```

## Batch Operations Best Practices

- **Create operations**: Customers should not have IDs assigned
- **Update operations**: Customers must have valid IDs and will be updated with provided values
- **Delete operations**: Provide only the IDs of customers to delete
- **Mixed operations**: You can combine create, update, and delete in a single request
- **Error handling**: If any operation fails, the entire batch may fail depending on API behavior

## customer_query

### class WooCustomerQuery extends WooQuery

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### const WooCustomerQuery({ super.page, super.perPage, super.order, super.orderBy, super.search, super.offset, this.context, this.exclude, this.include, this.email, this.role, })

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final WooContext? context

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final List<int>? exclude

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final List<int>? include

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final String? email

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final WooCustomerRole? role

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### Map<String, dynamic> toMap()

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

## customer_role

### enum WooCustomerRole implements WooEnum

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### all('all'),

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### administrator('administrator'),

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### editor('editor'),

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### author('author'),

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### contributor('contributor'),

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### subscriber('subscriber'),

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### customer('customer'),

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### shopManager('shop_manager'),

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### unknown('unknown')

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### const WooCustomerRole(this.value)

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final String value

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### static WooCustomerRole fake()

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

## customer

### class WooCustomer

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### WooCustomer({ this.id, this.dateCreated, this.dateCreatedGmt, this.dateModified, this.dateModifiedGmt, this.email, this.firstName, this.lastName, this.role, this.username, this.password, this.billing, this.shipping, this.isPayingCustomer, this.avatarUrl, this.metaData, })

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### factory WooCustomer.fromJson(Map<String, dynamic> json)

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### factory WooCustomer.fake({int? id})

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final int? id

Unique identifier for the resource.

### final DateTime? dateCreated

The date the customer was created, in the site's timezone.

### final DateTime? dateCreatedGmt

The date the customer was created, as GMT.

### final DateTime? dateModified

The date the customer was last modified, in the site's timezone.

### final DateTime? dateModifiedGmt

The date the customer was last modified, as GMT.

### final String? email

The email address for the customer.

### final String? firstName

Customer first name.

### final String? lastName

Customer last name.

### final WooCustomerRole? role

Customer role.

### final String? username

Customer login name.

### final String? password

Customer password.

### final WooBilling? billing

List of billing address data.

### final WooShipping? shipping

List of shipping address data.

### final bool? isPayingCustomer

Is the customer a paying customer?

### final String? avatarUrl

Avatar URL.

### final List<WooMetaData>? metaData

Meta data.

### Map<String, dynamic> toJson()

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### WooCustomer copyWith({ int? id, DateTime? dateCreated, DateTime? dateCreatedGmt, DateTime? dateModified, DateTime? dateModifiedGmt, String? email, String? firstName, String? lastName, WooCustomerRole? role, String? username, String? password, WooBilling? billing, WooShipping? shipping, bool? isPayingCustomer, String? avatarUrl, List<WooMetaData>? metaData, })

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### bool operator ==(Object other)

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### identical(this, other) ||

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### int get hashCode

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### String toString()

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

## customer_batch_request

### class WooCustomerBatchRequest

WooCommerce Customer Batch Request Model

This class represents a batch request for creating, updating, and deleting
multiple customers in a single API call. It allows you to perform bulk operations
efficiently without making multiple individual requests.

## Key Features

- **Bulk Creation**: Create multiple customers in a single request
- **Bulk Updates**: Update multiple existing customers simultaneously
- **Bulk Deletion**: Delete multiple customers at once
- **Flexible Operations**: Mix create, update, and delete operations in one request

## Usage Examples

### Creating a Batch Request

```dart
final batchRequest = WooCustomerBatchRequest(
  create: [
    WooCustomer(
      email: 'customer1@example.com',
      firstName: 'John',
      lastName: 'Doe',
      username: 'johndoe',
    ),
    WooCustomer(
      email: 'customer2@example.com',
      firstName: 'Jane',
      lastName: 'Smith',
      username: 'janesmith',
    ),
  ],
  update: [
    existingCustomer..firstName = 'Updated Name',
  ],
  delete: [123, 456],
);
```

### Working with Batch Requests

```dart
// Create a batch request with only creates
final createOnly = WooCustomerBatchRequest(
  create: [customer1, customer2, customer3],
);

// Create a batch request with only updates
final updateOnly = WooCustomerBatchRequest(
  update: [updatedCustomer1, updatedCustomer2],
);

// Create a batch request with only deletes
final deleteOnly = WooCustomerBatchRequest(
  delete: [101, 102, 103],
);
```

## JSON Serialization

The class supports full JSON serialization for API communication:

```dart
// Convert to JSON for API requests
final json = batchRequest.toJson();

// Create from JSON response
final batchRequest = WooCustomerBatchRequest.fromJson(jsonData);
```

### WooCustomerBatchRequest({this.create, this.update, this.delete})

WooCommerce Customer Batch Request Model

This class represents a batch request for creating, updating, and deleting
multiple customers in a single API call. It allows you to perform bulk operations
efficiently without making multiple individual requests.

## Key Features

- **Bulk Creation**: Create multiple customers in a single request
- **Bulk Updates**: Update multiple existing customers simultaneously
- **Bulk Deletion**: Delete multiple customers at once
- **Flexible Operations**: Mix create, update, and delete operations in one request

## Usage Examples

### Creating a Batch Request

```dart
final batchRequest = WooCustomerBatchRequest(
  create: [
    WooCustomer(
      email: 'customer1@example.com',
      firstName: 'John',
      lastName: 'Doe',
      username: 'johndoe',
    ),
    WooCustomer(
      email: 'customer2@example.com',
      firstName: 'Jane',
      lastName: 'Smith',
      username: 'janesmith',
    ),
  ],
  update: [
    existingCustomer..firstName = 'Updated Name',
  ],
  delete: [123, 456],
);
```

### Working with Batch Requests

```dart
// Create a batch request with only creates
final createOnly = WooCustomerBatchRequest(
  create: [customer1, customer2, customer3],
);

// Create a batch request with only updates
final updateOnly = WooCustomerBatchRequest(
  update: [updatedCustomer1, updatedCustomer2],
);

// Create a batch request with only deletes
final deleteOnly = WooCustomerBatchRequest(
  delete: [101, 102, 103],
);
```

## JSON Serialization

The class supports full JSON serialization for API communication:

```dart
// Convert to JSON for API requests
final json = batchRequest.toJson();

// Create from JSON response
final batchRequest = WooCustomerBatchRequest.fromJson(jsonData);
```

### factory WooCustomerBatchRequest.fromJson(Map<String, dynamic> json)

Creates a WooCustomerBatchRequest instance from JSON data

This factory constructor is used to deserialize batch request data
received from the WooCommerce REST API.

## Parameters

* [json] - A Map containing the batch request data in JSON format

## Returns

A `WooCustomerBatchRequest` instance populated with data from the JSON.

## Example Usage

```dart
final batchRequest = WooCustomerBatchRequest.fromJson(jsonData);
```

### factory WooCustomerBatchRequest.fake()

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final List<WooCustomer>? create

List of customers to create

Each customer in this list will be created as a new customer in the store.
Customers in this list should not have an ID assigned.

### final List<WooCustomer>? update

List of customers to update

Each customer in this list must have a valid ID and will be updated
with the provided values.

### final List<int>? delete

List of customer IDs to delete

Each ID in this list represents a customer that will be deleted from the store.

### Map<String, dynamic> toJson()

Converts the WooCustomerBatchRequest instance to JSON format

This method serializes the batch request data into a Map that can be sent
to the WooCommerce REST API.

## Returns

A `Map<String, dynamic>` containing the batch request data in JSON format.

## Example Usage

```dart
final jsonData = batchRequest.toJson();
```

### WooCustomerBatchRequest copyWith({ List<WooCustomer>? create, List<WooCustomer>? update, List<int>? delete, })

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### bool operator ==(Object other)

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### identical(this, other) ||

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### int get hashCode

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### String toString()

Returns a string representation of the WooCustomerBatchRequest instance

This method provides a human-readable representation of the batch request,
displaying the counts of create, update, and delete operations.

## Returns

A `String` containing the batch request's operation counts in a readable format.

## Example Usage

```dart
final batchRequest = WooCustomerBatchRequest(
  create: [customer1, customer2],
  update: [customer3],
  delete: [123, 456],
);
print(batchRequest.toString());
// Output: WooCustomerBatchRequest(create: 2, update: 1, delete: 2)
```

## customer_batch_response

### class WooCustomerBatchResponse

WooCommerce Customer Batch Response Model

This class represents the response from a batch customer operation. It contains
the results of create, update, and delete operations performed in a single
batch request.

## Key Features

- **Create Results**: List of successfully created customers with server-assigned IDs
- **Update Results**: List of successfully updated customers
- **Delete Results**: List of successfully deleted customers
- **Comprehensive Response**: All operations results in a single response object

## Usage Examples

### Processing Batch Response

```dart
final response = await wooCommerce.batchUpdateCustomers(batchRequest);

// Process created customers
for (final customer in response.create ?? []) {
  print('Created customer: ${customer.email} with ID: ${customer.id}');
}

// Process updated customers
for (final customer in response.update ?? []) {
  print('Updated customer: ${customer.email}');
}

// Process deleted customers
for (final customer in response.delete ?? []) {
  print('Deleted customer: ${customer.email}');
}
```

### Checking Batch Results

```dart
final response = await wooCommerce.batchUpdateCustomers(batchRequest);

final createdCount = response.create?.length ?? 0;
final updatedCount = response.update?.length ?? 0;
final deletedCount = response.delete?.length ?? 0;

print('Batch operation completed:');
print('  Created: $createdCount');
print('  Updated: $updatedCount');
print('  Deleted: $deletedCount');
```

## JSON Serialization

The class supports full JSON serialization for API communication:

```dart
// Create from JSON response
final batchResponse = WooCustomerBatchResponse.fromJson(jsonData);

// Convert to JSON if needed
final json = batchResponse.toJson();
```

### WooCustomerBatchResponse({this.create, this.update, this.delete})

WooCommerce Customer Batch Response Model

This class represents the response from a batch customer operation. It contains
the results of create, update, and delete operations performed in a single
batch request.

## Key Features

- **Create Results**: List of successfully created customers with server-assigned IDs
- **Update Results**: List of successfully updated customers
- **Delete Results**: List of successfully deleted customers
- **Comprehensive Response**: All operations results in a single response object

## Usage Examples

### Processing Batch Response

```dart
final response = await wooCommerce.batchUpdateCustomers(batchRequest);

// Process created customers
for (final customer in response.create ?? []) {
  print('Created customer: ${customer.email} with ID: ${customer.id}');
}

// Process updated customers
for (final customer in response.update ?? []) {
  print('Updated customer: ${customer.email}');
}

// Process deleted customers
for (final customer in response.delete ?? []) {
  print('Deleted customer: ${customer.email}');
}
```

### Checking Batch Results

```dart
final response = await wooCommerce.batchUpdateCustomers(batchRequest);

final createdCount = response.create?.length ?? 0;
final updatedCount = response.update?.length ?? 0;
final deletedCount = response.delete?.length ?? 0;

print('Batch operation completed:');
print('  Created: $createdCount');
print('  Updated: $updatedCount');
print('  Deleted: $deletedCount');
```

## JSON Serialization

The class supports full JSON serialization for API communication:

```dart
// Create from JSON response
final batchResponse = WooCustomerBatchResponse.fromJson(jsonData);

// Convert to JSON if needed
final json = batchResponse.toJson();
```

### factory WooCustomerBatchResponse.fromJson(Map<String, dynamic> json)

Creates a WooCustomerBatchResponse instance from JSON data

This factory constructor is used to deserialize batch response data
received from the WooCommerce REST API.

## Parameters

* [json] - A Map containing the batch response data in JSON format

## Returns

A `WooCustomerBatchResponse` instance populated with data from the JSON.

## Example Usage

```dart
final batchResponse = WooCustomerBatchResponse.fromJson(jsonData);
```

### factory WooCustomerBatchResponse.fake()

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final List<WooCustomer>? create

List of created customers

Contains the customers that were successfully created, each with a
server-assigned ID and all other properties as returned by the API.

### final List<WooCustomer>? update

List of updated customers

Contains the customers that were successfully updated, reflecting
the current state after the update operation.

### final List<WooCustomer>? delete

List of deleted customers

Contains the customers that were successfully deleted. These customers
may have limited information depending on the API response.

### Map<String, dynamic> toJson()

Converts the WooCustomerBatchResponse instance to JSON format

This method serializes the batch response data into a Map.

## Returns

A `Map<String, dynamic>` containing the batch response data in JSON format.

## Example Usage

```dart
final jsonData = batchResponse.toJson();
```

### WooCustomerBatchResponse copyWith({ List<WooCustomer>? create, List<WooCustomer>? update, List<WooCustomer>? delete, })

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### bool operator ==(Object other)

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### identical(this, other) ||

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### int get hashCode

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### String toString()

Returns a string representation of the WooCustomerBatchResponse instance

This method provides a human-readable representation of the batch response,
displaying the counts of create, update, and delete results.

## Returns

A `String` containing the batch response's result counts in a readable format.

## Example Usage

```dart
final batchResponse = WooCustomerBatchResponse(
  create: [customer1, customer2],
  update: [customer3],
  delete: [customer4, customer5],
);
print(batchResponse.toString());
// Output: WooCustomerBatchResponse(create: 2, update: 1, delete: 2)
```

## customer_download

### class WooCustomerDownload

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### WooCustomerDownload({ this.downloadId, this.downloadUrl, this.productId, this.productName, this.downloadName, this.orderId, this.orderKey, this.downloadsRemaining, this.accessExpires, this.accessExpiresGmt, this.file, })

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### factory WooCustomerDownload.fromJson(Map<String, dynamic> json)

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### factory WooCustomerDownload.fake()

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final String? downloadId

Download ID (MD5).

### final String? downloadUrl

Download file URL.

### final int? productId

Downloadable product ID.

### final String? productName

Product name.

### final String? downloadName

Downloadable file name.

### final int? orderId

Order ID.

### final String? orderKey

Order key.

### final String? downloadsRemaining

Number of downloads remaining.

### final DateTime? accessExpires

The date when download access expires, in the site's timezone.

### final DateTime? accessExpiresGmt

The date when download access expires, as GMT.

### final WooCustomerDownloadFile? file

File details.

### Map<String, dynamic> toJson()

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### WooCustomerDownload copyWith({ String? downloadId, String? downloadUrl, int? productId, String? productName, String? downloadName, int? orderId, String? orderKey, String? downloadsRemaining, DateTime? accessExpires, DateTime? accessExpiresGmt, WooCustomerDownloadFile? file, })

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### bool operator ==(Object other)

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### identical(this, other) ||

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### int get hashCode

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### String toString()

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

## customer_download_file

### class WooCustomerDownloadFile

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### WooCustomerDownloadFile({this.name, this.file})

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### factory WooCustomerDownloadFile.fromJson(Map<String, dynamic> json)

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### factory WooCustomerDownloadFile.fake()

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final String? name

File name.

### final String? file

File URL.

### Map<String, dynamic> toJson()

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### WooCustomerDownloadFile copyWith({String? name, String? file})

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### bool operator ==(Object other)

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### identical(this, other) ||

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### int get hashCode

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### String toString()

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

