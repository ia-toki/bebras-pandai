import 'package:go_router/go_router.dart';

import '../features/authentication/register/presentation/pages/_pages.dart';
import '../features/authentication/signin/presentation/pages/_pages.dart';
import '../features/error/presentation/pages/_pages.dart';
import '../features/main/presentation/pages/_pages.dart';
import '../features/material/menu/presentation/pages/_pages.dart';
import '../features/material/viewer/presentation/pages/_pages.dart';
import '../features/onboarding/presentation/pages/_pages.dart';
import '../features/quiz_exercise/presentation/pages/_pages.dart';
import '../features/quiz_registration/presentation/pages/_pages.dart';
import '../features/quiz_result/presentation/pages/_pages.dart';
import '../features/quiz_start/presentation/pages/_pages.dart';
import '../features/task_detail/presentation/pages/_pages.dart';
import '../features/task_list/presentation/pages/_pages.dart';

GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/splash',
      builder: (context, state) => const SplashPage(),
    ),
    GoRoute(
      path: '/onboarding',
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      path: '/register',
      builder: (context, state) => RegisterPage(
        isUpdateProfile: state.queryParameters['isUpdateProfile'],
      ),
    ),
    GoRoute(
      path: '/main',
      builder: (context, state) => const HomePage(),
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
      path: '/task_list',
      builder: (context, state) => const TaskListPage(),
    ),
    GoRoute(
      path: '/task_detail',
      builder: (context, state) => TaskDetailPage(
        taskId: state.queryParameters['task_id'],
      ),
    ),
    GoRoute(
      path: '/quiz_exercise',
      builder: (context, state) => QuizExercisePage(
        quizParticipantId: state.queryParameters['quiz_participant_id'],
      ),
    ),
    GoRoute(
      path: '/quiz_registration',
      builder: (context, state) => const QuizRegistrationPage(),
    ),
    GoRoute(
      path: '/quiz_result',
      builder: (context, state) => QuizResultPage(
        quizParticipantId: state.queryParameters['quiz_participant_id'],
      ),
    ),
    GoRoute(
      path: '/quiz_start',
      builder: (context, state) => QuizStartPage(
        quizParticipantId: state.queryParameters['quiz_participant_id'],
      ),
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
