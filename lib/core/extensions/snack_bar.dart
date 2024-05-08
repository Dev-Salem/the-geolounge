import 'package:flutter/material.dart';

extension SnackBarX on BuildContext {
  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> snackBar(
    String content,
  ) {
    return ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(behavior: SnackBarBehavior.floating, content: Text(content)),
    );
  }
}
