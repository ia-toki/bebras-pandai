part of 'quiz_exercise_bloc.dart';

abstract class QuizExerciseState extends Equatable {
  const QuizExerciseState();

  @override
  List<Object> get props => [];
}

class QuizExerciseInitialState extends QuizExerciseState {}

class QuizExerciseLoading extends QuizExerciseState {}

class QuizExerciseSuccess extends QuizExerciseState {
  final List<QuizExercise> quizExercise;
  const QuizExerciseSuccess(this.quizExercise);

  @override
  List<Object> get props => [quizExercise];
}

class QuizExerciseFailed extends QuizExerciseState {
  final String error;

  const QuizExerciseFailed(this.error);
  @override
  List<Object> get props => [error];
}
