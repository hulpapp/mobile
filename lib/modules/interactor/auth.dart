import 'package:dio/dio.dart';
import 'package:hulp/env/env.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

void main() async {
  AuthenticatorInteractor auth = new AuthenticatorInteractor();

  // var req = await auth.login('Fulano@hotmail.com', 'Fulano');
  // print(req);
}

class AuthenticatorInteractor {
  Dio dio = Dio();
  login(email, password) async {

    try {
      var response = await dio
          .post('${Env.api_url}login', data: {'email': email, 'password': password});
      print(response);
      return response;
    } catch (e) {
      return e;
    }
  }
}
