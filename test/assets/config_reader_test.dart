import 'package:flutter_test/flutter_test.dart';
import 'package:yonomi_flutter_demo/assets/config_reader.dart';

void main() {
  test('create token creates correct token', () async {
    TestWidgetsFlutterBinding.ensureInitialized();
    final testConfigMap = await Config.readFromConfigFile();
    expect(testConfigMap[Config.PRIVATE_KEY].length, isPositive);
    expect(testConfigMap[Config.TENANT_ID].length, isPositive);
    expect(testConfigMap[Config.URL].length, isPositive);
  });
}
