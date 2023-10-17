import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'features/authentication/register/bloc/user_register_bloc.dart';
import 'features/onboarding/presentation/bloc/user_initialization_bloc.dart';
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
        BlocProvider<UserRegisterBloc>(create: (_) => get<UserRegisterBloc>()
        ..add(
            InitEvent(),
        )),
        BlocProvider<UserInitializationBloc>(
          create: (_) => get<UserInitializationBloc>()
            ..add(
              OnboardingAuthEvent(),
            ),
          lazy: false,
        ),
      ],
      child: MaterialApp.router(
        theme: ThemeData(
          textTheme: GoogleFonts.poppinsTextTheme(),
        ),
        routerConfig: router,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
