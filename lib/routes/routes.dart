import 'package:go_router/go_router.dart';
import 'package:thank_you_pro/features/bottomNav/view/bottom_nav_screen.dart';
import 'package:thank_you_pro/features/drawing_board/view/drawing_page.dart';

import 'package:thank_you_pro/features/splash/view/splash_screen.dart';
import 'package:thank_you_pro/utils/strings/route_strings.dart';

final GoRouter myRoutes = GoRouter(
  initialLocation: '/',
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (context, state) => const BottomNavScreen(),
    ),
    GoRoute(
        path: '/${Routes.bottomNav}',
        builder: (context, state) => const BottomNavScreen(),
        routes: [
          GoRoute(
            path: Routes.drawingBoard,
            builder: (context, state) => const DrawingPage(),
          ),
        ]),
  ],
);
