import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nursery_love_care/Service/auth_service.dart';
import 'package:nursery_love_care/models/ChatService.dart';
import 'package:nursery_love_care/models/chat_thread_model.dart';
import 'package:nursery_love_care/page/chat/widgets/build_empty_state.dart';
import 'package:nursery_love_care/page/chat/widgets/build_message_bubble.dart';
import 'package:nursery_love_care/page/chat/widgets/custom_chat_app_bar%20.dart';

class ChatScreen extends StatefulWidget {
  final ChatThreadModel thread;
  final String receiverName;

  const ChatScreen({
    super.key,
    required this.thread,
    required this.receiverName
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late ChatService chatService;
  final TextEditingController messageController = TextEditingController();
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    chatService = Get.find<ChatService>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      chatService.getMessages(widget.thread.id);
      chatService.markAsRead(widget.thread.id);
    });
  }

  @override
  void dispose() {
    messageController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  Future<void> _sendMessage() async {
    if (messageController.text.trim().isEmpty) return;

    String messageText = messageController.text.trim();
    messageController.clear();

    bool success = await chatService.sendMessage(
      threadId: widget.thread.id,
      content: messageText,
    );

    if (success) {
      _scrollToBottom();
    } else {
      Get.snackbar(
        'خطأ',
        'فشل في إرسال الرسالة',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      messageController.text = messageText;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFfef8fe),
      appBar: CustomChatAppBar(
        receiverName: widget.receiverName,
        chatService: chatService,
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              if (chatService.isLoading.value && chatService.messages.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CircularProgressIndicator(color: Color(0xFFf66890)),
                      const SizedBox(height: 16),
                      Text(
                        'جاري تحميل الرسائل...',
                        style: GoogleFonts.inter(
                          fontSize: 16,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                );
              }

              if (chatService.messages.isEmpty) {
                return BuildEmptyState(receiverName: widget.receiverName);
              }

              return RefreshIndicator(
                onRefresh: () => chatService.getMessages(widget.thread.id),
                child: ListView.builder(
                  controller: scrollController,
                  itemCount: chatService.messages.length,
                  itemBuilder: (context, index) {
                    final message = chatService.messages[index];
                    return BuildMessageBubble(
                      message: message,
                      chatService: chatService,
                    );
                  },
                ),
              );
            }),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 23),
            decoration: BoxDecoration(
              color: const Color(0xFFF6ECDF),
              border: Border(top: BorderSide(color: Colors.grey[300]!)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 3,
                  offset: const Offset(0, -1),
                ),
              ],
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.attach_file,
                  color: Color(0xFFf66890),
                  size: 28,
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: TextField(
                      controller: messageController,
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        color: Colors.black87,
                      ),
                      decoration: InputDecoration(
                        hintText: '... اكتب رسالتك',
                        hintStyle: GoogleFonts.inter(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 12,
                        ),
                      ),
                      textAlign: TextAlign.right,
                      maxLines: null,
                      textInputAction: TextInputAction.send,
                      onSubmitted: (_) => _sendMessage(),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Obx(() {
                  final isLoading = chatService.isLoading.value;
                  return InkWell(
                    onTap: isLoading ? null : _sendMessage,
                    child: Container(
                      width: 45,
                      height: 45,
                      decoration: BoxDecoration(
                        color: isLoading
                            ? Colors.grey
                            : const Color(0xFFf66890),
                        shape: BoxShape.circle,
                      ),
                      child: isLoading
                          ? const Center(
                              child: SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              ),
                            )
                          : const Icon(
                              Icons.send,
                              color: Colors.white,
                              size: 20,
                            ),
                    ),
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
