import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:todo/app/models/task.dart';
import 'package:todo/data/repo/repository.dart';

part 'task_list_event.dart';
part 'task_list_state.dart';

class TaskListBloc extends Bloc<TaskListEvent, TaskListState> {
  final Repository<TaskEntity> repository;
  String searchTherm = '';
  TaskEntity task1 = TaskEntity();
  TaskListBloc(this.repository) : super(TaskListInitial()) {
    on<TaskListEvent>((event, emit) async {
      emit(TaskListLoading());
      await Future.delayed(const Duration(seconds: 1));

      final items = await repository.getAll(searchKeyword: searchTherm);
      if (event is TaskListSearch || event is TaskListStart) {
        if (event is TaskListSearch) {
          searchTherm = event.searchKeyWord;
        } else {
          searchTherm = '';
        }
        if (items.isNotEmpty) {
          try {
            emit(TaskListSuccess(items));
          } catch (e) {
            emit(DeleteTaskError('not defined error'));
          }
        } else {
          emit(TaskListEmpty());
        }
      } else if (event is TaskListDeleteAll) {
        await repository.deleteAll();
        emit(TaskListEmpty());
      } else if (event is DeleteTaskItem) {
        task1 = event.task;
        await repository.delete(task1);
        if (items.isNotEmpty) {
          try {
            emit(TaskListSuccess(items));
          } catch (e) {
            emit(DeleteTaskError('error'));
            debugPrint(e.toString());
          }
        } else {
          emit(TaskListEmpty());
        }
      }
    });
  }
}
