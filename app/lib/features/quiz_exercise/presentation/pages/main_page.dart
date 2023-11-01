// ignore_for_file: lines_longer_than_80_chars, require_trailing_commas

part of '_pages.dart';

class QuizExercisePage extends StatefulWidget {
  final String? quizId;
  final String? challengeGroup;
  final String? quizParticipantId;
  const QuizExercisePage(
      {super.key, this.quizId, this.challengeGroup, this.quizParticipantId});

  @override
  State<QuizExercisePage> createState() => _QuizExercisePageState();
}

class _QuizExercisePageState extends State<QuizExercisePage> {
  @override
  void initState() {
    super.initState();
    context.read<QuizExerciseCubit>().fetchQuizExercise(
        quizId: widget.quizId,
        quizParticipantId: widget.quizParticipantId,
        challengeGroup: widget.challengeGroup);
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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    Assets.bebrasPandaiText,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  BlocConsumer<QuizExerciseCubit, QuizExerciseState>(
                      listener: (context, state) {},
                      buildWhen: (context, state) {
                        return !(state is QuizExerciseFinished);
                      },
                      builder: (context, state) {
                        if (state is QuizExerciseInitialState) {
                          return Container();
                        }
                        if (state is QuizExerciseLoading) {
                          return Text('LOADING');
                        }
                        if (state is QuizExerciseFailed) {
                          return Text(state.error);
                        }
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text('TIMER'),
                            const SizedBox(
                              height: 20,
                            ),
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Title'),
                                Column(
                                  children: [
                                    const Text('ID'),
                                    const Text('Source'),
                                  ],
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              height: MediaQuery.of(context).size.height - 330,
                              width: double.infinity,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              decoration: BoxDecoration(border: Border.all()),
                              child: const Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Description',
                                    )
                                  ]),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              width: 150,
                              child: Button(
                                text: 'JAWAB',
                                buttonType: ButtonType.primary,
                              ),
                            )
                          ],
                        );
                      }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
