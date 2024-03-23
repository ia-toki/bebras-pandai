import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:go_router/go_router.dart';

import '../features/authentication/register/presentation/pages/_pages.dart';
import '../features/authentication/signin/presentation/pages/_pages.dart';
import '../features/error/presentation/pages/_pages.dart';
import '../features/main/presentation/pages/_pages.dart';
import '../features/material/menu/presentation/pages/_pages.dart';
import '../features/material/viewer/presentation/pages/_pages.dart';
import '../features/onboarding/presentation/pages/_pages.dart';
import '../features/quiz_download/presentation/pages/_pages.dart';
import '../features/quiz_exercise/presentation/pages/_pages.dart';
import '../features/quiz_registration/presentation/pages/_pages.dart';
import '../features/quiz_result/presentation/pages/_pages.dart';
import '../features/quiz_start/presentation/pages/_pages.dart';
import '../features/task_detail/presentation/pages/_pages.dart';
import '../features/task_list/presentation/pages/_pages.dart';
// import '../features/main/presentation/pages/v2/_pages.dart';

GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) {
        if (dotenv.env['APP_VERSION'] == 'V1') {
          return const SplashScreen();
        } else if (dotenv.env['APP_VERSION'] == 'V2') {
          // return const V2SplashScreen();
        }
        return const SplashScreen();
      },
    ),
    GoRoute(
      path: '/onboarding',
      builder: (context, state) => const OnboardingPage(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) {
        return const LoginPage();
      },
    ),
    GoRoute(
        path: '/register',
        builder: (context, state) {
          if (dotenv.env['APP_VERSION'] == 'V1') {
            return RegisterPage(
              isUpdateProfile: state.queryParameters['isUpdateProfile'],
            );
          } else if (dotenv.env['APP_VERSION'] == 'V2') {
            // return const V2RegisterPage();
          }
          return RegisterPage(
            isUpdateProfile: state.queryParameters['isUpdateProfile'],
          );
        }),
    GoRoute(
      path: '/main',
      builder: (context, state) {
        if (dotenv.env['APP_VERSION'] == 'V1') {
          return const HomePage();
        } else if (dotenv.env['APP_VERSION'] == 'V2') {
          // return const V2HomePage();
        }
        return const HomePage();
      },
    ),
    GoRoute(
      path: '/setting',
      builder: (context, state) {
        if (dotenv.env['APP_VERSION'] == 'V1') {
          return const SettingPage();
        } else if (dotenv.env['APP_VERSION'] == 'V2') {
          // return const V2SettingPage();
        }
        return const SettingPage();
      },
    ),
    GoRoute(
      path: '/construction',
      builder: (context, state) {
        if (dotenv.env['APP_VERSION'] == 'V1') {
          return const UnderConstructionPage();
        } else if (dotenv.env['APP_VERSION'] == 'V2') {
          // return const V2UnderConstructionPage();
        }
        return const UnderConstructionPage();
      },
    ),
    GoRoute(
      path: '/group_task_list',
      builder: (context, state) {
        if (dotenv.env['APP_VERSION'] == 'V1') {
          return const GroupTaskListPage();
        } else if (dotenv.env['APP_VERSION'] == 'V2') {
          // return const V2GroupTaskListPage();
        }
        return const GroupTaskListPage();
      },
    ),
    GoRoute(
        path: '/task_list',
        builder: (context, state) {
          if (dotenv.env['APP_VERSION'] == 'V1') {
            return TaskListPage(
              challengeGroup: state.queryParameters['challenge_group'],
            );
          } else if (dotenv.env['APP_VERSION'] == 'V2') {
            // return const V2TaskListPage();
          }
          return TaskListPage(
            challengeGroup: state.queryParameters['challenge_group'],
          );
        }),
    GoRoute(
      path: '/task_detail',
      builder: (context, state) {
        if (dotenv.env['APP_VERSION'] == 'V1') {
          return TaskDetailPage(
            taskId: state.queryParameters['task_id'],
          );
        } else if (dotenv.env['APP_VERSION'] == 'V2') {
          // return const V2TaskDetailPage();
        }
        return TaskDetailPage(
          taskId: state.queryParameters['task_id'],
        );
      },
    ),
    GoRoute(
        path: '/quiz_exercise',
        builder: (context, state) {
          if (dotenv.env['APP_VERSION'] == 'V1') {
            return QuizExercisePage(
              quizParticipantId: state.queryParameters['quiz_participant_id'],
            );
          } else if (dotenv.env['APP_VERSION'] == 'V2') {
            // return const V2QuizExercisePage();
          }
          return QuizExercisePage(
            quizParticipantId: state.queryParameters['quiz_participant_id'],
          );
        }),
    GoRoute(
      path: '/quiz_registration',
      builder: (context, state) {
        if (dotenv.env['APP_VERSION'] == 'V1') {
          return const QuizRegistrationPage();
        } else if (dotenv.env['APP_VERSION'] == 'V2') {
          // return const V2QuizRegistrationPage();
        }
        return const QuizRegistrationPage();
      },
    ),
    GoRoute(
      path: '/quiz_download',
      builder: (context, state) => const QuizDownloadPage(),
    ),
    GoRoute(
        path: '/quiz_result',
        builder: (context, state) {
          if (dotenv.env['APP_VERSION'] == 'V1') {
            return QuizResultPage(
              quizParticipantId: state.queryParameters['quiz_participant_id'],
            );
          } else if (dotenv.env['APP_VERSION'] == 'V2') {
            // return const V2QuizResultPage();
          }
          return QuizResultPage(
            quizParticipantId: state.queryParameters['quiz_participant_id'],
          );
        }),
    GoRoute(
        path: '/quiz_start',
        builder: (context, state) {
          if (dotenv.env['APP_VERSION'] == 'V1') {
            return QuizStartPage(
              quizParticipantId: state.queryParameters['quiz_participant_id'],
            );
          } else if (dotenv.env['APP_VERSION'] == 'V2') {
            // return const V2QuizStartPage();
          }
          return QuizStartPage(
            quizParticipantId: state.queryParameters['quiz_participant_id'],
          );
        }),
    GoRoute(
      path: '/material',
      builder: (context, state) {
        if (dotenv.env['APP_VERSION'] == 'V1') {
          return const MaterialMenu();
        } else if (dotenv.env['APP_VERSION'] == 'V2') {
          // return const V2MaterialMenu();
        }
        return const MaterialMenu();
      },
    ),
    GoRoute(
        path: '/material/:id',
        builder: (context, state) {
          if (dotenv.env['APP_VERSION'] == 'V1') {
            return PdfViewerPage(
              pdfUrl: state.queryParameters['pdfUrl'],
              title: state.queryParameters['title'],
              id: state.queryParameters['id'],
            );
          } else if (dotenv.env['APP_VERSION'] == 'V2') {
            // return const V2PdfViewerPage();
          }
          return PdfViewerPage(
            pdfUrl: state.queryParameters['pdfUrl'],
            title: state.queryParameters['title'],
            id: state.queryParameters['id'],
          );
        }),
  ],
);
