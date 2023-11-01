part of 'quiz_exercise_cubit.dart';

abstract class QuizExerciseState extends Equatable {
  const QuizExerciseState();

  @override
  List<Object> get props => [];
}

class QuizExerciseInitialState extends QuizExerciseState {}

class QuizExerciseLoading extends QuizExerciseState {}

class QuizExerciseShow extends QuizExerciseState {
  final QuizExercise quizExercise;
  final WeeklyQuiz quiz;
  final Duration remainingDuration;
  const QuizExerciseShow(this.quiz, this.quizExercise, this.remainingDuration);

  @override
  List<Object> get props => [quiz, quizExercise, remainingDuration];
}

class QuizExerciseFinished extends QuizExerciseState {
  final QuizExerciseAttempt quizExerciseAttempt;
  const QuizExerciseFinished(this.quizExerciseAttempt);

  @override
  List<Object> get props => [quizExerciseAttempt];
}

class QuizExerciseFailed extends QuizExerciseState {
  final String error;

  const QuizExerciseFailed(this.error);
  @override
  List<Object> get props => [error];
}
