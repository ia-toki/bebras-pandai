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
  const QuizExerciseShow(this.quizExercise);

  @override
  List<Object> get props => [quizExercise];
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
