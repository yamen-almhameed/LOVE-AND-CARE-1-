import 'package:dio/dio.dart';
import 'package:nursery_love_care/core/shared_pref_helper.dart';
import 'package:nursery_love_care/main.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class Apiclient {
  static final Dio dio =
      Dio(
          BaseOptions(
            baseUrl: 'https://loveandcarenursery.com/api/',
            headers: {
              'Accept': 'application/json',
              'Authorization':
                  'Bearer ${SharedPrefHelper.getString(StorageKeys.token)}',
            },
          ),
        )
        ..interceptors.add(
          PrettyDioLogger(
            requestHeader: true,
            requestBody: true,
            responseBody: true,
            responseHeader: false,
            error: true,
          ),
        );
}
