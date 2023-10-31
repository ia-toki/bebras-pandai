import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../services/quiz_service.dart';
import '../model/quiz_exercise.dart';
part 'quiz_exercise_state.dart';
part 'quiz_exercise_event.dart';

class QuizExerciseCubit extends Cubit<QuizExerciseState> {
  QuizExerciseCubit() : super(QuizExerciseInitialState());

  FutureOr<void> fetchQuizExercise() async {
    try {
      emit(QuizExerciseLoading());
      final quizExercise = await QuizService().getListQuizExerciese();
      if (quizExercise.isNotEmpty) {
        emit(QuizExerciseSuccess(quizExercise));
      } else {
        emit(const QuizExerciseFailed('error'));
      }
    } catch (e) {
      emit(QuizExerciseFailed(e.toString()));
    }
  }
}
