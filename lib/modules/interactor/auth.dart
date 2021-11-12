import 'package:dio/dio.dart';
import 'package:hulp/env/env.dart';

class AuthenticatorInteractor {
  Dio dio = Dio(BaseOptions(baseUrl: Env.api_url));

  Future login(email, password) async {
    try {
      var response = await dio
          .post('/login', data: {'email': email, 'password': password});
      return response.data;
    } on DioError catch (e) {
      if (e.type == DioErrorType.response) {
        throw 'Usuário ou senha inválida';
      }
      if (e.type == DioErrorType.connectTimeout) {
        throw 'Verifique sua conexão';
      }

      if (e.type == DioErrorType.receiveTimeout) {
        throw 'Não foi possivel conectar ao servidor';
      }

      if (e.type == DioErrorType.other) {
        throw 'Erro de conexão';
      }
    }
  }
}
