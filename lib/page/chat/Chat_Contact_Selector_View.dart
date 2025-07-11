import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nursery_love_care/components/icon_pink_back.dart';
import 'package:nursery_love_care/models/ChatService.dart';
import 'package:nursery_love_care/page/chat/chat.dart';

class ChatContactSelectorView extends StatefulWidget {
  const ChatContactSelectorView({super.key});

  @override
  State<ChatContactSelectorView> createState() =>
      _ChatContactSelectorViewState();
}

class _ChatContactSelectorViewState extends State<ChatContactSelectorView> {
  late ChatService controller;
  @override
  void initState() {
    super.initState();
    controller = Get.put(ChatService());
    controller.fetchAdminAndTeacher();
    controller.fetchCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFfef8fe),
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.16,
            width: double.infinity,
            color: Color(0xFFf6ecdf),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: Row(
                children: [
                  // زر الرجوع
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
          ),
          Expanded(
            child: Obx(
              () => ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: controller.teachers.length,
                itemBuilder: (context, index) {
                  final user = controller.teachers[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 30,
                          child: ClipOval(
                            child: Image.asset(
                              'assets/Image/Chiken.png',
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(width: 16),
                        InkWell(
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.7,
                            height: MediaQuery.of(context).size.height * 0.1,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(28),
                              border: Border.all(color: Color(0xFFffeae7)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.3),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            alignment: Alignment.center,
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            child: Text(
                              user.name,
                              style: GoogleFonts.inter(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          onTap: () async {
                            Get.to(Chat());
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
          Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.1,
                color: const Color(0xFFf6ecdf),
              ),
              Positioned(
                top: -30,
                child: InkWell(
                  child: Container(
                    width: 70,
                    height: 65,
                    decoration: BoxDecoration(
                      color: Color(0xFFf66890),
                      shape: BoxShape.circle,
                      border: Border.all(color: Color(0xFFf7cdcf), width: 8),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.keyboard_arrow_left,
                        size: 50,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  onTap: () {
                    Get.back();
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
