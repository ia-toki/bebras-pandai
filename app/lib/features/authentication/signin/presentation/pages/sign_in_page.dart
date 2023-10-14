part of '_pages.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
      backgroundColor: ColorConstants.primaryBlueColor,
      body: SafeArea(
        child: Stack(
          children: [
            // Image.asset(
            //   Assets.studyBackground,
            //   fit: BoxFit.cover,
            //   height: size.height * 0.45,
            // ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: const EdgeInsets.all(32),
                height: size.height,
                width: size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(32),
                  color: Colors.transparent,
                ),
                child: Column(
                  children: [
                    Image.asset(
                      Assets.bebrasPandaiText,
                    ),
                    const SizedBox(
                      height: 55,
                    ),
                    Image.asset(
                      Assets.bebrasMascot,
                      fit: BoxFit.cover,
                      height: size.height * 0.4,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    const Text(
                      'Selamat Datang di Aplikasi Bebras Pandai!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: ColorConstants.whiteColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      'Yuk cari tahu seberapa tajam logikamu!',
                      style: TextStyle(
                        color: ColorConstants.whiteColor,
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    BlocConsumer<SignInBloc, SignInState>(
                      bloc: _signInBloc,
                      listener: (context, state) {
                        if (state is SignInSuccessState) {
                          // context.go('/main');
                          context.go('/register');
                        }
                      },
                      builder: (context, state) {
                        return SizedBox(
                          height: 50,
                          width: 200,
                          child: ElevatedButton(
                            child: Text(
                              'Login with Google',
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900,),),
                            style: ButtonStyle(
                                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(18.0),
                                    )
                                ),
                              backgroundColor: MaterialStateProperty.all(
                                  ColorConstants.darkPrimaryBlueColor,
                              ),
                            ),
                            onPressed: () {
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
