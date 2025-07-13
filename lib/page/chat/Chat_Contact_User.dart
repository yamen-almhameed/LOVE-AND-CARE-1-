import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nursery_love_care/components/icon_pink_back.dart';
import 'package:nursery_love_care/models/ChatService.dart';
import 'package:nursery_love_care/models/teatcher_model.dart';
import 'package:nursery_love_care/page/Services_page.dart';
import 'package:nursery_love_care/page/chat/chat_screen.dart';

class ChatContactSelectorView extends StatefulWidget {
  const ChatContactSelectorView({super.key});

  @override
  State<ChatContactSelectorView> createState() =>
      _ChatContactSelectorViewState();
}

class _ChatContactSelectorViewState extends State<ChatContactSelectorView> {
  late ChatService chatService;

  @override
  void initState() {
    super.initState();
    chatService = Get.find<ChatService>();

    // جلب المدرسين والإداريين عند فتح الشاشة
    chatService.fetchAdminAndTeacher();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFfef8fe),
      body: Column(
        children: [
          // Header
          Container(
            height: MediaQuery.of(context).size.height * 0.16,
            width: double.infinity,
            color: Color(0xFFf6ecdf),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: Row(
                children: [
                  // icon back
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: IconPinkBack(width: 60, height: 70),
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.19),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Text(
                      'الدردشة',
                      style: GoogleFonts.inter(
                        fontSize: 32,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Refresh data button
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Obx(
                  () => ElevatedButton.icon(
                    onPressed: chatService.isLoading.value
                        ? null
                        : () => chatService.fetchAdminAndTeacher(),
                    icon: chatService.isLoading.value
                        ? SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : Icon(Icons.refresh, color: Colors.white),
                    label: Text(
                      'تحديث',
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFf66890),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // قائمة المدرسين والإداريين
          Expanded(
            child: Obx(() {
              if (chatService.isLoading.value && chatService.teachers.isEmpty) {
                //Loading teacher
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(color: Color(0xFFf66890)),
                      SizedBox(height: 16),
                      Text(
                        'جاري تحميل قائمة المعلمين والإداريين...',
                        style: GoogleFonts.inter(
                          fontSize: 16,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                );
              }
              if (chatService.teachers.isEmpty) {
                //Empty teacher
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.people_outline,
                        size: 80,
                        color: Colors.grey[400],
                      ),
                      SizedBox(height: 16),
                      Text(
                        'لا يوجد أي معلمين أو إداريين',
                        style: GoogleFonts.inter(
                          fontSize: 18,
                          color: Colors.grey[600],
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'تأكد من الاتصال بالإنترنت وحاول مرة أخرى',
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          color: Colors.grey[500],
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () => chatService.fetchAdminAndTeacher(),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFFf66890),
                          foregroundColor: Colors.white,
                        ),
                        child: Text('إعادة المحاولة'),
                      ),
                    ],
                  ),
                );
              }

              return RefreshIndicator(
                //Widget refresh the data by pulling down(scroll up)
                onRefresh: () => chatService.fetchAdminAndTeacher(),
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  physics: AlwaysScrollableScrollPhysics(),
                  itemCount: chatService.teachers.length,
                  itemBuilder: (context, index) {
                    final user = chatService.teachers[index];
                    return _buildUserCard(user);
                  },
                ),
              );
            }),
          ),

          Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.1,
                color: const Color(0xFFf6ecdf),
              ),
              Positioned(
                top: -30,
                child: InkWell(
                  child: Container(
                    width: 70,
                    height: 65,
                    decoration: BoxDecoration(
                      color: Color(0xFFf66890),
                      shape: BoxShape.circle,
                      border: Border.all(color: Color(0xFFf7cdcf), width: 8),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.keyboard_arrow_left,
                        size: 50,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  onTap: () {
                    Get.back();
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildUserCard(TeacherModel user) {
    //card of Teacher
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Color(0xFFffeae7)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: InkWell(
          onTap: () => _handleUserTap(user),
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                // صورة المستخدم
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Color(0xFFf66890), width: 2),
                  ),
                  child: CircleAvatar(
                    radius: 30,
                    backgroundColor: Color(0xFFf6ecdf),
                    child: ClipOval(
                      child:
                          user.profileImageUrl != null &&
                              user.profileImageUrl!.isNotEmpty
                          ? Image.network(
                              user.profileImageUrl!,
                              width: 56,
                              height: 56,
                              fit: BoxFit.cover,
                              loadingBuilder:
                                  (context, child, loadingProgress) {
                                    if (loadingProgress == null) return child;
                                    return Center(
                                      child: CircularProgressIndicator(
                                        color: Color(0xFFf66890),
                                        strokeWidth: 2,
                                      ),
                                    );
                                  },
                              errorBuilder: (context, error, stackTrace) {
                                return Image.asset(
                                  'assets/Image/Chiken.png',
                                  width: 56,
                                  height: 56,
                                  fit: BoxFit.cover,
                                );
                              },
                            )
                          : Image.asset(
                              'assets/Image/Chiken.png',
                              width: 56,
                              height: 56,
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                ),

                SizedBox(width: 16),

                // معلومات المستخدم
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user.name,
                        style: GoogleFonts.inter(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(height: 4),
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: user.role == 'admin'
                                  ? Color(0xFFe3f2fd)
                                  : Color(0xFFf3e5f5),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              user.role == 'admin' ? 'إداري' : 'معلم',
                              style: GoogleFonts.inter(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: user.role == 'admin'
                                    ? Color(0xFF1976d2)
                                    : Color(0xFF7b1fa2),
                              ),
                            ),
                          ),
                          Spacer(),
                          Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Color(0xFFf66890).withOpacity(0.1),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.chat_bubble_outline,
                              color: Color(0xFFf66890),
                              size: 16,
                            ),
                          ),
                        ],
                      ),
                      if (user.email.isNotEmpty) ...[
                        SizedBox(height: 4),
                        Text(
                          user.email,
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ],
                  ),
                ),

                // سهم التنقل
                Icon(Icons.chevron_right, color: Color(0xFFf66890), size: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _handleUserTap(TeacherModel user) async {
    //ما زالت موجودة widget
    if (!mounted) return;

    // الحصول على الـ context قبل العمليات الغير متزامنة
    final currentContext = context;

    // عرض loading dialog
    showDialog(
      context: currentContext,
      barrierDismissible: false, //cant be closed
      builder: (context) => Center(
        child: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(color: Color(0xFFf66890)),
              SizedBox(height: 16),
              Text(
                'جاري إنشاء المحادثة...',
                style: GoogleFonts.inter(fontSize: 16, color: Colors.black87),
              ),
            ],
          ),
        ),
      ),
    );

    try {
      // إنشاء أو الحصول على thread
      final thread = await chatService.createOrGetThread(
        participantIds: [user.id],
        type: 'direct',
        title: user.name,
      );

      // التحقق من أن الـ widget ما زال موجود قبل التنقل
      if (!mounted) return;

      // إغلاق loading
      Navigator.pop(currentContext);

      if (thread != null) {
        // الانتقال لشاشة الرسائل
        Get.to(() => ChatScreen(thread: thread, receiverName: user.name));
      } else {
        _showErrorSnackbar('حدث خطأ أثناء إنشاء المحادثة');
      }
    } catch (e) {
      // التحقق من أن الـ widget ما زال موجود
      if (!mounted) return;

      // إغلاق loading
      Navigator.pop(currentContext);

      _showErrorSnackbar('حدث خطأ أثناء إنشاء المحادثة: ${e.toString()}');
    }
  }

  void _showErrorSnackbar(String message) {
    if (mounted) {
      Get.snackbar(
        'خطأ',
        message,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: Duration(seconds: 3),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
