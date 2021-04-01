import 'package:yonomi_platform_sdk/request/request.dart';

class YoRequestCreator {
  static String endpoint = "https://platform-stg.yonomi.cloud/graphql";

  static String token =
      "Bearer eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIzODExYzMxNS1kMGM0LTQ4YTEtOWQwZi04NzdkMjIyYzk1NTYiLCJpc3MiOiIzYWE5NTFlYi0yZDFhLTQ0Y2EtOWZhMi1iZWM2M2Y4ODFjNjUiLCJpYXQiOjE2MTY3MDExMDUsImV4cCI6MTYxNjc4NzUwNX0.N3MfYR_JsfXAlOE5NJG1QsJSB0_UMnrp8gFMO_LZo-vVpi8ICqjjq4Ys0AhQWWyPJdc0rTDeN__lbQw6fNc_xO42pRnWMVMrdTKDARIpnIcRcgD71zin4Zbhi41VOqiM7UkjQXjlZ_Pgvq4qLZE6DMQ8pYJfYw-h6WFRMZ6Dxas3ekxNi0JxB_GUiD_67wy9y9keqqyD-Br_Dc0KU6DmwV2lDBiKVCEcOGVMDbR72ryi8JKgV7wPOjDZlcs2bMESwI_4hQ6KgbHV8Ayw4-AQqW72rcC3jUsAkcaryzlRsWLiu2wML8XonSTo_U7vDMCluhn86JzLMdcYe6D9QVHBBQ";

  static Request request() {
    return Request(endpoint, {'Authorization': 'Bearer ${token}'});
  }
}
