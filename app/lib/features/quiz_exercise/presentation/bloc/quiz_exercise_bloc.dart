import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../model/quiz_exercise.dart';
import '../repositories/quiz_exercise.dart';
part 'quiz_exercise_state.dart';
part 'quiz_exercise_event.dart';

class QuizExerciseBlocInitialize
    extends Bloc<QuizExerciseEvent, QuizExerciseState> {
  final QuizExerciseRepository _quizExerciseRepository;
  QuizExerciseBlocInitialize(this._quizExerciseRepository)
      : super(QuizExerciseInitial()) {
    on<GetQuizExercise>(_fetchQuizExercise);
  }

  FutureOr<void> _fetchQuizExercise(
      GetQuizExercise quizExercise, Emitter<QuizExerciseState> emit) async {
    final listofQuizExercise = await _quizExerciseRepository.getAll();
    emit(QuizExerciseSuccess(listofQuizExercise));
  }
}
