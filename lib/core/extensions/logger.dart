import 'package:logger/logger.dart';

extension GlobalLogger on Object {
  void debugLogger() => Logger().d(this);
  void errorLogger() => Logger().e(this);
  void infoLogger() => Logger().i(this);
  void fatalLogger() => Logger().f(this);
  void warnLogger() => Logger().w(this);
}
