import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:nursery_love_care/core/cache/shared_pref_helper.dart';
import 'package:nursery_love_care/page/SplashScreenView.dart';
import 'package:nursery_love_care/page/Login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
        GetPage(name: '/', page: () => Splashscreenview()),
        GetPage(name: '/login', page: () => Login()),
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
}

String checkIfUserSeenOnboarding() {
  if (SharedPrefHelper.getBool(StorageKeys.hasSeenOnboarding) == true) {
    return '/login';
  } else {
    return '/';
  }
}
