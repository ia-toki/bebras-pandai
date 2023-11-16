part of 'task_detail_cubit.dart';

@immutable
abstract class TaskDetailState {}

class TaskDetailInitial extends TaskDetailState {}

class TaskDetailSuccess extends TaskDetailState {
  final QuizExercise task;

  TaskDetailSuccess({required this.task});
  List<Object> get props => [task];
}

class TaskDetailFailed extends TaskDetailState {
  final String error;

  TaskDetailFailed(this.error);

  List<Object> get props => [error];
}
