// ignore_for_file: lines_longer_than_80_chars, require_trailing_commas

part of '_pages.dart';

class QuizDownloadPage extends StatefulWidget {
  const QuizDownloadPage({super.key});

  @override
  State<QuizDownloadPage> createState() => _QuizDownloadPageState();
}

class _QuizDownloadPageState extends State<QuizDownloadPage> {
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

  // void selectWeek(String week) {
  //   setState(() {
  //     selectedWeek = week;
  //   });
  // }
  //
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

  Function _downloadQuiz() {
    return context.read<QuizRegistrationCubit>().fetchParticipantWeeklyQuiz;
  }

  @override
  Widget build(BuildContext context) {
    return BebrasScaffold(
      body: SizedBox(
        height: double.infinity,
        child: Stack(
          children: [
            Container(
              height: 300,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Color(0xFF1BB8E1),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(60),
                  bottomRight: Radius.circular(60),
                ),
              ),
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(
                      top: 15,
                    ),
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () => Navigator.of(context).pop(),
                          icon: const Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          child: const Text(
                            'Latihan Minggu Depan',
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                                color: Colors.white),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 100,
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(42),
                    topRight: Radius.circular(42),
                  ),
                ),
                child:
                    BlocConsumer<QuizRegistrationCubit, QuizRegistrationState>(
                  listener: (context, state) {
                    if (state is QuizRegistrationSuccess) {
                      // return PermissionToDownloadQuiz(); // onClickDownload: _downloadQuiz);
                    }
                  },
                  builder: (context, state) {
                    if (state is QuizRegistrationLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (state is QuizRegistrationSuccess) {
                      return PermissionToDownloadQuiz(
                          onClickDownload:
                              _downloadQuiz()); // onClickDownload: _downloadQuiz);
                    }
                    print(state);
                    return Column(
                      children: [
                        const SizedBox(
                          height: 40,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Latihan yang pernah diikuti',
                            style: FontTheme.blackSubtitleBold(),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height - 211,
                          width: double.infinity,
                          child: BlocConsumer<QuizRegistrationCubit,
                              QuizRegistrationState>(
                            listener: (context, state) {
                              // TODO(someone): implement listener
                            },
                            builder: (context, state) {
                              if (state is GetParticipantWeeklyQuizSuccess) {
                                if (state.weeklyQuizzes.isEmpty) {
                                  return Container(
                                    padding: const EdgeInsets.all(10),
                                    margin: const EdgeInsets.only(
                                        bottom: 12, top: 12),
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
                                return ListView(children: [
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  for (final quiz in state.weeklyQuizzes)
                                    QuizCard(
                                      quiz,
                                      quiz.attempts.isNotEmpty
                                          ? quiz
                                              .attempts[
                                                  quiz.attempts.length - 1]
                                              .startAt
                                              .toString()
                                          : '-',
                                      quiz.attempts.isNotEmpty
                                          ? quiz
                                              .attempts[
                                                  quiz.attempts.length - 1]
                                              .score
                                              .toString()
                                          : '??',
                                      quiz.challenge_group,
                                    ),
                                ]);
                              }

                              if (state is GetParticipantWeeklyQuizFailed) {
                                return Text(state.error);
                              }
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            },
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
            // Container(
            //   alignment: Alignment.bottomCenter,
            //   padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            //   child: Button(
            //     borderRadius: 4,
            //           customTextColor: Colors.white,
            //           customButtonColor: const Color(0xFF1BB8E1),
            //           fontSize: 14,
            //           innerVerticalPadding: 10,
            //           onTap: () async {
            //             // await showModal();
            //           },
            //           text: 'Batalkan',
            //         ),
            // ),
          ],
        ),
      ),
    );
  }
}
