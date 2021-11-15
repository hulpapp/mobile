import 'package:dio/dio.dart';
import 'package:hulp/env/env.dart';
import 'package:hulp/modules/entities/Bene.dart';
import 'package:hulp/modules/entities/donations.dart';
import 'package:hulp/utils/http_intercept.dart';


class BeneficiaryInteractor {
  Dio dio = Dio(BaseOptions(baseUrl: Env.api_url))..interceptors.add(BaseInterception());

  Future create(Beneficiary beneficiary) async {
    try {
      var response = await dio
          .post('/beneficiaries', data: {'beneficiary': beneficiary});
      return response.data;
    } on DioError catch (e) {
      throw e.message;
    }
  }


  Future list() async {
    try {
      var response = await dio
          .get('/beneficiaries');
      return response.data;
    } on DioError catch (e) {
      throw e.message;
    }

  }
}