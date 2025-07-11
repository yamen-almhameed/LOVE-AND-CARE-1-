import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nursery_love_care/Controller/login_controller.dart';
import 'package:nursery_love_care/components/container_login.dart';
import 'package:nursery_love_care/components/custom_text_field.dart';
import 'package:nursery_love_care/page/forget_password.dart';

class LoginView extends StatelessWidget {
  final loginController = Get.put(LoginController());

  bool checked;

  LoginView({super.key, this.checked = false});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFFF6ECDF),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 40),
                child: Image.asset(
                  'assets/Image/LOVE AND CARE[1]-1 (1) 2.png',
                  width: 200,
                  height: 200,
                  fit: BoxFit.contain,
                ),
              ),
              Text(
                'سجل الدخول الآن',
                style: GoogleFonts.inter(
                  color: Color(0xFFF66890),
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Center(
                child: Container(
                  child: Text(
                    'قم بوضع رقم الهاتف وكلمة السر',
                    style: GoogleFonts.inter(
                      color: Color(0xFFF66890),
                      fontSize: 14,
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
                        showIcon: loginController.ignoreShowIcon,
                        visibility: loginController.isPasswordVisible,
                        toggleVisibility:
                            loginController.togglePasswordVisibility,
                      ),
                      SizedBox(height: 10),
                      CustomTextField(
                        hintText: 'كلمة السر',
                        controller: loginController.passwordController,
                        showIcon: loginController.showIcon,
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
                                child: Obx(
                                  () => Checkbox(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    side: BorderSide(color: Colors.black),
                                    checkColor: Colors.black,
                                    activeColor: Color(0xFF6c7278),
                                    value: loginController.isChecked.value,
                                    onChanged: (value) {
                                      loginController.isChecked.value = value!;
                                      print(value);
                                    },
                                  ),
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
                          InkWell(
                            child: Text(
                              'هل نسيت كلمة السر؟',
                              style: TextStyle(
                                color: Color(0xFF4d81e7),
                                fontSize: 14,
                                fontFamily: 'Inter_18pt',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            onTap: () {
                              Get.to(ForgetPassword());
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: 15),
                      InkWell(
                        onTap: () {
                          loginController.login();
                        },
                        child: ContainerLogin(title: 'سجل الدخول'),
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
    );
  }
}
