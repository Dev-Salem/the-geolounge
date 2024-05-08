import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:the_geolounge/core/core.dart';
import 'package:the_geolounge/gen/strings.g.dart';

class EmptyResultWidget extends StatelessWidget {
  const EmptyResultWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        LottieBuilder.asset(
          Assets.emptyBoxAnimation,
          height: 200,
        ),
        Text(
          t.posts.nothing_to_show,
          style: context.bodyLarge,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
