import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../utils/app_constants.dart';
import 'dio_interceptors.dart';

@singleton
class DioClient {
  final Dio dio;

  DioClient()
    : dio = Dio(
        BaseOptions(
          baseUrl: AppConstants.baseUrl,
          receiveDataWhenStatusError: true,
          connectTimeout: Duration(seconds: 20),
          receiveTimeout: Duration(seconds: 20),
        ),
      ) {
    dio.interceptors.addAll([
      DioInterceptors(),
      PrettyDioLogger(
        request: true,
        requestBody: true,
        requestHeader: true,
        responseBody: true,
        responseHeader: true,
        error: true,
      ),
    ]);
  }
}
