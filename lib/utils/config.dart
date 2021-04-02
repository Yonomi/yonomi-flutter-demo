import 'package:flutter/services.dart';
import 'package:yaml/yaml.dart';

// Utility class to read config variables from the assets directory, i.e.:
//    "assets/yonomi.yaml"
//
// The structure of the file is:
//    tenant_id: "my-tenant-id"
//    graph_endpoint: "my-graph-endpoint"
//
// Example usage:
//    var tenantId = Config().tenantId
//    var graphEndpoint = Config().graphEndpoint
//
class Config {
  String _endpoint;

  String _tenantId;

  static const String _configFileName = "yonomi.yaml";

  static final Config _instance = Config._privateConstructor();

  factory Config() {
    return _instance;
  }

  Config._privateConstructor() {
    loadConfigFile();
  }

  Future<void> loadConfigFile() {
    rootBundle.loadString("assets/${_configFileName}").then((myYaml) {
      var configMap = loadYaml(myYaml);

      _instance.tenantId = configMap["tenant_id"];
      _instance.graphEndpoint = configMap["graph_endpoint"];
    });
  }

  String get tenantId => _tenantId;
  void set tenantId(String tenantId) {
    this._tenantId = tenantId;
  }

  String get graphEndpoint => _endpoint;
  void set graphEndpoint(String endpoint) {
    this._endpoint = endpoint;
  }
}
