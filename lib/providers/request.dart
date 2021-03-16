import 'package:yonomi_platform_sdk/request/request.dart';

class YoRequestCreator {
  static Request request() {
    return Request(
        'https://dhapuogzxl.execute-api.us-east-1.amazonaws.com/stg/graphql', {
      'Authorization':
          'Bearer eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIzODExYzMxNS1kMGM0LTQ4YTEtOWQwZi04NzdkMjIyYzk1NTYiLCJpc3MiOiIzYWE5NTFlYi0yZDFhLTQ0Y2EtOWZhMi1iZWM2M2Y4ODFjNjUiLCJpYXQiOjE2MTU5MDMzNjksImV4cCI6MTYxNTk4OTc2OX0.OEmuf4yrTmbx2P-WDOJC1Mvo7-MMhbXdYbCeuOgxOpIUIAb1p-JAlfvCmlq2WsysPtzGl9TJd0dmG3l0z-fq9TRDm7dhXhUxmmpJ9eZwhndLCXTb_b5SYtSaUTCUhxj9ioxh5gG3SuMmzlyKA72BxrDllsstBnxPxdDNDzKzPpTTRHsKepPdxB3ifxtXpcsmGguzYsH4N7t9ixvI0yjEifkuzVWRECq56qJ5-VMQpw90zxjSzsp1RY3-uUu84cvKd4ISkmJNUxj5fUOv4hf5gEMYP_LhmqujEdvAfIAUYlE7dV5KIwUwk7f2q09sCKZe-UG09doGMLiCK4acyEVH9g'
    });
  }
}
