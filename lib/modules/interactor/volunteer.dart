import 'package:dio/dio.dart';
import 'package:hulp/env/env.dart';
import 'package:hulp/modules/entities/Volunteer.dart';
import 'package:hulp/utils/http_intercept.dart';
class VolunteerInteractor {
  Dio dio = Dio(BaseOptions(baseUrl: Env.api_url))..interceptors.add(BaseInterception());


  Future list() async {
    try {
      var response = await dio
          .get('/volunteers');
      return response.data;
    } on DioError catch (e) {
      throw e.message;
    }

  }

  Future getVolunteer(int volId) async {
    try {
      var response = await dio
          .get('/volunteers/$volId');
      return response.data;
    } on DioError catch (e) {
      throw e.message;
    }

  }


}