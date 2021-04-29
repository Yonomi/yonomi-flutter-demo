import 'dart:collection';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:yaml/yaml.dart';

class Config {
  static const String _CONFIG_FILE_NAME = 'assets/config.yaml';
  static const String _ENV_FILENAME = 'assets/.env';

  Future<String> _envFileString;
  Future<String> _configFileString;
  static const String PRIVATE_KEY = 'PRIVATE_KEY';
  static const String TENANT_ID = 'TENANT_ID';
  static const String URL = 'URL';
  static final _objectMap = HashMap();

  Config._({@required envFileName, @required configFileName}) {
    _envFileString = rootBundle.loadString(envFileName);
    _configFileString = rootBundle.loadString(configFileName);
  }

  factory Config.fromFileName(
      {@required envFileName, @required configFileName}) {
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
      {envFileName = _ENV_FILENAME, configFileName = _CONFIG_FILE_NAME}) async {
    final config = Config.fromFileName(
        envFileName: envFileName, configFileName: configFileName);
    final envFileString = await config._envFileString;

    final configFileString = await config._configFileString;

    final envYaml = loadYaml(envFileString);
    final configYaml = loadYaml(configFileString);
    final configMap = HashMap();
    configMap[PRIVATE_KEY] = utf8.decode(base64.decode(envYaml[PRIVATE_KEY]));

    configMap[TENANT_ID] = envYaml[TENANT_ID];
    configMap[URL] = configYaml[URL];
    return configMap;
  }
}
