enum Flavor { DEV, TEST, QAS, PROD }

class EnvConfig {
  String appKey;
  String appName;
  String appVersion;
  String databaseName;
  String baseUrl;
  String googleAuthUrl;
  String firebaseAuthId;
  String tweetApiKey;
  String tweetApiKeySecret;
  String tweetBearerToken;
  int connectTimeOut;
  int receiveTimeout;

  EnvConfig(
      {this.appKey,
      this.appName,
      this.appVersion,
      this.baseUrl,
      this.connectTimeOut,
      this.receiveTimeout,
      this.databaseName,
      this.googleAuthUrl,
      this.firebaseAuthId,
      this.tweetApiKey,
      this.tweetApiKeySecret,
      this.tweetBearerToken});

  factory EnvConfig.fromJson(Map<String, dynamic> json) => EnvConfig(
      appKey: json['appKey'] as String,
      appName: json['appName'] as String,
      appVersion: json['appVersion'] as String,
      baseUrl: json['baseUrl'] as String,
      connectTimeOut: json['connectTimeOut'] as int,
      receiveTimeout: json['receiveTimeout'] as int,
      googleAuthUrl: json['googleAuthUrl'],
      firebaseAuthId: json['firebaseId'],
      databaseName: json['databaseName'],
      tweetApiKey: json['tweetKey'],
      tweetApiKeySecret: json['tweetKeySecret'],
      tweetBearerToken: json['tweetBearerToken']);

  Map<String, dynamic> toJson() {
    return {
      "appKey": this.appKey,
      "appName": this.appName,
      "appVersion": this.appVersion,
      "databaseName": this.databaseName,
      "baseUrl": this.baseUrl,
      "connectTimeOut": this.connectTimeOut,
      "receiveTimeout": this.receiveTimeout,
      "googleAuth": this.googleAuthUrl,
      "firebaseAuthId": this.firebaseAuthId,
    };
  }
}
