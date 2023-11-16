part of 'task_list_cubit.dart';

@immutable
abstract class TaskListState {}

class TaskListInitial extends TaskListState {}

class TaskListSuccess extends TaskListState {
  final List<QuizExercise> taskList;

  TaskListSuccess({required this.taskList});
  List<Object> get props => [taskList];
}

class TaskListFailed extends TaskListState {
  final String error;

  TaskListFailed(this.error);

  List<Object> get props => [error];
}
