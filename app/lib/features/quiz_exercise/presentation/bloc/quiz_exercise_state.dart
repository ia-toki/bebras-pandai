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
  final Duration remainingDuration;
  final String selectedAnswer;
  final String modalErrorMessage;
  const QuizExerciseShow(
      {required this.quiz,
      required this.quizExercise,
      required this.remainingDuration,
      required this.selectedAnswer,
      this.modalErrorMessage = ''});

  @override
  List<Object> get props => [
        quiz,
        quizExercise,
        remainingDuration,
        selectedAnswer,
        modalErrorMessage
      ];
}

class QuizExerciseFinished extends QuizExerciseState {
  final QuizExerciseAttempt quizExerciseAttempt;
  const QuizExerciseFinished(this.quizExerciseAttempt);

  @override
  List<Object> get props => [quizExerciseAttempt];
}

class QuizExerciseFailed extends QuizExerciseState {
  final String error;

  const QuizExerciseFailed(this.error);
  @override
  List<Object> get props => [error];
}
