part of 'quiz_exercise_bloc.dart';

abstract class QuizExerciseState extends Equatable {
  const QuizExerciseState();

  @override
  List<Object> get props => [];
}

class QuizExerciseInitial extends QuizExerciseState {}

class QuizExerciseSuccess extends QuizExerciseState {
  final List<QuizExercise> quizExercise;
  const QuizExerciseSuccess(this.quizExercise);

  @override
  List<Object> get props => [quizExercise];
}

class QuizExerciseError extends QuizExerciseState {
  @override
  List<Object> get props => [];
}
