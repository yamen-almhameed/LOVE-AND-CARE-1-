import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nursery_love_care/models/ChatService.dart';
import 'package:nursery_love_care/models/chat_massage_model.dart';

class BuildMessageBubble extends StatelessWidget {
  final ChatMassageModel message;
  final ChatService chatService;
  const BuildMessageBubble({super.key, required this.message, required this.chatService});

  @override
  Widget build(BuildContext context) {
    bool isMe = message.senderId == chatService.currentUserId.value;
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        child: Row(
          mainAxisAlignment: isMe
              ? MainAxisAlignment.end
              : MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // صورة المرسل (للرسائل الواردة فقط)
            if (!isMe) ...[
              CircleAvatar(
                radius: 16,
                child: ClipOval(
                  child: Image.asset(
                    'assets/Image/Chiken.png',
                    width: 32,
                    height: 32,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: 8),
            ],

            // فقاعة الرسالة
            Flexible(
              child: Container(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.75,
                ),
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: isMe ? Color(0xFFf66890) : Color(0xFFf6ecdf),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                    bottomLeft: isMe ? Radius.circular(16) : Radius.circular(4),
                    bottomRight: isMe
                        ? Radius.circular(4)
                        : Radius.circular(16),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 1,
                      blurRadius: 3,
                      offset: Offset(0, 1),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // محتوى الرسالة
                    Text(
                      message.content ?? 'رسالة فارغة',
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        color: isMe ? Colors.white : Colors.black87,
                      ),
                    ),
                    SizedBox(height: 4),

                    // وقت الرسالة
                    Text(
                      DateFormat('HH:mm').format(message.timestamp),
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        color: isMe ? Colors.white70 : Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
