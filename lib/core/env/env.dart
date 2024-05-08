// ignore_for_file: public_member_api_docs

import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env')
abstract class Env {
  @EnviedField(varName: 'PROJECT_URL', obfuscate: true)
  static final String projectUrl = _Env.projectUrl;

  @EnviedField(varName: 'ANON_KEY', obfuscate: true)
  static final String anonKey = _Env.anonKey;

  @EnviedField(varName: 'WEB_CLIENT_ID', obfuscate: true)
  static final String webClientId = _Env.webClientId;

  @EnviedField(varName: 'IOS_CLIENT_ID', obfuscate: true)
  static final String iosClientId = _Env.iosClientId;
}
