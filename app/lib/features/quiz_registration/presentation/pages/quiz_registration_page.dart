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
      onTap: () {
        final endDate = DateFormat('yyyy-MM-dd HH:mm:ss')
            .parse(weeklyQuizParticipant.quiz_end_at);
        if (endDate.isBefore(DateTime.now())) {
        } else {
          context.push(
            Uri(
              path: '/quiz_exercise',
              queryParameters: {
                'quiz_id': weeklyQuizParticipant.quiz_id,
                'challenge_group': weeklyQuizParticipant.challenge_group,
                'quiz_participant_id': weeklyQuizParticipant.id,
              },
            ).toString(),
          );
        }
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
                'dikerjakan: $date',
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
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const SizedBox(
                    height: 40,
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 20),
                    child: const Text(
                      'Daftar Latihan Bebras',
                      textAlign: TextAlign.left,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Container(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      width: double.infinity,
                      child: Button(
                        onTap: () =>
                            setState(() => selectedWeek = 'next_weekly_quiz'),
                        isDisabled: isNextWeekSelected,
                        customButtonColor: Colors.green.shade400,
                        customTextColor: Colors.white,
                        text: 'Latihan Minggu Depan',
                      )),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      width: double.infinity,
                      child: Button(
                        onTap: () => setState(
                            () => selectedWeek = 'running_weekly_quiz'),
                        isDisabled: isRunningWeekSelected,
                        customButtonColor: Colors.brown.shade400,
                        customTextColor: Colors.white,
                        text: 'Latihan Minggu Ini',
                      ))
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
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    Assets.bebrasPandaiText,
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  const Text('Latihan yang pernah diikuti'),
                  BlocConsumer<QuizRegistrationCubit, QuizRegistrationState>(
                    listener: (context, state) {
                      if (state is QuizRegistrationSuccess) {
                        context
                            .read<QuizRegistrationCubit>()
                            .fetchParticipantWeeklyQuiz();
                      }
                    },
                    builder: (context, state) {
                      if (state is QuizRegistrationLoading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return SizedBox(
                        height: MediaQuery.of(context).size.height - 300,
                        width: double.infinity,
                        child: BlocConsumer<QuizRegistrationCubit,
                            QuizRegistrationState>(
                          listener: (context, state) {
                            // TODO(someone): implement listener
                          },
                          builder: (context, state) {
                            if (state is GetParticipantWeeklyQuizSuccess) {
                              return ListView(children: [
                                const SizedBox(
                                  height: 10,
                                ),
                                for (final quiz in state.weeklyQuizzes)
                                  quizCard(
                                    quiz,
                                    quiz.attempts.isNotEmpty
                                        ? quiz
                                            .attempts[quiz.attempts.length - 1]
                                            .startAt
                                            .toString()
                                        : '-',
                                    quiz.attempts.isNotEmpty
                                        ? quiz
                                            .attempts[quiz.attempts.length - 1]
                                            .score
                                            .toString()
                                        : '??',
                                    quiz.challenge_group,
                                    context,
                                  ),
                              ]);
                            }

                            if (state is GetParticipantWeeklyQuizFailed) {
                              return Container(
                                padding: const EdgeInsets.all(10),
                                margin:
                                    const EdgeInsets.only(bottom: 12, top: 12),
                                decoration: BoxDecoration(
                                  color: Colors.blue[50],
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Center(
                                  child: Text(
                                    'Silahkan klik Tombol `Daftar Latihan Bebras` dibawah untuk memulai',
                                  ),
                                ),
                              );
                            }
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          },
                        ),
                      );
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Button(
                    buttonType: ButtonType.tertiary,
                    onTap: () async {
                      await showModal();
                    },
                    text: 'Daftar Latihan Bebras',
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
