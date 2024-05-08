import 'package:equatable/equatable.dart';

import 'package:the_geolounge/core/constants/request_status.dart';

class ChatRequest extends Equatable {
  const ChatRequest({
    required this.id,
    required this.createdAt,
    required this.senderId,
    required this.receiverId,
    required this.postId,
    required this.status,
    required this.openingMessage,
  });

  factory ChatRequest.fromMap(Map<String, dynamic> map) {
    return ChatRequest(
      id: map['id'] as String,
      createdAt: DateTime.parse(map['created_at'] as String),
      senderId: map['sender_id'] as String,
      receiverId: map['receiver_id'] as String,
      status: RequestStatus.values
          .firstWhere((element) => element.name == map['status'] as String),
      openingMessage: map['opening_message'] as String,
      postId: map['post_id'] as String,
    );
  }
  final String id;
  final DateTime createdAt;
  final String senderId;
  final String receiverId;
  final String postId;
  final RequestStatus status;
  final String openingMessage;

  @override
  List<Object> get props => [senderId, receiverId, status, openingMessage];

  ChatRequest copyWith({
    String? id,
    DateTime? createdAt,
    String? senderId,
    String? receiverId,
    RequestStatus? status,
    String? openingMessage,
    String? postId,
  }) {
    return ChatRequest(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      senderId: senderId ?? this.senderId,
      receiverId: receiverId ?? this.receiverId,
      status: status ?? this.status,
      openingMessage: openingMessage ?? this.openingMessage,
      postId: postId ?? this.postId,
    );
  }

  static Map<String, dynamic> toMap({
    required String receiverId,
    required String postId,
    required String openingMessage,
  }) {
    return {
      'receiver_id': receiverId,
      'opening_message': openingMessage,
      'post_id': postId,
      'status': RequestStatus.pending.name,
    };
  }

  @override
  bool get stringify => true;
}
