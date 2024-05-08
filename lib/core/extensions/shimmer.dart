import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';

extension ShimmerBox on SizedBox {
  Widget shimmer() {
    return ColoredBox(
      color: Colors.black12,
      child: this,
    ).applyShimmer(
      baseColor: Colors.grey,
    );
  }
}
