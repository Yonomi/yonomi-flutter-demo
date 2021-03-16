import 'package:yonomi_platform_sdk/request/request.dart';

class YoRequestCreator {
  static Request request() {
    return Request(
        'https://dhapuogzxl.execute-api.us-east-1.amazonaws.com/stg/graphql', {
      'Authorization':
          'Bearer eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIzODExYzMxNS1kMGM0LTQ4YTEtOWQwZi04NzdkMjIyYzk1NTYiLCJpc3MiOiIzYWE5NTFlYi0yZDFhLTQ0Y2EtOWZhMi1iZWM2M2Y4ODFjNjUiLCJpYXQiOjE2MTU4NDM3MjYsImV4cCI6MTYxNTkzMDEyNn0.F601SvtdD7wP553ZCAjYsgmdBOs5PMBT_9qXXTqEhaLMmiv2mDNatyHSBoCfjFAW0m5yViU8-Y4r21kKtu9-TGWXou4mpp_uKOgiu_An9rdZJlph6N_OGBA0xia7MmXL0_s9sqnq5-wyknsJILlreb5dsJbSUY5qkhQsWS3PwJxDnNDpOr79R5VGD7OSSG8TShdA2J4zUpim_SdpHy5Ho_0jHHYzVvSOMZQ3xh_alOpuFTUWuM01u51T6gm7Om9mWgT2nJ4i9bFSENUrEnVKP1WFM9toAorWWJHJQ6swOjkWw_9YvVIZDPmpMlbeaUQSftSeKhg69CXxUoDu0KY7mQ'
    });
  }
}
