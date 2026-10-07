import 'dart:async';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract interface class WooCartTokenStore {
  Future<String?> read();

  Future<void> write(String? token);
}

class InMemoryWooCartTokenStore implements WooCartTokenStore {
  InMemoryWooCartTokenStore([this._token]);

  String? _token;

  @override
  Future<String?> read() async => _token;

  @override
  Future<void> write(String? token) async => _token = token;
}

class SecureStorageWooCartTokenStore implements WooCartTokenStore {
  SecureStorageWooCartTokenStore({
    FlutterSecureStorage? storage,
    this.key = defaultKey,
  }) : _storage = storage ?? const FlutterSecureStorage();

  static const String defaultKey = 'woocommerce_cart_token';

  final FlutterSecureStorage _storage;

  final String key;

  @override
  Future<String?> read() => _storage.read(key: key);

  @override
  Future<void> write(String? token) async {
    if (token == null) {
      await _storage.delete(key: key);
    } else {
      await _storage.write(key: key, value: token);
    }
  }
}

class WooCartSession {
  WooCartSession({WooCartTokenStore? tokens})
      : _tokens = tokens ?? SecureStorageWooCartTokenStore();

  final WooCartTokenStore _tokens;
  String? _nonce;
  Completer<void>? _establishing;

  Future<String?> get cartToken => _tokens.read();

  String? get nonce => _nonce;

  Future<void> adopt(String token) => _tokens.write(token);

  Future<void> clear() async {
    _nonce = null;
    settle();
    await _tokens.write(null);
  }

  Future<Map<String, String>> headers() async {
    String? token = await _tokens.read();

    if (token == null) {
      final waiting = _establishing;
      if (waiting != null) {
        await waiting.future;
        token = await _tokens.read();
      } else {
        _establishing = Completer<void>();
      }
    }

    return <String, String>{
      if (token != null && token.isNotEmpty) 'Cart-Token': token,
      if (_nonce != null && _nonce!.isNotEmpty) 'Nonce': _nonce!,
    };
  }

  void settle() {
    final completer = _establishing;
    _establishing = null;
    if (completer != null && !completer.isCompleted) completer.complete();
  }

  Future<void> absorb(Map<String, String> responseHeaders) async {
    final lower = <String, String>{
      for (final entry in responseHeaders.entries)
        entry.key.toLowerCase(): entry.value,
    };
    final nonce = lower['nonce'];
    if (nonce != null && nonce.isNotEmpty) _nonce = nonce;
    final token = lower['cart-token'];
    if (token != null && token.isNotEmpty) await _tokens.write(token);
  }
}
