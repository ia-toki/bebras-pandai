import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../quiz_exercise/presentation/model/quiz_exercise.dart';
import '../../../quiz_exercise/presentation/repositories/quiz_exercise.dart';

part 'task_list_state.dart';

class TaskListCubit extends Cubit<TaskListState> {
  TaskListCubit() : super(TaskListInitial());

  Future<void> initialize({required String? group}) async {
    try {
      if (group == null) {
        throw Exception('challenge group is null');
      }
      final quizExerciseRepository = QuizExerciseRepository();
      final list = await quizExerciseRepository.getListQuizExerciseBase(group);
      emit(TaskListSuccess(taskList: list));
    } catch (e) {
      emit(TaskListFailed(e.toString()));
    }
  }
}
