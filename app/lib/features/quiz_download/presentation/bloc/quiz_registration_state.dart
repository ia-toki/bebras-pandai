part of 'quiz_registration_cubit.dart';

abstract class QuizRegistrationState extends Equatable {
  const QuizRegistrationState();

  @override
  List<Object> get props => [];
}

class QuizRegistrationInitialState extends QuizRegistrationState {}

class QuizRegistrationLoading extends QuizRegistrationState {}

class QuizRegistrationSuccess extends QuizRegistrationState {
  final List<WeeklyQuizParticipation> weeklyQuizzes;

  const QuizRegistrationSuccess(
    this.weeklyQuizzes,
  );

  @override
  List<Object> get props => [weeklyQuizzes];
}

class QuizRegistrationFailed extends QuizRegistrationState {
  final String error;

  const QuizRegistrationFailed(this.error);
  @override
  List<Object> get props => [error];
}
