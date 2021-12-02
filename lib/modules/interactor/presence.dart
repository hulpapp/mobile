import 'package:dio/dio.dart';
import 'package:hulp/env/env.dart';
import 'package:hulp/modules/entities/Bene.dart';
import 'package:hulp/modules/entities/donations.dart';
import 'package:hulp/modules/entities/presence.dart';
import 'package:hulp/utils/http_intercept.dart';
import 'package:shared_preferences/shared_preferences.dart';


class PresenceInteractor {
  Dio dio = Dio(BaseOptions(baseUrl: Env.api_url))..interceptors.add(BaseInterception());

  Future create(Presence presence) async {
    try {
      var response = await dio
          .post('/presences', data: {'presence': presence});
      return response.data;
    } on DioError catch (e) {
      throw e.message;
    }
  }



  Future getCertification(eventId) async {
    SharedPreferences prefs =  await SharedPreferences.getInstance();
    var userId = prefs.get("user");

    try {
      var response = await dio
          .get('/presences/event/$eventId/volunteer/$userId');
      return response.data;
    } on DioError catch (e) {
      throw e.message;
    }

  }
}