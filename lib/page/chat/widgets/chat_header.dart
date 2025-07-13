import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nursery_love_care/components/icon_pink_back.dart';

class ChatHeader extends StatelessWidget {
  const ChatHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.16,
      width: double.infinity,
      color: const Color(0xFFf6ecdf),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: IconPinkBack(width: 60, height: 70),
            ),
            SizedBox(width: MediaQuery.of(context).size.width * 0.19),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Text(
                'الدردشة',
                style: GoogleFonts.inter(
                  fontSize: 32,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
