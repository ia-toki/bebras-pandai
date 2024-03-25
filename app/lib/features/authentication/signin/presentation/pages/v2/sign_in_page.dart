part of '_pages.dart';

class LoginPageV2 extends StatefulWidget {
  const LoginPageV2({super.key});

  @override
  State<LoginPageV2> createState() => _LoginPageV2State();
}

class _LoginPageV2State extends State<LoginPageV2> {
  late final SignInBloc _signInBloc;

  @override
  void initState() {
    _signInBloc = get<SignInBloc>();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Image.asset(
              Assets.iconLogin,
              fit: BoxFit.cover,
              height: size.height * 0.30,
              width: double.infinity,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: const EdgeInsets.all(32),
                height: size.height * 0.55,
                width: size.width,
                // decoration: BoxDecoration(
                //   borderRadius: BorderRadius.circular(32),
                //   color: Colors.white,
                // ),
                child: Column(
                  children: [
                    // Image.asset(
                    //   Assets.bebrasPandaiText,
                    // ),
                    // const SizedBox(
                    //   height: 100,
                    // ),
                    const Text(
                      'Selamat Datang di Aplikasi Bebras Pandai!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    const Text(
                      'Yuk cari tahu seberapa tajam logikamu!',
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    BlocConsumer<SignInBloc, SignInState>(
                      bloc: _signInBloc,
                      listener: (context, state) {
                        if (state is UserUnregistered) {
                          context.go('/register');
                        } else if (state is UserRegistered) {
                          context.go('/main');
                        }
                      },
                      builder: (context, state) {
                        return SizedBox(
                          height: 50,
                          width: 200,
                          child: Button(
                            text: 'Login with Google',
                            buttonType: ButtonType.secondary,
                            customBorderColor: BaseColors.black,
                            icon: Assets.iconGoogle,
                            onTap: () {
                              if (state is! SignInLoadingState) {
                                _signInBloc.add(
                                  TriggerSignInEvent(),
                                );
                              }
                            },
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
