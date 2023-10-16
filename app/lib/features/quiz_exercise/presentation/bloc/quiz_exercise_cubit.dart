import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/quiz_exercise.dart';

part 'quiz_exercise_state.dart';
part 'quiz_exercise_event.dart';

class QuizExerciseCubit extends Cubit<QuizExerciseState> {
  QuizExerciseCubit() : super(QuizExerciseInitialState());
}
