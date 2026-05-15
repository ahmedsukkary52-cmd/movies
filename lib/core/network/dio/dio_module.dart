import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../apiServices/api_services.dart';
import 'dio_client.dart';

@module
abstract class DiModule {
  @singleton
  Dio provideDio(DioClient dioClient) => dioClient.dio;

  @singleton
  ApiServices provideApiServices(Dio dio) => ApiServices(dio);
}
