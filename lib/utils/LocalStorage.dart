import 'dart:io' show Platform;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

Future<void> main()   async {
  // Get the operating system as a string.
  String os = Platform.operatingSystem;
  // Or, use a predicate getter.
  print(os);

  final storage = new FlutterSecureStorage();

  await storage.write(key: 'key', value: 'value');



}