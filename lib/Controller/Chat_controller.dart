import 'package:get/get.dart';
import 'package:nursery_love_care/Service/apiclient.dart';

class ChatController extends GetxController {
  var threads = [].obs;

  Future<void> fetchThreads() async {
    final res = await Apiclient.dio.post('/thread');
    if (res.data['success']) {
      threads.value=res.data['data'];
    }
  }
}
