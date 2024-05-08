import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:the_geolounge/core/core.dart';
import 'package:the_geolounge/core/router/go_router.dart';
import 'package:the_geolounge/features/user/user.dart';
import 'package:the_geolounge/gen/strings.g.dart';
part 'localization_controller.g.dart';

@riverpod
class LocalizationController extends _$LocalizationController {
  @override
  FutureOr<Locale> build() async => getLocale();

  Future<Locale> getLocale() async {
    final prefs = await ref.watch(sharedPreferencesProvider.future);
    final storedLocale = prefs.getString('language');
    final locale = storedLocale == null
        ? AppLocale.en
        : AppLocale.values
            .firstWhere((element) => element.name == storedLocale);
    return locale.flutterLocale;
  }

  Future<void> setLocale(AppLocale locale) async {
    final prefs = await ref.watch(sharedPreferencesProvider.future);
    await prefs.setString('language', locale.name);
    state = AsyncValue.data(await getLocale());
    ref.watch(goRouterProvider).pop();
  }
}
