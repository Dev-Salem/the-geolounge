// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:the_geolounge/core/constants/rooms.dart';
import 'package:the_geolounge/core/core.dart';
import 'package:the_geolounge/features/post/domain/comment.dart';

class Post extends Equatable {
  final String id;
  final String userId;
  final DateTime creationDate;
  final String content;
  final Rooms room;
  final List<String> upvotes;
  final List<String> downvotes;
  final String country;
  final String city;
  final List<Comment>? comments;
  final int? numberOfComments;
  const Post({
    required this.id,
    required this.userId,
    required this.creationDate,
    required this.content,
    required this.room,
    required this.upvotes,
    required this.downvotes,
    required this.country,
    required this.city,
    this.comments,
    this.numberOfComments,
  });

  Post copyWith({
    String? id,
    String? userId,
    DateTime? creationDate,
    String? content,
    Rooms? room,
    List<String>? upvotes,
    List<String>? downvotes,
    String? country,
    String? city,
    List<Comment>? comments,
    int? numberOfComments,
  }) {
    return Post(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      creationDate: creationDate ?? this.creationDate,
      content: content ?? this.content,
      room: room ?? this.room,
      upvotes: upvotes ?? this.upvotes,
      downvotes: downvotes ?? this.downvotes,
      country: country ?? this.country,
      city: city ?? this.city,
      comments: comments ?? this.comments,
      numberOfComments: numberOfComments ?? this.numberOfComments,
    );
  }

  factory Post.fromMap(Map<String, dynamic> map) {
    return Post(
      id: map['id'] as String,
      userId: map['user_id'] as String,
      creationDate: DateTime.parse(map['created_at'] as String),
      content: map['content'] as String,
      room: Rooms.values
          .singleWhere((element) => element.room == (map['room'] as String)),
      country: map['country'] as String,
      city: map['city'] as String,
      upvotes: List<String>.from(map['upvotes'] as List<dynamic>),
      downvotes: List<String>.from(map['downvotes'] as List<dynamic>),
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
  String toString() => '\nPost($content)';

  @override
  List<Object> get props {
    return [
      id,
      userId,
      creationDate,
      content,
      room,
      upvotes,
      downvotes,
      country,
      city,
    ];
  }
}
