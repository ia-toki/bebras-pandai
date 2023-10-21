import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'features/onboarding/presentation/bloc/user_initialization_bloc.dart';
import 'features/quiz_registration/bloc/quiz_registration_cubit.dart';
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
    return MaterialApp.router(
      theme: ThemeData(
        textTheme: GoogleFonts.interTextTheme(),
      ),
      routerConfig: router,
      debugShowCheckedModeBanner: false,
    );
    // MultiBlocProvider(
    //   providers: [
    //     BlocProvider<UserInitializationBloc>(
    //       create: (_) => get<UserInitializationBloc>()
    //         ..add(
    //           OnboardingAuthEvent(),
    //         ),
    //     ),
    //     BlocProvider(create: (context) => QuizRegistrationCubit()),
    //   ],
    //   child: MaterialApp.router(
    //     theme: ThemeData(
    //       textTheme: GoogleFonts.interTextTheme(),
    //     ),
    //     routerConfig: router,
    //     debugShowCheckedModeBanner: false,
    //   ),
    // );
  }
}
