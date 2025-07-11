import 'package:nursery_love_care/Service/auth_service.dart';

class ChatParticipant {
  final int id;
  final int threadId;
  final int userId;
  final DateTime joinedAt;
  final bool isAdmin;
  final int? lastReadMessageId;
  final int unreadCount;
  final UserModel user;

  ChatParticipant({
    required this.id,
    required this.threadId,
    required this.userId,
    required this.joinedAt,
    required this.isAdmin,
    this.lastReadMessageId,
    required this.unreadCount,
    required this.user,
  });

  factory ChatParticipant.fromJson(Map<String, dynamic> json) {
    return ChatParticipant(
      id: json['id'],
      threadId: json['thread_id'],
      userId: json['user_id'],
      joinedAt: DateTime.parse(json['joined_at']),
      isAdmin: json['is_admin'],
      lastReadMessageId: json['last_read_message_id'],
      unreadCount: json['unread_count'],
      user: UserModel.fromJson(json['user']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'thread_id': threadId,
      'user_id': userId,
      'joined_at': joinedAt.toIso8601String(),
      'is_admin': isAdmin,
      'last_read_message_id': lastReadMessageId,
      'unread_count': unreadCount,
      'user': user.toJson(),
    };
  }
}
