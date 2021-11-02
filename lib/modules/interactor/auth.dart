import 'package:dio/dio.dart';
import 'package:hulp/env/env.dart';

class AuthenticatorInteractor {
  Dio dio = Dio(BaseOptions(baseUrl: Env.api_url));

 Future login(email, password) async {
    try {
      var response = await dio
          .post('/token/login', data: {'email': email, 'password': password});
      return response;
    } on DioError catch (e) {
      if (e.type == DioErrorType.response) {
        throw  'Usuário ou senha inválida';
      }
    }
  }
}
