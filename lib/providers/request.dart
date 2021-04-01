import 'package:yonomi_platform_sdk/request/request.dart';

class YoRequestCreator {
  static String endpoint = "https://platform-stg.yonomi.cloud/graphql";

  static String token =
      "eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMWU4MzRjNi0zNzMyLTQyYjgtYjVjMS00MTc5YjhkNDhhZTQiLCJpc3MiOiIxZDA3YzVjOC1mYTgwLTRjNGYtOGQ2My0xNjljZmY4YWNiMjMiLCJpYXQiOjE2MTcyOTM2NjksImV4cCI6MTYxNzM4MDA2OX0.IrO_PoOAKzi_tOVRY_QU929Z7o1yOMuqF3HcjBIznbvTYJMzGSMq-_zUBYsgcKw2ZoK_xe_Vef1cs3ocLTPENWHs6VwAKfgLGBZiE8lLHhGO2nwSBKO9UOBy77zT7jKouSJ0e18IDCKAD199v7ZkYmslNse9Z8bvMEEegXcqxuq10s20MEg0NOuo_REUcbASGP4Z3wcS_MAJchmnvbYwDuGL8fczs33gyNCTVqlwcFG3vnj8LHZgnLLu6y8FMZYV4_AkmVVifI2J9BCD-jnbfN5NOF-LB0oh8YmjhW3jBwDZXxzqi8AEMJYge3lz2A99YKMkmX-KZBmaehEJaLAZ8Q";

  static Request request() {
    return Request(endpoint, {'Authorization': 'Bearer ${_token}'});
  }

  static String get token => _token;
  static void set token(String token) {
    _token = token;
  }
}
