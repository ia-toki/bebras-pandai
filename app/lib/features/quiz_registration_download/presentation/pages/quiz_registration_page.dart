// ignore_for_file: lines_longer_than_80_chars, require_trailing_commas

part of '_pages.dart';

class QuizRegistrationPage extends StatefulWidget {
  const QuizRegistrationPage({super.key});

  @override
  State<QuizRegistrationPage> createState() => _QuizRegistrationPageState();
}

class _QuizRegistrationPageState extends State<QuizRegistrationPage> {
  String selectedWeek = '';
  bool isRunningWeekSelected = false;
  bool isNextWeekSelected = false;

  @override
  void initState() {
    super.initState();
    context.read<QuizRegistrationCubit>().fetchParticipantWeeklyQuiz();
    checkRunningWeeklyQuiz();
    checkNextWeeklyQuiz();
  }

  void selectWeek(String week) {
    setState(() {
      selectedWeek = week;
    });
  }

  Future<void> checkRunningWeeklyQuiz() async {
    final check =
        await QuizService().checkParticipantWeeklyQuiz('running_weekly_quiz');
    setState(() {
      isRunningWeekSelected = check;
    });
  }

  Future<void> checkNextWeeklyQuiz() async {
    final check =
        await QuizService().checkParticipantWeeklyQuiz('next_weekly_quiz');
    setState(() {
      isNextWeekSelected = check;
    });
  }

  Widget quizCard(WeeklyQuizParticipation weeklyQuizParticipant, String date,
      String score, String level, BuildContext context) {
    return InkWell(
      onTap: () async {
        await context.push(
          Uri(
            path: '/quiz_start',
            queryParameters: {
              'quiz_participant_id': weeklyQuizParticipant.id,
            },
          ).toString(),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 18),
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: Colors.blue[50],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Container(
                  padding: const EdgeInsets.only(right: 20),
                  child: Text(
                    weeklyQuizParticipant.quiz_title,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 12),
                  ),
                ),
              ),
              Text(
                'Nilai: $score',
                style: const TextStyle(fontSize: 12),
              )
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Row(
            children: [
              Text(
                'Kategori: $level',
                style: const TextStyle(fontSize: 12),
              )
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Row(
            children: [
              Text(
                'Dikerjakan: $date',
                style: const TextStyle(fontSize: 12),
              )
            ],
          )
        ]),
      ),
    );
  }

  Future<void> showModal() async {
    return showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            if (selectedWeek != '') {
              return Container(
                constraints: const BoxConstraints(minHeight: 30),
                width: double.infinity,
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 20),
                      child: InkWell(
                        onTap: () => setState(() => selectedWeek = ''),
                        child: const Row(
                          children: [
                            Icon(Icons.chevron_left),
                            Text('Pilih Minggu')
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 20),
                      child: Text(
                        'Daftar Latihan Bebras ${selectedWeek == 'next_weekly_quiz' ? 'Minggu Depan' : 'Minggu Ini'}',
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
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
                            context
                                .read<QuizRegistrationCubit>()
                                .registerParticipant('sikecil', selectedWeek);
                            checkNextWeeklyQuiz();
                            checkRunningWeeklyQuiz();
                            selectWeek('');
                            Navigator.pop(context);
                          },
                          customButtonColor: Colors.blue.shade400,
                          customTextColor: Colors.white,
                          text: 'siKecil',
                          isDisabled: true,
                        )),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        width: double.infinity,
                        child: Button(
                          onTap: () {
                            context
                                .read<QuizRegistrationCubit>()
                                .registerParticipant('siaga', selectedWeek);
                            checkNextWeeklyQuiz();
                            checkRunningWeeklyQuiz();
                            selectWeek('');
                            Navigator.pop(context);
                          },
                          customButtonColor: Colors.green.shade400,
                          customTextColor: Colors.white,
                          text: 'Siaga',
                        )),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        width: double.infinity,
                        child: Button(
                          onTap: () {
                            context
                                .read<QuizRegistrationCubit>()
                                .registerParticipant(
                                    'penggalang', selectedWeek);
                            checkNextWeeklyQuiz();
                            checkRunningWeeklyQuiz();
                            selectWeek('');
                            Navigator.pop(context);
                          },
                          customButtonColor: Colors.red.shade400,
                          customTextColor: Colors.white,
                          text: 'Penggalang',
                        )),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        width: double.infinity,
                        child: Button(
                          onTap: () {
                            context
                                .read<QuizRegistrationCubit>()
                                .registerParticipant('penegak', selectedWeek);
                            checkNextWeeklyQuiz();
                            checkRunningWeeklyQuiz();
                            selectWeek('');
                            Navigator.pop(context);
                          },
                          customButtonColor: Colors.orange.shade400,
                          customTextColor: Colors.white,
                          text: 'Penegak',
                        )),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              );
            }
            return Container(
              height: 260,
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
                      'Ayo pilih latihanmu!',
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
                      onTap: () => setState(
                              () => selectedWeek = 'running_weekly_quiz'),
                      isDisabled: isRunningWeekSelected,
                      customButtonColor: Color(0xFF1BB8E1),
                      customTextColor: Colors.white,
                      text: 'Unduh Latihan Minggu Ini',
                    ),),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      width: double.infinity,
                      child: Button(
                        onTap: () =>
                            setState(() => selectedWeek = 'next_weekly_quiz'),
                        isDisabled: isNextWeekSelected,
                        customTextColor: Color(0xFF1BB8E1),
                        customButtonColor: Color(0x1F1BB8E1),
                        text: 'Latihan Minggu Depan',
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
    return BebrasScaffold(
      body: SizedBox(
        child: Stack(
          children: [
            Container(
              height: 300,
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xFF1BB8E1),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(42),
                  topRight: Radius.circular(42),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [],
              ),
            ),
            Positioned(
              child: Container(
                height: 600,
                width: 300,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(radius: 42),
                ),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 60,
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(24.0),
                        child: Image.asset(
                          Assets.bLogo,
                          height: 150,
                        ),
                      ),
                    ),
                    // Align(
                    //   alignment: Alignment.centerLeft,
                    //   child: Text(
                    //     'Latihan yang pernah diikuti',
                    //     style: FontTheme.blackSubtitleBold(),
                    //   ),
                    // ),
                    // BlocConsumer<QuizRegistrationCubit, QuizRegistrationState>(
                    //   listener: (context, state) {
                    //     if (state is QuizRegistrationSuccess) {
                    //       context
                    //           .read<QuizRegistrationCubit>()
                    //           .fetchParticipantWeeklyQuiz();
                    //     }
                    //   },
                    //   builder: (context, state) {
                    //     if (state is QuizRegistrationLoading) {
                    //       return const Center(
                    //         child: CircularProgressIndicator(),
                    //       );
                    //     }
                    //     return SizedBox(
                    //       height: MediaQuery.of(context).size.height - 300,
                    //       width: double.infinity,
                    //       child: BlocConsumer<QuizRegistrationCubit,
                    //           QuizRegistrationState>(
                    //         listener: (context, state) {
                    //           // TODO(someone): implement listener
                    //         },
                    //         builder: (context, state) {
                    //           if (state is GetParticipantWeeklyQuizSuccess) {
                    //             if (state.weeklyQuizzes.isEmpty) {
                    //               return Container(
                    //                 padding: const EdgeInsets.all(10),
                    //                 margin: const EdgeInsets.only(
                    //                     bottom: 12, top: 12),
                    //                 decoration: BoxDecoration(
                    //                   color: Colors.blue[50],
                    //                   borderRadius: BorderRadius.circular(8),
                    //                 ),
                    //                 child: const Center(
                    //                   child: Text(
                    //                     'Silahkan klik Tombol `Daftar Latihan Bebras` dibawah untuk memulai',
                    //                   ),
                    //                 ),
                    //               );
                    //             }
                    //             return ListView(children: [
                    //               const SizedBox(
                    //                 height: 10,
                    //               ),
                    //               for (final quiz in state.weeklyQuizzes)
                    //                 quizCard(
                    //                   quiz,
                    //                   quiz.attempts.isNotEmpty
                    //                       ? quiz
                    //                           .attempts[quiz.attempts.length - 1]
                    //                           .startAt
                    //                           .toString()
                    //                       : '-',
                    //                   quiz.attempts.isNotEmpty
                    //                       ? quiz
                    //                           .attempts[quiz.attempts.length - 1]
                    //                           .score
                    //                           .toString()
                    //                       : '??',
                    //                   quiz.challenge_group,
                    //                   context,
                    //                 ),
                    //             ]);
                    //           }
                    //
                    //           if (state is GetParticipantWeeklyQuizFailed) {
                    //             return Text(state.error);
                    //           }
                    //           return const Center(
                    //             child: CircularProgressIndicator(),
                    //           );
                    //         },
                    //       ),
                    //     );
                    //   },
                    // ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 300,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(42),
                    topRight: Radius.circular(42),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Ayo mulai latihanmu!', style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,),),
                    const SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                      width: 230,
                      child: Button(
                        customTextColor: Colors.white,
                        customButtonColor: Color(0xFF1BB8E1),
                        fontSize: 14,
                        innerVerticalPadding: 14,
                        onTap: () async {
                          await showModal();
                        },
                        text: 'Daftar Latihan',
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: 230,
                      child: Button(
                        customTextColor: Color(0xFF1BB8E1),
                        customButtonColor: Color(0x1F1BB8E1),
                        fontSize: 14,
                        innerVerticalPadding: 14,
                        onTap: () async {
                          // await showModal();
                        },
                        text: 'Riwayat Latihan',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
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
        currentIndex: 2,
      ),
    );
  }
}
