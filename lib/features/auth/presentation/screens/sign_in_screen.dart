import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:lottie/lottie.dart';
import 'package:the_geolounge/core/core.dart';
import 'package:the_geolounge/core/widgets/responsive_screen_template.dart';
import 'package:the_geolounge/features/auth/presentation/controller/auth_controller.dart';
import 'package:the_geolounge/gen/strings.g.dart';

class SignInScreen extends ConsumerWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(
      authControllerProvider,
      (previous, current) {
        if (current.isLoading) {
          context.loaderOverlay.show();
        }
        if (current.hasError && (!current.isLoading)) {
          context.loaderOverlay.hide();
          if (context.mounted) {
            current.error.toString().errorLogger();
            context.snackBar(t.posts.something_wrong);
          }
        }
      },
    );
    return Scaffold(
      body: LoaderOverlay(
        overlayColor: Colors.black26,
        child: ResponsiveScreenTemplate(
          body: Center(
            child: ListView(
              shrinkWrap: true,
              children: [
                Text(
                  t.auth.onboarding_title,
                  style: context.headlineSmall!.semiBold,
                  textAlign: TextAlign.center,
                ),
                LottieBuilder.asset(
                  Assets.authIllustration,
                  height: 300,
                ),
                Text(
                  t.auth.onboarding_slogan,
                  style: context.headlineSmall,
                  textAlign: TextAlign.center,
                ),
                64.heightBox,
                FilledButton.icon(
                  onPressed: ref
                      .read(authControllerProvider.notifier)
                      .signInWithGoogle,
                  icon: const Icon(FontAwesomeIcons.google).paddingAll(10),
                  label: Text(
                    t.auth.google_sign_in,
                    style: context.bodyLarge!.semiBold,
                    textAlign: TextAlign.center,
                  ),
                ),
                //incognito
                TextButton.icon(
                  onPressed: () => ref
                      .read(authControllerProvider.notifier)
                      .signInAnonymously(),
                  icon: const Icon(FontAwesomeIcons.userSecret),
                  label: Text(t.auth.continue_guest),
                ),
              ],
            ).paddingSymmetric(horizontal: 24),
          ),
        ),
      ),
    );
  }
}
