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

class RunningWeeklyQuizSuccess extends QuizRegistrationState {
  final WeeklyQuizModel runningWeeklyQuiz;

  const RunningWeeklyQuizSuccess(this.runningWeeklyQuiz);

  @override
  List<Object> get props => [runningWeeklyQuiz];
}

class QuizRegistrationSuccess extends QuizRegistrationState {
  final String quizRegistration;

  const QuizRegistrationSuccess(this.quizRegistration);

  @override
  List<Object> get props => [quizRegistration];
}

class GetParticipantWeeklyQuizSuccess extends QuizRegistrationState {
  final List<RegisteredParticipantModel> weeklyQuizzes;

  const GetParticipantWeeklyQuizSuccess(
    this.weeklyQuizzes,
  );

  @override
  List<Object> get props => [weeklyQuizzes];
}

class GetRunningQuizTasksSuccess extends QuizRegistrationState {
  final String tasks;

  const GetRunningQuizTasksSuccess(
    this.tasks,
  );

  @override
  List<Object> get props => [tasks];
}

class GetParticipantWeeklyQuizFailed extends QuizRegistrationState {
  final String error;

  const GetParticipantWeeklyQuizFailed(this.error);
  @override
  List<Object> get props => [error];
}

class QuizRegistrationSFailed extends QuizRegistrationState {
  final String error;

  const QuizRegistrationSFailed(this.error);
  @override
  List<Object> get props => [error];
}

class RunningWeeklyQuizFailed extends QuizRegistrationState {
  final String error;

  const RunningWeeklyQuizFailed(this.error);
  @override
  List<Object> get props => [error];
}
