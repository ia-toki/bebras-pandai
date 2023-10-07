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

// class QuizRegistrationSuccess extends QuizRegistrationState {
//   final List<QuizRegistrationModel> QuizRegistrations;

//   const QuizRegistrationSuccess(this.QuizRegistrations);

//   @override
//   List<Object> get props => [QuizRegistrations];
// }

// class QuizRegistrationFailed extends QuizRegistrationState {
//   final String error;

//   const QuizRegistrationFailed(this.error);
//   @override
//   List<Object> get props => [error];
// }
