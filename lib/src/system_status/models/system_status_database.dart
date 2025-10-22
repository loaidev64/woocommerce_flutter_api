import 'package:woocommerce_flutter_api/src/helpers/fake_helper.dart';

class WooSystemStatusDatabase {

  WooSystemStatusDatabase({
    this.wcDatabaseVersion,
    this.databasePrefix,
    this.maxmindGeoipDatabase,
    this.databaseTables,
  });

  factory WooSystemStatusDatabase.fromJson(Map<String, dynamic> json) => WooSystemStatusDatabase(
    wcDatabaseVersion: json['wc_database_version'],
    databasePrefix: json['database_prefix'],
    maxmindGeoipDatabase: json['maxmind_geoip_database'],
    databaseTables: json['database_tables'] != null 
        ? List<String>.from(json['database_tables']) 
        : null,
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

  Map<String, dynamic> toJson() => {
    'wc_database_version': wcDatabaseVersion,
    'database_prefix': databasePrefix,
    'maxmind_geoip_database': maxmindGeoipDatabase,
    'database_tables': databaseTables,
  };
}