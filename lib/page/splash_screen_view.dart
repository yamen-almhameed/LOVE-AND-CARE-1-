import 'package:flutter/material.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/route_manager.dart';
import 'package:nursery_love_care/components/splash_screen.dart';
import 'package:nursery_love_care/components/controller.dart';
import 'package:nursery_love_care/core/shared_pref_helper.dart';
import 'package:nursery_love_care/main.dart';
import 'package:nursery_love_care/page/login_view.dart';

class SplashScreenView extends StatelessWidget {
  SplashScreenView({super.key});
  final SplashController controller = Get.put(SplashController());
  final List<Map<String, String>> splashData = [
    {
      'image': 'assets/Image/10387865 1.png',
      'title': 'بيئة سعيدة للتعلم واللعب',
      'description':
          'روضتنا مليئة بالضحك، والفضول، والرعاية، حيث يشعر كل طفل بالأمان والمحبة، ويتحمّس لاكتشاف العالم من حوله.',
    },
    {
      'image': 'assets/Image/photo 2.png',
      'title': 'نرعى بحب، لننمو بفرح',
      'description':
          'من أول يوم، نرافق الطفل برعاية محبة ونمنحه مساحة لينمو، يكتشف، ويلعب بسعادة',
    },
    {
      'image': 'assets/Image/photo 3.png',
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
                        Get.offAll(LoginView()),
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
