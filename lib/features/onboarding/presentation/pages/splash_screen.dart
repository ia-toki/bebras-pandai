part of '_pages.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocListener<UserInitializationBloc, UserInitializationState>(
      listener: (context, state) {
        if (state is UserAuthenticated) {
          context.go('/main');
        } else if (state is UserUnauthenticated) {
          context.go('/onboarding');
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
