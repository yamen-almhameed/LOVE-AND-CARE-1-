import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:nursery_love_care/core/cache/shared_pref_helper.dart';
import 'package:nursery_love_care/page/home_page.dart';
import 'package:nursery_love_care/page/login_view.dart';
import 'package:nursery_love_care/page/splash_screen_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefHelper.init();
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
      ],
    );
  }
}

class StorageKeys {
  const StorageKeys._();

  // Key for onboarding
  static const String hasSeenOnboarding = 'has_seen_onboarding';

  // Auth Related
  static const String isLoggedIn = 'is_logged_in';

  static const String token = 'token';
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
