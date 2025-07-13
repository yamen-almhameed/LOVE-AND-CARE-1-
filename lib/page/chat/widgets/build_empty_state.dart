import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BuildEmptyState extends StatelessWidget {
  final String receiverName;
  const BuildEmptyState({super.key, required this.receiverName});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.chat_bubble_outline, size: 80, color: Colors.grey[400]),
          SizedBox(height: 16),
          Text(
            'لا توجد رسائل حتى الآن',
            style: GoogleFonts.inter(fontSize: 18, color: Colors.grey[600]),
          ),
          SizedBox(height: 8),
          Text(
            'ابدأ المحادثة مع ${receiverName}!',
            style: GoogleFonts.inter(fontSize: 14, color: Colors.grey[500]),
          ),
        ],
      ),
    );
  }
}