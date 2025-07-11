import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nursery_love_care/Controller/login_controller.dart';
import 'package:nursery_love_care/components/forgetpassword_sceen.dart';

class ForgetPassword extends StatelessWidget {
  final loginController = Get.put(LoginController());
  ForgetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return ForgetpasswordSceen(
      text: 'سوف نرسل لك كود التحقق للبريد الالكتروني المسجل',
      title: 'ارسال كود التحقق',
      colorText: true,
      hintText: 'البريد الالكتروني',
      limitToFour: false,
      navigatorPage: true,
    );
  }
}
