import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:nursery_love_care/core/shared_pref_helper.dart';
import 'package:nursery_love_care/models/ChatService.dart';
import 'package:nursery_love_care/page/Services_page.dart';
import 'package:nursery_love_care/page/chat/Chat_Contact_User.dart';
import 'package:nursery_love_care/page/chat/chat_admin.dart' hide ChatContactSelectorView;
import 'package:nursery_love_care/page/home_page.dart';
import 'package:nursery_love_care/page/login_view.dart';
import 'package:nursery_love_care/page/splash_screen_view.dart';

import 'Controller/Chat_controller.dart';
import 'page/chat/chat_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefHelper.init();
  debugPaintSizeEnabled = false;

  // تسجيل الخدمات
  Get.put(ChatService());
  Get.put(ChatController());

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
        GetPage(name: '/chat', page: () => ChatContactSelectorView()),
        GetPage(
          name: '/chatScreen',
          page: () {
            final Map<String, dynamic>? args = Get.arguments;

            if (args != null &&
                args.containsKey('thread') &&
                args.containsKey('receiverName')) {
              return ChatScreen(
                thread: args['thread'],
                receiverName: args['receiverName'],
              );
            } else {
              return Scaffold(
                body: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.error, size: 64, color: Colors.red),
                      SizedBox(height: 16),
                      Text('خطأ: لم يتم توفير بيانات المحادثة'),
                      ElevatedButton(
                        onPressed: () => Get.back(),
                        child: Text('العودة'),
                      ),
                    ],
                  ),
                ),
              );
            }
          },
        ),
        GetPage(
          name: '/ChatMessagesScreen',
          page: () {
            final Map<String, dynamic>? args = Get.arguments;

            if (args != null &&
                args.containsKey('thread') &&
                args.containsKey('receiverName')) {
              return ChatMessagesScreen(
                thread: args['thread'],
                receiverName: args['receiverName'],
              );
            } else {
              return Scaffold(
                body: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.error, size: 64, color: Colors.red),
                      SizedBox(height: 16),
                      Text('خطأ: لم يتم توفير بيانات المحادثة'),
                      ElevatedButton(
                        onPressed: () => Get.back(),
                        child: Text('العودة'),
                      ),
                    ],
                  ),
                ),
              );
            }
          },
        ),
      ],
    );
  }
}

class StorageKeys {
  const StorageKeys._();
  static const String hasSeenOnboarding = 'has_seen_onboarding';
  static const String isLoggedIn = 'is_logged_in';
  static const String token = 'token';
  static const String userId = 'user_id';
  static const String userName = 'user_name';
  static const String userEmail = 'user_email';
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
