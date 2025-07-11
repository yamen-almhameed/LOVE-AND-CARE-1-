import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nursery_love_care/Controller/login_controller.dart';
import 'package:nursery_love_care/components/container_login.dart';
import 'package:nursery_love_care/components/custom_text_field.dart';
import 'package:nursery_love_care/page/code_otp.dart';

class ForgetpasswordSceen extends StatelessWidget {
  final loginController = Get.put(LoginController());
  final String text;
  final String title;
  final bool colorText;
  final bool navigatorPage;
  final String hintText;
  final bool limitToFour;
  ForgetpasswordSceen({
    super.key,
    required this.text,
    required this.title,
    required this.colorText,
    required this.navigatorPage,
    required this.hintText,
    required this.limitToFour,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF6ECDF),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Image.asset(
                'assets/Image/LOVE AND CARE[1]-1 (1) 2.png',
                width: 200,
                height: 200,
                fit: BoxFit.contain,
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
              Text(
                'قم بوضع البريد الالكتروني لاعادة تعين كلمة السر',
                style: GoogleFonts.inter(
                  color: Color(0xFFF66890),
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.06),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.4,
                  width: MediaQuery.of(context).size.width * 0.9,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                            top: 30,
                            bottom: 13,
                          ), // أو حسب حاجتك
                          child: Text(
                            text,
                            style: colorText
                                ? GoogleFonts.inter(
                                    color: Color(0xFFF66890),
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                  )
                                : GoogleFonts.montserrat(
                                    color: Color(0x7A000000),
                                    fontSize: 13,
                                    fontWeight:
                                        FontWeight.bold, // ✅ الصيغة الصحيحة
                                  ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20, bottom: 30),
                          child: CustomTextField(
                            limitToFour: limitToFour,
                            hintText: hintText,
                            controller: loginController.phoneController,
                            showIcon: false.obs,
                            filled: true,
                            filledColor: true,
                            hintStyle: true,
                            outInputBorder: true,
                          ),
                        ),
                        InkWell(
                          child: ContainerLogin(title: title),
                          onTap: () {
                            navigatorPage
                                ? {
                                    Get.to(CodeOtp()),
                                    loginController.phoneController.clear(),
                                  }
                                : {
                                    Get.back(),
                                    loginController.phoneController.clear(),
                                  };
                          },
                        ),
                      ],
                    ),
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
