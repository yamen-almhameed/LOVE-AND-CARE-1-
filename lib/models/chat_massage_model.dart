import 'package:nursery_love_care/Service/auth_service.dart';

class ChatMassageModel {
  final int? id;
  final int? threadId;
  final int? senderId;
  final int? receiverId;
  final String? content;
  final String? fileUrl;
  final DateTime timestamp;
  final bool isRead;
  final DateTime? readAt;
  final bool isDeleted;
  final String messageType;
  final UserModel? sender;

  ChatMassageModel({
    this.id,
    this.threadId,
    this.senderId,
    this.receiverId,
    this.content,
    this.fileUrl,
    required this.timestamp,
    required this.isRead,
    this.readAt,
    required this.isDeleted,
    required this.messageType,
    this.sender,
  });

  factory ChatMassageModel.fromJson(Map<String, dynamic> json) {
    try {
      return ChatMassageModel(
        id: json['id'] as int?,
        threadId: json['thread_id'] as int?,
        senderId: json['senderId'] as int?,
        receiverId: json['receiver_id'] as int?,
        content: json['content'] as String?,
        fileUrl: json['file_url'] as String?,
        timestamp: json['timestamp'] != null
            ? DateTime.tryParse(json['timestamp']) ?? DateTime.now()
            : DateTime.now(),
        isRead: json['is_read'] as bool? ?? false,
        readAt: json['read_at'] != null
            ? DateTime.tryParse(json['read_at'])
            : null,
        isDeleted: json['isDeleted'] as bool? ?? false,
        messageType: json['message_type'] as String? ?? 'text',
        sender: json['sender'] != null
            ? UserModel.fromJson(json['sender'])
            : null,
      );
    } catch (e) {
      print('Error parsing ChatMassageModel: $e');
      // إرجاع object افتراضي في حالة الخطأ
      return ChatMassageModel(
        id: json['id'] as int?,
        content: json['content'] as String? ?? 'رسالة غير صالحة',
        timestamp: DateTime.now(),
        isRead: false,
        isDeleted: false,
        messageType: 'text',
      );
    }
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
      'sender': sender?.toJson(),
    };
  }
}
