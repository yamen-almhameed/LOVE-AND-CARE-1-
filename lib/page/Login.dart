
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:nursery_love_care/Controller/Login_Controller.dart';
import 'package:nursery_love_care/components/TextField.dart';

class Login extends StatelessWidget {
  TextEditingController PhoneNumber = TextEditingController();
  final loginController = Get.put(LoginController());

  Login({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          backgroundColor: Color(0xFFF6ECDF),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: Image.asset(
                    'lib/assets/Image/LOVE AND CARE[1]-1 (1) 2.png',
                    width: 200,
                    height: 200,
                    fit: BoxFit.contain,
                  ),
                ),
                Text(
                  'سجل الدخول الآن',
                  style: TextStyle(
                    color: Color(0xFFF66890),
                    fontSize: 35,
                    fontFamily: 'Inter_18pt',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Center(
                  child: Container(
                    child: Text(
                      'قم بوضع رقم الهاتف وكلمة السر',
                      style: TextStyle(
                        color: Color(0xFFF66890),
                        fontSize: 14,
                        fontFamily: 'Inter_18pt',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(25),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      children: [
                        CustomTextField(
                          hintText: 'رقم الهاتف',
                          controller: loginController.phoneController,
                          ShowIcon: loginController.IgnoreShowIcon,
                          visibility: loginController.isPasswordVisible,
                          toggleVisibility:
                              loginController.togglePasswordVisibility,
                        ),
                        SizedBox(height: 10),
                        CustomTextField(
                          hintText: 'كلمة السر',
                          controller: PhoneNumber,
                          ShowIcon: loginController.ShowIcon,
                          visibility: loginController.isPasswordVisible,
                          toggleVisibility:
                              loginController.togglePasswordVisibility,
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Transform.scale(
                                  scale: 0.8,
                                  child: Checkbox(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    side: BorderSide(color: Colors.black),
                                    checkColor: Colors.black,
                                    activeColor: Color(0xFF6c7278),
                                    value: false,
                                    onChanged: (value) {},
                                  ),
                                ),
                                Text(
                                  'تذكرني',
                                  style: TextStyle(
                                    color: Color(0xFF6c7278),
                                    fontSize: 13,
                                    fontFamily: 'Inter_18pt',
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              'هل نسيت كلمة السر؟',
                              style: TextStyle(
                                color: Color(0xFF4d81e7),
                                fontSize: 14,
                                fontFamily: 'Inter_18pt',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 15),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Color(0xFFF66890),
                          ),
                          height: 48,
                          child: Center(
                            child: Text(
                              'سجل الدخول',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontFamily: 'Inter_18pt',
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 50),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
