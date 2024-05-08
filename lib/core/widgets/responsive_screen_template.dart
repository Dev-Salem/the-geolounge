import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';

class ResponsiveScreenTemplate extends StatelessWidget {
  const ResponsiveScreenTemplate({required this.body, super.key});
  final Widget body;

  @override
  Widget build(BuildContext context) {
    return context.isPhone
        ? body
        : Row(
            children: [
              const Expanded(child: SizedBox()),
              Expanded(
                child: body,
              ),
              const Expanded(child: SizedBox()),
            ],
          );
  }
}
