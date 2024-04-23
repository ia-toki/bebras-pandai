import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:go_router/go_router.dart';

import '../features/authentication/register/presentation/pages/_pages.dart';
import '../features/authentication/signin/presentation/pages/_pages.dart';
import '../features/authentication/signin/presentation/pages/v2/_pages.dart';
import '../features/error/presentation/pages/_pages.dart';
import '../features/main/presentation/pages/_pages.dart';
import '../features/main/presentation/pages/delete_page.dart';
import '../features/material/menu/presentation/pages/_pages.dart';
import '../features/material/viewer/presentation/pages/_pages.dart';
import '../features/onboarding/presentation/pages/_pages.dart';
import '../features/onboarding/presentation/pages/v2/_pages.dart';
import '../features/quiz_download/presentation/pages/_pages.dart';
import '../features/quiz_exercise/presentation/pages/_pages.dart';
import '../features/quiz_exercise/presentation/pages/v2/_pages.dart';
import '../features/quiz_registration/presentation/pages/_pages.dart';
import '../features/quiz_result/presentation/pages/_pages.dart';
import '../features/quiz_start/presentation/pages/_pages.dart';
import '../features/task_detail/presentation/pages/_pages.dart';
import '../features/task_list/presentation/pages/_pages.dart';

GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) {
        if (dotenv.env['APP_VERSION'] == 'V1') {
          return const SplashScreen();
        } else if (dotenv.env['APP_VERSION'] == 'V2') {
          return const SplashScreenV2();
        }
        return const SplashScreen();
      },
    ),
    GoRoute(
        path: '/onboarding',
        builder: (context, state) {
          if (dotenv.env['APP_VERSION'] == 'V1') {
            return const LoginPage();
          } else if (dotenv.env['APP_VERSION'] == 'V2') {
            return const OnboardingPageV2();
          }
          return const LoginPage();
        }),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginPageV2(),
    ),
    GoRoute(
        path: '/register',
        builder: (context, state) {
          if (dotenv.env['APP_VERSION'] == 'V1') {
            return RegisterPage(
              isUpdateProfile: state.queryParameters['isUpdateProfile'],
            );
          } else if (dotenv.env['APP_VERSION'] == 'V2') {
            // return RegisterPageV2(
            //   isUpdateProfile: state.queryParameters['isUpdateProfile'],
            // );
          }
          return RegisterPage(
            isUpdateProfile: state.queryParameters['isUpdateProfile'],
          );
        }),
    GoRoute(
      path: '/main',
      builder: (context, state) {
        return const QuizRegistrationPage();
      },
    ),
    GoRoute(
      path: '/setting',
      builder: (context, state) {
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
            return QuizExercisePageV2(
              quizParticipantId: state.queryParameters['quiz_participant_id'],
            );
          }
          return QuizExercisePage(
            quizParticipantId: state.queryParameters['quiz_participant_id'],
          );
        }),
    GoRoute(
      path: '/quiz_registration',
      builder: (context, state) {
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
        return const MaterialMenu();
      },
    ),
    GoRoute(
        path: '/material/:id',
        builder: (context, state) {
          return PdfViewerPage(
            pdfUrl: state.queryParameters['pdfUrl'],
            title: state.queryParameters['title'],
            id: state.queryParameters['id'],
          );
        }),
    GoRoute(
      path: '/policy',
      builder: (context, state) {
        return const PrivacyPolicyPage();
      },
    ),
    GoRoute(
      path: '/delete',
      builder: (context, state) {
        if (dotenv.env['APP_VERSION'] == 'V1') {
          return const DeleteAccountPage();
        } else if (dotenv.env['APP_VERSION'] == 'V2') {
          // return const V2SettingPage();
        }
        return const DeleteAccountPage();
      },
    ),
  ],
);
