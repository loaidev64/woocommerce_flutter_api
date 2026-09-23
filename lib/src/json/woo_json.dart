library;

abstract final class WooJson {
  static String? readString(Map<String, dynamic> json, String key) {
    final value = json[key];
    if (value == null) return null;
    if (value is String) return value;
    return value.toString();
  }

  static int? readInt(Map<String, dynamic> json, String key) {
    final value = json[key];
    if (value is int) return value;
    if (value is num) return value.toInt();
    if (value is String) return int.tryParse(value);
    return null;
  }

  static double? readDouble(Map<String, dynamic> json, String key) {
    final value = json[key];
    if (value is double) return value;
    if (value is num) return value.toDouble();
    if (value is String) {
      return double.tryParse(value) ?? int.tryParse(value)?.toDouble();
    }
    return null;
  }

  static bool? readBool(Map<String, dynamic> json, String key) {
    final value = json[key];
    if (value is bool) return value;
    if (value is num) return value != 0;
    if (value is String) {
      if (value == 'true' || value == '1' || value == 'yes') return true;
      if (value == 'false' || value == '0' || value == 'no') return false;
    }
    return null;
  }

  static DateTime? readDate(Map<String, dynamic> json, String key) {
    final value = json[key];
    if (value is! String || value.isEmpty) return null;
    return DateTime.tryParse(value)?.toUtc();
  }

  static List<T>? readList<T>(
    Map<String, dynamic> json,
    String key,
    T Function(Map<String, dynamic> item) parseItem,
  ) {
    final value = json[key];
    if (value is! List) return null;
    return value
        .whereType<Map<String, dynamic>>()
        .map(parseItem)
        .toList(growable: false);
  }

  static List<T> readListOrEmpty<T>(
    Map<String, dynamic> json,
    String key,
    T Function(Map<String, dynamic> item) parseItem,
  ) =>
      readList(json, key, parseItem) ?? const [];
  static List<int>? readIntList(Map<String, dynamic> json, String key) {
    final value = json[key];
    if (value is! List) return null;
    return [
      for (final element in value)
        if (element is int) element else if (element is num) element.toInt(),
    ];
  }

  static Map<String, dynamic>? readMap(Map<String, dynamic> json, String key) {
    final value = json[key];
    if (value is Map<String, dynamic>) return value;
    if (value is Map) return value.cast<String, dynamic>();
    return null;
  }

  static E? readEnum<E extends WooEnum>(
    Map<String, dynamic> json,
    String key,
    List<E> values,
  ) {
    final raw = json[key];
    if (raw == null) return null;
    final value = raw.toString();
    for (final candidate in values) {
      if (candidate.value == value) return candidate;
    }
    for (final candidate in values) {
      if ((candidate as Enum).name == value) return candidate;
    }
    for (final candidate in values) {
      if ((candidate as Enum).name == 'unknown') return candidate;
    }
    return null;
  }

  static bool listEquals<T>(List<T>? a, List<T>? b) {
    if (identical(a, b)) return true;
    if (a == null || b == null || a.length != b.length) return false;
    for (var i = 0; i < a.length; i++) {
      if (a[i] != b[i]) return false;
    }
    return true;
  }

  static bool mapEquals<K, V>(Map<K, V>? a, Map<K, V>? b) {
    if (identical(a, b)) return true;
    if (a == null || b == null || a.length != b.length) return false;
    for (final key in a.keys) {
      if (!b.containsKey(key) || a[key] != b[key]) return false;
    }
    return true;
  }
}

abstract interface class WooEnum {
  String get value;
}

extension WooJsonWriteExt on Map<String, dynamic> {
  void putIfPresent(String key, Object? value) {
    if (value != null) this[key] = value;
  }

  void putDate(String key, DateTime? value) {
    if (value != null) this[key] = value.toIso8601String();
  }

  void putEnum(String key, WooEnum? value) {
    if (value != null) this[key] = value.value;
  }

  void putList(String key, List<Map<String, dynamic>>? values) {
    if (values != null) this[key] = values;
  }
}
