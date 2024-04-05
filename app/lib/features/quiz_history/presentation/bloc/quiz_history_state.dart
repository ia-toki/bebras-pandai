part of 'quiz_history_cubit.dart';

abstract class QuizHistoryState extends Equatable {
  const QuizHistoryState();

  @override
  List<Object> get props => [];
}

class QuizHistoryInitialState extends QuizHistoryState {}

class QuizHistoryLoading extends QuizHistoryState {}

class GetParticipantWeeklyQuizSuccess extends QuizHistoryState {
  final List<WeeklyQuizParticipation> weeklyQuizzes;

  const GetParticipantWeeklyQuizSuccess(
    this.weeklyQuizzes,
  );

  @override
  List<Object> get props => [weeklyQuizzes];
}

class GetParticipantWeeklyQuizFailed extends QuizHistoryState {
  final String error;

  const GetParticipantWeeklyQuizFailed(this.error);
  @override
  List<Object> get props => [error];
}
