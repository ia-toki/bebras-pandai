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
      body: Container(
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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(
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
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(42.0),
                    topRight: Radius.circular(42.0),
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
                    if (state is QuizRegistrationFailed) {
                      return buildQuizRegistrationHeader(Text(state.error));
                    }
                    if (state is QuizRegistrationSuccess) {
                      return buildQuizRegistrationHeader(
                          state.weeklyQuizzes.isEmpty
                              ? buildQuizRegistrationEmpty()
                              : buildQuizRegistrationList(state));
                    }
                    return Container();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildQuizRegistrationHeader(Widget widget) {
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
        widget
      ],
    );
  }

  Widget buildQuizRegistrationList(QuizRegistrationSuccess state) {
    return Column(
      children: state.weeklyQuizzes
          .map((quiz) => QuizCard(
                quiz,
                quiz.attempts.isNotEmpty
                    ? quiz.attempts[quiz.attempts.length - 1].startAt.toString()
                    : '-',
                quiz.attempts.isNotEmpty
                    ? quiz.attempts[quiz.attempts.length - 1].score.toString()
                    : '??',
                quiz.challenge_group,
              ))
          .toList(),
    );
  }

  Container buildQuizRegistrationEmpty() {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(bottom: 12, top: 12),
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
}
