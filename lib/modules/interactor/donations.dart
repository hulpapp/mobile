import 'package:dio/dio.dart';
import 'package:hulp/env/env.dart';
import 'package:hulp/modules/entities/donations.dart';
import 'package:hulp/utils/http_intercept.dart';
class DonationInteractor {
  Dio dio = Dio(BaseOptions(baseUrl: Env.api_url))..interceptors.add(BaseInterception());

  Future create(Donation donation) async {
    try {
      var response = await dio
          .post('/donations/event/${donation.eventId}', data: donation);
      return response.data;
    } on DioError catch (e) {
      throw e.message;
    }
  }

  Future update(Donation event) async {
    try {
      var response = await dio
          .put('/events/${event.id}', data: {'event':event});
      return response.data;
    } on DioError catch (e) {
      throw e.message;
    }
  }



  Future list(eventId) async {
    try {
      var response = await dio
          .get('/generate_report/$eventId');
      return response.data;
    } on DioError catch (e) {
      throw e.message;
    }

  }
}