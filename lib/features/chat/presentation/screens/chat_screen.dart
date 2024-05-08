import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:the_geolounge/core/core.dart';
import 'package:the_geolounge/features/chat/data/supabase_chat_repository.dart';
import 'package:the_geolounge/features/chat/presentation/controller/chat_controller.dart';
import 'package:the_geolounge/features/chat/presentation/widgets/chats_list.dart';
import 'package:the_geolounge/features/chat/presentation/widgets/pending_requests_list.dart';
import 'package:the_geolounge/gen/strings.g.dart';

class ChatScreen extends ConsumerWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(
      chatControllerProvider,
      (previous, current) {
        if (current.isLoading) {
          context.loaderOverlay.show();
        }
        if (!current.isLoading) {
          context.loaderOverlay.hide();
          if (current.hasError) {
            context.snackBar((current.error! as PostgrestException).message);
          }
        }
      },
    );
    return LoaderOverlay(
      overlayColor: Colors.black38,
      child: Scaffold(
        appBar: AppBar(
          title: Text(TranslationProvider.of(context).translations.chat.chats),
        ),
        body: RefreshIndicator.adaptive(
          onRefresh: () async {
            ref
              ..invalidate(getAcceptedChatRequestsProvider)
              ..invalidate(
                getChatRequestsProvider.call(RequestStatus.pending),
              );
          },
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            children: [
              16.heightBox,
              const PendingRequestsList(),
              16.heightBox,
              const ChatsList(),
            ],
          ),
        ),
      ),
    );
  }
}
