import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../quiz_exercise/presentation/model/quiz_exercise.dart';
import '../../../quiz_exercise/presentation/repositories/quiz_exercise.dart';

part 'task_detail_state.dart';

class TaskDetailCubit extends Cubit<TaskDetailState> {
  TaskDetailCubit() : super(TaskDetailInitial());

  Future<void> initialize({required String? taskId}) async {
    try {
      if (taskId == null) {
        throw Exception('Task ID is null');
      }
      final quizExerciseRepository = QuizExerciseRepository();
      final task = await quizExerciseRepository.getQuizExercise(taskId);
      emit(TaskDetailSuccess(task: task));
    } catch (e) {
      emit(TaskDetailFailed(e.toString()));
    }
  }
}
