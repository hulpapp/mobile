import 'package:dio/dio.dart';
import 'package:hulp/env/env.dart';
import 'package:hulp/modules/entities/teams.dart';
import 'package:hulp/utils/http_intercept.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TeamInteractor {
  Dio dio = Dio(BaseOptions(baseUrl: Env.api_url))..interceptors.add(BaseInterception());

  Future create(Team team) async {
    try {
      var response = await dio
          .post('/teams', data: {'team':team});
      return response.data;
    } on DioError catch (e) {
      throw e.message;
    }
  }


  Future insertMember(members) async {
    try {
      var response = await dio
          .post('/team_have_vol', data: members);
      return response.data;
    } on DioError catch (e) {
      throw e.message;
    }
  }

  Future getTeamByIdLeader() async {

    SharedPreferences prefs =  await SharedPreferences.getInstance();
    var userId = prefs.get("user");


    try {
      var response = await dio
          .get('/teams-by-responsible/$userId');
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

  Future<List> listMembers() async {
    try {
      var response = await dio
          .get('/teams_have_volunteers');
      return response.data;
    } on DioError catch (e) {
      throw e.message;
    }

  }
}