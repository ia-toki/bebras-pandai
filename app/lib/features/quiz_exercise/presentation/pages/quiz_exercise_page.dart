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
    if (cubit.quizParticipantId == widget.quizParticipantId &&
        cubit.state is QuizExercisePaused) {
      cubit.resume();
    } else {
      cubit.initialize(quizParticipantId: widget.quizParticipantId);
    }
    super.initState();
  }

  @override
  void dispose() {
    context.read<QuizExerciseCubit>().pause();
    super.dispose();
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
                            // is_time_up always true if remaining time is zero
                            'is_time_up':
                                state.remainingDuration.inSeconds <= 0,
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
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (state is QuizExerciseFailed) {
                      return Text(state.error);
                    }
                    if (state is QuizExerciseShow) {
                      return TaskView(
                        task: state.quizExercise,
                        context: context,
                        remainingDuration: state.remainingDuration,
                        attempt: state.attempt,
                        onTaskTap: () {
                          onAnswerTap();
                        },
                        showPreviousButton: state.currentProblemIndex > 0,
                        showNextButton: state.currentProblemIndex <
                            (state.totalProblem - 1),
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

  void onAnswerTap() {
    showDialog(
        context: context,
        builder: (context) {
          return BlocBuilder<QuizExerciseCubit, QuizExerciseState>(
              buildWhen: (context, state) {
            return state is QuizExerciseShow;
          }, builder: (context, state) {
            if (state is QuizExerciseShow) {
              return TaskDialog(
                task: state.quizExercise,
                preview: false,
                answer: state.answer.answer,
                error: state.modalErrorMessage,
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
