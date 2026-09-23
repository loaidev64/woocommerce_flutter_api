# json

## woo_json

### abstract final class WooJson

Null-safe JSON readers and writers for WooCommerce REST API payloads.

WooCommerce serializes many scalar values as strings (prices, totals,
quantities) and omits fields entirely depending on the endpoint and request
context. These helpers are the single source of truth for how models parse
and emit JSON, so parsing never throws `TypeError` on real payloads.

## Reading

```dart
final name = WooJson.readString(json, 'name');
final price = WooJson.readDouble(json, 'price'); // handles "12.50"
final date = WooJson.readDate(json, 'date_created');
final status = WooJson.readEnum(json, 'status', WooOrderStatus.values);
```

## Writing

```dart
final json = <String, dynamic>{}
  ..putIfPresent('name', product.name)
  ..putDate('date_created', product.dateCreated)
  ..putEnum('status', product.status);
```

### static String? readString(Map<String, dynamic> json, String key)

Reads a `String` value, coercing numbers and booleans when needed.

### static int? readInt(Map<String, dynamic> json, String key)

Reads an `int` value, accepting numeric strings such as `"12"`.

### static double? readDouble(Map<String, dynamic> json, String key)

Reads a `double` value, accepting strings such as `"12.50"` or `"12"`.

### static bool? readBool(Map<String, dynamic> json, String key)

Reads a `bool` value, accepting `"true"`/`"false"` and `0`/`1`.

### static DateTime? readDate(Map<String, dynamic> json, String key)

Reads a `DateTime` value from an ISO 8601 string. Returns `null` when the key
is absent, empty, or unparseable instead of throwing, so partial payloads
never crash model construction.

### static List<T>? readList(Map<String, dynamic> json, String key, T Function(Map<String, dynamic> item) parseItem)

Reads a `List` of items parsed with `parseItem`. Returns `null` when the key
is absent or `null`, and skips `null` entries inside the list.

### static List<T> readListOrEmpty(Map<String, dynamic> json, String key, T Function(Map<String, dynamic> item) parseItem)

Like `readList` but returns an empty list when the key is absent.

### static List<int>? readIntList(Map<String, dynamic> json, String key)

Reads a `List<int>`, accepting numeric strings for each element.

### static Map<String, dynamic>? readMap(Map<String, dynamic> json, String key)

Reads a nested `Map`, returning `null` when absent or not a map.

### static E? readEnum(Map<String, dynamic> json, String key, List<E> values)

Reads an enum value from its wire representation (`WooEnum.value`). Falls
back to matching the Dart enum name for robustness, then to the enum's
`unknown` member when it defines one. Returns `null` instead of silently
coercing unrecognized values (for example custom statuses registered by
third-party plugins).

### static bool listEquals(List<T>? a, List<T>? b)

Structural equality for lists whose elements implement `==`.

### static bool mapEquals(Map<K, V>? a, Map<K, V>? b)

Structural equality for maps whose values implement `==`.

## abstract interface class WooEnum

Contract for enums that round-trip against WooCommerce wire values. Every
enum in this package implements this interface so models can serialize with
`value` instead of `Enum.name`, which breaks for values like `onHold` (wire
value `on-hold`).

### String get value

The exact string the WooCommerce REST API expects or returns.

## extension WooJsonWriteExt on Map<String, dynamic>

Extensions for building request payloads where `null` means "leave
unchanged" — WooCommerce rejects explicit `null` values in update requests,
so absent fields must simply be omitted.

### void putIfPresent(String key, Object? value)

Adds `value` only when it is not `null`.

### void putDate(String key, DateTime? value)

Adds an ISO 8601 date string only when `value` is not `null`.

### void putEnum(String key, WooEnum? value)

Adds an enum's wire value only when `value` is not `null`.

### void putList(String key, List<Map<String, dynamic>>? values)

Adds a list of nested object payloads only when `values` is not `null`.