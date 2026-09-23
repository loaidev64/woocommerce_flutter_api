# base

## base

## api

### enum WooApiVersion implements WooEnum

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### v3('v3'),

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### v4('v4'),

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### unknown('unknown')

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### const WooApiVersion(this.value)

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final String value

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### static WooApiVersion fake()

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### enum WooAuthMethod implements WooEnum

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### basic('basic'),

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### queryString('query_string'),

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### unknown('unknown')

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### const WooAuthMethod(this.value)

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final String value

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### static WooAuthMethod fake()

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

## context

### enum WooContext implements WooEnum

Scope under which the request is made; determines fields present in response.

### view('view'),

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### edit('edit'),

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### unknown('unknown')

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### const WooContext(this.value)

Scope under which the request is made; determines fields present in response.

### final String value

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### static WooContext fake()

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

## sort

### enum WooSort implements WooEnum

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### asc('asc'),

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### desc('desc'),

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### unknown('unknown')

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### const WooSort(this.value)

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final String value

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### static WooSort fake()

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### enum WooOrderBy implements WooEnum

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### date('date'),

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### dateGmt('date_gmt'),

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### modified('modified'),

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### id('id'),

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### include('include'),

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### title('title'),

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### name('name'),

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### slug('slug'),

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### termGroup('term_group'),

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### description('description'),

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### count('count'),

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### price('price'),

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### popularity('popularity'),

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### rating('rating'),

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### menuOrder('menu_order'),

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### registeredDate('registered_date'),

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### unknown('unknown')

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### const WooOrderBy(this.value)

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final String value

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### static WooOrderBy fake()

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

## status

### enum WooFilterStatus implements WooEnum

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### any('any'),

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### draft('draft'),

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### pending('pending'),

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### private('private'),

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### publish('publish'),

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### unknown('unknown')

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### const WooFilterStatus(this.value)

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final String value

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### static WooFilterStatus fake()

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

## metadata

### class WooMetaData

Key-value metadata attached to many WooCommerce resources (products,
orders, customers, coupons, …). Values are arbitrary strings; use the
`_links`-style raw JSON only when a plugin stores structured metadata.

## Example Usage

```dart
final product = product.copyWith(
  metaData: [
    WooMetaData(key: '_custom_field', value: 'custom value'),
  ],
);
```

### const WooMetaData({this.id, this.key, this.value})

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### factory WooMetaData.fromJson(Map<String, dynamic> json)

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### factory WooMetaData.fake()

Returns a fake metadata entry for testing and development.

### final int? id

Meta ID.

### final String? key

Meta key.

### final String? value

Meta value.

### Map<String, dynamic> toJson()

Serializes this metadata entry; nulls are omitted.

### WooMetaData copyWith({int? id, String? key, String? value})

Returns a copy with the given fields replaced.

### bool operator ==(Object other)

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### identical(this, other) ||

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### int get hashCode

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### String toString()

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

## woo_delete_result

### class WooDeleteResult

Result of a WooCommerce delete operation.

WooCommerce delete endpoints respond with the deleted resource plus a
`deleted: true` flag (or `previous` when trashing). All `delete*` methods
in this package return this type so consumers get a consistent contract
across every module.

### const WooDeleteResult({required this.id, required this.deleted})

Creates a delete result.

### factory WooDeleteResult.fromJson(Map<String, dynamic> json)

Builds the result from a delete response body.

### factory WooDeleteResult.fake()

Returns a fake delete result for testing and development.

### final int? id

The identifier of the deleted resource, when the response includes it.

### final bool deleted

Whether the resource was actually deleted (false when trashed).

### Map<String, dynamic> toJson()

Serializes this delete result; nulls are omitted.

### WooDeleteResult copyWith({int? id, bool? deleted})

Returns a copy with the given fields replaced.

### bool operator ==(Object other)

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### identical(this, other) ||

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### int get hashCode

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### String toString()

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

## woo_query

### abstract class WooQuery

Base class for typed list-request query options.

Concrete subclasses (`WooProductQuery`, `WooOrderQuery`, `WooCustomerQuery`,
…) add module-specific filters on top of the shared pagination, sorting,
search and offset parameters. Each exposes `toMap()` for the query string.

### const WooQuery({ this.page, this.perPage, this.order, this.orderBy, this.search, this.offset, })

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final int? page

Current page of the collection (1-based).

### final int? perPage

Maximum number of items to return per page.

### final WooSort? order

Sort direction (`asc`/`desc`).

### final WooOrderBy? orderBy

Sort key (shared across modules: date, id, title, price, …).

### final String? search

Limit results to items matching a search string.

### final int? offset

Offset the result set by a number of items.

### Map<String, dynamic> toMap()

Builds the query parameters map; `null` values are omitted and enums are
serialized with their wire values.

