import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:the_geolounge/core/router/go_router.dart';
import 'package:the_geolounge/core/theme/theme.dart';
import 'package:the_geolounge/features/settings/presentation/controllers/localization_controller.dart';
import 'package:the_geolounge/features/settings/presentation/controllers/theme_controller.dart';
import 'package:the_geolounge/gen/strings.g.dart';

class TheGeoLounge extends ConsumerWidget {
  const TheGeoLounge({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeManger.darkTheme,
      theme: ThemeManger.theme,
      localizationsDelegates: GlobalMaterialLocalizations.delegates,
      locale: ref.watch(localizationControllerProvider).value,
      supportedLocales: AppLocaleUtils.supportedLocales,
      themeMode: ref.watch(themeControllerProvider).value,
      routerConfig: ref.watch(goRouterProvider),
    );
  }
}
