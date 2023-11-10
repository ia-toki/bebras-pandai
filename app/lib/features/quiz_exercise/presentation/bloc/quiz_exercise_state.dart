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
  final String selectedAnswer;
  final String shortAnswer;
  final String modalErrorMessage;

  const QuizExerciseShow({
    required this.quiz,
    required this.quizExercise,
    required this.remainingDuration,
    this.shortAnswer = '',
    this.selectedAnswer = '',
    this.modalErrorMessage = '',
  });

  @override
  List<Object> get props => [
        quiz,
        quizExercise,
        remainingDuration,
        selectedAnswer,
        shortAnswer,
        modalErrorMessage,
      ];
}

class QuizExerciseFinished extends QuizExerciseState {
  final String quizParticipantId;
  const QuizExerciseFinished(this.quizParticipantId);

  @override
  List<Object> get props => [quizParticipantId];
}

class QuizExerciseFailed extends QuizExerciseState {
  final String error;

  const QuizExerciseFailed(this.error);
  @override
  List<Object> get props => [error];
}
