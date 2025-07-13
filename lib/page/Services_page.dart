import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nursery_love_care/components/container_service.dart';
import 'package:nursery_love_care/core/shared_pref_helper.dart';
import 'package:nursery_love_care/main.dart';
import 'package:nursery_love_care/models/ChatService.dart';
import 'package:nursery_love_care/page/chat/Chat_Contact_User.dart';
import 'package:nursery_love_care/page/chat/chat_contact_admin.dart';

class ServicesPage extends StatefulWidget {
  const ServicesPage({super.key});

  @override
  State<ServicesPage> createState() => _ServicesPageState();
}

class _ServicesPageState extends State<ServicesPage> {
  String userName = '';
  late ChatService chatService;

  @override
  void initState() {
    super.initState();
    chatService = Get.find<ChatService>();

    _loadUserData();
  }

  void _loadUserData() async {
    String value = SharedPrefHelper.getString(StorageKeys.userName);
    setState(() {
      userName = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.14,
              color: Color(0xFFf6ecdf),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: Color(0x42D9D9D9),
                        shape: BoxShape.circle,
                        border: Border.all(color: Color(0xFFBDBDBD), width: 1),
                      ),
                      child: Center(
                        child: Image.asset(
                          'assets/Image/Doorbell.png',
                          width: 30,
                          height: 30,
                        ),
                      ),
                    ),
                    Text(
                      '! $userName اهلا\nمرحبا بك مرة اخرى',
                      textAlign: TextAlign.right,
                      style: GoogleFonts.inter(
                        fontSize: 24,
                        letterSpacing: -0.5,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              color: Color(0xFFf7f1e5),
              width: double.infinity,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(40),
                          child: Text(
                            'الخدمات',
                            style: GoogleFonts.inter(
                              fontSize: 17,
                              letterSpacing: -0.5,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    child: ContainerService(
                      title: 'الدردشة',
                      description: ',ابقَ على اتصال\n دائمًا نحن معك',
                      image: 'assets/Image/image 8.png',
                    ),
                    onTap: () {
                      Get.to(() {
                        if (chatService.currentUser?.role == 'parent') {
                          return ChatContactSelectorView();
                        } else {
                          return ChatContactSelectorViewAdmin();
                        }
                      });
                    },
                  ),
                  ContainerService(
                    title: 'الكاميرا',
                    description: 'اكتشف ماذا يفعل صغيرك\n   اليوم',
                    image: 'assets/Image/image 10.png',
                    isImageLeft: true,
                  ),
                  ContainerService(
                    title: 'الاشعارات',
                    description: 'تقرير عن يوم مليء\n بالفرح والاكتشاف',
                    image: 'assets/Image/image 11.png',
                    color: false,
                  ),
                ],
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
