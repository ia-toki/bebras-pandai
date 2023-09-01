import 'package:go_router/go_router.dart';

import '../features/authentication/signin/presentation/pages/_pages.dart';
import '../features/onboarding/presentation/pages/_pages.dart';

GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/onboarding',
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      path: '/main',
      builder: (context, state) => const SplashScreen(),
    ),
  ],
);
