import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class LoginController extends GetxController {
  var ShowIcon = true.obs;
  var IgnoreShowIcon = false.obs;
  var isPasswordVisible = false.obs;
  var phoneController = TextEditingController();
  var passwordController = TextEditingController();
  var isLoading = false.obs;

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }
}
