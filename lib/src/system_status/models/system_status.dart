import '../../helpers/fake_helper.dart';
import '../../json/woo_json.dart';
import 'system_status_database.dart';
import 'system_status_environment.dart';
import 'system_status_security.dart';
import 'system_status_settings.dart';
import 'system_status_theme.dart';

class WooSystemStatus {
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
        environment: WooJson.readMap(json, 'environment') == null
            ? null
            : WooSystemStatusEnvironment.fromJson(
                WooJson.readMap(json, 'environment')!),
        database: WooJson.readMap(json, 'database') == null
            ? null
            : WooSystemStatusDatabase.fromJson(
                WooJson.readMap(json, 'database')!),
        activePlugins: _readStringList(json, 'active_plugins'),
        theme: WooJson.readMap(json, 'theme') == null
            ? null
            : WooSystemStatusTheme.fromJson(WooJson.readMap(json, 'theme')!),
        settings: WooJson.readMap(json, 'settings') == null
            ? null
            : WooSystemStatusSettings.fromJson(
                WooJson.readMap(json, 'settings')!),
        security: WooJson.readMap(json, 'security') == null
            ? null
            : WooSystemStatusSecurity.fromJson(
                WooJson.readMap(json, 'security')!),
        pages: _readStringList(json, 'pages'),
      );
  factory WooSystemStatus.fake() => WooSystemStatus(
        environment: WooSystemStatusEnvironment.fake(),
        database: WooSystemStatusDatabase.fake(),
        activePlugins: FakeHelper.list(() => FakeHelper.word()),
        theme: WooSystemStatusTheme.fake(),
        settings: WooSystemStatusSettings.fake(),
        security: WooSystemStatusSecurity.fake(),
        pages: FakeHelper.list(() => FakeHelper.word()),
      );
  final WooSystemStatusEnvironment? environment;
  final WooSystemStatusDatabase? database;
  final List<String>? activePlugins;
  final WooSystemStatusTheme? theme;
  final WooSystemStatusSettings? settings;
  final WooSystemStatusSecurity? security;
  final List<String>? pages;
  Map<String, dynamic> toJson() => <String, dynamic>{}
    ..putIfPresent('environment', environment?.toJson())
    ..putIfPresent('database', database?.toJson())
    ..putIfPresent('active_plugins', activePlugins)
    ..putIfPresent('theme', theme?.toJson())
    ..putIfPresent('settings', settings?.toJson())
    ..putIfPresent('security', security?.toJson())
    ..putIfPresent('pages', pages);
  WooSystemStatus copyWith({
    WooSystemStatusEnvironment? environment,
    WooSystemStatusDatabase? database,
    List<String>? activePlugins,
    WooSystemStatusTheme? theme,
    WooSystemStatusSettings? settings,
    WooSystemStatusSecurity? security,
    List<String>? pages,
  }) =>
      WooSystemStatus(
        environment: environment ?? this.environment,
        database: database ?? this.database,
        activePlugins: activePlugins ?? this.activePlugins,
        theme: theme ?? this.theme,
        settings: settings ?? this.settings,
        security: security ?? this.security,
        pages: pages ?? this.pages,
      );
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is WooSystemStatus &&
        other.environment == environment &&
        other.database == database &&
        WooJson.listEquals(other.activePlugins, activePlugins) &&
        other.theme == theme &&
        other.settings == settings &&
        other.security == security &&
        WooJson.listEquals(other.pages, pages);
  }

  @override
  int get hashCode => Object.hashAll([
        environment,
        database,
        Object.hashAll(activePlugins ?? const []),
        theme,
        settings,
        security,
        Object.hashAll(pages ?? const []),
      ]);
  @override
  String toString() => 'WooSystemStatus(environment: $environment, '
      'database: $database)';
  static List<String>? _readStringList(Map<String, dynamic> json, String key) {
    final value = json[key];
    if (value is! List) return null;
    return [for (final element in value) element.toString()];
  }
}
