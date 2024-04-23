part of '_pages.dart';

class QuizExercisePageV2 extends StatefulWidget {
  final String? quizParticipantId;
  const QuizExercisePageV2({super.key, this.quizParticipantId});

  @override
  State<QuizExercisePageV2> createState() => _QuizExercisePageV2State();
}

class _QuizExercisePageV2State extends State<QuizExercisePageV2> {
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
      avoidBottomInset: false,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 15,
                top: 20,
                right: 16,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(Icons.arrow_back),
                      ),
                      const Flexible(
                        child: Center(
                          child: Text(
                            'Bebras Pandai',
                            textAlign: TextAlign.center,
                            style:
                              TextStyle(fontWeight: FontWeight.bold, fontSize: 16)
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(Icons.list),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
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
                    },
                    buildWhen: (context, state) {
                      return state is! QuizExerciseFinished;
                    },
                    builder: (context, state) {
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
                    }
                  ),
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
        },
        builder: (context, state) {
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
      }
    );
  }
}