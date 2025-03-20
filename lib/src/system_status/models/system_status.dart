import 'package:woocommerce_flutter_api/woocommerce_flutter_api.dart';

class WooSystemStatus {
  /// Environment information
  final WooSystemStatusEnvironment? environment;

  /// Database information
  final WooSystemStatusDatabase? database;

  /// Active plugins
  final List<String>? activePlugins;

  /// Theme information
  final WooSystemStatusTheme? theme;

  /// Settings information
  final WooSystemStatusSettings? settings;

  /// Security information
  final WooSystemStatusSecurity? security;

  /// WooCommerce pages
  final List<String>? pages;

  WooSystemStatus({
    this.environment,
    this.database,
    this.activePlugins,
    this.theme,
    this.settings,
    this.security,
    this.pages,
  });

  factory WooSystemStatus.fromJson(Map<String, dynamic> json) =>
      WooSystemStatus(
        environment: json['environment'] != null
            ? WooSystemStatusEnvironment.fromJson(json['environment'])
            : null,
        database: json['database'] != null
            ? WooSystemStatusDatabase.fromJson(json['database'])
            : null,
        activePlugins: json['active_plugins'] != null
            ? List<String>.from(json['active_plugins'])
            : null,
        theme: json['theme'] != null
            ? WooSystemStatusTheme.fromJson(json['theme'])
            : null,
        settings: json['settings'] != null
            ? WooSystemStatusSettings.fromJson(json['settings'])
            : null,
        security: json['security'] != null
            ? WooSystemStatusSecurity.fromJson(json['security'])
            : null,
        pages: json['pages'] != null ? List<String>.from(json['pages']) : null,
      );

  Map<String, dynamic> toJson() => {
        'environment': environment?.toJson(),
        'database': database?.toJson(),
        'active_plugins': activePlugins,
        'theme': theme?.toJson(),
        'settings': settings?.toJson(),
        'security': security?.toJson(),
        'pages': pages,
      };

  factory WooSystemStatus.fake() => WooSystemStatus(
        environment: WooSystemStatusEnvironment.fake(),
        database: WooSystemStatusDatabase.fake(),
        activePlugins: FakeHelper.list(() => FakeHelper.word()),
        theme: WooSystemStatusTheme.fake(),
        settings: WooSystemStatusSettings.fake(),
        security: WooSystemStatusSecurity.fake(),
        pages: FakeHelper.list(() => FakeHelper.word()),
      );
}
