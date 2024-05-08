import 'package:flutter/material.dart';
import 'package:the_geolounge/gen/strings.g.dart';

class ChatOptionsDialog extends StatelessWidget {
  const ChatOptionsDialog({required this.onDelete, super.key});
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return AlertDialog.adaptive(
      title: Text(t.chat.options),
      actions: [
        TextButton(
          onPressed: () {
            showDialog<void>(
              context: context,
              builder: (_) => AlertDialog.adaptive(
                title: Text(t.chat.confirm_delete),
                content: Text(
                  t.chat.are_you_sure,
                ),
                actions: [
                  TextButton(
                    onPressed: onDelete,
                    child: Text(
                      t.chat.confirm_delete,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
                ],
              ),
            );
          },
          child: Text(
            t.chat.delete,
            style: const TextStyle(color: Colors.red),
          ),
        ),
      ],
    );
  }
}
