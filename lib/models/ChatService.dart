import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:nursery_love_care/Service/apiclient.dart';
import 'package:nursery_love_care/Service/auth_service.dart';
import 'package:nursery_love_care/models/chat_massage_model.dart';
import 'package:nursery_love_care/models/chat_thread_model.dart';
import 'package:nursery_love_care/models/teatcher_model.dart';

class ChatService extends GetxController {
  var messages = <ChatMassageModel>[].obs;
  var threads = <ChatThreadModel>[].obs;
  var teachers = <TeacherModel>[].obs;
  // final ChatController chatController = Get.put(ChatController());
  var currentUserId = 0.obs;
  var isLoading = false.obs;
  var selectedThread = Rxn<ChatThreadModel>();
  var Users = <UserModel>[].obs;
  UserModel? currentUser;

  @override
  void onInit() {
    super.onInit();
    fetchCurrentUser();
    fetchAdminAndTeacher();
  }

  Future<void> fetchThreads(String type, String? search) async {
    try {
      isLoading.value = true;
      final res = await Apiclient.dio.get(
        'chat/threads',
        queryParameters: {'type': type, if (search != null) 'search': search},
      );

      if (res.data != null && res.data['success'] == true) {
        List<dynamic> threadsData = res.data['data'] ?? [];
        threads.value = threadsData
            .map((json) => ChatThreadModel.fromJson(json))
            .toList();
      } else {
        if (kDebugMode) {
          print(
            'Error fetching threads: ${res.data?['message'] ?? 'Unknown error'}',
          );
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching threads: $e');
      }
    } finally {
      isLoading.value = false;
    }
  }

  Future<ChatThreadModel?> createOrGetThread({
    required List<int> participantIds,
    required String type,
    String? title,
    String? message,
  }) async {
    try {
      isLoading.value = true;

      if (kDebugMode) {
        print('Creating/Getting thread for participants: $participantIds');
      }

      // أولاً نتحقق من وجود thread مع هذا المستخدم
      await fetchThreads(type, null);

      // البحث عن thread موجود مع نفس المشاركين
      ChatThreadModel? existingThread = _findExistingThread(participantIds);

      if (existingThread != null) {
        if (kDebugMode) {
          print('Found existing thread: ${existingThread.id}');
        }
        selectedThread.value = existingThread;
        return existingThread;
      }

      if (kDebugMode) {
        print('Creating new thread');
      }

      // إنشاء thread جديد إذا لم يكن موجود
      final res = await Apiclient.dio.post(
        'chat/thread',
        data: {
          'participantIds': participantIds,
          'type': type,
          if (title != null) 'title': title,
          if (message != null) 'message': message,
        },
      );

      if (kDebugMode) {
        print('Create thread response: ${res.data}');
      }

      if (res.data != null && res.data['success'] == true) {
        ChatThreadModel newThread = ChatThreadModel.fromJson(res.data['data']);
        threads.add(newThread);
        selectedThread.value = newThread;

        if (kDebugMode) {
          print('Created new thread: ${newThread.id}');
        }

        return newThread;
      }

      return null;
    } catch (e) {
      if (kDebugMode) {
        print('Error creating/getting thread: $e');
      }
      return null;
    } finally {
      isLoading.value = false;
    }
  }

  // دالة محسنة للبحث عن thread موجود
  ChatThreadModel? _findExistingThread(List<int> participantIds) {
    //thread existing
    try {
      for (var thread in threads) {
        if (thread.participants != null) {
          // إذا كان participants عبارة عن قائمة
          if (thread.participants is List) {
            List<dynamic> participants = thread.participants as List;
            for (var participant in participants) {
              if (participant != null && participant is Map) {
                // التحقق من userId أو user_id أو id
                int? userId =
                    participant['userId'] ??
                    participant['user_id'] ??
                    participant['id'];

                // إذا كان هناك user object داخل participant
                if (userId == null && participant['user'] != null) {
                  var user = participant['user'];
                  userId = user['id'];
                }

                if (userId != null && participantIds.contains(userId)) {
                  if (kDebugMode) {
                    print('Found existing thread with participant: $userId');
                  }
                  return thread;
                }
              }
            }
          }
          // إذا كان participants عبارة عن object واحد
          else if (thread.participants is Map) {
            Map<String, dynamic> participant =
                thread.participants as Map<String, dynamic>;
            int? userId =
                participant['userId'] ??
                participant['user_id'] ??
                participant['id'];

            // إذا كان هناك user object داخل participant
            if (userId == null && participant['user'] != null) {
              var user = participant['user'];
              userId = user['id'];
            }

            if (userId != null && participantIds.contains(userId)) {
              if (kDebugMode) {
                print('Found existing thread with participant: $userId');
              }
              return thread;
            }
          }
        }
      }

      if (kDebugMode) {
        print('No existing thread found for participants: $participantIds');
      }
      return null;
    } catch (e) {
      if (kDebugMode) {
        print('Error finding existing thread: $e');
      }
      return null;
    }
  }

  Future<bool> sendMessage({
    required int threadId,
    required String content,
    String? fileUrl,
  }) async {
    try {
      final res = await Apiclient.dio.post(
        'chat/thread/$threadId/message',
        data: {'content': content, if (fileUrl != null) 'file_url': fileUrl},
      );

      if (res.data != null && res.data['success'] == true) {
        if (res.data['data'] != null) {
          ChatMassageModel newMessage = ChatMassageModel.fromJson(
            res.data['data'],
          );
          messages.add(newMessage);

          // تحديث آخر رسالة في الـ thread
          if (selectedThread.value != null) {
            selectedThread.value = selectedThread.value!.copyWith(
              lastMessage: newMessage,
            );
          }
        }
        return true;
      }
      return false;
    } catch (e) {
      if (kDebugMode) {
        print('Error sending message: $e');
      }
      return false;
    }
  }

  Future<void> getMessages(int threadId, {int? before, int limit = 50}) async {
    try {
      isLoading.value = true;
      final res = await Apiclient.dio.get(
        'chat/thread/$threadId/messages',
        queryParameters: {'limit': limit, if (before != null) 'before': before},
      );

      if (res.data != null && res.data['success'] == true) {
        List<dynamic> messagesData = res.data['data'] ?? [];
        List<ChatMassageModel> newMessages = messagesData
            .where((json) => json != null)
            .map((json) => ChatMassageModel.fromJson(json))
            .toList();

        // ترتيب الرسائل حسب التاريخ
        newMessages.sort((a, b) => a.timestamp.compareTo(b.timestamp));
        messages.value = newMessages;
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching messages: $e');
      }
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> markAsRead(int threadId) async {
    try {
      await Apiclient.dio.patch('chat/thread/$threadId/read');
    } catch (e) {
      if (kDebugMode) {
        print('Error marking as read: $e');
      }
    }
  }

  Future<void> deleteMessage(int messageId) async {
    try {
      await Apiclient.dio.delete('chat/message/$messageId');
      messages.removeWhere((message) => message.id == messageId);
    } catch (e) {
      if (kDebugMode) {
        print('Error deleting message: $e');
      }
    }
  }

  Future<void> fetchAllUsers() async {
    try {
      if (kDebugMode) {
        print('Fetching admin and teachers...');
      }

      isLoading.value = true;
      final res = await Apiclient.dio.get('chat/users/all');

      if (kDebugMode) {
        print('Fetch admin/teacher response: ${res.statusCode} - ${res.data}');
      }

      if (res.statusCode == 200 &&
          res.data != null &&
          res.data['success'] == true) {
        List<dynamic> jsonList = res.data['data'] ?? [];
        Users.value = jsonList
            .where((json) => json != null && json['role'] == 'parent')
            .map((json) => UserModel.fromJson(json))
            .toList();

        if (kDebugMode) {
          print('Loaded ${Users.length} teachers/admins');
        }
      } else {
        if (kDebugMode) {
          print('Failed to fetch admin/teacher: ${res.data}');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching admin/teacher: $e');
      }
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchAdminAndTeacher() async {
    try {
      if (kDebugMode) {
        print('Fetching admin and teachers...');
      }

      isLoading.value = true;
      final res = await Apiclient.dio.get('chat/users');

      if (kDebugMode) {
        print('Fetch admin/teacher response: ${res.statusCode} - ${res.data}');
      }

      if (res.statusCode == 200 &&
          res.data != null &&
          res.data['success'] == true) {
        List<dynamic> jsonList = res.data['data'] ?? [];
        teachers.value = jsonList
            .where((json) => json != null)
            .map((json) => TeacherModel.fromJson(json))
            .toList();

        if (kDebugMode) {
          print('Loaded ${teachers.length} teachers/admins');
        }
      } else {
        if (kDebugMode) {
          print('Failed to fetch admin/teacher: ${res.data}');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching admin/teacher: $e');
      }
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchCurrentUser() async {
    try {
      final res = await Apiclient.dio.get('user');

      if (res.statusCode == 200 && res.data != null && res.data['id'] != null) {
        currentUserId.value = res.data['id'] as int;
        currentUser = UserModel.fromJson(res.data);
        if (kDebugMode) {
          print('Current User ID: ${currentUserId.value}');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching current user: $e');
      }
    }
  }

  void clearMessages() {
    messages.clear();
    selectedThread.value = null;
  }

  ChatThreadModel? getThreadById(int threadId) {
    try {
      return threads.firstWhereOrNull((thread) => thread.id == threadId);
    } catch (e) {
      if (kDebugMode) {
        print('Error getting thread by ID: $e');
      }
      return null;
    }
  }

  //   Future<bool> deleteOneMessage(int messageId) async {
  //   try {
  //     final response = await Apiclient.dio.delete('chat/messages/$messageId');
  //     return response.statusCode == 200;
  //   } catch (e) {
  //     print("Error deleting message: $e");
  //     return false;
  //   }
  // }
}
