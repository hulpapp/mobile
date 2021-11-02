import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LocalStorage {


  final storage = new FlutterSecureStorage();


  saveToken(var token) async{

    var tk  = jsonDecode(token)['token'];

    await storage.write(key: 'token', value: tk);


  }





}