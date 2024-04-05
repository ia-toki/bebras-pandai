// ignore_for_file: lines_longer_than_80_chars, require_trailing_commas

part of '_pages.dart';

class QuizHistoryPage extends StatefulWidget {
  const QuizHistoryPage({super.key});

  @override
  State<QuizHistoryPage> createState() => _QuizHistoryPageState();
}

class _QuizHistoryPageState extends State<QuizHistoryPage> {
  @override
  void initState() {
    super.initState();
    context.read<QuizHistoryCubit>().fetchParticipantWeeklyQuiz();
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
                            'Riwayat Latihan',
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
                child: BlocConsumer<QuizHistoryCubit, QuizHistoryState>(
                  listener: (context, state) {},
                  builder: (context, state) {
                    if (state is QuizHistoryLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return Column(
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Expanded(
                          child: SizedBox(
                            height: MediaQuery.of(context).size.height - 211,
                            width: double.infinity,
                            child: BlocConsumer<QuizHistoryCubit,
                                QuizHistoryState>(
                              listener: (context, state) {},
                              builder: (context, state) {
                                if (state is GetParticipantWeeklyQuizSuccess) {
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
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
