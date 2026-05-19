import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:moives/config/app_route/app_routes_name.dart';
import 'package:moives/features/movies/presentation/pages/home/ui/home_page.dart';
import 'package:moives/features/movies/presentation/pages/movie_details/ui/movie_details_page.dart';
import 'package:moives/features/movies/presentation/pages/onBoarding/on_boarding.dart';

import '../../features/movies/presentation/pages/bottom_nav/cubit/bottom_nav_cubit.dart';
import '../../features/movies/presentation/pages/bottom_nav/ui/bottom_nav_screen.dart';
import '../di/di.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: AppRoutes.onBoarding,
    routes: [
      GoRoute(
        path: AppRoutes.home,
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: AppRoutes.onBoarding,
        builder: (context, state) => const OnboardingScreens(),
      ),
      GoRoute(
        path: '/details/:id',
        name: AppRoutes.details,
        builder: (context, state) {
          final id = int.parse(state.pathParameters['id']!);
          return MovieDetailsPage(movieId: id);
        },
      ),
      GoRoute(
        path: AppRoutes.main,
        builder: (context, state) => BlocProvider(
          create: (_) => getIt<BottomNavCubit>(),
          child: MainScreenBottomNav(),
        ),
      ),
    ],
  );
}
