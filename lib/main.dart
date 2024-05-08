import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:jiffy/jiffy.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:the_geolounge/app.dart';
import 'package:the_geolounge/core/core.dart';
import 'package:the_geolounge/features/user/user.dart';
import 'package:the_geolounge/gen/strings.g.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  await _initLocalization();
  usePathUrlStrategy();
  await Supabase.initialize(
    url: Env.projectUrl,
    anonKey: Env.anonKey,
    debug: kDebugMode,
  );
  runApp(
    ProviderScope(
      observers: const [],
      overrides: [sharedPreferencesProvider.overrideWith((ref) => prefs)],
      child: TranslationProvider(child: const TheGeoLounge()),
    ),
  );
}

Future<void> _initLocalization() async {
  final prefs = await SharedPreferences.getInstance();
  final locale = prefs.getString('language');
  LocaleSettings.setLocaleRaw(locale ?? 'en', listenToDeviceLocale: true);
  await Jiffy.setLocale(locale ?? 'en_US');
}
