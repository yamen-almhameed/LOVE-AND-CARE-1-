import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nursery_love_care/components/icon_pink_back.dart';
import 'package:nursery_love_care/models/ChatService.dart';

class CustomChatAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String receiverName;
  final ChatService chatService;

  const CustomChatAppBar({
    super.key,
    required this.receiverName,
    required this.chatService,
  });

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight * 2);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFFf6ecdf),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 3,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              // زر الرجوع
              IconPinkBack(width: 60, height: 60),

              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      receiverName,
                      style: GoogleFonts.inter(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Obx(
                      () => Text(
                        chatService.isLoading.value ? 'جاري التحميل...' : 'متصل',
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          color: chatService.isLoading.value ? Colors.orange : Colors.green,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(width: 8),

              // صورة المستقبل مع إطار دائري
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Color(0xFFf66890),
                    width: 2,
                  ),
                ),
                child: CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.white,
                  child: ClipOval(
                    child: Image.asset(
                      'assets/Image/Chiken.png',
                      width: 46,
                      height: 46,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
