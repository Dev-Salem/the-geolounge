import 'package:equatable/equatable.dart';

class Comment extends Equatable {
  const Comment({
    required this.id,
    required this.userId,
    required this.postId,
    required this.content,
    required this.createdAt,
    required this.upvotes,
    required this.downvotes,
    this.parentCommentId,
  });

  factory Comment.fromMap(Map<String, dynamic> map) {
    return Comment(
      id: map['id'] as String,
      userId: map['user_id'] as String,
      postId: map['post_id'] as String,
      parentCommentId: map['parent_comment_id'] as String?,
      content: map['content'] as String,
      createdAt: DateTime.parse(map['created_at'] as String),
      upvotes: List<String>.from(map['upvotes'] as List<dynamic>),
      downvotes: List<String>.from(map['downvotes'] as List<dynamic>),
    );
  }

  static Map<String, dynamic> toMap({
    required String postId,
    required String content,
    String? parentCommentId,
  }) {
    return parentCommentId == null
        ? {
            'post_id': postId,
            'content': content,
            'upvotes': <String>[],
            'downvotes': <String>[],
          }
        : {
            'post_id': postId,
            'parent_comment_id': parentCommentId,
            'content': content,
            'upvotes': <String>[],
            'downvotes': <String>[],
          };
  }

  final String id;
  final String userId;
  final String postId;
  final String? parentCommentId;
  final String content;
  final DateTime createdAt;
  final List<String> upvotes;
  final List<String> downvotes;

  Comment copyWith({
    String? id,
    String? userId,
    String? postId,
    List<Comment>? replies,
    String? content,
    DateTime? createdAt,
    List<String>? upvotes,
    List<String>? downvotes,
    String? parentCommentId,
  }) {
    return Comment(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      postId: postId ?? this.postId,
      content: content ?? this.content,
      createdAt: createdAt ?? this.createdAt,
      upvotes: upvotes ?? this.upvotes,
      downvotes: downvotes ?? this.downvotes,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id,
      userId,
      postId,
      content,
      createdAt,
      upvotes,
      downvotes,
    ];
  }
}
