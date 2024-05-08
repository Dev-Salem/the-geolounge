import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:the_geolounge/core/extensions/shimmer.dart';

class PostCardShimmer extends StatelessWidget {
  const PostCardShimmer({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const _CardInfo(),
        4.heightBox,
        const SizedBox(
          height: 20,
          width: 400,
        ).shimmer(),
        const _CardActions(),
        8.heightBox,
      ],
    );
  }
}

class _CardInfo extends StatelessWidget {
  const _CardInfo();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        //icon
        Flexible(
          child: const SizedBox(
            height: 50,
            width: 50,
          ).shimmer(),
        ),
        16.widthBox,
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //room
              const SizedBox(
                height: 20,
                width: 80,
              ).shimmer(),
              3.heightBox,
              const SizedBox(
                height: 20,
                width: 120,
              ).shimmer(),
            ],
          ),
        ),
      ],
    );
  }
}

class _CardActions extends StatelessWidget {
  const _CardActions();

  @override
  Widget build(
    BuildContext context,
  ) {
    const cardIconsSize = 20.0;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Flexible(
          child: IconButton(
            onPressed: null,
            icon: Icon(
              FontAwesomeIcons.chevronUp,
              size: cardIconsSize,
            ),
          ),
        ),
        const Flexible(
          child: IconButton(
            onPressed: null,
            icon: Icon(
              FontAwesomeIcons.chevronDown,
              size: cardIconsSize,
            ),
          ),
        ),
        Flexible(
          child: const IconButton(
            onPressed: null,
            icon: Icon(
              FontAwesomeIcons.commentDots,
              size: cardIconsSize,
            ),
          ).applyShimmer(),
        ),
        Flexible(
          child: const SizedBox(
            height: 20,
            width: 70,
          ).shimmer(),
        ),
      ],
    );
  }
}
