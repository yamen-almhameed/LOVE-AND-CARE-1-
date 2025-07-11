import 'package:flutter/material.dart';
import 'package:nursery_love_care/Service/auth_service.dart';
import 'package:nursery_love_care/components/icon_pink_back.dart';
import 'package:nursery_love_care/core/shared_pref_helper.dart';
import 'package:nursery_love_care/main.dart';

class Chat extends StatefulWidget {
  const Chat({super.key});

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  String userName = '';

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  void _loadUserData() async {
    String value = SharedPrefHelper.getString(StorageKeys.token);
    setState(() {
      userName = value;
    });
  }

  void _saveUserName(String name) async {
    await SharedPrefHelper.setData(StorageKeys.token, name);
  }

  @override
  Widget build(BuildContext context) {
    LoginRespones? arguments =
        ModalRoute.of(context)?.settings.arguments as LoginRespones?;
    if (arguments != null) {
      userName = arguments.user.name;
      _saveUserName(userName);
    }

    return Scaffold(
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.16,
            width: double.infinity,
            color: Color(0xFFf6ecdf),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // زر الرجوع
                  Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: IconPinkBack(width: 60, height: 70),
                  ),
                  Row(
                    children: [
                      Text(
                        userName.isNotEmpty ? userName : 'اسم المستخدم',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(width: 5),
                      Image.asset(
                        'assets/Image/friend.png',
                        width: 80,
                        height: 80,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // ✅ Expanded لإظهار الرسائل
          Expanded(
            child: ListView.builder(
              itemCount: 13, // عدد الرسائل
              itemBuilder: (context, index) {
                bool isMe = index % 2 == 0; // تحديد من أرسل الرسالة
                return Align(
                  alignment: isMe
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Row(
                    mainAxisAlignment: isMe
                        ? MainAxisAlignment.end
                        : MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (!isMe)
                        Padding(
                          padding: const EdgeInsets.only(top: 6),
                          child: CircleAvatar(
                            radius: 20,
                            backgroundImage: AssetImage(
                              'assets/Image/friend.png',
                            ),
                          ),
                        ),

                      Container(
                        margin: EdgeInsets.symmetric(
                          vertical: 5,
                          horizontal: 10,
                        ),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: isMe ? Color(0xFFd6d6d6) : Color(0xFFf6ecdf),
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 1,
                              blurRadius: 5,
                            ),
                          ],
                        ),
                        child: Text(
                          isMe
                              ? 'مرحبا، كيف يمكنني مساعدتك اليوم؟'
                              : 'أهلا! أنا هنا للمساعدة.',
                          style: TextStyle(fontSize: 16, color: Colors.black87),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),

          // ✅ القسم السفلي — عبارة تعريفية فقط (يمكن تغييره لاحقًا إلى TextField لإرسال رسالة)
          Container(
            height: MediaQuery.of(context).size.height * 0.1,
            width: double.infinity,
            color: Color(0xFFf6ecdf),
            child: Center(
              child: Text(
                'تواصل معنا عبر الدردشة في أي وقت',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.black54,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
