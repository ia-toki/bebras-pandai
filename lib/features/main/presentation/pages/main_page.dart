part of '_pages.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final nama = 'dummy';

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return BebrasScaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              height: size.height * 0.35,
              color: BaseColors.blue,
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      text: 'Halo! ',
                      style: FontTheme.whiteBold36(),
                      children: <TextSpan>[
                        TextSpan(
                          text:
                              ' ${FirebaseService.auth().currentUser?.displayName}',
                          style: FontTheme.redBold36(),
                          // recognizer: TapGestureRecognizer()
                          //   ..onTap = () => context.go('/signup'),
                        ),
                      ],
                    ),
                  ),
                  Button(
                    onTap: () async {
                      await GoogleSignIn().signOut();
                      context.go('/onboarding');
                    },
                    text: 'Log out',
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
