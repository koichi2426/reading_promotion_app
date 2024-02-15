import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: 'env/.env')
abstract class Env {
  @EnviedField(varName: 'GPT_APIKEY', obfuscate: true)
  static String key = _Env.key;
}