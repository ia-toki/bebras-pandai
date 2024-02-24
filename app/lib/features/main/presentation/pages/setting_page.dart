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
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const SizedBox(
                    height: 40,
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
                    child: Button(
                      onTap: () {
                        // setState(() => selectedWeek = 'running_weekly_quiz');
                        // context.read<QuizRegistrationCubit>()
                        //     .registerParticipant('siaga', selectedWeek);
                        // checkNextWeeklyQuiz();
                        // checkRunningWeeklyQuiz();
                        // selectWeek('');
                        // Navigator.pop(context);
                        // context.push('/quiz_download');
                      },
                      // isDisabled: isRunningWeekSelected,
                      customButtonColor: Color(0xFF1BB8E1),
                      customTextColor: Colors.white,
                      text: 'Keluar',
                    ),),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 59,
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    width: double.infinity,
                    child: Button(
                      onTap: () {
                        // setState(() => selectedWeek = 'next_weekly_quiz');
                        // context.read<QuizRegistrationCubit>()
                        //     .registerParticipant('siaga', selectedWeek);
                        // checkNextWeeklyQuiz();
                        // checkRunningWeeklyQuiz();
                        // selectWeek('');
                        // Navigator.pop(context);
                        // context.push('/quiz_download');
                      },
                      // isDisabled: isNextWeekSelected,
                      customTextColor: Color(0xFF1BB8E1),
                      customButtonColor: Color(0x1F1BB8E1),
                      fontSize: 14,
                      text: 'Batal',
                    ),),
                ],
              ),
            );
          },
        );
      },
    ).whenComplete(() => null);
  }

  @override
  Widget build(BuildContext context) {
    showModal();

    return BebrasScaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(32),
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
                    'Farida Nabila',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Column(
                    children: [
                      Container(
                        padding:
                            const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                        margin: const EdgeInsets.only(bottom: 12),
                        decoration: BoxDecoration(
                          color: Color(0x0A1BB8E1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            Container(
                              margin: const EdgeInsets.symmetric(horizontal: 12),
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                color: Color(0x1F1BB8E1),
                                shape: BoxShape.circle,
                                // borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            Flexible(
                              child: Container(
                                width: double.infinity,
                                child: const Text(
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
                      Container(
                        padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                        margin: const EdgeInsets.only(bottom: 12),
                        decoration: BoxDecoration(
                          color: Color(0x0A1BB8E1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            Container(
                              margin: const EdgeInsets.symmetric(horizontal: 12),
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                color: Color(0x1F1BB8E1),
                                shape: BoxShape.circle,
                                // borderRadius: BorderRadius.circular(20),
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
                      Container(
                        padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                        margin: const EdgeInsets.only(bottom: 12),
                        decoration: BoxDecoration(
                          color: Color(0x0A1BB8E1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            Container(
                              margin: const EdgeInsets.symmetric(horizontal: 12),
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                color: Color(0x1F1BB8E1),
                                shape: BoxShape.circle,
                                // borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            Flexible(
                              child: Container(
                                width: double.infinity,
                                child: const Text(
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
                      InkWell(
                        onTap: () async {
                          await FirebaseAuth.instance.signOut();
                          await GoogleSignIn().signOut();
                          context.go('/onboarding');
                        },
                        child: Container(
                        padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                        margin: const EdgeInsets.only(bottom: 12),
                        decoration: BoxDecoration(
                          color: Color(0x0AF50000),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            Container(
                              margin: const EdgeInsets.symmetric(horizontal: 12),
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                color: Color(0x1FF50000),
                                shape: BoxShape.circle,
                                // borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            Flexible(
                              child: Container(
                                width: double.infinity,
                                child: const Text(
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
                      Container(
                        padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                        margin: const EdgeInsets.only(bottom: 12),
                        decoration: BoxDecoration(
                          color: Color(0xFFF5F5F5),
                            borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            Container(
                              margin: const EdgeInsets.symmetric(horizontal: 12),
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                color: Color(0xFFE6E6E6),
                                shape: BoxShape.circle,
                                // borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            Flexible(
                              child: Container(
                                width: double.infinity,
                                child: const Text(
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
                    ],
                  ),
                  // Button(
                  //   buttonType: ButtonType.primary,
                  //   onTap: () async {
                  //     await context.push(
                  //       Uri(
                  //         path: '/register',
                  //         queryParameters: {
                  //           'isUpdateProfile': 'true',
                  //         },
                  //       ).toString(),
                  //     );
                  //   },
                  //   text: 'Edit Profil',
                  // ),
                  // const SizedBox(
                  //   height: 25,
                  // ),
                  // Button(
                  //   onTap: () async {
                  //     final url = Uri.parse(
                  //       'https://docs.google.com/forms/d/1mUpZXTLvNU93C_bD-HeUTSTBVK1tRDE69t117dkE7ks/edit',
                  //     );
                  //     if (!await launchUrl(url)) {
                  //       throw Exception('Could not launch $url');
                  //     }
                  //   },
                  //   customButtonColor: Colors.grey,
                  //   customTextColor: Colors.white,
                  //   text: 'Hapus Akun',
                  // ),
                  // const SizedBox(
                  //   height: 50,
                  // ),
                  // Button(
                  //   buttonType: ButtonType.primary,
                  //   onTap: () async {
                  //     final url = Uri.parse(
                  //       'https://docs.google.com/document/d/1aj1cWrPak3f9On8Bj3KJO68p4MDtZPpWZCBquJZ9Nx0/edit',
                  //     );
                  //     if (!await launchUrl(url)) {
                  //       throw Exception('Could not launch $url');
                  //     }
                  //   },
                  //   text: 'Kebijakan Privasi',
                  // ),
                  // const SizedBox(
                  //   height: 25,
                  // ),
                  // Button(
                  //   onTap: () async {
                  //     final url = Uri.parse(
                  //       'https://tip.fintix.id/iatoki',
                  //     );
                  //     if (!await launchUrl(url)) {
                  //       throw Exception('Could not launch $url');
                  //     }
                  //   },
                  //   customButtonColor: Colors.amber,
                  //   customTextColor: Colors.white,
                  //   text: 'Bantu Donasi 💌',
                  // ),
                  // BlocBuilder<HomeCubit, HomeState>(
                  //   builder: (context, state) {
                  //     if (state is HomeSuccess && state.user.isAdmin) {
                  //       return Column(
                  //         children: [
                  //           SizedBox(
                  //             height:
                  //                 225, // MediaQuery.of(context).size.height - 625,
                  //           ),
                  //           Button(
                  //             onTap: () {
                  //               context.push('/task_list');
                  //             },
                  //             buttonType: ButtonType.primary,
                  //             text: 'Lihat Bebras Task',
                  //           ),
                  //           const SizedBox(
                  //             height: 25,
                  //           ),
                  //         ],
                  //       );
                  //     }
                  //     return SizedBox(
                  //       height:
                  //           225, // MediaQuery.of(context).size.height - 695,
                  //     );
                  //   },
                  // ),
                  // Button(
                  //   onTap: () async {
                  //     await FirebaseAuth.instance.signOut();
                  //     await GoogleSignIn().signOut();
                  //     context.go('/onboarding');
                  //   },
                  //   customButtonColor: Colors.red.shade900,
                  //   customTextColor: Colors.white,
                  //   text: 'Keluar',
                  // ),
                  // const SizedBox(
                  //   height: 50,
                  // ),
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
    );
  }
}
