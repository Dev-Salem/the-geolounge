import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:the_geolounge/core/core.dart';
import 'package:the_geolounge/gen/strings.g.dart';

class ErrorResultWidget extends ConsumerWidget {
  const ErrorResultWidget({required this.onRefresh, super.key});
  final VoidCallback onRefresh;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        LottieBuilder.asset(
          Assets.errorAnimation,
          height: 250,
        ),
        Text(
          t.posts.something_wrong,
          style: context.headlineMedium,
          textAlign: TextAlign.center,
        ).paddingSymmetric(horizontal: 16),
        TextButton(onPressed: onRefresh, child: Text(t.posts.go_back)),
      ],
    );
  }
}
