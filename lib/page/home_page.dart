import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nursery_love_care/Controller/login_controller.dart';
import 'package:nursery_love_care/core/shared_pref_helper.dart';
import 'package:nursery_love_care/main.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final loginController = Get.put(LoginController());
  String userName = '';
  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final name = SharedPrefHelper.getString(StorageKeys.userName);
    setState(() {
      userName = name;
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
                      child: InkWell(
                        child: Center(
                          child: Image.asset(
                            'assets/Image/Doorbell.png',
                            width: 30,
                            height: 30,
                          ),
                        ),
                        onTap: () {
                          loginController.logout();
                        },
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
              width: double.infinity,
              color: Color(0xFFf7f1e5),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 140 / 135,
                children: [
                  buildGridItem('assets/Image/Class Star.png', 'صف النجوم'),
                  InkWell(
                    child: buildGridItem(
                      'assets/Image/bara3im.png',
                      'صف البراعم',
                    ),
                    onTap: () {
                      Get.toNamed('/ServicesPage');
                    },
                  ),
                  buildGridItem('assets/Image/Class Cherry.png', 'صف الكرز'),
                  buildGridItem('assets/Image/Chiken.png', 'صف الكتاكيت'),
                  buildGridItem('assets/Image/rainbow.png', 'صف الرينبو'),
                  buildGridItem(
                    'assets/Image/event&music.png',
                    'الانشطة\nوالمناسبات',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget buildGridItem(String imagePath, String title) {
  return Container(
    decoration: BoxDecoration(
      color: Color(0xFFf6f8fa),
      borderRadius: BorderRadius.circular(32),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.3),
          spreadRadius: 2,
          blurRadius: 5,
          offset: const Offset(0, 3),
        ),
      ],
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(imagePath, width: 80, height: 80),
        const SizedBox(height: 8),
        Text(
          title,
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black,
            letterSpacing: -0.5,
          ),
        ),
      ],
    ),
  );
}

// }
// IconButton(icon: Icon(Icons.arrow_back), onPressed: () {
//                   loginController.logout();
//                 }),
