import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nursery_love_care/Service/auth_service.dart';
import 'package:nursery_love_care/models/ChatService.dart';
import 'package:nursery_love_care/models/chat_thread_model.dart';

class ChatMessagesScreen extends StatefulWidget {
  final ChatThreadModel? thread;
  final UserModel receiverName;

  const ChatMessagesScreen({
    Key? key,
    required this.thread,
    required this.receiverName,
  }) : super(key: key);

  @override
  State<ChatMessagesScreen> createState() => _ChatMessagesScreenState();
}

class _ChatMessagesScreenState extends State<ChatMessagesScreen> {
  late ChatService chatService;

  @override
  void initState() {
    super.initState();
    chatService = Get.find<ChatService>();

    if (widget.thread != null) {
      chatService.selectedThread.value = widget.thread!;
      chatService.getMessages(widget.thread!.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.receiverName.name)),
      body: Obx(() {
        if (chatService.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final messages = chatService.messages;

        if (messages.isEmpty) {
          return const Center(child: Text("لا توجد رسائل"));
        }

        return ListView.builder(
          reverse: true,
          itemCount: messages.length,
          itemBuilder: (context, index) {
            final message = messages[index];
            final isMine = message.senderId == chatService.currentUserId.value;

            return Align(
              alignment: isMine ? Alignment.centerRight : Alignment.centerLeft,
              child: Container(
                padding: const EdgeInsets.all(12),
                margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
                decoration: BoxDecoration(
                  color: isMine ? Colors.blue[100] : Colors.grey[300],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(message.content ?? ''),
              ),
            );
          },
        );
      }),
    );
  }
}
