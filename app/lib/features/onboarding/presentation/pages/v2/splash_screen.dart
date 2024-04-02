part of '_pages.dart';

class SplashScreenV2 extends StatelessWidget {
  const SplashScreenV2({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocListener<UserInitializationBloc, UserInitializationState>(
      listener: (context, state) {
        if (state is UpdateAvailable) {
          showUpdateDialogV2(context);
        } else if (state is UserUnauthenticated) {
          context.go('/onboarding');
        } else if (state is UserUnregistered) {
          context.go('/register');
        } else if (state is UserRegistered) {
          context.go('/main');
        }
      },
      child: Scaffold(
        body: Center(
          child: Container(
            height: size.width * 0.75,
            width: size.width * 0.75,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  Assets.logo,
                ),
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

void showUpdateDialogV2(BuildContext context) {
  showDialog<Widget>(
    context: context,
    builder: (BuildContext context) {
      return const UpdateDialogV2();
    },
  );
}
