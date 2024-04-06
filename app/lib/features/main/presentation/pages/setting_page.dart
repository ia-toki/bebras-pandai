part of '_pages.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

// Displayed as a profile image if the user doesn't have one.
const placeholderImage =
    'https://upload.wikimedia.org/wikipedia/commons/c/cd/Portrait_Placeholder_Square.png';

class _SettingPageState extends State<SettingPage> {
  late User user;
  late FirebaseAuth auth;

  @override
  void initState() {
    auth = FirebaseService.auth();
    user = auth.currentUser!;

    auth.userChanges().listen((event) {
      if (event != null && mounted) {
        setState(() {
          user = event;
        });
      }
    });

    super.initState();
  }

  Future<void> showModal() async {
    return showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Container(
              height: 206,
              width: double.infinity,
              color: Colors.white,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 20),
                    child: const Text(
                      'Anda yakin ingin keluar?',
                      textAlign: TextAlign.left,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    width: double.infinity,
                    height: 50,
                    child: Button(
                      onTap: () async {
                        await FirebaseAuth.instance.signOut();
                        await GoogleSignIn().signOut();
                        context.go('/onboarding');
                      },
                      customButtonColor: const Color(0xFF1BB8E1),
                      customTextColor: Colors.white,
                      text: 'Keluar',
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 50,
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    width: double.infinity,
                    child: Button(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      customTextColor: const Color(0xFF1BB8E1),
                      customButtonColor: const Color(0x1F1BB8E1),
                      fontSize: 14,
                      text: 'Batal',
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    ).whenComplete(() => null);
  }

  DateTime? backButtonPressTime;
  String exitWarning = 'Tekan sekali lagi untuk keluar';

  Future<bool> onDidPop() {
    final now = DateTime.now();
    final backButtonHasNotBeenPressedOrSnackBarHasBeenClosed =
        backButtonPressTime == null ||
            now.difference(backButtonPressTime!) > const Duration(seconds: 2);

    if (backButtonHasNotBeenPressedOrSnackBarHasBeenClosed) {
      backButtonPressTime = now;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(exitWarning),
      ));
      return Future.value(false);
    }

    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    return BebrasScaffold(
      body: PopScope(
        canPop: false,
        onPopInvoked: (didPop) async {
          if (didPop) {
            return;
          }
          final navigator = Navigator.of(context);
          final value = await onDidPop();
          if (value) {
            navigator.pop();
          }
        },
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    CircleAvatar(
                      maxRadius: 60,
                      backgroundImage: NetworkImage(
                        user.photoURL ?? placeholderImage,
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Text(
                      user.displayName ?? '',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Column(
                      children: [
                        InkWell(
                          onTap: () async {
                            await context.push(
                              Uri(
                                path: '/register',
                                queryParameters: {
                                  'isUpdateProfile': 'true',
                                },
                              ).toString(),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 10),
                            margin: const EdgeInsets.only(bottom: 12),
                            decoration: BoxDecoration(
                              color: const Color(0x0A1BB8E1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 12),
                                  height: 50,
                                  width: 50,
                                  decoration: const BoxDecoration(
                                    color: Color(0x1F1BB8E1),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Container(
                                    alignment: Alignment.center,
                                    child: SvgPicture.asset(
                                      'assets/icon/profile.svg',
                                      height: 24,
                                      width: 24,
                                    ),
                                  ),
                                ),
                                const Flexible(
                                  child: SizedBox(
                                    width: double.infinity,
                                    child: Text(
                                      'Edit Profile',
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                                const Icon(
                                  Icons.chevron_right,
                                  size: 28,
                                  color: Colors.black,
                                ),
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () async {
                            await context.push(
                              Uri(
                                path: '/policy',
                              ).toString(),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 10),
                            margin: const EdgeInsets.only(bottom: 12),
                            decoration: BoxDecoration(
                              color: const Color(0x0A1BB8E1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 12),
                                  height: 50,
                                  width: 50,
                                  decoration: const BoxDecoration(
                                    color: Color(0x1F1BB8E1),
                                    shape: BoxShape.circle,
                                    // borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Container(
                                    alignment: Alignment.center,
                                    child: SvgPicture.asset(
                                      'assets/icon/privacy.svg',
                                      height: 24,
                                      width: 24,
                                    ),
                                  ),
                                ),
                                Flexible(
                                  child: Container(
                                    width: double.infinity,
                                    child: const Text(
                                      'Kebijakan Privasi',
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                                const Icon(
                                  Icons.chevron_right,
                                  size: 28,
                                  color: Colors.black,
                                ),
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () async {
                            final url = Uri.parse(
                              'https://tip.fintix.id/iatoki',
                            );
                            if (!await launchUrl(url)) {
                              throw Exception('Could not launch $url');
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 10),
                            margin: const EdgeInsets.only(bottom: 12),
                            decoration: BoxDecoration(
                              color: const Color(0x0A1BB8E1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 12),
                                  height: 50,
                                  width: 50,
                                  decoration: const BoxDecoration(
                                    color: Color(0x1F1BB8E1),
                                    shape: BoxShape.circle,
                                    // borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Container(
                                    alignment: Alignment.center,
                                    child: SvgPicture.asset(
                                      'assets/icon/donate.svg',
                                      height: 24,
                                      width: 24,
                                    ),
                                  ),
                                ),
                                const Flexible(
                                  child: SizedBox(
                                    width: double.infinity,
                                    child: Text(
                                      'Bantu Donasi',
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                                const Icon(
                                  Icons.chevron_right,
                                  size: 28,
                                  color: Colors.black,
                                ),
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: showModal,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 10),
                            margin: const EdgeInsets.only(bottom: 12),
                            decoration: BoxDecoration(
                              color: const Color(0x0AF50000),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 12),
                                  height: 50,
                                  width: 50,
                                  decoration: const BoxDecoration(
                                    color: Color(0x1FF50000),
                                    shape: BoxShape.circle,
                                    // borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Container(
                                    alignment: Alignment.center,
                                    child: SvgPicture.asset(
                                      'assets/icon/exit.svg',
                                      height: 24,
                                      width: 24,
                                    ),
                                  ),
                                ),
                                const Flexible(
                                  child: SizedBox(
                                    width: double.infinity,
                                    child: Text(
                                      'Keluar',
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xFFF50000),
                                      ),
                                    ),
                                  ),
                                ),
                                const Icon(
                                  Icons.chevron_right,
                                  size: 28,
                                  color: Color(0xFFF50000),
                                ),
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () async {
                            final url = Uri.parse(
                              'https://docs.google.com/forms/d/1mUpZXTLvNU93C_bD-HeUTSTBVK1tRDE69t117dkE7ks/edit',
                            );
                            if (!await launchUrl(url)) {
                              throw Exception('Could not launch $url');
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 10),
                            margin: const EdgeInsets.only(bottom: 12),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF5F5F5),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 12),
                                  height: 50,
                                  width: 50,
                                  decoration: const BoxDecoration(
                                    color: Color(0xFFE6E6E6),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Container(
                                    alignment: Alignment.center,
                                    child: SvgPicture.asset(
                                      'assets/icon/delete.svg',
                                      height: 24,
                                      width: 24,
                                    ),
                                  ),
                                ),
                                const Flexible(
                                  child: SizedBox(
                                    width: double.infinity,
                                    child: Text(
                                      'Hapus Akun',
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                                const Icon(
                                  Icons.chevron_right,
                                  size: 28,
                                  color: Color(0xFF636363),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    InkWell(
                      onTap: () async {
                        final url = Uri.parse(
                          'https://tlx.toki.id/',
                        );
                        if (!await launchUrl(url)) {
                          throw Exception('Could not launch $url');
                        }
                      },
                      child: Center(
                        child: Text(
                          'From Ikatan Alumni TOKI with ❤️',
                          textAlign: TextAlign.center,
                          style: FontTheme.greyNormal14(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.go('/quiz_registration');
        },
        child: const FaIcon(FontAwesomeIcons.graduationCap),
      ),
      bottomNavigationBar: const BottomNavBar(
        currentIndex: 1,
      ),
    );
  }
}
