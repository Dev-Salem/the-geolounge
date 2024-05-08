import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CommentAvatar extends StatelessWidget {
  const CommentAvatar({
    required this.userId,
    required this.postId,
    super.key,
  });
  final String userId;
  final String postId;

  @override
  Widget build(BuildContext context) {
    return AvatarImage(
      shape: AvatarImageShape.standard,
      backgroundColor: context.hoverColor,
      radius: 20,
      child: Icon(
        FontAwesomeIcons.circleUser,
        size: 20,
        shadows: [
          Shadow(
            blurRadius: 2,
            color: context.scaffoldBackgroundColor,
          ),
        ],
        color: _getUserColor(
          userId: userId,
          postId: postId,
        ),
      ),
    );
  }
}

Color _getUserColor({required String userId, required String postId}) {
  final hash = '$userId$postId'.hashCode;
  final r = (hash & 0xFF0000) >> 16;
  final g = (hash & 0x00F00) >> 8;
  final b = hash & 0x0000FF;
  return Color.fromRGBO(r, g, b, 1);
}
