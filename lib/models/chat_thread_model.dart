import 'package:nursery_love_care/models/chat_massage_model.dart';
import 'package:nursery_love_care/models/chat_participant_model.dart';

class ChatThreadModel {
  final int id;
  final String? title;
  final String thread_type;
  final bool is_active;
  final int last_message_id;
  final String? last_message_content;
  final int? last_message_sender_id;
  final DateTime? last_message_timestamp;
  final DateTime created_at;
  final DateTime updated_at;
  final ChatParticipant participants;
  final ChatMassageModel? lastMessage;
  ChatThreadModel({
    required this.id,
    this.title,
    required this.thread_type,
    required this.is_active,
    required this.last_message_id,
    this.last_message_content,
    this.last_message_sender_id,
    this.last_message_timestamp,
    required this.created_at,
    required this.updated_at,
    required this.participants,
    this.lastMessage,
  });
  factory ChatThreadModel.fromJson(Map<String, dynamic> json) {
    return ChatThreadModel(
      id: json['id'],
      title: json['title'],
      thread_type: json['thread_type'],
      is_active: json['is_active'],
      last_message_id: json['last_message_id'],
      last_message_content: json['last_message_content'],
      last_message_sender_id: json['last_message_sender_id'],
      last_message_timestamp: json['last_message_timestamp'] != null
          ? DateTime.parse(json['last_message_timestamp'])
          : null,
      created_at: DateTime.parse(json['created_at']),
      updated_at: DateTime.parse(json['updated_at']),
      participants: ChatParticipant.fromJson(json['participants']),
      lastMessage: json['last_message'] != null
          ? ChatMassageModel.fromJson(json['last_message'])
          : null,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'thread_type': thread_type,
      'is_active': is_active,
      'last_message_id': last_message_id,
      'last_message_content': last_message_content,
      'last_message_sender_id': last_message_sender_id,
      'last_message_timestamp':
          last_message_timestamp?.toIso8601String(),
      'created_at': created_at.toIso8601String(),
      'updated_at': updated_at.toIso8601String(),
      'participants': participants.toJson(),
      if (lastMessage != null) 'last_message': lastMessage!.toJson(),
    };
  }
}
