part of 'quiz_result_cubit.dart';

@immutable
abstract class QuizResultState extends Equatable {
  const QuizResultState();

  @override
  List<Object> get props => [];
}

class QuizResultInitial extends QuizResultState {}

class QuizResultNotAvailable extends QuizResultState {}

class QuizResultAvailable extends QuizResultState {
  final QuizExerciseAttempt attempt;

  const QuizResultAvailable(this.attempt);
  @override
  List<Object> get props => [attempt];
}

class QuizResultFailed extends QuizResultState {
  final String error;

  const QuizResultFailed(this.error);
  @override
  List<Object> get props => [error];
}
