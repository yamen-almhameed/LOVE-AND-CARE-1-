import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nursery_love_care/models/ChatService.dart';
import 'package:nursery_love_care/page/home_page.dart';

class ThreadsScreen extends StatelessWidget {
  final ChatService controller = Get.put(ChatService());

  ThreadsScreen({super.key}) {
    controller.fetchThreads('direct', null);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('المحادثات'),
          actions: [
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                Get.to(() => HomePage());
              },
            ),
          ],
        ),
        body: Obx(() {
          if (controller.threads.isEmpty) {
            return const Center(child: Text('لا توجد محادثات حالياً'));
          }

          return ListView.builder(
            itemCount: controller.threads.length,
            itemBuilder: (context, index) {
              final thread = controller.threads[index];

              final title = thread['title'] ?? 'بدون عنوان';
              final lastMessage =
                  thread['last_message']?['content'] ?? 'لا توجد رسائل';

              return ListTile(
                title: Text(title),
                subtitle: Text(
                  lastMessage,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                onTap: () {
                  final threadId = thread['id'];
                  Get.to(() => HomePage()); //MessagesScreen(threadId: threadId));
                },
              );
            },
          );
        }),
      ),
    );
  }
}
