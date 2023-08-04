part of 'task_list_bloc.dart';

@immutable
abstract class TaskListState {}

class TaskListInitial extends TaskListState {}

class TaskListLoading extends TaskListState {}

class TaskListSuccess extends TaskListState {
  final List<TaskEntity> items;

  TaskListSuccess(this.items);
}

class TaskListEmpty extends TaskListState {}

class TaskListError extends TaskListState {
  final String error;
  TaskListError(this.error);
}

class DeleteTaskError extends TaskListState {
  final String error;
  DeleteTaskError(this.error);
}