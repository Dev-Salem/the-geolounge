import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:the_geolounge/core/widgets/post_text_field.dart';
import 'package:the_geolounge/features/chat/presentation/controller/chat_controller.dart';
import 'package:the_geolounge/gen/strings.g.dart';

class SendMessageDialog extends ConsumerWidget {
  const SendMessageDialog({
    required this.receiverId,
    required this.postId,
    super.key,
  });
  final String receiverId;
  final String postId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SimpleDialog(
      title: Text(t.posts.send_message),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
      children: [
        PostTextField(
          validator: (p0) {
            if (p0 == null) {
              return null;
            }
            if (p0.length > 100) {
              return t.chat.too_long;
            }
            if (p0.length < 5) {
              return t.chat.too_short;
            }
            return null;
          },
          onSend: (text) {
            ref.read(chatControllerProvider.notifier).sendChatRequest(
                  receiverId: receiverId,
                  postId: postId,
                  openingMessage: text!,
                );
          },
        ),
        16.heightBox,
      ],
    );
  }
}
