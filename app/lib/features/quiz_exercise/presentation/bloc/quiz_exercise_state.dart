part of 'quiz_exercise_cubit.dart';

abstract class QuizExerciseState extends Equatable {
  const QuizExerciseState();

  @override
  List<Object> get props => [];
}

class QuizExerciseInitialState extends QuizExerciseState {}

class QuizExerciseLoading extends QuizExerciseState {}

class QuizExerciseSuccess extends QuizExerciseState {
  final List<QuizExercise> quizExercises;

  const QuizExerciseSuccess(this.quizExercises);

  @override
  List<Object> get props => [quizExercises];
}

class QuizExerciseFailed extends QuizExerciseState {
  final String error;

  const QuizExerciseFailed(this.error);
  @override
  List<Object> get props => [error];
}
