import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:nursery_love_care/Controller/login_controller.dart';

class HomePage extends StatelessWidget {
  final loginController = Get.put(LoginController());
   HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(icon: Icon(Icons.arrow_back), onPressed: () {
                  loginController.logout();
                }),
                Text('الصفحة الرئيسية'),
                IconButton(icon: Icon(Icons.search), onPressed: () {

                }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
