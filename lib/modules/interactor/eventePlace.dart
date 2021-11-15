import 'package:dio/dio.dart';
import 'package:hulp/env/env.dart';
import 'package:hulp/modules/entities/location.dart';
import 'package:hulp/utils/http_intercept.dart';
class EventPlaceInteractor {
  Dio dio = Dio(BaseOptions(baseUrl: Env.api_url))..interceptors.add(BaseInterception());

  Future create(List<EventPlace> places) async {
   var req = [];
   places.forEach((element) {req.add(element.toJson());});


    try {
      var response = await dio
          .post('/create_eventplaces', data: req);
      return response.data;
    } on DioError catch (e) {
      throw e.message;
    } 
  }


  Future list(eventId) async {
    try {
      var response = await dio
          .get('/events/$eventId/places');
      if(response.data.length>0) return response.data;
      return  [];
    } on DioError catch (e) {
      throw e.message;
    }

  }
}