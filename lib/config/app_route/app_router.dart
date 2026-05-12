import 'package:go_router/go_router.dart';
import 'package:moives/config/app_route/app_routes_name.dart';
import 'package:moives/features/movies/presentation/pages/home/ui/home_page.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: AppRoutes.home,
    routes: [
      GoRoute(
        path: AppRoutes.home,
        builder: (context, state) => const HomePage(),
      ),
    ],
  );
}
