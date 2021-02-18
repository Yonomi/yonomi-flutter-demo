import 'package:yonomi_platform_sdk/request/request.dart';

class YoRequestFactory {
  static Request request() {
    return Request(
        'https://dhapuogzxl.execute-api.us-east-1.amazonaws.com/stg/graphql', {
      'Authorization':
          'Bearer eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI4OWI3NTYyYi1hMDNmLTQ1YmEtODc5My03NGM5MTg4OTFlYTUiLCJpc3MiOiIwM2U3MTBjYy1kN2RjLTQ2YmMtYmUyMi1hYzYxNjE0YTVjMTIiLCJpYXQiOjE2MTM2NzkwMDcsImV4cCI6MTYxMzc2NTQwN30.i8Wj0OK9bzc2huNSMNw8I4iQLHqGlcSbRF0pX-dr7fcb5plxdvdaO-nQNt6J7Z0XxPucloqW5iej3gqWCSo36bue_y-EBFABD91F8BstQxdOVZyibiiv9rfamulcufwtPUWJzHmhB1bEwWz_ETWi3EJaLNeUN06oJHhZnCZ2XYnPwUaQllDimb_tUQVF_EKw_SVU9qY1TDp_zcqx4-P4OGPuzyCspmf_alzgMtxCZQdJzID-Iq52n8KeVSDU2FYiOpvz_EPQRawpzHYv1pwwACH4_EXEB89X1lcSCtHlskhATyTdrSgVT0KU-O5WQ_DkpgJIlEOriWH5Ze2U03RW8A'
    });
  }
}
