import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  saveToken(var token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token['token']);
  }
}
