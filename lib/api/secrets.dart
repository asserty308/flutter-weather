import 'dart:async' show Future;
import 'dart:convert' show json;
import 'package:flutter/services.dart' show rootBundle;

class Secrets {
  final String googleApiKey;
  final String owmApiKey;

  Secrets({
    this.googleApiKey = "",
    this.owmApiKey = ""
  });

  factory Secrets.fromJson(Map<String, dynamic> jsonMap) {
    return new Secrets(
      googleApiKey: jsonMap["google_api_key"],
      owmApiKey: jsonMap["owm_api_key"]
    );
  }
}

class SecretsLoader {
  final String secretsPath;

  SecretsLoader({this.secretsPath});

  Future<Secrets> load() {
    return rootBundle.loadStructuredData<Secrets>(this.secretsPath, (jsonStr) async {
      final secret = Secrets.fromJson(json.decode(jsonStr));
      return secret;
    });
  }
}