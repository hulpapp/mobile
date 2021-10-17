import 'package:dio/dio.dart';
import 'package:hulp/env/env.dart';

class HttpRequest {
  Dio dio = Dio();

  HttpRequest(String baseUrl) {
    this.dio = Dio(BaseOptions(baseUrl: baseUrl));
  }

  get(String endPoint,Map? option) async {
    try {
      var response = await dio.get('http://www.google.com');
      return response;
    } catch (e) {
      print(e);


    }

  }



}