enum Flavor { DEV, TEST, QAS, PROD }

class EnvConfig {
  String appKey;
  String appName;
  String appVersion;
  String databaseName;
  String baseUrl;
  String tweetApiKey;
  String tweetApiKeySecret;
  String tweetBearerToken;
  String mapBoxKey;
  int connectTimeOut;
  int receiveTimeout;
  String wavePubKey;
  String waveEncryptKey;
  String waveSecretKey;
  String yocoPubKey;
  String yocoSecretKey;

  EnvConfig(
      {this.appKey,
      this.appName,
      this.appVersion,
      this.baseUrl,
      this.connectTimeOut,
      this.receiveTimeout,
      this.databaseName,
      this.tweetApiKey,
      this.tweetApiKeySecret,
      this.tweetBearerToken,
      this.mapBoxKey,
      this.wavePubKey,
      this.waveEncryptKey,
      this.waveSecretKey,
      this.yocoPubKey,
      this.yocoSecretKey});

  factory EnvConfig.fromJson(Map<String, dynamic> json) => EnvConfig(
        appKey: json['appKey'] as String,
        appName: json['appName'] as String,
        appVersion: json['appVersion'] as String,
        baseUrl: json['baseUrl'] as String,
        connectTimeOut: json['connectTimeOut'] as int,
        receiveTimeout: json['receiveTimeout'] as int,
        databaseName: json['databaseName'],
        tweetApiKey: json['tweetKey'],
        tweetApiKeySecret: json['tweetKeySecret'],
        tweetBearerToken: json['tweetBearerToken'],
        mapBoxKey: json['mapBoxKey'],
        wavePubKey: json['wavePubKey'],
        waveEncryptKey: json['waveEncryptKey'],
        waveSecretKey: json['waveSecretKey'],
        yocoPubKey: json['yocoPubKey'],
        yocoSecretKey: json['yocoSecretKey'],
      );
}
