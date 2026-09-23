import '../../helpers/fake_helper.dart';
import '../../json/woo_json.dart';

class WooSystemStatusEnvironment {
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
  factory WooSystemStatusEnvironment.fromJson(Map<String, dynamic> json) =>
      WooSystemStatusEnvironment(
        homeUrl: WooJson.readString(json, 'home_url'),
        siteUrl: WooJson.readString(json, 'site_url'),
        version: WooJson.readString(json, 'version'),
        logDirectory: WooJson.readString(json, 'log_directory'),
        logDirectoryWritable: WooJson.readBool(json, 'log_directory_writable'),
        wpVersion: WooJson.readString(json, 'wp_version'),
        wpMultisite: WooJson.readBool(json, 'wp_multisite'),
        wpMemoryLimit: WooJson.readInt(json, 'wp_memory_limit'),
        wpDebugMode: WooJson.readBool(json, 'wp_debug_mode'),
        wpCron: WooJson.readBool(json, 'wp_cron'),
        language: WooJson.readString(json, 'language'),
        serverInfo: WooJson.readString(json, 'server_info'),
        phpVersion: WooJson.readString(json, 'php_version'),
        phpPostMaxSize: WooJson.readInt(json, 'php_post_max_size'),
        phpMaxExecutionTime: WooJson.readInt(json, 'php_max_execution_time'),
        phpMaxInputVars: WooJson.readInt(json, 'php_max_input_vars'),
        curlVersion: WooJson.readString(json, 'curl_version'),
        suhosinInstalled: WooJson.readBool(json, 'suhosin_installed'),
        maxUploadSize: WooJson.readInt(json, 'max_upload_size'),
        mysqlVersion: WooJson.readString(json, 'mysql_version'),
        defaultTimezone: WooJson.readString(json, 'default_timezone'),
        fsockOpenOrCurlEnabled:
            WooJson.readBool(json, 'fsockopen_or_curl_enabled'),
        soapClientEnabled: WooJson.readBool(json, 'soapclient_enabled'),
        domDocumentEnabled: WooJson.readBool(json, 'domdocument_enabled'),
        gzipEnabled: WooJson.readBool(json, 'gzip_enabled'),
        mbstringEnabled: WooJson.readBool(json, 'mbstring_enabled'),
        remotePostSuccessful: WooJson.readBool(json, 'remote_post_successful'),
        remotePostResponse: WooJson.readString(json, 'remote_post_response'),
        remoteGetSuccessful: WooJson.readBool(json, 'remote_get_successful'),
        remoteGetResponse: WooJson.readString(json, 'remote_get_response'),
      );
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
  Map<String, dynamic> toJson() => <String, dynamic>{}
    ..putIfPresent('home_url', homeUrl)
    ..putIfPresent('site_url', siteUrl)
    ..putIfPresent('version', version)
    ..putIfPresent('log_directory', logDirectory)
    ..putIfPresent('log_directory_writable', logDirectoryWritable)
    ..putIfPresent('wp_version', wpVersion)
    ..putIfPresent('wp_multisite', wpMultisite)
    ..putIfPresent('wp_memory_limit', wpMemoryLimit)
    ..putIfPresent('wp_debug_mode', wpDebugMode)
    ..putIfPresent('wp_cron', wpCron)
    ..putIfPresent('language', language)
    ..putIfPresent('server_info', serverInfo)
    ..putIfPresent('php_version', phpVersion)
    ..putIfPresent('php_post_max_size', phpPostMaxSize)
    ..putIfPresent('php_max_execution_time', phpMaxExecutionTime)
    ..putIfPresent('php_max_input_vars', phpMaxInputVars)
    ..putIfPresent('curl_version', curlVersion)
    ..putIfPresent('suhosin_installed', suhosinInstalled)
    ..putIfPresent('max_upload_size', maxUploadSize)
    ..putIfPresent('mysql_version', mysqlVersion)
    ..putIfPresent('default_timezone', defaultTimezone)
    ..putIfPresent('fsockopen_or_curl_enabled', fsockOpenOrCurlEnabled)
    ..putIfPresent('soapclient_enabled', soapClientEnabled)
    ..putIfPresent('domdocument_enabled', domDocumentEnabled)
    ..putIfPresent('gzip_enabled', gzipEnabled)
    ..putIfPresent('mbstring_enabled', mbstringEnabled)
    ..putIfPresent('remote_post_successful', remotePostSuccessful)
    ..putIfPresent('remote_post_response', remotePostResponse)
    ..putIfPresent('remote_get_successful', remoteGetSuccessful)
    ..putIfPresent('remote_get_response', remoteGetResponse);
  WooSystemStatusEnvironment copyWith({
    String? homeUrl,
    String? siteUrl,
    String? version,
    String? logDirectory,
    bool? logDirectoryWritable,
    String? wpVersion,
    bool? wpMultisite,
    int? wpMemoryLimit,
    bool? wpDebugMode,
    bool? wpCron,
    String? language,
    String? serverInfo,
    String? phpVersion,
    int? phpPostMaxSize,
    int? phpMaxExecutionTime,
    int? phpMaxInputVars,
    String? curlVersion,
    bool? suhosinInstalled,
    int? maxUploadSize,
    String? mysqlVersion,
    String? defaultTimezone,
    bool? fsockOpenOrCurlEnabled,
    bool? soapClientEnabled,
    bool? domDocumentEnabled,
    bool? gzipEnabled,
    bool? mbstringEnabled,
    bool? remotePostSuccessful,
    String? remotePostResponse,
    bool? remoteGetSuccessful,
    String? remoteGetResponse,
  }) =>
      WooSystemStatusEnvironment(
        homeUrl: homeUrl ?? this.homeUrl,
        siteUrl: siteUrl ?? this.siteUrl,
        version: version ?? this.version,
        logDirectory: logDirectory ?? this.logDirectory,
        logDirectoryWritable: logDirectoryWritable ?? this.logDirectoryWritable,
        wpVersion: wpVersion ?? this.wpVersion,
        wpMultisite: wpMultisite ?? this.wpMultisite,
        wpMemoryLimit: wpMemoryLimit ?? this.wpMemoryLimit,
        wpDebugMode: wpDebugMode ?? this.wpDebugMode,
        wpCron: wpCron ?? this.wpCron,
        language: language ?? this.language,
        serverInfo: serverInfo ?? this.serverInfo,
        phpVersion: phpVersion ?? this.phpVersion,
        phpPostMaxSize: phpPostMaxSize ?? this.phpPostMaxSize,
        phpMaxExecutionTime: phpMaxExecutionTime ?? this.phpMaxExecutionTime,
        phpMaxInputVars: phpMaxInputVars ?? this.phpMaxInputVars,
        curlVersion: curlVersion ?? this.curlVersion,
        suhosinInstalled: suhosinInstalled ?? this.suhosinInstalled,
        maxUploadSize: maxUploadSize ?? this.maxUploadSize,
        mysqlVersion: mysqlVersion ?? this.mysqlVersion,
        defaultTimezone: defaultTimezone ?? this.defaultTimezone,
        fsockOpenOrCurlEnabled:
            fsockOpenOrCurlEnabled ?? this.fsockOpenOrCurlEnabled,
        soapClientEnabled: soapClientEnabled ?? this.soapClientEnabled,
        domDocumentEnabled: domDocumentEnabled ?? this.domDocumentEnabled,
        gzipEnabled: gzipEnabled ?? this.gzipEnabled,
        mbstringEnabled: mbstringEnabled ?? this.mbstringEnabled,
        remotePostSuccessful: remotePostSuccessful ?? this.remotePostSuccessful,
        remotePostResponse: remotePostResponse ?? this.remotePostResponse,
        remoteGetSuccessful: remoteGetSuccessful ?? this.remoteGetSuccessful,
        remoteGetResponse: remoteGetResponse ?? this.remoteGetResponse,
      );
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is WooSystemStatusEnvironment &&
        other.homeUrl == homeUrl &&
        other.siteUrl == siteUrl &&
        other.version == version &&
        other.logDirectory == logDirectory &&
        other.logDirectoryWritable == logDirectoryWritable &&
        other.wpVersion == wpVersion &&
        other.wpMultisite == wpMultisite &&
        other.wpMemoryLimit == wpMemoryLimit &&
        other.wpDebugMode == wpDebugMode &&
        other.wpCron == wpCron &&
        other.language == language &&
        other.serverInfo == serverInfo &&
        other.phpVersion == phpVersion &&
        other.phpPostMaxSize == phpPostMaxSize &&
        other.phpMaxExecutionTime == phpMaxExecutionTime &&
        other.phpMaxInputVars == phpMaxInputVars &&
        other.curlVersion == curlVersion &&
        other.suhosinInstalled == suhosinInstalled &&
        other.maxUploadSize == maxUploadSize &&
        other.mysqlVersion == mysqlVersion &&
        other.defaultTimezone == defaultTimezone &&
        other.fsockOpenOrCurlEnabled == fsockOpenOrCurlEnabled &&
        other.soapClientEnabled == soapClientEnabled &&
        other.domDocumentEnabled == domDocumentEnabled &&
        other.gzipEnabled == gzipEnabled &&
        other.mbstringEnabled == mbstringEnabled &&
        other.remotePostSuccessful == remotePostSuccessful &&
        other.remotePostResponse == remotePostResponse &&
        other.remoteGetSuccessful == remoteGetSuccessful &&
        other.remoteGetResponse == remoteGetResponse;
  }

  @override
  int get hashCode => Object.hashAll([
        homeUrl,
        siteUrl,
        version,
        logDirectory,
        logDirectoryWritable,
        wpVersion,
        wpMultisite,
        wpMemoryLimit,
        wpDebugMode,
        wpCron,
        language,
        serverInfo,
        phpVersion,
        phpPostMaxSize,
        phpMaxExecutionTime,
        phpMaxInputVars,
        curlVersion,
        suhosinInstalled,
        maxUploadSize,
        mysqlVersion,
        defaultTimezone,
        fsockOpenOrCurlEnabled,
        soapClientEnabled,
        domDocumentEnabled,
        gzipEnabled,
        mbstringEnabled,
        remotePostSuccessful,
        remotePostResponse,
        remoteGetSuccessful,
        remoteGetResponse,
      ]);
  @override
  String toString() => 'WooSystemStatusEnvironment(phpVersion: $phpVersion, '
      'wpVersion: $wpVersion)';
}
