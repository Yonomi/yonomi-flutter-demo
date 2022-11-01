import 'package:flutter_test/flutter_test.dart';
import 'package:yonomi_flutter_demo/assets/config_reader.dart';

void main() {
  test('ConfigReader reads fields correctly', () async {
    TestWidgetsFlutterBinding.ensureInitialized();
    var testConfigMap = await Config.readFromConfigFile();
    expect(testConfigMap[Config.DOMAIN].length, isPositive);
    expect(testConfigMap[Config.CLIENT_ID].length, isPositive);
    expect(testConfigMap[Config.OAUTH_CALLBACK_URL].length, isPositive);
    expect(testConfigMap[Config.URL].length, isPositive);
    expect(testConfigMap[Config.AUDIENCE], isEmpty);

    testConfigMap = await Config.readFromConfigFile(
        envFileName: 'assets/.env', configFileName: 'assets/config.yaml');
    expect(testConfigMap[Config.DOMAIN].length, isPositive);
    expect(testConfigMap[Config.CLIENT_ID].length, isPositive);
    expect(testConfigMap[Config.OAUTH_CALLBACK_URL].length, isPositive);
    expect(testConfigMap[Config.URL].length, isPositive);
    expect(testConfigMap[Config.AUDIENCE], isEmpty);
  });
}
