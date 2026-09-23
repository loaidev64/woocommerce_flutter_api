import '../../helpers/fake_helper.dart';
import '../../json/woo_json.dart';

class WooSystemStatusTheme {
  WooSystemStatusTheme({
    this.name,
    this.version,
    this.versionLatest,
    this.authorUrl,
    this.isChildTheme,
    this.hasWooCommerceSupport,
    this.hasWooCommerceFile,
    this.hasOutdatedTemplates,
    this.overrides,
    this.parentName,
    this.parentVersion,
    this.parentAuthorUrl,
  });
  factory WooSystemStatusTheme.fromJson(Map<String, dynamic> json) =>
      WooSystemStatusTheme(
        name: WooJson.readString(json, 'name'),
        version: WooJson.readString(json, 'version'),
        versionLatest: WooJson.readString(json, 'version_latest'),
        authorUrl: WooJson.readString(json, 'author_url'),
        isChildTheme: WooJson.readBool(json, 'is_child_theme'),
        hasWooCommerceSupport:
            WooJson.readBool(json, 'has_woocommerce_support'),
        hasWooCommerceFile: WooJson.readBool(json, 'has_woocommerce_file'),
        hasOutdatedTemplates: WooJson.readBool(json, 'has_outdated_templates'),
        overrides: _readStringList(json, 'overrides'),
        parentName: WooJson.readString(json, 'parent_name'),
        parentVersion: WooJson.readString(json, 'parent_version'),
        parentAuthorUrl: WooJson.readString(json, 'parent_author_url'),
      );
  factory WooSystemStatusTheme.fake() => WooSystemStatusTheme(
        name: 'Storefront',
        version: '4.2.0',
        versionLatest: '4.2.0',
        authorUrl: FakeHelper.url(),
        isChildTheme: FakeHelper.boolean(),
        hasWooCommerceSupport: FakeHelper.boolean(),
        hasWooCommerceFile: FakeHelper.boolean(),
        hasOutdatedTemplates: FakeHelper.boolean(),
        overrides: FakeHelper.list(() => FakeHelper.word()),
        parentName: 'Storefront',
        parentVersion: '4.2.0',
        parentAuthorUrl: FakeHelper.url(),
      );
  final String? name;
  final String? version;
  final String? versionLatest;
  final String? authorUrl;
  final bool? isChildTheme;
  final bool? hasWooCommerceSupport;
  final bool? hasWooCommerceFile;
  final bool? hasOutdatedTemplates;
  final List<String>? overrides;
  final String? parentName;
  final String? parentVersion;
  final String? parentAuthorUrl;
  Map<String, dynamic> toJson() => <String, dynamic>{}
    ..putIfPresent('name', name)
    ..putIfPresent('version', version)
    ..putIfPresent('version_latest', versionLatest)
    ..putIfPresent('author_url', authorUrl)
    ..putIfPresent('is_child_theme', isChildTheme)
    ..putIfPresent('has_woocommerce_support', hasWooCommerceSupport)
    ..putIfPresent('has_woocommerce_file', hasWooCommerceFile)
    ..putIfPresent('has_outdated_templates', hasOutdatedTemplates)
    ..putIfPresent('overrides', overrides)
    ..putIfPresent('parent_name', parentName)
    ..putIfPresent('parent_version', parentVersion)
    ..putIfPresent('parent_author_url', parentAuthorUrl);
  WooSystemStatusTheme copyWith({
    String? name,
    String? version,
    String? versionLatest,
    String? authorUrl,
    bool? isChildTheme,
    bool? hasWooCommerceSupport,
    bool? hasWooCommerceFile,
    bool? hasOutdatedTemplates,
    List<String>? overrides,
    String? parentName,
    String? parentVersion,
    String? parentAuthorUrl,
  }) =>
      WooSystemStatusTheme(
        name: name ?? this.name,
        version: version ?? this.version,
        versionLatest: versionLatest ?? this.versionLatest,
        authorUrl: authorUrl ?? this.authorUrl,
        isChildTheme: isChildTheme ?? this.isChildTheme,
        hasWooCommerceSupport:
            hasWooCommerceSupport ?? this.hasWooCommerceSupport,
        hasWooCommerceFile: hasWooCommerceFile ?? this.hasWooCommerceFile,
        hasOutdatedTemplates: hasOutdatedTemplates ?? this.hasOutdatedTemplates,
        overrides: overrides ?? this.overrides,
        parentName: parentName ?? this.parentName,
        parentVersion: parentVersion ?? this.parentVersion,
        parentAuthorUrl: parentAuthorUrl ?? this.parentAuthorUrl,
      );
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is WooSystemStatusTheme &&
        other.name == name &&
        other.version == version &&
        other.versionLatest == versionLatest &&
        other.authorUrl == authorUrl &&
        other.isChildTheme == isChildTheme &&
        other.hasWooCommerceSupport == hasWooCommerceSupport &&
        other.hasWooCommerceFile == hasWooCommerceFile &&
        other.hasOutdatedTemplates == hasOutdatedTemplates &&
        WooJson.listEquals(other.overrides, overrides) &&
        other.parentName == parentName &&
        other.parentVersion == parentVersion &&
        other.parentAuthorUrl == parentAuthorUrl;
  }

  @override
  int get hashCode => Object.hashAll([
        name,
        version,
        versionLatest,
        authorUrl,
        isChildTheme,
        hasWooCommerceSupport,
        hasWooCommerceFile,
        hasOutdatedTemplates,
        Object.hashAll(overrides ?? const []),
        parentName,
        parentVersion,
        parentAuthorUrl,
      ]);
  @override
  String toString() => 'WooSystemStatusTheme(name: $name, version: $version)';
  static List<String>? _readStringList(Map<String, dynamic> json, String key) {
    final value = json[key];
    if (value is! List) return null;
    return [for (final element in value) element.toString()];
  }
}
