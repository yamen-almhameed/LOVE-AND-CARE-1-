import 'package:nursery_love_care/models/chat_massage_model.dart';

class ChatThreadModel {
  final int id;
  final String? title;
  final String thread_type;
  final bool is_active;
  final int? last_message_id;
  final String? last_message_content;
  final int? last_message_sender_id;
  final DateTime? last_message_timestamp;
  final DateTime created_at;
  final DateTime updated_at;
  final dynamic participants; // مرونة أكثر في التعامل مع البيانات
  final ChatMassageModel? lastMessage;

  ChatThreadModel({
    required this.id,
    this.title,
    required this.thread_type,
    required this.is_active,
    this.last_message_id,
    this.last_message_content,
    this.last_message_sender_id,
    this.last_message_timestamp,
    required this.created_at,
    required this.updated_at,
    required this.participants,
    this.lastMessage,
  });

  factory ChatThreadModel.fromJson(Map<String, dynamic> json) {
    try {
      return ChatThreadModel(
        id: json['id'] ?? 0,
        title: json['title'],
        thread_type: json['thread_type'] ?? 'direct',
        is_active: json['is_active'] ?? true,
        last_message_id: json['last_message_id'],
        last_message_content: json['last_message_content'],
        last_message_sender_id: json['last_message_sender_id'],
        last_message_timestamp: json['last_message_timestamp'] != null
            ? DateTime.tryParse(json['last_message_timestamp']) ??
                  DateTime.now()
            : null,
        created_at: json['created_at'] != null
            ? DateTime.tryParse(json['created_at']) ?? DateTime.now()
            : DateTime.now(),
        updated_at: json['updated_at'] != null
            ? DateTime.tryParse(json['updated_at']) ?? DateTime.now()
            : DateTime.now(),
        participants: json['participants'], // حفظ البيانات كما هي من الـ API
        lastMessage: json['lastMessage'] != null || json['last_message'] != null
            ? ChatMassageModel.fromJson(
                json['lastMessage'] ?? json['last_message'],
              )
            : null,
      );
    } catch (e) {
      print('Error parsing ChatThreadModel: $e');
      // إرجاع object افتراضي في حالة الخطأ
      return ChatThreadModel(
        id: json['id'] ?? 0,
        title: json['title'],
        thread_type: 'direct',
        is_active: true,
        created_at: DateTime.now(),
        updated_at: DateTime.now(),
        participants: json['participants'],
      );
    }
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
      'last_message_timestamp': last_message_timestamp?.toIso8601String(),
      'created_at': created_at.toIso8601String(),
      'updated_at': updated_at.toIso8601String(),
      'participants': participants,
      if (lastMessage != null) 'lastMessage': lastMessage!.toJson(),
    };
  }

  ChatThreadModel copyWith({
    int? id,
    String? title,
    String? thread_type,
    bool? is_active,
    int? last_message_id,
    String? last_message_content,
    int? last_message_sender_id,
    DateTime? last_message_timestamp,
    DateTime? created_at,
    DateTime? updated_at,
    dynamic participants,
    ChatMassageModel? lastMessage,
  }) {
    return ChatThreadModel(
      id: id ?? this.id,
      title: title ?? this.title,
      thread_type: thread_type ?? this.thread_type,
      is_active: is_active ?? this.is_active,
      last_message_id: last_message_id ?? this.last_message_id,
      last_message_content: last_message_content ?? this.last_message_content,
      last_message_sender_id:
          last_message_sender_id ?? this.last_message_sender_id,
      last_message_timestamp:
          last_message_timestamp ?? this.last_message_timestamp,
      created_at: created_at ?? this.created_at,
      updated_at: updated_at ?? this.updated_at,
      participants: participants ?? this.participants,
      lastMessage: lastMessage ?? this.lastMessage,
    );
  }
}
