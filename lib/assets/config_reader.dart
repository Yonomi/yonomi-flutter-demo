import 'dart:collection';

import 'package:flutter/services.dart' show rootBundle;
import 'package:yaml/yaml.dart';

/// Make sure you have the following files in your `assets/` folder:
/// ```
/// assets/config.yaml
/// assets/.env
/// ```
///
/// `config.yaml` should have the following variable:
/// ```
/// URL: <YOUR GRAPHQL ENDPOINT URL GOES HERE>
/// ```
///
/// `.env` should have the following variables:
/// ```
/// DOMAIN: <REPLACE WITH YOUR DOMAIN HERE>
/// CLIENT_ID: <REPLACE WITH YOUR CLIENT ID HERE>
/// AUDIENCE: <REPLACE WITH YOUR Audience HERE>
/// OAUTH_CALLBACK_URL: <REPLACE WITH YOUR OAUTH CALLBACK URL>
/// ```
class Config {
  static const String _CONFIG_FILE_NAME = 'assets/config.yaml';
  static const String _ENV_FILENAME = 'assets/.env';

  Future<String>? _envFileString;
  Future<String>? _configFileString;

  static const String DOMAIN = 'DOMAIN';
  static const String CLIENT_ID = 'CLIENT_ID';
  static const String AUDIENCE = 'AUDIENCE';
  static const String OAUTH_CALLBACK_URL = 'OAUTH_CALLBACK_URL';

  static const String URL = 'URL';
  static final _objectMap = HashMap();

  Config._({required envFileName, required configFileName}) {
    _envFileString = rootBundle.loadString(envFileName);
    _configFileString = rootBundle.loadString(configFileName);
  }

  factory Config.fromFileName(
      {required String envFileName, required String configFileName}) {
    if (_objectMap.isEmpty) {
      final config =
          Config._(envFileName: envFileName, configFileName: configFileName);
      _objectMap[configFileName + envFileName] = config;
      return config;
    }

    if (_objectMap.length > 1) {
      _objectMap.clear();
      return _addAndReturnConfig(configFileName, envFileName, _objectMap);
    }

    final existingConfig = _objectMap[configFileName + envFileName];
    if (existingConfig == null) {
      _objectMap.clear();
      return _addAndReturnConfig(configFileName, envFileName, _objectMap);
    }

    return existingConfig;
  }

  static Config _addAndReturnConfig(envFileName, configFileName, objectMap) {
    final config =
        Config._(envFileName: envFileName, configFileName: configFileName);
    objectMap[configFileName + envFileName] = config;
    return config;
  }

  static Future<Map> readFromConfigFile(
      {String envFileName = _ENV_FILENAME,
      String configFileName = _CONFIG_FILE_NAME}) async {
    final config = Config.fromFileName(
        envFileName: envFileName, configFileName: configFileName);
    final envFileString = await config._envFileString!;

    final configFileString = await config._configFileString!;

    final envYaml = loadYaml(envFileString);
    final configYaml = loadYaml(configFileString);
    final configMap = HashMap();

    configMap[URL] = configYaml[URL];

    configMap[DOMAIN] = envYaml[DOMAIN];
    configMap[CLIENT_ID] = envYaml[CLIENT_ID];
    configMap[AUDIENCE] = envYaml[AUDIENCE] ?? '';
    configMap[OAUTH_CALLBACK_URL] = envYaml[OAUTH_CALLBACK_URL];

    return configMap;
  }
}
