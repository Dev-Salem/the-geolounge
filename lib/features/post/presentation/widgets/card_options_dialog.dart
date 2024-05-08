import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:the_geolounge/features/auth/data/supabase_auth_repository.dart';
import 'package:the_geolounge/gen/strings.g.dart';

class CardOptionsDialog extends ConsumerWidget {
  const CardOptionsDialog({
    required this.onReport,
    required this.onDelete,
    required this.onSendMessage,
    required this.authorId,
    super.key,
  });
  final VoidCallback? onDelete;
  final VoidCallback? onSendMessage;
  final VoidCallback? onReport;
  final String authorId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IconButton(
      onPressed: () async {
        final currentUserId =
            ref.read(supabaseClientProvider).auth.currentUser?.id;
        await showDialog<void>(
          context: context,
          builder: (context) => SimpleDialog(
            contentPadding: const EdgeInsets.all(24),
            title: Text(t.posts.options),
            children: [
              if (authorId == currentUserId)
                _buildOption(
                  icon: FontAwesomeIcons.trash,
                  color: Colors.red,
                  title: t.posts.delete,
                  onTap: onDelete,
                )
              else
                _buildOption(
                  icon: FontAwesomeIcons.paperPlane,
                  title: t.posts.send_message,
                  onTap: onSendMessage,
                ),
              _buildOption(
                icon: FontAwesomeIcons.flag,
                title: t.posts.report,
                onTap: onReport,
              ),
            ],
          ),
        );
      },
      icon: const Icon(FontAwesomeIcons.ellipsis),
    );
  }

  /// Builds an option ListTile widget.
  Widget _buildOption({
    required IconData icon,
    required String title,
    Color? color,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: ListTile(
        leading: Icon(
          icon,
          color: color,
        ),
        title: Text(title),
      ),
    );
  }
}
