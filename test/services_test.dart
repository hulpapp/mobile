import 'package:hulp/utils/encryptService.dart';
import 'package:test/test.dart';

void main(){

  test('Encrypt Service',() async {
    var filename = '.env';
     EncryptService.encryptFile(filename);

  });

  test('Decrypt Service',() async {
    var filename = '.env.aes';
    EncryptService.decryptFile(filename);

  });




}