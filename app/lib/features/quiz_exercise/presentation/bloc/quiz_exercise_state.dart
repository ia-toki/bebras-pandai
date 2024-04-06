part of 'quiz_exercise_cubit.dart';

abstract class QuizExerciseState extends Equatable {
  const QuizExerciseState();

  @override
  List<Object> get props => [];
}

class QuizExerciseInitialState extends QuizExerciseState {}

class QuizExerciseLoading extends QuizExerciseState {}

class QuizExerciseShow extends QuizExerciseState {
  final QuizExercise quizExercise;
  final WeeklyQuiz quiz;
  final QuizExerciseAnswer answer;
  final QuizExerciseAttempt attempt;
  final Duration remainingDuration;
  final String modalErrorMessage;
  final int currentProblemIndex;
  final int totalProblem;

  const QuizExerciseShow({
    required this.quiz,
    required this.quizExercise,
    required this.remainingDuration,
    required this.currentProblemIndex,
    required this.totalProblem,
    required this.attempt,
    required this.answer,
    this.modalErrorMessage = '',
  });

  @override
  List<Object> get props => [
        quiz,
        quizExercise,
        remainingDuration,
        answer,
        attempt,
        modalErrorMessage,
      ];
}

class QuizExerciseFinalization extends QuizExerciseState {}

class QuizExerciseFinished extends QuizExerciseState {
  final String quizParticipantId;
  const QuizExerciseFinished(this.quizParticipantId);

  @override
  List<Object> get props => [quizParticipantId];
}

class QuizExercisePaused extends QuizExerciseState {}

class QuizExerciseFailed extends QuizExerciseState {
  final String error;

  const QuizExerciseFailed(this.error);
  @override
  List<Object> get props => [error];
}
