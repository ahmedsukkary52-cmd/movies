import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:moives/config/app_route/app_router.dart';
import 'package:moives/config/app_route/app_routes_name.dart';
import 'package:moives/config/di/di.dart';
import 'package:moives/config/theme/theme_app.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  configureDependencies();

  final prefs = await SharedPreferences.getInstance();
  final seenOnboarding = prefs.getBool('seen_onboarding') ?? false;
  final firebaseUser = FirebaseAuth.instance.currentUser;

  runApp(MoviesApp(
    initialRoute: firebaseUser != null
        ? AppRoutes.main
        : seenOnboarding
        ? AppRoutes.login
        : AppRoutes.onBoarding,
  ));
}

class MoviesApp extends StatelessWidget {
  final String initialRoute;

  const MoviesApp({super.key, required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(430, 932),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          routerConfig: AppRouter.router(initialRoute),
          theme: ThemeApp.themeData,
        );
      },
    );
  }
}