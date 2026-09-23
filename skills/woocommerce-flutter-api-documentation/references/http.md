# http

## woo_error_interceptor

### class WooErrorInterceptor extends Interceptor

Dio interceptor that maps every `DioException` to the typed
`WooCommerceException` hierarchy (see `exceptions.md`).

Installed on the client by default. The mapped exception is attached as the
Dio error's `error` so `requestGet`/`requestPost`/`requestPut`/`requestDelete`
can rethrow it typed. It never maps exceptions that are already
`WooCommerceException`.

## woo_log_interceptor

### class WooLogInterceptor extends Interceptor

Credential-safe request/response logger (not installed by default; pass it
via the `interceptors:` constructor parameter).

Logs the method, URL and request body for requests and the status code and
URL for responses via `dart:developer` under the `woocommerce_flutter_api`
log name. Never logs headers, so `Authorization` credentials are not leaked.

**Note:** when the client is constructed with `isDebug: true`, `PrettyDioLogger`
is used instead (v2 configures it without logging credentials).