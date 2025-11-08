import 'package:woocommerce_flutter_api/src/helpers/fake_helper.dart';

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

  factory WooSystemStatusTheme.fromJson(Map<String, dynamic> json) => WooSystemStatusTheme(
    name: json['name'],
    version: json['version'],
    versionLatest: json['version_latest'],
    authorUrl: json['author_url'],
    isChildTheme: json['is_child_theme'],
    hasWooCommerceSupport: json['has_woocommerce_support'],
    hasWooCommerceFile: json['has_woocommerce_file'],
    hasOutdatedTemplates: json['has_outdated_templates'],
    overrides: json['overrides'] != null 
        ? List<String>.from(json['overrides']) 
        : null,
    parentName: json['parent_name'],
    parentVersion: json['parent_version'],
    parentAuthorUrl: json['parent_author_url'],
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

  Map<String, dynamic> toJson() => {
    'name': name,
    'version': version,
    'version_latest': versionLatest,
    'author_url': authorUrl,
    'is_child_theme': isChildTheme,
    'has_woocommerce_support': hasWooCommerceSupport,
    'has_woocommerce_file': hasWooCommerceFile,
    'has_outdated_templates': hasOutdatedTemplates,
    'overrides': overrides,
    'parent_name': parentName,
    'parent_version': parentVersion,
    'parent_author_url': parentAuthorUrl,
  };
}