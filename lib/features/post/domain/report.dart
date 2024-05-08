import 'package:equatable/equatable.dart';

class Report extends Equatable {
  const Report({
    required this.postId,
    required this.userId,
    required this.content,
  });

  factory Report.fromMap(Map<String, dynamic> map) {
    return Report(
      postId: map['id'] as String,
      userId: map['user_id'] as String,
      content: map['content'] as String,
    );
  }

  final String postId;
  final String userId;
  final String content;

  Report copyWith({
    String? postId,
    String? userId,
    String? content,
  }) {
    return Report(
      postId: postId ?? this.postId,
      userId: userId ?? this.userId,
      content: content ?? this.content,
    );
  }

  static Map<String, dynamic> toMap({
    required String postId,
    required String userId,
    required String content,
  }) {
    return <String, dynamic>{
      'id': postId,
      'user_id': userId,
      'content': content,
    };
  }

  @override
  String toString() =>
      'Report(postId: $postId, userId: $userId, content: $content)';

  @override
  List<Object> get props => [postId, userId, content];
}
