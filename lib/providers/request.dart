import 'package:yonomi_platform_sdk/request/request.dart';

class YoRequestFactory {
  static Request request() {
    return Request(
        'https://dhapuogzxl.execute-api.us-east-1.amazonaws.com/stg/graphql', {
      'Authorization':
          'Bearer eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI4OWI3NTYyYi1hMDNmLTQ1YmEtODc5My03NGM5MTg4OTFlYTUiLCJpc3MiOiIwM2U3MTBjYy1kN2RjLTQ2YmMtYmUyMi1hYzYxNjE0YTVjMTIiLCJpYXQiOjE2MTUzMjY5NTgsImV4cCI6MTYxNTQxMzM1OH0.tDnCuhBXvFjTyPqnTg1NoaubY0xs-yo4SqlmyzYBc9Bc4qGabmqkiffso2T3eYhzOChkALvGvX9M2_wbcvMsFXzRVfBlxMQv_qaC5dacaEeZN-mkV33aqTWOm-diVY-h1Z7ku3FrkDtImIoZULb9w2iasA-YVXxJNvZyixkXneY5VzkyqmWv5D64I1qoX---ItO_A6x3qur7aMpgEpu335X2usj1Q78yDdZHqcGHUTFtU89yFy0m8NV-R-9XhEplhEbDKTchpsxTaIUwa1OoWKZAdYoY2oxk2oQ_O4y2G3jXufw5_xrglJ_Fc6beFRc3zQKDnyXlc4lLNelcgBJqCg'
    });
  }
}
