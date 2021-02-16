import 'package:yonomi_platform_sdk/request/request.dart';

class YoRequestFactory {
  static Request request() {
    return Request(
        'https://dhapuogzxl.execute-api.us-east-1.amazonaws.com/stg/graphql', {
      'Authorization':
          'Bearer eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI4OWI3NTYyYi1hMDNmLTQ1YmEtODc5My03NGM5MTg4OTFlYTUiLCJpc3MiOiIwM2U3MTBjYy1kN2RjLTQ2YmMtYmUyMi1hYzYxNjE0YTVjMTIiLCJpYXQiOjE2MTM0OTc4NjAsImV4cCI6MTYxMzU4NDI2MH0.fJ2cUIm4m_a1q_ecmdli_cHvnyyqdgCGdwWZftp_OZHJimotHuDk3qjg0PVemUxDeJEpToSWfHvH6R087jpom_L0eEyIJU8_wgOLJfxu9xMOwRtat_7tagFMb_oXzXTXa67vLf1xcNv0WR3nV6bsdQ6JTJx_IBQGnveADIcmExWfpSjt2qMtEcQUcULz5oG3xdLxXteHbVcFYh5a2isK4ngIIPR-i-EWoLQONSzI-uwPvof9tpTkSH3v1sx7YMQ_PHxUJl_tDN0s5jshnJZiL_x0y7fdWWM-O1UvvbPO1zQbNg8-jIQjBgxlJKCqs4Dh-ateh5dubrICWR34XQcSXg'
    });
  }
}
