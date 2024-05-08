import 'package:equatable/equatable.dart';

class Message extends Equatable {
  const Message({
    required this.id,
    required this.senderId,
    required this.receiverId,
    required this.chatRequestId,
    required this.content,
    required this.sentAt,
  });

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      id: map['id'] as String,
      sentAt: DateTime.parse(map['sent_at'] as String),
      chatRequestId: map['chat_request_id'] as String,
      senderId: map['sender_id'] as String,
      receiverId: map['receiver_id'] as String,
      content: map['content'] as String,
    );
  }
  final String id;
  final String senderId;
  final String receiverId;
  final String chatRequestId;
  final String content;
  final DateTime sentAt;

  @override
  List<Object> get props {
    return [
      id,
      senderId,
      receiverId,
      chatRequestId,
      content,
      sentAt,
    ];
  }

  Message copyWith({
    String? id,
    String? senderId,
    String? receiverId,
    String? chatRequestId,
    String? content,
    DateTime? sentAt,
  }) {
    return Message(
      id: id ?? this.id,
      senderId: senderId ?? this.senderId,
      receiverId: receiverId ?? this.receiverId,
      chatRequestId: chatRequestId ?? this.chatRequestId,
      content: content ?? this.content,
      sentAt: sentAt ?? this.sentAt,
    );
  }

  static Map<String, dynamic> toMap(
    String receiverId,
    String chatRequestId,
    String content,
  ) {
    return <String, dynamic>{
      'receiver_id': receiverId,
      'chat_request_id': chatRequestId,
      'content': content,
    };
  }

  @override
  bool get stringify => true;
}
