# pagination

## woo_page

### class WooPage<T>

Paginated result returned by every list method.

Exposes the store's real totals from the `X-WP-Total` and `X-WP-TotalPages`
response headers, so consumers can page accurately instead of guessing with
`length < perPage`.

## Example Usage

```dart
var page = await wooCommerce.getProducts(page: 1, perPage: 25);
final all = [...page.items];
while (page.hasNextPage) {
  page = await wooCommerce.getProducts(page: page.page + 1, perPage: 25);
  all.addAll(page.items);
}
print('${page.totalItems} products in the store');
```

### const WooPage({ required List<T> items, required int page, int? totalItems, int? totalPages })

Creates a page with explicit values.

### factory WooPage.fromResponse(Response<List<T>> response, { required int page })

Builds a page from a Dio response whose data is already a `List<T>`.

### factory WooPage.parse({ required Response<dynamic> response, required List<T> items, required int page })

Builds a page from parsed `items` plus the pagination headers of a response.

### List<T> items

Items on this page.

### int page

Current page number (1-based).

### int? totalItems

Total items across all pages (`X-WP-Total`), when the header is present.

### int? totalPages

Total number of pages (`X-WP-TotalPages`), when the header is present.

### bool get hasNextPage

Whether another page exists: `page < totalPages` when total pages are
known, otherwise whether the current page is non-empty.