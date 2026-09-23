import '../../helpers/fake_helper.dart';
import '../../json/woo_json.dart';

class WooSystemStatusDatabase {
  WooSystemStatusDatabase({
    this.wcDatabaseVersion,
    this.databasePrefix,
    this.maxmindGeoipDatabase,
    this.databaseTables,
  });
  factory WooSystemStatusDatabase.fromJson(Map<String, dynamic> json) =>
      WooSystemStatusDatabase(
        wcDatabaseVersion: WooJson.readString(json, 'wc_database_version'),
        databasePrefix: WooJson.readString(json, 'database_prefix'),
        maxmindGeoipDatabase:
            WooJson.readString(json, 'maxmind_geoip_database'),
        databaseTables: _readStringList(json, 'database_tables'),
      );
  factory WooSystemStatusDatabase.fake() => WooSystemStatusDatabase(
        wcDatabaseVersion: '7.4.0',
        databasePrefix: 'wp_',
        maxmindGeoipDatabase: FakeHelper.sentence(),
        databaseTables: FakeHelper.list(() => 'wp_${FakeHelper.word()}'),
      );
  final String? wcDatabaseVersion;
  final String? databasePrefix;
  final String? maxmindGeoipDatabase;
  final List<String>? databaseTables;
  Map<String, dynamic> toJson() => <String, dynamic>{}
    ..putIfPresent('wc_database_version', wcDatabaseVersion)
    ..putIfPresent('database_prefix', databasePrefix)
    ..putIfPresent('maxmind_geoip_database', maxmindGeoipDatabase)
    ..putIfPresent('database_tables', databaseTables);
  WooSystemStatusDatabase copyWith({
    String? wcDatabaseVersion,
    String? databasePrefix,
    String? maxmindGeoipDatabase,
    List<String>? databaseTables,
  }) =>
      WooSystemStatusDatabase(
        wcDatabaseVersion: wcDatabaseVersion ?? this.wcDatabaseVersion,
        databasePrefix: databasePrefix ?? this.databasePrefix,
        maxmindGeoipDatabase: maxmindGeoipDatabase ?? this.maxmindGeoipDatabase,
        databaseTables: databaseTables ?? this.databaseTables,
      );
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is WooSystemStatusDatabase &&
        other.wcDatabaseVersion == wcDatabaseVersion &&
        other.databasePrefix == databasePrefix &&
        other.maxmindGeoipDatabase == maxmindGeoipDatabase &&
        WooJson.listEquals(other.databaseTables, databaseTables);
  }

  @override
  int get hashCode => Object.hashAll([
        wcDatabaseVersion,
        databasePrefix,
        maxmindGeoipDatabase,
        Object.hashAll(databaseTables ?? const []),
      ]);
  @override
  String toString() => 'WooSystemStatusDatabase(wcDatabaseVersion: '
      '$wcDatabaseVersion)';
  static List<String>? _readStringList(Map<String, dynamic> json, String key) {
    final value = json[key];
    if (value is! List) return null;
    return [for (final element in value) element.toString()];
  }
}
