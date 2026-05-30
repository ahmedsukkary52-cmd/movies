import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../apiServices/api_services.dart';
import 'dio_client.dart';

@module
abstract class DiModule {
  @singleton
  Dio provideDio(DioClient dioClient) => dioClient.dio;

  @singleton
  ApiServices provideApiServices(Dio dio) => ApiServices(dio);

  @singleton
  FirebaseAuth provideFirebaseAuth() => FirebaseAuth.instance;

  @singleton
  GoogleSignIn provideGoogleSignIn() => GoogleSignIn();

  @preResolve
  Future<SharedPreferences> provideSharedPreferences() async =>
      await SharedPreferences.getInstance();
}