part of '_pages.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocListener<UserInitializationBloc, UserInitializationState>(
      listener: (context, state) {
        print(state.toString());
         if (state is UserUnauthenticated) {
          context.go('/onboarding');
        } else if (state is UserUnregistered) {
          context.go('/register');
        } else if (state is UserRegistered) {
        context.go('/main');
        }
        },
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Container(
                  height: size.width * 0.8,
                  width: size.width * 0.8,
                  alignment: Alignment.center,
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
          ],
        ),
        // safeArea: false,
        // padding: false,
      ),
    );
  }
}
