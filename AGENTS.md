# AGENTS.md

WooCommerce Flutter/Dart client. Each `lib/src/<module>/` is exposed as Dart
`extension`s on `WooCommerce` (configured in
`lib/src/woocommerce_flutter_api_base.dart`).

## Checks

`tool/check.sh` runs the full gate; CI runs the same via
`.github/workflows/ci.yaml`.

- `flutter analyze`
- `flutter test` — **not** `dart test`; the package depends on Flutter plugins
  and `dart test` fails to compile the Flutter SDK.
- `dart format --output=none --set-exit-if-changed lib test example tool`

## Docs

`lib/src` is deliberately comment-free. Usage docs live in
`skills/woocommerce-flutter-api-documentation/references/` — one hand-maintained
`<module>.md` per directory under `lib/src/`, named after the directory
(`lib/src/store/` → `references/store.md`). Migration guides are in
`skills/woocommerce-flutter-api-migration-guide/SKILL.md`. `tool/extract_docs.dart`
can extract references from doc comments, but the source has none by design.
