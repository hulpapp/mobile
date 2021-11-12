import 'package:dio/dio.dart';
import 'package:hulp/env/env.dart';
import 'package:hulp/modules/entities/event.dart';
import 'package:hulp/utils/http_intercept.dart';
class TeamInteractor {
  Dio dio = Dio(BaseOptions(baseUrl: Env.api_url))..interceptors.add(BaseInterception());

  Future create(Event event) async {
    try {
      var response = await dio
          .post('/events', data: {'event':event});
      return response.data;
    } on DioError catch (e) {
      throw e.message;
    }
  }


  Future list() async {
    try {
      var response = await dio
          .get('/teams');
      return response.data;
    } on DioError catch (e) {
      throw e.message;
    }

  }
}