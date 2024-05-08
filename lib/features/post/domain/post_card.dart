import 'package:equatable/equatable.dart';

import 'package:the_geolounge/core/core.dart';

class PostCard extends Equatable {
  const PostCard({
    required this.id,
    required this.userId,
    required this.createdAt,
    required this.content,
    required this.room,
    required this.country,
    required this.city,
    required this.upvotes,
    required this.downvotes,
    required this.comments,
  });

  factory PostCard.fromMap(Map<String, dynamic> map) {
    return PostCard(
      id: map['post_id'] as String,
      userId: map['user_id'] as String,
      createdAt: DateTime.parse(map['created_at'] as String),
      content: map['content'] as String,
      room: Rooms.values.firstWhere((element) => element.name == map['room']),
      country: map['country'] as String,
      city: map['city'] as String,
      upvotes: map['upvotes_count'] as int,
      downvotes: map['downvotes_count'] as int,
      comments: map['comments_count'] as int,
    );
  }
  final String id;
  final String userId;
  final DateTime createdAt;
  final String content;
  final Rooms room;
  final String country;
  final String city;
  final int upvotes;
  final int downvotes;
  final int comments;

  PostCard copyWith({
    String? id,
    String? userId,
    DateTime? createdAt,
    String? content,
    Rooms? room,
    String? country,
    String? city,
    int? upvotes,
    int? downvotes,
    int? comments,
  }) {
    return PostCard(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      createdAt: createdAt ?? this.createdAt,
      content: content ?? this.content,
      room: room ?? this.room,
      country: country ?? this.country,
      city: city ?? this.city,
      upvotes: upvotes ?? this.upvotes,
      downvotes: downvotes ?? this.downvotes,
      comments: comments ?? this.comments,
    );
  }

  static Map<String, dynamic> toMap({
    required String content,
    required Rooms room,
    required String country,
    required String city,
  }) {
    return {
      'content': content,
      'room': room.name,
      'country': country,
      'city': city,
      'upvotes': <String>[],
      'downvotes': <String>[],
    };
  }

  @override
  String toString() {
    return '\n✨PostCard(content: $content)✨';
  }

  @override
  List<Object> get props {
    return [
      id,
      userId,
      createdAt,
      content,
      room,
      country,
      city,
      upvotes,
      downvotes,
      comments,
    ];
  }
}
