import 'package:dio/dio.dart';
import 'package:nursery_love_care/core/shared_pref_helper.dart';
import 'package:nursery_love_care/main.dart';

class Apiclient {

  static final Dio dio = Dio(
    BaseOptions(
      baseUrl: 'https://loveandcarenursery.com/api/chat',
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${SharedPrefHelper.getString(StorageKeys.token)}',
      },
    ),
  );
}