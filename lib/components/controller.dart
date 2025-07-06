import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nursery_love_care/page/Login.dart';

class SplashController extends GetxController {
  var currentIndex = 0.obs;
  late PageController pageController;

  @override
  void onInit() {
    super.onInit();
    pageController = PageController();
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }

  void nextpage(int length) {
    if (currentIndex.value < length - 1) {
      currentIndex.value++;
      pageController.animateToPage(
        currentIndex.value,
        duration: const Duration(milliseconds: 400),
        curve: Curves.fastOutSlowIn,
      );
    } else {
      Get.offAll(Login());
    }
  }

  void onpagechanged(int index) {
    currentIndex.value = index;
  }
}
