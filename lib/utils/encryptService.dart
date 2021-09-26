// ignore: import_of_legacy_library_into_null_safe
import 'dart:io';

import 'package:aes_crypt/aes_crypt.dart';

class EncryptService {

  static void encryptFile(String filename) =>
  AesCrypt('MODIFYIT').encryptFileSync(filename,'$filename.aes');

  static void decryptFile(String filename) =>
  AesCrypt('MODIFYIT').decryptFileSync(filename,filename.replaceAll('.aes',''));


}