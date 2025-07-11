import 'package:flutter/material.dart';
import 'package:nursery_love_care/components/forgetpassword_sceen.dart';

class CodeOtp extends StatelessWidget {
  const CodeOtp({super.key});

  @override
  Widget build(BuildContext context) {
    return ForgetpasswordSceen(
      text: 'ahmad@gmail.com أدخل رمز الكود المرسل ألى ',
      title: 'تاكيد كود التحقق',
      colorText: false,
      hintText: 'كود التحقق',
      limitToFour: true,
      navigatorPage: false,
    );
  }
}
