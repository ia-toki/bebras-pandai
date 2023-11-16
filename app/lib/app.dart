import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'features/authentication/register/bloc/user_register_bloc.dart';
import 'features/main/presentation/bloc/home_cubit.dart';
import 'features/onboarding/presentation/bloc/user_initialization_bloc.dart';
import 'features/quiz_exercise/presentation/bloc/quiz_exercise_cubit.dart';
import 'features/quiz_registration/presentation/bloc/quiz_registration_cubit.dart';
import 'features/quiz_result/presentation/bloc/quiz_result_cubit.dart';
import 'features/quiz_start/presentation/bloc/quiz_start_cubit.dart';
import 'features/task_detail/presentation/bloc/task_detail_cubit.dart';
import 'features/task_list/presentation/bloc/task_list_cubit.dart';
import 'services/di.dart';
import 'services/router_service.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MultiBlocProvider(
      providers: [
        BlocProvider<UserInitializationBloc>(
          create: (_) => get<UserInitializationBloc>()
            ..add(
              OnboardingAuthEvent(),
            ),
        ),
        BlocProvider(create: (context) => HomeCubit()),
        BlocProvider(create: (context) => TaskListCubit()),
        BlocProvider(create: (context) => TaskDetailCubit()),
        BlocProvider(create: (context) => QuizExerciseCubit()),
        BlocProvider(create: (context) => QuizResultCubit()),
        BlocProvider(create: (context) => QuizStartCubit()),
        BlocProvider(create: (context) => QuizRegistrationCubit()),
        BlocProvider(create: (context) => get<UserRegisterBloc>()),
      ],
      child: MaterialApp.router(
        theme: ThemeData(
          textTheme: GoogleFonts.interTextTheme(),
        ),
        routerConfig: router,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
