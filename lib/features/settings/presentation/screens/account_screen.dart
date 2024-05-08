import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:the_geolounge/core/constants/urls.dart';
import 'package:the_geolounge/core/core.dart';
import 'package:the_geolounge/features/auth/auth.dart';
import 'package:the_geolounge/features/settings/presentation/controllers/localization_controller.dart';
import 'package:the_geolounge/features/settings/presentation/controllers/theme_controller.dart';
import 'package:the_geolounge/gen/strings.g.dart';
import 'package:url_launcher/url_launcher.dart';

class AccountScreen extends ConsumerWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeControllerProvider).value;
    ref
      ..listen(localizationControllerProvider, (previous, current) {
        if (current.hasValue) {
          context.snackBar(t.account.language_changed);
        }
      })
      ..listen(authControllerProvider, (previous, current) {
        if (current.isLoading) {
          context.loaderOverlay.show();
        }
        if (current.hasError && !current.isLoading) {
          context.loaderOverlay.hide();
          context.snackBar(t.posts.something_wrong);
        }
      });
    return LoaderOverlay(
      overlayColor: Colors.black38,
      child: Scaffold(
        appBar: AppBar(
          title: Text(t.account.language),
        ),
        body: ListView(
          children: ListTile.divideTiles(
            context: context,
            tiles: [
              SwitchListTile.adaptive(
                title: Text(t.account.dark_theme),
                value: theme == ThemeMode.dark,
                onChanged: (isDarkTheme) {
                  ref
                      .read(themeControllerProvider.notifier)
                      .toggle(isDarkTheme ? ThemeMode.dark : ThemeMode.light);
                },
              ),
              ListTile(
                title: Text(t.account.language),
                onTap: () => showDialog<void>(
                  context: context,
                  builder: (dialogCtx) {
                    return SimpleDialog(
                      title: Text(t.account.languages),
                      children: ListTile.divideTiles(
                        context: context,
                        tiles: AppLocale.values.map(
                          (locale) => ListTile(
                            title: Text(locale.name),
                            onTap: () {
                              ref
                                  .read(localizationControllerProvider.notifier)
                                  .setLocale(
                                    locale,
                                  );
                            },
                          ),
                        ),
                      ).toList(),
                    );
                  },
                ),
              ),
              ListTile(
                title: Text(t.account.privacy_policy),
                onTap: () async {
                  try {
                    await launchPrivacyPolicyUrl();
                  } on Exception {
                    if (context.mounted) {
                      context.snackBar(t.posts.something_wrong);
                    }
                  }
                },
              ),
              ListTile(
                title: Text(t.account.sign_out),
                onTap: () =>
                    ref.read(authControllerProvider.notifier).signOut(),
              ),
              ListTile(
                textColor: Colors.red,
                title: Text(t.account.delete_account),
                onTap: () {
                  showDialog<void>(
                    context: context,
                    builder: (context) {
                      return AlertDialog.adaptive(
                        title: Text(t.account.delete_permanently),
                        content: Text(t.account.confirm_delete_account),
                        actions: [
                          TextButton(
                            onPressed: ref.read(goRouterProvider).pop,
                            child: Text(t.account.dismiss),
                          ),
                          TextButton(
                            onPressed: () {
                              ref
                                ..read(authControllerProvider.notifier)
                                    .deleteAccount()
                                ..read(goRouterProvider).pop();
                            },
                            child: Text(
                              t.account.delete_account,
                              style: const TextStyle(color: Colors.red),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ],
          ).toList(),
        ),
      ),
    );
  }
}

Future<void> launchPrivacyPolicyUrl() =>
    launchUrl(Uri.parse(Urls.privacyPolicy));
