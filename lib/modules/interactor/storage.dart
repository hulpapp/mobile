import 'package:shared_preferences/shared_preferences.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class LocalStorage {
  saveToken(var token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> decodedToken = JwtDecoder.decode(token['token']);
    print(decodedToken['user_id']);
    await prefs.setString('token', token['token']);
    await prefs.setInt('user', decodedToken['user_id']);
  }
}
