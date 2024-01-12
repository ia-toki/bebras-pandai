part of '_pages.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocListener<UserInitializationBloc, UserInitializationState>(
      listener: (context, state) {
        if (state is UserUnauthenticated) {
          context.go('/splash');
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
