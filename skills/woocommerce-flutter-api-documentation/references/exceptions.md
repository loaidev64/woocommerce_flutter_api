# exceptions

## woocommerce_exception

### class WooCommerceException implements Exception

Base class for every error thrown by this package.

All HTTP/Dio failures are mapped to this typed hierarchy by
`WooErrorInterceptor` (installed on the client by default). Catch
`on WooCommerceException` instead of `on DioException`.

### factory WooCommerceException.fromDioException(DioException error)

Maps a `DioException` to the appropriate subclass:

- Non-HTTP failures (timeouts, connection refused, cancellation) →
  `WooCommerceNetworkException` (carries `dioType`).
- 400 → `WooCommerceValidationException` (with `fieldErrors` from the
  `data.details` body section).
- 401/403 → `WooCommerceAuthException`.
- 404 → `WooCommerceNotFoundException`.
- 429 → `WooCommerceRateLimitException` (with `retryAfterSeconds` parsed
  from the `Retry-After` header).
- 500/502/503/504 → `WooCommerceServerException`.
- Anything else → base `WooCommerceException`.

The WooCommerce error `code` and `message` are parsed from the response
body when present, and the request id is read from the
`x-woo-commerce-request-id` response header.

### String message

Human-readable error message.

### int? statusCode

HTTP status code, when the store responded.

### String? code

WooCommerce API error code (e.g. `woocommerce_rest_invalid_product_id`),
when the store provided one.

### String? requestId

Request id echoed from the `x-woo-commerce-request-id` header.

## class WooCommerceValidationException extends WooCommerceException

400 Bad Request. Carries per-field validation errors.

### Map<String, dynamic> fieldErrors

Per-field validation errors from the `data.details` section of the error
body.

## class WooCommerceAuthException extends WooCommerceException

401/403 — the consumer key/secret are invalid or lack permission.

## class WooCommerceNotFoundException extends WooCommerceException

404 — the requested resource does not exist.

## class WooCommerceRateLimitException extends WooCommerceException

429 — too many requests.

### int? retryAfterSeconds

Seconds to wait before retrying, from the `Retry-After` header.

## class WooCommerceServerException extends WooCommerceException

5xx — the store failed while processing the request.

## class WooCommerceNetworkException extends WooCommerceException

The request never reached the store (timeout, connection failure,
cancellation).

### DioExceptionType? dioType

The original Dio failure type.

## class WooCommerceParseException extends WooCommerceException

The response was not in the expected shape (e.g. a list expected but a map
returned). Thrown by API methods when the payload cannot be parsed.

### String? path

The API path that produced the unparseable response.