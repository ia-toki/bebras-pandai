part of 'quiz_start_cubit.dart';

@immutable
abstract class QuizStartState {}

class QuizStartInitial extends QuizStartState {}

class QuizStartSuccess extends QuizStartState {
  final WeeklyQuizParticipation participation;
  final WeeklyQuiz quiz;
  final bool agreement;

  QuizStartSuccess(
      {required this.participation,
      required this.quiz,
      required this.agreement});
  List<Object> get props => [participation, quiz, agreement];
}

class QuizStartFailed extends QuizStartState {
  final String error;

  QuizStartFailed(this.error);

  List<Object> get props => [error];
}
