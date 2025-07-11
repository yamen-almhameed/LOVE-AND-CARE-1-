import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:nursery_love_care/models/ChatService.dart';
import 'package:nursery_love_care/page/Services_page.dart';
import 'package:nursery_love_care/core/shared_pref_helper.dart';
import 'package:nursery_love_care/page/chat/chat.dart' show Chat;
import 'package:nursery_love_care/page/home_page.dart';
import 'package:nursery_love_care/page/login_view.dart';
import 'package:nursery_love_care/page/splash_screen_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefHelper.init();
  debugPaintSizeEnabled = false;
  Get.put(ChatService());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: checkIfUserSeenOnboarding(),
      debugShowCheckedModeBanner: false,
      getPages: [
        GetPage(name: '/splash', page: () => SplashScreenView()),
        GetPage(name: '/login', page: () => LoginView()),
        GetPage(name: '/HomePage', page: () => HomePage()),
        GetPage(name: '/ServicesPage', page: () => const ServicesPage()),
        GetPage(name: '/chat', page: () => const Chat()),
      ],
    );
  }
}

// GetPage(
//   name: '/messages/:threadId',
//   page: () {
//     // استخرج threadId من الباراميتر كـ String، ثم حوّله إلى int
//     final threadIdString = Get.parameters['threadId'];
//     final threadId = int.tryParse(threadIdString ?? '') ?? 0;
//     return MessagesScreen(threadId: threadId);
//   },
// ),
class StorageKeys {
  const StorageKeys._();

  // Key for onboarding
  static const String hasSeenOnboarding = 'has_seen_onboarding';

  // Auth Related
  static const String isLoggedIn = 'is_logged_in';

  static const String token = 'token';

  static const String userName = 'user_name';

  static const userData = 'user_data';
}

String checkIfUserSeenOnboarding() {
  bool hasSeenOnboarding = SharedPrefHelper.getBool(
    StorageKeys.hasSeenOnboarding,
  );
  String isLoggedIn = SharedPrefHelper.getString(StorageKeys.token).toString();
  if (isLoggedIn.isNotEmpty && isLoggedIn != 'null') {
    return '/HomePage';
  }
  if (hasSeenOnboarding) {
    log('User has seen onboarding, navigating to home');
    return '/login';
  } else {
    return '/splash';
  }
}
