import 'package:nursery_love_care/Service/auth_service.dart';

class ChatMassageModel {
  final int id;
  final int? threadId;
  final int senderId;
  final int? receiverId;
  final String? content;
  final String? fileUrl;
  final DateTime timestamp;
  final bool isRead;
  final DateTime? readAt;
  final bool isDeleted;
  final String messageType;
  final UserModel sender;

  ChatMassageModel({
    required this.id,
    this.threadId,
    required this.senderId,
    this.receiverId,
    this.content,
    this.fileUrl,
    required this.timestamp,
    required this.isRead,
    this.readAt,
    required this.isDeleted,
    required this.messageType,
    required this.sender,
  });

  factory ChatMassageModel.fromJson(Map<String, dynamic> json) {
    return ChatMassageModel(
      id: json['id'],
      threadId: json['thread_id'],
      senderId: json['senderId'],
      receiverId: json['receiver_id'],
      content: json['content'],
      fileUrl: json['file_url'],
      timestamp: DateTime.parse(json['timestamp']),
      isRead: json['is_read'],
      readAt: json['read_at'] != null ? DateTime.parse(json['read_at']) : null,
      isDeleted: json['isDeleted'],
      messageType: json['message_type'],
      sender: UserModel.fromJson(json['sender']),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'thread_id': threadId,
      'senderId': senderId,
      'receiver_id': receiverId,
      'content': content,
      'file_url': fileUrl,
      'timestamp': timestamp.toIso8601String(),
      'is_read': isRead,
      'read_at': readAt?.toIso8601String(),
      'isDeleted': isDeleted,
      'message_type': messageType,
      'sender': sender.toJson(),
    };
  }
}
