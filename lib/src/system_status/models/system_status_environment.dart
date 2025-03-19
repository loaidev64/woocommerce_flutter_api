import 'package:woocommerce_flutter_api/src/helpers/fake_helper.dart';

class WooSystemStatusEnvironment {
  final String? homeUrl;
  final String? siteUrl;
  final String? version;
  final String? logDirectory;
  final bool? logDirectoryWritable;
  final String? wpVersion;
  final bool? wpMultisite;
  final int? wpMemoryLimit;
  final bool? wpDebugMode;
  final bool? wpCron;
  final String? language;
  final String? serverInfo;
  final String? phpVersion;
  final int? phpPostMaxSize;
  final int? phpMaxExecutionTime;
  final int? phpMaxInputVars;
  final String? curlVersion;
  final bool? suhosinInstalled;
  final int? maxUploadSize;
  final String? mysqlVersion;
  final String? defaultTimezone;
  final bool? fsockOpenOrCurlEnabled;
  final bool? soapClientEnabled;
  final bool? domDocumentEnabled;
  final bool? gzipEnabled;
  final bool? mbstringEnabled;
  final bool? remotePostSuccessful;
  final String? remotePostResponse;
  final bool? remoteGetSuccessful;
  final String? remoteGetResponse;

  WooSystemStatusEnvironment({
    this.homeUrl,
    this.siteUrl,
    this.version,
    this.logDirectory,
    this.logDirectoryWritable,
    this.wpVersion,
    this.wpMultisite,
    this.wpMemoryLimit,
    this.wpDebugMode,
    this.wpCron,
    this.language,
    this.serverInfo,
    this.phpVersion,
    this.phpPostMaxSize,
    this.phpMaxExecutionTime,
    this.phpMaxInputVars,
    this.curlVersion,
    this.suhosinInstalled,
    this.maxUploadSize,
    this.mysqlVersion,
    this.defaultTimezone,
    this.fsockOpenOrCurlEnabled,
    this.soapClientEnabled,
    this.domDocumentEnabled,
    this.gzipEnabled,
    this.mbstringEnabled,
    this.remotePostSuccessful,
    this.remotePostResponse,
    this.remoteGetSuccessful,
    this.remoteGetResponse,
  });

  factory WooSystemStatusEnvironment.fromJson(Map<String, dynamic> json) => WooSystemStatusEnvironment(
    homeUrl: json['home_url'],
    siteUrl: json['site_url'],
    version: json['version'],
    logDirectory: json['log_directory'],
    logDirectoryWritable: json['log_directory_writable'],
    wpVersion: json['wp_version'],
    wpMultisite: json['wp_multisite'],
    wpMemoryLimit: json['wp_memory_limit'],
    wpDebugMode: json['wp_debug_mode'],
    wpCron: json['wp_cron'],
    language: json['language'],
    serverInfo: json['server_info'],
    phpVersion: json['php_version'],
    phpPostMaxSize: json['php_post_max_size'],
    phpMaxExecutionTime: json['php_max_execution_time'],
    phpMaxInputVars: json['php_max_input_vars'],
    curlVersion: json['curl_version'],
    suhosinInstalled: json['suhosin_installed'],
    maxUploadSize: json['max_upload_size'],
    mysqlVersion: json['mysql_version'],
    defaultTimezone: json['default_timezone'],
    fsockOpenOrCurlEnabled: json['fsockopen_or_curl_enabled'],
    soapClientEnabled: json['soapclient_enabled'],
    domDocumentEnabled: json['domdocument_enabled'],
    gzipEnabled: json['gzip_enabled'],
    mbstringEnabled: json['mbstring_enabled'],
    remotePostSuccessful: json['remote_post_successful'],
    remotePostResponse: json['remote_post_response'],
    remoteGetSuccessful: json['remote_get_successful'],
    remoteGetResponse: json['remote_get_response'],
  );

  Map<String, dynamic> toJson() => {
    'home_url': homeUrl,
    'site_url': siteUrl,
    'version': version,
    'log_directory': logDirectory,
    'log_directory_writable': logDirectoryWritable,
    'wp_version': wpVersion,
    'wp_multisite': wpMultisite,
    'wp_memory_limit': wpMemoryLimit,
    'wp_debug_mode': wpDebugMode,
    'wp_cron': wpCron,
    'language': language,
    'server_info': serverInfo,
    'php_version': phpVersion,
    'php_post_max_size': phpPostMaxSize,
    'php_max_execution_time': phpMaxExecutionTime,
    'php_max_input_vars': phpMaxInputVars,
    'curl_version': curlVersion,
    'suhosin_installed': suhosinInstalled,
    'max_upload_size': maxUploadSize,
    'mysql_version': mysqlVersion,
    'default_timezone': defaultTimezone,
    'fsockopen_or_curl_enabled': fsockOpenOrCurlEnabled,
    'soapclient_enabled': soapClientEnabled,
    'domdocument_enabled': domDocumentEnabled,
    'gzip_enabled': gzipEnabled,
    'mbstring_enabled': mbstringEnabled,
    'remote_post_successful': remotePostSuccessful,
    'remote_post_response': remotePostResponse,
    'remote_get_successful': remoteGetSuccessful,
    'remote_get_response': remoteGetResponse,
  };

  factory WooSystemStatusEnvironment.fake() => WooSystemStatusEnvironment(
    homeUrl: FakeHelper.url(),
    siteUrl: FakeHelper.url(),
    version: '7.4.0',
    logDirectory: '/var/www/html/wp-content/uploads/wc-logs/',
    logDirectoryWritable: FakeHelper.boolean(),
    wpVersion: '6.2.2',
    wpMultisite: FakeHelper.boolean(),
    wpMemoryLimit: 256,
    wpDebugMode: FakeHelper.boolean(),
    wpCron: FakeHelper.boolean(),
    language: 'en_US',
    serverInfo: 'Apache/2.4.41 (Ubuntu)',
    phpVersion: '8.1.10',
    phpPostMaxSize: 8,
    phpMaxExecutionTime: 30,
    phpMaxInputVars: 1000,
    curlVersion: '7.68.0',
    suhosinInstalled: FakeHelper.boolean(),
    maxUploadSize: 8,
    mysqlVersion: '8.0.30',
    defaultTimezone: 'UTC',
    fsockOpenOrCurlEnabled: FakeHelper.boolean(),
    soapClientEnabled: FakeHelper.boolean(),
    domDocumentEnabled: FakeHelper.boolean(),
    gzipEnabled: FakeHelper.boolean(),
    mbstringEnabled: FakeHelper.boolean(),
    remotePostSuccessful: FakeHelper.boolean(),
    remotePostResponse: FakeHelper.sentence(),
    remoteGetSuccessful: FakeHelper.boolean(),
    remoteGetResponse: FakeHelper.sentence(),
  );
}