// ignore_for_file: lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation

part of '_pages.dart';

class QuizExercisePage extends StatefulWidget {
  final String? quizParticipantId;
  const QuizExercisePage({super.key, this.quizParticipantId});

  @override
  State<QuizExercisePage> createState() => _QuizExercisePageState();
}

class _QuizExercisePageState extends State<QuizExercisePage> {
  @override
  void initState() {
    final cubit = context.read<QuizExerciseCubit>();
    // if (cubit.quizParticipantId != widget.quizParticipantId) {
    cubit.initialize(quizParticipantId: widget.quizParticipantId);
    // }
    super.initState();
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
                      context.pushReplacement(
                        Uri(
                          path: '/quiz_result',
                          queryParameters: {
                            'quiz_participant_id': state.quizParticipantId,
                          },
                        ).toString(),
                      );
                      context
                          .read<QuizStartCubit>()
                          .initialize(widget.quizParticipantId);
                      context
                          .read<QuizRegistrationCubit>()
                          .fetchParticipantWeeklyQuiz();
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
                      final exercise = state.quizExercise;
                      final taskDecription =
                          '<h3>Deskripsi</h3>${exercise.description.content}';
                      final taskQuestion =
                          '<h3>Pertanyaan</h3>${exercise.question.content}';

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
                              Image.asset(
                                '${Assets.flagDir}${state.quizExercise.country}.png',
                                width: 40,
                                height: 20,
                              ),
                              Flexible(
                                child: Text(
                                  state.quizExercise.title,
                                  textAlign: TextAlign.center,
                                  style: FontTheme.blackSubtitleBold(),
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    state.quizExercise.id,
                                    style: const TextStyle(fontSize: 9),
                                  ),
                                  Text(
                                    state.quizExercise.source,
                                    style: const TextStyle(fontSize: 7),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Container(
                            height: 2,
                            color: Colors.black,
                          ),
                          const SizedBox(
                            height: 3,
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height - 340,
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            decoration: BoxDecoration(border: Border.all()),
                            child: SingleChildScrollView(
                              child: HtmlWithCachedImages(
                                data: taskDecription + taskQuestion,
                              ),
                            ),
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
              var index = 0;

              return Scaffold(
                backgroundColor: Colors.transparent,
                body: AlertDialog(
                  content: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Text(
                            'Pertanyaan',
                            style: FontTheme.blackTextBold(),
                          ),
                        ),
                        SizedBox(
                          width: 400,
                          height: 200,
                          child: SingleChildScrollView(
                            child: HtmlWithCachedImages(
                                data: state.quizExercise.question.content),
                          ),
                        ),
                        ...state.quizExercise.question.options!.map((e) {
                          final current = String.fromCharCode(65 + index);
                          index++;

                          return RadioListTile(
                              title: SizedBox(
                                width: 100,
                                child: Row(
                                  children: [
                                    Text(
                                      current,
                                      style: const TextStyle(fontSize: 12),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    state.quizExercise.type ==
                                            'MULTIPLE_CHOICE_IMAGE'
                                        ? CachedNetworkImage(
                                            imageUrl: e.content,
                                            width: 140,
                                          )
                                        : Text(e.content),
                                  ],
                                ),
                              ),
                              value: e.id,
                              groupValue: state.selectedAnswer,
                              onChanged: (value) {
                                context
                                    .read<QuizExerciseCubit>()
                                    .selectAnswer(e.id);
                              });
                        }),
                        state.quizExercise.type == 'SHORT_ANSWER'
                            ? Container(
                                padding: const EdgeInsets.only(top: 20),
                                child: CustomTextField('Jawaban anda', (value) {
                                  context
                                      .read<QuizExerciseCubit>()
                                      .fillAnswer(value);
                                }, (p0) => null, ''),
                              )
                            : Container(),
                        Text(state.modalErrorMessage),
                      ],
                    ),
                  ),
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
                          var error = '';
                          if (state.quizExercise.type == 'SHORT_ANSWER') {
                            if (state.shortAnswer == '') {
                              error = 'Isi jawaban anda';
                            }
                          } else {
                            if (state.selectedAnswer == '') {
                              error = 'Pilih salah satu jawaban';
                            }
                          }

                          if (error != '') {
                            final snackBar = SnackBar(
                              backgroundColor: Colors.red,
                              duration: const Duration(seconds: 1),
                              behavior: SnackBarBehavior.floating,
                              margin: const EdgeInsets.only(
                                  bottom: 50, left: 10, right: 10),
                              content: Text(error),
                            );

                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);

                            error = '';
                            return;
                          }

                          context.read<QuizExerciseCubit>().submitAnswer();
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ],
                ),
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
