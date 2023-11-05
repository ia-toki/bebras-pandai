// ignore_for_file: lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation

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
                children: [
                  Image.asset(
                    Assets.bebrasPandaiText,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  BlocConsumer<QuizExerciseCubit, QuizExerciseState>(
                      listenWhen: (context, state) {
                    return state is QuizExerciseFinished;
                  }, listener: (context, state) {
                    if (state is QuizExerciseFinished) {
                      context.replace(
                        Uri(
                          path: '/quiz_result',
                          queryParameters: {},
                        ).toString(),
                      );
                    }
                  }, buildWhen: (context, state) {
                    return state is! QuizExerciseFinished;
                  }, builder: (context, state) {
                    if (state is QuizExerciseLoading) {
                      return const Text('LOADING');
                    }
                    if (state is QuizExerciseFailed) {
                      return Text(state.error);
                    }
                    if (state is QuizExerciseShow) {
                      return Column(
                        children: [
                          Container(
                            color: Colors.yellowAccent,
                            padding: const EdgeInsets.symmetric(
                                vertical: 4, horizontal: 8),
                            child: Text(
                                '${state.remainingDuration.inMinutes.toString().padLeft(2, '0')} : ${state.remainingDuration.inSeconds.remainder(60).toString().padLeft(2, '0')}'),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(state.quizExercise.title),
                              Column(
                                children: [
                                  Text(state.quizExercise.id),
                                  Text(state.quizExercise.source),
                                ],
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height - 340,
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            decoration: BoxDecoration(border: Border.all()),
                            child: Column(children: [
                              Html(
                                data: state.quizExercise.description.content,
                              )
                            ]),
                          ),
                          const SizedBox(
                            height: 14,
                          ),
                          SizedBox(
                            width: 150,
                            child: Button(
                              text: 'JAWAB',
                              buttonType: ButtonType.primary,
                              onTap: () {
                                showAnswerOptions();
                              },
                            ),
                          )
                        ],
                      );
                    }
                    return Container();
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showAnswerOptions() {
    showDialog(
        context: context,
        builder: (context) {
          return BlocBuilder<QuizExerciseCubit, QuizExerciseState>(
              buildWhen: (context, state) {
            return state is QuizExerciseShow;
          }, builder: (context, state) {
            if (state is QuizExerciseShow) {
              return AlertDialog(
                content: SingleChildScrollView(
                    child: Column(
                  children: [
                    SizedBox(
                      width: 400,
                      height: 200,
                      child: Html(data: state.quizExercise.question.content),
                    ),
                    ...state.quizExercise.question.options
                        .map((e) => RadioListTile(
                            title: Text(e.content),
                            value: e.id,
                            groupValue: state.selectedAnswer,
                            onChanged: (value) {
                              context
                                  .read<QuizExerciseCubit>()
                                  .selectAnswer(e.id);
                            })),
                    Text(state.modalErrorMessage),
                  ],
                )),
                actions: [
                  SizedBox(
                    width: 100,
                    height: 50,
                    child: Button(
                      buttonType: ButtonType.secondary,
                      text: 'Cancel',
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  SizedBox(
                    width: 100,
                    height: 50,
                    child: Button(
                      buttonType: ButtonType.tertiary,
                      text: 'OK',
                      onTap: () {
                        context.read<QuizExerciseCubit>().submitAnswer();
                        if (state.selectedAnswer != '') {
                          Navigator.pop(context);
                        }
                      },
                    ),
                  ),
                ],
              );
            }
            return const SizedBox(
              width: 100,
              height: 100,
            );
          });
        });
  }
}
