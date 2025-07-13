import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nursery_love_care/models/ChatService.dart';

void showClearChatDialog(BuildContext context, ChatService chatService) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(
          'مسح المحادثة',
          style: GoogleFonts.inter(fontWeight: FontWeight.bold),
        ),
        content: Text(
          'هل أنت متأكد من أنك تريد مسح جميع الرسائل؟',
          style: GoogleFonts.inter(),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('إلغاء', style: GoogleFonts.inter(color: Colors.grey)),
          ),
          TextButton(
            onPressed: () {
              //  chatService.clearMessages();
              Navigator.of(context).pop();
              Get.snackbar(
                'تم',
                'تم مسح المحادثة محلياً',
                backgroundColor: Colors.green,
                colorText: Colors.white,
              );
            },
            child: Text('مسح', style: GoogleFonts.inter(color: Colors.red)),
          ),
        ],
      );
    },
  );
}
