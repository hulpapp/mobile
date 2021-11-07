import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BaseInterception extends Interceptor {
  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {

    SharedPreferences prefs =  await SharedPreferences.getInstance();
    var token = prefs.get("token");

    options.headers.addAll({"authorization": "Bearer $token"});

    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print(
      'RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}',
    );
    return super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {



    print(
      'ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}',
    );
    return super.onError(DioError(requestOptions: err.requestOptions,error: 'Erro de conexão tente novamente',type: DioErrorType.other), handler);
  }
}