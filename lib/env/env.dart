import 'package:envify/envify.dart';
part 'env.g.dart';

@Envify(path: '.env.development')
abstract class Env {
  static const String api_url = _Env.api_url;
}