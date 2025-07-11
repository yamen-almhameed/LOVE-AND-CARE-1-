import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:nursery_love_care/Controller/Chat_controller.dart';
import 'package:nursery_love_care/Service/apiclient.dart';
import 'package:nursery_love_care/core/shared_pref_helper.dart';
import 'package:nursery_love_care/main.dart';
import 'package:nursery_love_care/models/teatcher_model.dart';

class ChatService extends GetxController {
  var messages = [].obs;
  var threads = [].obs;
  var teachers = <TeacherModel>[].obs;
  final ChatController chatController = Get.put(ChatController());
  var id;
  Future<void> fetchThreads(String type, String? search) async {//done
    try {
      final res = await Apiclient.dio.get(
        '/threads',
        queryParameters: {'type': type, if (search != null) 'search': search},
      );

      if (res.data['success']) {
        threads.value = res.data['data'];
      } else {
        if (kDebugMode) {
          print('Error fetching threads: ${res.data['message']}');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching threads: $e');
      }
    }
  }

  Future<void> createThreads({
    required List<int> paricipantIds,
    required String type,
    String? title,
    String? massage,
  }) async {
    final res = await Apiclient.dio.post(
      '/thread',
      data: {
        'paricipant_ids': paricipantIds,
        'type': type,
        if (title != null) 'title': title,
        if (massage != null) 'massage': massage,
      },
    );
    if (res.data['success']) {
      await fetchThreads(type, null);
    }
  }

  Future<void> sendMessage({
    required int threadId,
    required String content,
  }) async {
    final res = await Apiclient.dio.post(
      '/thread/$threadId/message',
      data: {'content': content},
    );
    if (!res.data['success']) {
      if (kDebugMode) {
        print('Error sending message: ${res.data['message']}');
      }
    }
  }

  Future<void> getMessages(int threadId) async {
    final res = await Apiclient.dio.get('/thread/$threadId/messages');
    if (res.data['success']) {
      messages.value = res.data['data'];
    } else {
      if (kDebugMode) {
        print('Error fetching messages: ${res.data['message']}');
      }
    }
  }

  Future<void> markAsRead(int threadId) async {
    await Apiclient.dio.patch('/thread/$threadId/read');
  }

  Future<void> deleteMessage(int messageId) async {
    await Apiclient.dio.delete('/message/$messageId');
  }

  Future<void> fetchAdminAndTeacher() async {//done 
    final res = await Apiclient.dio.get(
      'https://loveandcarenursery.com/api/chat/users',
      options: Options(
        headers: {
          'Authorization':
              'Bearer ${SharedPrefHelper.getString(StorageKeys.token)}',
        },
      ),
    );
    if (res.statusCode == 200 && res.data['success']) {
      List<dynamic> jsonList = res.data['data'];
      teachers.value = jsonList
          .map((json) => TeacherModel.fromJson(json))
          .toList();
    }
  }

  Future<void> fetchCurrentUser() async {
    final token = SharedPrefHelper.getString(StorageKeys.token);
    print("TOKEN USED: $token");

    try {
      final res = await Apiclient.dio.get(
        'http://loveandcarenursery.com/api/user',
        
        options: Options(headers: {'Authorization': 'Bearer $token', 'Accept': 'application/json'}),
      );

      if (res.statusCode == 200) {
        id = res.data['id'];
        print('User ID: $id');
      } else {
        print('Status: ${res.statusCode}, Response: ${res.data}');
      }
    } on DioException catch (e) {
      print('❌ DioException: ${e.response?.statusCode} - ${e.response?.data}');
    }
  }
}
