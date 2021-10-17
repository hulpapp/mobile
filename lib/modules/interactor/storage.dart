import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LocalStorage {


  final storage = new FlutterSecureStorage();


  saveToken(String token) async{
    await storage.write(key: 'csrf', value: token);


  }





}