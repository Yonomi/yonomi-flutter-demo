import 'package:yonomi_platform_sdk/request/request.dart';

class YoRequestCreator {
  static Request request() {
    return Request(
        'https://dhapuogzxl.execute-api.us-east-1.amazonaws.com/stg/graphql', {
      'Authorization':
          'Bearer eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIzODExYzMxNS1kMGM0LTQ4YTEtOWQwZi04NzdkMjIyYzk1NTYiLCJpc3MiOiIzYWE5NTFlYi0yZDFhLTQ0Y2EtOWZhMi1iZWM2M2Y4ODFjNjUiLCJpYXQiOjE2MTU3NzE1NTcsImV4cCI6MTYxNTg1Nzk1N30.EoD5syUr3rSwBwsTFv3q2N14ILhTzsciUj1OrdOyNeQdflGoU2FBzRcoyLhDIWYMONFA4RxnPZ5uXSvG-baQp1xmn976NSTlOJYMurMsEoqcXanTXBRtN6WehYdwdor-tMOa2rfljY6Ti9rlm9k6XQx4yP2gIlbutaaViGThinHiHsGIhWrjWEHKEfziRqLKuZelsuTW2sJt25qCnhCO1plTVFvgbG-JwHH_nXE7dp2e2aViZIKYEam8nOlOXIHIgV4o16u0xI-Mx_uAtZobnLqaGpOUGwpaiac9ayK0QPOFUFY6cRh_dMMUJ3ANnwC5BeTedg7Nl4qknUDUHQ94lQ'
    });
  }
}
