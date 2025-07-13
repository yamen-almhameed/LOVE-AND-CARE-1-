import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nursery_love_care/Service/auth_service.dart';
import 'package:nursery_love_care/core/shared_pref_helper.dart';
import 'package:nursery_love_care/main.dart';

class LoginController extends GetxController {
  var showIcon = true.obs;
  var ignoreShowIcon = false.obs;
  var isPasswordVisible = false.obs;
  var phoneController = TextEditingController();
  var passwordController = TextEditingController();
  var isLoading = false.obs;
  var isChecked = false.obs;

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  Future<void> login() async {
    final email = phoneController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      Get.snackbar('خطأ', 'يرجى إدخال البريد وكلمة المرور');
      return;
    }

    isLoading.value = true;

    try {
      final response = await AuthService.login(email, password);
      UserModel user = UserModel.fromJson(response.user.toJson());

      LoginRespones loginData = LoginRespones(
        token: response.token,
        tokenType: response.tokenType,
        user: user,
        message: response.message,
      );
      print(loginData.toJson());
      if (isChecked.value) {
        await SharedPrefHelper.setData(StorageKeys.token, response.token);
        await SharedPrefHelper.setData(
          StorageKeys.userName,
          response.user.name,
        );
      } else {
        await SharedPrefHelper.removeData(StorageKeys.token);
        await SharedPrefHelper.setData(
          StorageKeys.userName,
          response.user.name,
        );
      }
      Get.snackbar('تم بنجاح', response.message);
      log('${user.role.toString()}');
      if (user.role == "parent") {
        Get.offAllNamed('/HomePage');
      } else {
        Get.offAllNamed('/ServicesPage');
      }
    } catch (e) {
      Get.snackbar('فشل الدخول', 'تأكد من صحة البيانات أو جرب مرة أخرى');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> logout() async {
    isLoading.value = true;
    try {
      await AuthService.logout();

      await SharedPrefHelper.removeData(StorageKeys.token);

      Get.offAllNamed('/login');
    } catch (e) {
      Get.snackbar('خطأ', 'حدث خطأ أثناء تسجيل الخروج');
    } finally {
      isLoading.value = false;
    }
  }
}
