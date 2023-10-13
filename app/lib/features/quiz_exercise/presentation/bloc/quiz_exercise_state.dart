part of 'quiz_exercise_cubit.dart';

abstract class QuizExerciseState extends Equatable {
  const QuizExerciseState();

  @override
  List<Object> get props => [];
}

class QuizExerciseInitialState extends QuizExerciseState {}

class QuizExerciseLoading extends QuizExerciseState {}

class QuizExerciseWeekSelected extends QuizExerciseState {}

// class QuizExerciseSuccess extends QuizExerciseState {
//   final List<QuizExerciseModel> QuizExercises;

//   const QuizExerciseSuccess(this.QuizExercises);

//   @override
//   List<Object> get props => [QuizExercises];
// }

// class QuizExerciseFailed extends QuizExerciseState {
//   final String error;

//   const QuizExerciseFailed(this.error);
//   @override
//   List<Object> get props => [error];
// }
