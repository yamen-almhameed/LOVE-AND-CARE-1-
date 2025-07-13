import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nursery_love_care/models/ChatService.dart';
import 'package:nursery_love_care/page/chat/widgets/show_clear_chat_dialog.dart';

class CustomChatActions extends StatelessWidget {
  final ChatService chatService;
  final int threadId;

  const CustomChatActions({
    Key? key,
    required this.chatService,
    required this.threadId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Color(0xFFf66890), size: 28),
          onPressed: () {
            chatService
                .clearMessages(); // إذا كنت تريد فعلاً مسح الرسائل عند الرجوع
            Get.back();
          },
        ),
        PopupMenuButton<String>(
          icon: Icon(Icons.more_vert, color: Color(0xFFf66890), size: 24),
          onSelected: (value) {
            switch (value) {
              case 'refresh':
                chatService.getMessages(threadId);
                break;
              case 'clear':
                showClearChatDialog(context, chatService);
                break;
            }
          },
          itemBuilder: (BuildContext context) => [
            PopupMenuItem<String>(
              value: 'refresh',
              child: Row(
                children: [
                  Icon(Icons.refresh, color: Color(0xFFf66890), size: 20),
                  SizedBox(width: 8),
                  Text('تحديث الرسائل'),
                ],
              ),
            ),
            PopupMenuItem<String>(
              value: 'clear',
              child: Row(
                children: [
                  Icon(Icons.clear_all, color: Colors.red, size: 20),
                  SizedBox(width: 8),
                  Text('مسح المحادثة'),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
