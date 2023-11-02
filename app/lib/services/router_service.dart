import 'package:go_router/go_router.dart';

import '../features/authentication/register/presentation/pages/_pages.dart';
import '../features/authentication/signin/presentation/pages/_pages.dart';
import '../features/error/presentation/pages/_pages.dart';
import '../features/main/presentation/pages/_pages.dart';
import '../features/material/menu/presentation/pages/_pages.dart';
import '../features/material/viewer/presentation/pages/_pages.dart';
import '../features/onboarding/presentation/pages/_pages.dart';
import '../features/quiz_registration/presentation/pages/_pages.dart';

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
      path: '/register',
      builder: (context, state) => const RegisterPage(),
    ),
    GoRoute(
      path: '/main',
      builder: (context, state) => const MainPage(),
    ),
    GoRoute(
      path: '/setting',
      builder: (context, state) => const SettingPage(),
    ),
    GoRoute(
      path: '/construction',
      builder: (context, state) => const UnderConstructionPage(),
    ),
    GoRoute(
      path: '/quiz_registration',
      builder: (context, state) => const QuizRegistrationPage(),
    ),
    GoRoute(
      path: '/material',
      builder: (context, state) => const MaterialMenu(),
    ),
    GoRoute(
      path: '/material/:id',
      builder: (context, state) => PdfViewerPage(
        pdfUrl: state.queryParameters['pdfUrl'],
        title: state.queryParameters['title'],
        id: state.queryParameters['id'],
      ),
    ),
  ],
);
