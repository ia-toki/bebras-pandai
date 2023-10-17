part of 'quiz_registration_cubit.dart';

abstract class QuizRegistrationState extends Equatable {
  const QuizRegistrationState();

  @override
  List<Object> get props => [];
}

class QuizRegistrationInitialState extends QuizRegistrationState {}

class QuizRegistrationLoading extends QuizRegistrationState {}

class QuizRegistrationWeekSelected extends QuizRegistrationState {
  final String selectedWeek;

  const QuizRegistrationWeekSelected(this.selectedWeek);

  @override
  List<Object> get props => [selectedWeek];
}

class QuizRegistrationLevelSelected extends QuizRegistrationState {
  final String selectedLevel;

  const QuizRegistrationLevelSelected(this.selectedLevel);

  @override
  List<Object> get props => [selectedLevel];
}
