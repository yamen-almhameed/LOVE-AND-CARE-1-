import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/route_manager.dart';
import 'package:nursery_love_care/components/SplashScreen.dart';
import 'package:nursery_love_care/components/controller.dart';
import 'package:nursery_love_care/core/cache/shared_pref_helper.dart';
import 'package:nursery_love_care/main.dart';
import 'package:nursery_love_care/page/Login.dart';

class Splashscreenview extends StatelessWidget {
  Splashscreenview({super.key});
  SplashController controller = Get.put(SplashController());
  final List<Map<String, String>> splashData = [
    {
      'image': 'lib/assets/Image/10387865 1.png',
      'title': 'بيئة سعيدة للتعلم واللعب',
      'description':
          'روضتنا مليئة بالضحك، والفضول، والرعاية، حيث يشعر كل طفل بالأمان والمحبة، ويتحمّس لاكتشاف العالم من حوله.',
    },
    {
      'image': 'lib/assets/Image/photo 2.png',
      'title': 'نرعى بحب، لننمو بفرح',
      'description':
          'من أول يوم، نرافق الطفل برعاية محبة ونمنحه مساحة لينمو، يكتشف، ويلعب بسعادة',
    },
    {
      'image': 'lib/assets/Image/photo 3.png',
      'title': 'نعتني بخطواتهم الأولى، لنمهد لهم دروب المستقبل',
      'description':
          'نوفّر بيئة آمنة، مليئة بالحب والتشجيع، ليكتشف كل طفل إمكاناته بثقة وسعادة',
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF6ECDF),
      body: PageView.builder(
        controller: controller.pageController,
        onPageChanged: controller.onpagechanged,
        itemCount: splashData.length,
        itemBuilder: (context, index) {
          final data = splashData[index];
          return Obx(
            () => SplashScreen(
              imagePath: data['image']!,
              title: data['title']!,
              description: data['description']!,
              currentIndex: controller.currentIndex.value,
              NextPressed: () {
                controller.currentIndex.value == 2
                    ? {
                        SharedPrefHelper.setData(
                          StorageKeys.hasSeenOnboarding,
                          true,
                        ),
                        Get.offAll(Login()),
                      }
                    : controller.nextpage(splashData.length);
              },
            ),
          );
        },
      ),
    );
  }
}
