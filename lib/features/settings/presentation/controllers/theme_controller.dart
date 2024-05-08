import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:the_geolounge/features/user/user.dart';
part 'theme_controller.g.dart';

@riverpod
class ThemeController extends _$ThemeController {
  @override
  FutureOr<ThemeMode> build() async => getTheme();

  Future<void> toggle(ThemeMode preferredTheme) async {
    final prefs = await ref.watch(sharedPreferencesProvider.future);
    await prefs.setString('theme', preferredTheme.name);
    state = AsyncValue.data(preferredTheme);
  }

  Future<ThemeMode> getTheme() async {
    final prefs = await ref.watch(sharedPreferencesProvider.future);
    final theme = prefs.getString('theme');
    return theme == null
        ? ThemeMode.system
        : ThemeMode.values.firstWhere((element) => element.name == theme);
  }
}
