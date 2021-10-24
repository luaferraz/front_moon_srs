enum Environment { LOCAL, DEV, PROD }

class AppConfig {
  static late Map<String, dynamic> _config;

  static void setEnvironment(Environment env) {
    switch (env) {
      case Environment.LOCAL:
        _config = _Config.localConfig;
        break;
      case Environment.DEV:
        _config = _Config.devConfig;
        break;
      case Environment.PROD:
        _config = _Config.prodConstants;
        break;
    }
  }

  static get baseUrl {
    return _config["baseUrl"];
  }

  // static get androidAppId {
  //   return _config["androidAppId"];
  // }

  // static get iosAppId {
  //   return _config["iosAppId"];
  // }

  // static get digitalOcean {
  //   return _config["digitalOcean"];
  // }

  // static get WHERE_AM_I {
  //   return _config["WHERE_AM_I"];
  // }
}

class _Config {
  // static const WHERE_AM_I = "WHERE_AM_I";
  //
  // static final baseUrl = "baseUrl";
  // static final androidAppId = "androidAppId";
  // static final iosAppId = "iosAppId";
  // static final digitalOcean = "digitalOcean";

  static Map<String, dynamic> localConfig = {
    "baseUrl": "https://localhost:5001/api",
    // "androidAppId": "com.letsranking.lets_mobile",
    // "iosAppId": "1548378164",
    // "digitalOcean": {
    //   "publicUrl": "https://lets-storage.nyc3.digitaloceanspaces.com/",
    //   "region": "nyc3",
    //   "bucket": "lets-storage",
    //   "accessKey": "KLB5Z7FHBI2A6WRRCIXW",
    //   "secretKey": "JLEZgdb8b2YXssw+izGgc7kSabhDcw0GTsU4uTtTVYQ",
    // },

    "WHERE_AM_I": "local"
  };

  static Map<String, dynamic> devConfig = {
    // "baseUrl": "http://devapi.letsranking.com",
    // "androidAppId": "com.letsranking.lets_mobile",
    // "iosAppId": "1548378164",
    // "digitalOcean": {
    //   "publicUrl": "https://lets-storage.nyc3.digitaloceanspaces.com/",
    //   "region": "nyc3",
    //   "bucket": "lets-storage",
    //   "accessKey": "KLB5Z7FHBI2A6WRRCIXW",
    //   "secretKey": "JLEZgdb8b2YXssw+izGgc7kSabhDcw0GTsU4uTtTVYQ",
    // },
    // "WHERE_AM_I": "dev"
  };

  static Map<String, dynamic> prodConstants = {
    // "baseUrl": "https://api.letsranking.com",
    // "androidAppId": "com.letsranking.lets_mobile",
    // "iosAppId": "1548378164",
    // "digitalOcean": {
    //   "publicUrl": "https://lets-storage.nyc3.digitaloceanspaces.com/",
    //   "region": "nyc3",
    //   "bucket": "lets-storage",
    //   "accessKey": "KLB5Z7FHBI2A6WRRCIXW",
    //   "secretKey": "JLEZgdb8b2YXssw+izGgc7kSabhDcw0GTsU4uTtTVYQ",
    // },
    // "WHERE_AM_I": ""
  };
}
