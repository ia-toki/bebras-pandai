part of 'quiz_exercise_cubit.dart';

abstract class QuizExerciseEvent extends Equatable {
  const QuizExerciseEvent();

  @override
  List<Object?> get props => [];
}

class GetQuizExercise extends QuizExerciseEvent {
  const GetQuizExercise();
}
