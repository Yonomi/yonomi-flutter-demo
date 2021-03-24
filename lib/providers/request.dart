import 'package:yonomi_platform_sdk/request/request.dart';

class YoRequestCreator {
  static Request request() {
    return Request(
        'https://dhapuogzxl.execute-api.us-east-1.amazonaws.com/stg/graphql', {
      'Authorization':
          'Bearer eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIzODExYzMxNS1kMGM0LTQ4YTEtOWQwZi04NzdkMjIyYzk1NTYiLCJpc3MiOiIzYWE5NTFlYi0yZDFhLTQ0Y2EtOWZhMi1iZWM2M2Y4ODFjNjUiLCJpYXQiOjE2MTY1NTU1MDMsImV4cCI6MTYxNjY0MTkwM30.r_4onHJAQ24KUBBtHSMIKg0ochrs5CF3_LKXHE_-bD0QsFKOhXKXkpCpwfZRGm1AcKrnN_xo2-2SUO1Q5rKetgQ4vGrvZU7eniuJNrfZGXKHDiuCymDS3-3HvjQ8CV2h4irLbwAqt4szw_Sdch4sF3E12SKSCworZIZ4ESCBRfC0HHQYD04EamN_K9fzl3QWaLKWgEK04ezYYgN18i36iXTY-xuEEySPvGirNkhjuoLcQ2WFK0BtB647dqHdJVnIOJHzFlY4-E6vIIOsVDt0jv4nf0vAVb6hMTdLtdGnZvcs61NHdRLP6vyuJodEBaC9ApKXWVH2ihaWW-wwyBM3cA'
    });
  }
}
