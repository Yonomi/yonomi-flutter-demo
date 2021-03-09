import 'package:yonomi_platform_sdk/request/request.dart';

class YoRequestFactory {
  static Request request() {
    return Request(
        'https://dhapuogzxl.execute-api.us-east-1.amazonaws.com/stg/graphql', {
      'Authorization':
          'Bearer eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI4OWI3NTYyYi1hMDNmLTQ1YmEtODc5My03NGM5MTg4OTFlYTUiLCJpc3MiOiIwM2U3MTBjYy1kN2RjLTQ2YmMtYmUyMi1hYzYxNjE0YTVjMTIiLCJpYXQiOjE2MTUyOTY4MTksImV4cCI6MTYxNTM4MzIxOX0.IjeZYynkcZvx6NYPl5FaMIL6r9Hs6jL-MSPHtq_txHoodG6elMLCoPhWw1jSeHwfbiwc-pdit7TFyFEJRlKVw4GemxhXTOS0Z8Q6GSbip2urJFq-b0lYltMlulXp4qxPZSKK0fJnT0zJH2ZWxPPG1Cc_iLB8witRZ-fmLl88sFwntb6brZHsAT7R_LnuYCg2rLFHNY4Rsvg7j6JneQ8wJxBqc4hRGOTn-9JoIZr3WGYgfembsbcSh__ZHG-Z67We2PlrUJ24pMYTOzoIGs6axglSyFDunhUraJMbaccD_5sF_hXmCkuVG6Glyc9RmSo4B8Kg0S_O58q8enL83l06dw'
    });
  }
}
